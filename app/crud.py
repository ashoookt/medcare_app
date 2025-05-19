from sqlalchemy.orm import Session
from models import Register, UserSignUp
from schemas import UserCreate, UserSignUpCreate
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
