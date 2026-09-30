library(foreign)
library(dplyr)

DEMO_L <- read.xport("NHANES/DEMO_L.xpt")
BMX_L <- read.xport("NHANES/BMX_L.xpt")
ALB_CR_L <- read.xport("NHANES/ALB_CR_L.xpt")
HDL_L <- read.xport("NHANES/HDL_L.xpt")
TRIGLY_L <- read.xport("NHANES/TRIGLY_L.xpt")
TCHOL_L <- read.xport("NHANES/TCHOL_L.xpt")
GHB_L <- read.xport("NHANES/GHB_L.xpt")
INS_L <- read.xport("NHANES/INS_L.xpt")
GLU_L <- read.xport("NHANES/GLU_L.xpt")
ALQ_L <- read.xport("NHANES/ALQ_L.xpt")
DIQ_L <- read.xport("NHANES/DIQ_L.xpt")
FSQ_L <- read.xport("NHANES/FSQ_L.xpt")
HUQ_L <- read.xport("NHANES/HUQ_L.xpt")
SMQ_L <- read.xport("NHANES/SMQ_L.xpt")
PAQ_L <- read.xport("NHANES/PAQ_L.xpt")
BPQ_L <- read.xport("NHANES/BPQ_L.xpt")
MCQ_L <- read.xport("NHANES/MCQ_L.xpt")
FERTIN_L <- read.xport("NHANES/FERTIN_L.xpt")
KIQ_U_L <- read.xport("NHANES/KIQ_U_L.xpt")
SLQ_L <- read.xport("NHANES/SLQ_L.xpt")
FNQ_L <- read.xport("NHANES/FNQ_L.xpt")

write.csv(
  MCQ_L,
  file = "NHANES_CSV/MCQ_L.csv",
  row.names = FALSE
)


#merge all at once
dflist_nhanes <- list(
  DEMO_L, BMX_L, ALB_CR_L, HDL_L, TRIGLY_L, TCHOL_L,
  GHB_L, INS_L, GLU_L, ALQ_L, DIQ_L, FSQ_L, HUQ_L, SMQ_L,
  PAQ_L, BPQ_L, MCQ_L, FERTIN_L, KIQ_U_L, SLQ_L, FNQ_L
)

merged_nhanes <- Reduce(function(x, y) merge(x, y, by = "SEQN", all = TRUE), dflist_nhanes)

#DEMO_L drop variables
vars_to_keep <- c(
  "SEQN","SDDSRVYR", "RIAGENDR", "RIDSTATR","RIDAGEYR","RIDRETH3","DMDEDUC2","INDFMPIR",
  "BMXBMI","BMXWAIST","BMXWT","URDACT","LBDHDD","LBXTLG","LBDLDLM","LBXTC","LBXGH","LBXIN",
  "LBXGLU","ALQ121","ALQ130","DIQ010",
  "FSDAD","HUQ010","SMQ040","PAD790Q","PAD810Q","BPQ020","BPQ150","BPQ101D",
  "MCQ160B","MCQ160C","MCQ160D","MCQ160E","MCQ160F","MCQ160M","MCQ170M","MCQ160L","MCQ170L",
  "MCQ510A","MCQ510B","MCQ510C","MCQ510D","MCQ510E","MCQ510F","MCQ220","LBXFER",
  "FNQ510","FNQ520","FNQ530","FNQ540","KIQ022","SLD012","SLD013"
)

merged_nhanes <- merged_nhanes %>% select(all_of(vars_to_keep))


#write csv file
write.csv(
  merged_nhanes,
  file = "nhanes.csv",
  row.names = FALSE
)

library(haven)
write_dta(merged_nhanes, "nhanes.dta")