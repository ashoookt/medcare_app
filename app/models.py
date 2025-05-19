from sqlalchemy import Column, Integer, String, Text, ForeignKey
from sqlalchemy.orm import relationship
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


class PatientRecords(Base):
    __tablename__ = "patients"

    id = Column(Integer, primary_key=True, index=True) 
    patient_name = Column(String(100), nullable=False)
    patient_address = Column(String(255), nullable=False)
    patient_gender = Column(String(10), nullable=False)
    patient_age = Column(Integer, nullable=False)
    patient_doctor = Column(String(100), nullable=False)
    patient_ward = Column(String(100), nullable=False)

medical_history = relationship("PatientMedicalHistory", back_populates="patient")


class PatientMedicalHistory(Base):
    __tablename__ = "patientmedical"

    id = Column(Integer, primary_key=True, index=True)
    patient_complaint = Column(Text, nullable=False)
    patient_diagnostics = Column(Text, nullable=False)
    patient_diet = Column(Text, nullable=False)
    patient_id = Column(Integer, ForeignKey("patients.id", ondelete="CASCADE"), nullable=False)

medical_history = relationship("PatientMedicalHistory", back_populates="patient")