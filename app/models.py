from sqlalchemy import Column, Integer, String
from database import Base

# Register table for full student information
class Register(Base):
    __tablename__ = "register"

    id = Column(Integer, primary_key=True, index=True)
    student_id = Column(String(50), unique=True, nullable=False)
    lorma_email = Column(String(100), unique=True, nullable=False)
    full_name = Column(String(100), nullable=False)
    age = Column(Integer, nullable=True)
    course_year = Column(String(50), nullable=True)
    gender = Column(String(10), nullable=True)
    contact_no = Column(String(20), nullable=True)

# SignUp table for login credentials
class UserSignUp(Base):
    __tablename__ = "signup"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)  # PK of this table

    student_id = Column(String(50), unique=True, nullable=False)  # same type as Register.student_id
    full_name = Column(String(100), nullable=False)
    lorma_email = Column(String(100), unique=True, nullable=False)
    student_password = Column(String(255), nullable=False)


