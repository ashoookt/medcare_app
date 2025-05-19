from pydantic import BaseModel, EmailStr
from typing import Optional

# This is for registering full student info
class UserCreate(BaseModel):
    student_id: str
    lorma_email: EmailStr
    full_name: str
    age: Optional[int] = None
    course_year: Optional[str] = None
    gender: Optional[str] = None
    contact_no: Optional[str] = None

# This is for sign-up with login credentials
class UserSignUpCreate(BaseModel):
    student_id: str
    lorma_email: str
    full_name: str
    password: str

class UserSignUp(BaseModel):
    student_id: str
    lorma_email: EmailStr
    full_name: str
    
    class Config:
        orm_mode = True
        
class LoginRequest(BaseModel):
    lorma_email: str  
    password: str

class PatientCreate(BaseModel):
    patient_name: str
    patient_address: str
    patient_gender: str
    patient_age: int
    patient_doctor: str
    patient_ward: str


class PatientMedicalHistoryBase(BaseModel):
    patient_complaint: str
    patient_diagnostics: str
    patient_diet: str
    patient_id: int

class PatientMedicalHistoryCreate(PatientMedicalHistoryBase):
    pass

class PatientMedicalHistory(PatientMedicalHistoryBase):
    id: int

    class Config:
        from_attributes = True


    class Config:
        orm_mode = True

        