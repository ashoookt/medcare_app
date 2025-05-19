from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from database import SessionLocal, engine
import models, schemas, crud
from passlib.context import CryptContext
from models import UserSignUp
from schemas import LoginRequest
from models import PatientMedicalHistory
from schemas import PatientMedicalHistoryCreate
from models import PatientMedicalHistory


models.Base.metadata.create_all(bind=engine)

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, use specific origin
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_password(password: str) -> str:
    return pwd_context.hash(password)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# First screen: Register full info
@app.post("/register", response_model=schemas.UserCreate)
def register_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    existing_user = db.query(models.Register).filter(
        (models.Register.lorma_email == user.lorma_email) |
        (models.Register.student_id == user.student_id)
    ).first()

    if existing_user:
        raise HTTPException(status_code=400, detail="Email or Student ID already registered.")

    return crud.create_user(db, user)



# Second screen: Sign up for login
@app.post("/signup")
def signup_user(user: schemas.UserSignUpCreate, db: Session = Depends(get_db)):
    existing_signup = db.query(models.UserSignUp).filter(
        models.UserSignUp.lorma_email == user.lorma_email
    ).first()

    if existing_signup:
        raise HTTPException(status_code=400, detail="User already signed up.")

    created = crud.create_signup(db, user)  # ONLY two arguments here

    if not created:
        raise HTTPException(status_code=404, detail="No matching user in register. Please register first.")

    return {"message": "Sign-up successful"}

@app.post("/login")
def login_user(login: LoginRequest, db: Session = Depends(get_db)):

    user = db.query(UserSignUp).filter(UserSignUp.lorma_email == login.lorma_email).first()

    if not user:
        raise HTTPException(status_code=401, detail="Invalid email or password")

    # Verify password
    if not pwd_context.verify(login.password, user.student_password):
        raise HTTPException(status_code=401, detail="Invalid email or password")

    return {"message": "Login successful"}

@app.post("/patients")
def add_patient(patient: schemas.PatientCreate, db: Session = Depends(get_db)):
    return crud.create_patient(db, patient)

@app.post("/medical-history/", response_model=schemas.PatientMedicalHistory)
def create_medical_history_entry(
    medical_history: PatientMedicalHistoryCreate,
    db: Session = Depends(get_db)
):
    return crud.create_medical_history(db=db, medical_history=medical_history)

