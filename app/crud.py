from sqlalchemy.orm import Session
from models import Register, UserSignUp, PatientRecords, PatientMedicalHistory
from schemas import UserCreate, UserSignUpCreate,PatientCreate, PatientMedicalHistoryCreate
from passlib.context import CryptContext


pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def create_user(db: Session, user: UserCreate):
    db_user = Register(**user.dict())
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def create_signup(db: Session, user: UserSignUpCreate):
    match = db.query(Register).filter(
        Register.lorma_email == user.lorma_email,
        Register.full_name == user.full_name
    ).first()

    if not match:
        return None

    hashed_password = pwd_context.hash(user.password)

    db_signup = UserSignUp(
        student_id=match.student_id,
        lorma_email=user.lorma_email,
        full_name=user.full_name,
        student_password=hashed_password
    )
    db.add(db_signup)
    db.commit()
    db.refresh(db_signup)
    return db_signup

def create_patient(db: Session, patient: PatientCreate):
    db_patient = PatientRecords(**patient.dict())
    db.add(db_patient)
    db.commit()
    db.refresh(db_patient)
    return db_patient

def create_medical_history(db: Session, medical_history: PatientMedicalHistoryCreate):
    db_history = PatientMedicalHistory(**medical_history.dict())
    db.add(db_history)
    db.commit()
    db.refresh(db_history)
    return db_history

def get_medical_history(db: Session, history_id: int):
    return db.query(PatientMedicalHistory).filter(PatientMedicalHistory.id == history_id).first()

def get_all_medical_histories(db: Session, skip: int = 0, limit: int = 100):
    return db.query(PatientMedicalHistory).offset(skip).limit(limit).all()

def update_medical_history(db: Session, history_id: int, updated_data: PatientMedicalHistoryCreate):
    db_history = db.query(PatientMedicalHistory).filter(PatientMedicalHistory.id == history_id).first()
    if db_history:
        for key, value in updated_data.dict().items():
            setattr(db_history, key, value)
        db.commit()
        db.refresh(db_history)
    return db_history

def delete_medical_history(db: Session, history_id: int):
    db_history = db.query(PatientMedicalHistory).filter(PatientMedicalHistory.id == history_id).first()
    if db_history:
        db.delete(db_history)
        db.commit()
    return db_history
