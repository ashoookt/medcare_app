from fastapi import FastAPI, Depends
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session

app = FastAPI()

DATABASE_URL = "mysql+mysqlconnector://medcare:AAA3@localhost/medcare_app"

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), index=True)

Base.metadata.create_all(bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/")  # Changed from @sql.get("/") to @app.get("/")
def index(db: Session = Depends(get_db)):
    try:
        users = db.query(User).all()
        return {"message": f"Connected to the medcare_app database! Found {len(users)} user(s)."}
    except Exception as e:
        return {"error": str(e)}

@app.get("/user-count")
def get_user_count(db: Session = Depends(get_db)):
    try:
        user_count = db.query(User).count()
        return {"user_count": user_count}
    except Exception as e:
        return {"error": str(e)}
