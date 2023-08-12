!ifndef ROOT
ROOT = $(MAKEDIR)
!endif
#---------------------------------------------------------------------------------------------------
DCC  = $(ROOT)\dcc32.exe -q -w -m
#---------------------------------------------------------------------------------------------------
default: \
BasicDemo.exe \
CollectionDemo.exe \
SimpleHIDWrite.exe \
UsagesDemo.exe

#---------------------------------------------------------------------------------------------------

BasicDemo.exe: Delphi\BasicDemo\BasicDemo.dpr
  cd Delphi\BasicDemo
  $(DCC) $&.dpr
  cd ..\..

CollectionDemo.exe: Delphi\CollectionDemo\CollectionDemo.dpr
  cd Delphi\CollectionDemo
  $(DCC) $&.dpr
  cd ..\..

SimpleHIDWrite.exe: Delphi\ReadWriteDemo\SimpleHIDWrite.dpr
  cd Delphi\ReadWriteDemo
  $(DCC) $&.dpr
  cd ..\..

UsagesDemo.exe: Delphi\UsagesDemo\UsagesDemo.dpr
  cd Delphi\UsagesDemo
  $(DCC) $&.dpr
  cd ..\..