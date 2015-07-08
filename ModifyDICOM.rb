# encoding: utf-8


=begin
#console version
require 'rubygems'
require 'dicom'

inf=ARGV[0]
outf=ARGV[1]
pid=ARGV[2]

dcm = DICOM::DObject.read(inf)
if dcm.read?
 dcm.patient_id.value=pid
 dcm.write(outf)
end
=end


#gui version
require 'rubygems'
require 'dicom'
require 'soap/rpc/driver'
require 'tk'
require 'scanf'


#button event.
def getinputfile()
  @txt_inputfile.value=Tk.getOpenFile
end
def getoutputfile()
  @txt_outputfile.value=Tk.getOpenFile
end
def submitmodify(inf,outf,pid)
  dcm = DICOM::DObject.read(inf)
  if dcm.read?
   dcm.patient_id.value=pid
   dcm.write(outf)
  end
  
  @lbl_result.text="已轉換成功為#{pid}."
end




#make window root
@root=TkRoot.new{title "Modify DICOM Tags Toolkit"}


#make object
#result label
@lbl_result=TkLabel.new(@root){
  text "　　　　　　"
  font "arial 20 bold"
  foreground "red"
}

#input file path
@lbl_inputfile=TkLabel.new(@root){
  text "　　　來源："
  font "arial 20 bold"
}
txt_val1=TkVariable.new
@txt_inputfile=TkEntry.new(@root){
  text txt_val1
  font "arial 20 bold"
}
@btn_inputfile=TkButton.new(@root){
  text "選擇"
  font "arial 20 bold"
}
@btn_inputfile.command{getinputfile()}


#output file path
@lbl_outputfile=TkLabel.new(@root){
  text "　　　輸出："
  font "arial 20 bold"
}
txt_val2=TkVariable.new
@txt_outputfile=TkEntry.new(@root){
  text txt_val2
  font "arial 20 bold"
}
@btn_outputfile=TkButton.new(@root){
  text "選擇"
  font "arial 20 bold"
}
@btn_outputfile.command{getoutputfile()}


#patient
@lbl_patientid=TkLabel.new(@root){
  text "身分證字號："
  font "arial 20 bold"
}
txt_val3=TkVariable.new
@txt_patientid=TkEntry.new(@root){
  text txt_val3
  font "arial 20 bold"
}


#submit command
@btn_submit=TkButton.new(@root){
  text "確定"
  font "arial 20 bold"
}
@btn_submit.command{submitmodify(txt_val1.value,txt_val2.value,txt_val3.value)}


#@set object place
@lbl_result.place('x'=>20,'y'=>20,'width'=>350,'height'=>50)

@lbl_inputfile.place('x'=>20,'y'=>90,'width'=>200,'height'=>50)
@txt_inputfile.place('x'=>230,'y'=>90,'width'=>200,'height'=>50)
@btn_inputfile.place('x'=>470,'y'=>90,'width'=>100,'height'=>50)

@lbl_outputfile.place('x'=>20,'y'=>160,'width'=>200,'height'=>50)
@txt_outputfile.place('x'=>230,'y'=>160,'width'=>200,'height'=>50)
@btn_outputfile.place('x'=>470,'y'=>160,'width'=>100,'height'=>50)

@lbl_patientid.place('x'=>20,'y'=>230,'width'=>200,'height'=>50)
@txt_patientid.place('x'=>230,'y'=>230,'width'=>200,'height'=>50)

@btn_submit.place('x'=>220,'y'=>290,'width'=>150,'height'=>50)

#set window root place
@root.configure :width=>600,:height=>400

#loop window root
Tk.mainloop 
