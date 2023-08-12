unit DevReader;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, JvHidControllerClass;

type
  TPlaybackResult = (pbIgnore, pbSuccess, pbFail);

  TReport = packed record
    ReportID: Byte;
    Bytes: array [0..63] of Byte;
  end;

  TMainForm = class(TForm)
    DevListBox: TListBox;
    HistoryListBox: TListBox;
    WriteBtn: TSpeedButton;
    SaveBtn: TSpeedButton;
    SaveDialog: TSaveDialog;
    ReportID: TEdit;
    Edit1: TEdit;
    Label1: TLabel;
    HidCtl: TJvHidDeviceController;
    InfoBtn: TSpeedButton;
    ClearBtn: TSpeedButton;
    GetReportBtn: TSpeedButton;
    SetReportBtn: TSpeedButton;
    GetFeatureBtn: TSpeedButton;
    SetFeatureBtn: TSpeedButton;
    PlaybackBtn: TSpeedButton;
    OpenDialog: TOpenDialog;
    procedure FormActivate(Sender: TObject);
    procedure HidCtlDeviceChange(Sender: TObject);
    function HidCtlEnumerate(HidDev: TJvHidDevice;
      const Idx: Integer): Boolean;
    procedure HidCtlDeviceDataError(HidDev: TJvHidDevice; Error: Cardinal);
    procedure HidCtlArrival(HidDev: TJvHidDevice);
    procedure HidCtlRemoval(HidDev: TJvHidDevice);
    procedure DevListBoxClick(Sender: TObject);
    procedure InfoBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure WriteBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure GetReportBtnClick(Sender: TObject);
    procedure SetReportBtnClick(Sender: TObject);
    procedure GetFeatureBtnClick(Sender: TObject);
    procedure SetFeatureBtnClick(Sender: TObject);
    procedure PlaybackBtnClick(Sender: TObject);
    procedure HistoryListBoxDblClick(Sender: TObject);
  public
    Activated: Boolean;
    Edits: array [0..63] of TEdit;
    CurrentDevice: TJvHidDevice;
    function DeviceName(HidDev: TJvHidDevice): string;
    procedure ShowRead(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
    function Apply(Line: string): TPlaybackResult;
    procedure AddToHistory(Str: string);
  end;

var
  MainForm: TMainForm;

implementation

uses
  Math,
  Info;

{$R *.dfm}

procedure TMainForm.FormActivate(Sender: TObject);
var
  I, J: Integer;
begin
  if not Activated then
  begin
    Activated := True;
    Edits[0] := Edit1;
    for I := 1 to High(Edits) do
      Edits[I] := TEdit.Create(Self);
    for J := 0 to 3 do
      for I := 0 to 15 do
        with Edits[J*16 + I] do
        begin
          Visible  := False;
          Left     := Edit1.Left + I*(Edit1.Width+2);
          Top      := Edit1.Top  + J*(Edit1.Height+2);
          Width    := Edit1.Width;
          Anchors  := Edit1.Anchors;
          if not Assigned(Parent) then
            Parent := Edit1.Parent;
          TabOrder := Edit1.TabOrder + J*16 + I;
        end;
    DevListBoxClick(Self);
  end;
end;

procedure TMainForm.HidCtlDeviceChange(Sender: TObject);
var
  Dev: TJvHidDevice;
  I, N: Integer;
begin
  for I := 0 to DevListBox.Items.Count - 1 do
  begin
    Dev := TJvHidDevice(DevListBox.Items.Objects[I]);
    Dev.Free;
  end;
  DevListBox.Items.Clear;

  while HidCtl.CheckOut(Dev) do
  begin
    N := DevListBox.Items.Add(DeviceName(Dev));
    Dev.NumInputBuffers := 128;
    Dev.NumOverlappedBuffers := 128;
    DevListBox.Items.Objects[N] := Dev;
  end;
end;

function TMainForm.DeviceName(HidDev: TJvHidDevice): string;
begin
  if HidDev.ProductName <> '' then
    Result := HidDev.ProductName
  else
    Result := Format('Device VID=%.4x PID=%.4x',
      [HidDev.Attributes.VendorID, HidDev.Attributes.ProductID]);
  if HidDev.SerialNumber <> '' then
    Result := Result + Format(' (Serial=%s)', [HidDev.SerialNumber]);
end;

function TMainForm.HidCtlEnumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
var
  N: Integer;
  Dev: TJvHidDevice;
begin
  N := DevListBox.Items.Add(DeviceName(HidDev));
  HidCtl.CheckOutByIndex(Dev, Idx);
  Dev.NumInputBuffers := 128;
  Dev.NumOverlappedBuffers := 128;
  DevListBox.Items.Objects[N] := Dev;
  Result := True;
end;

procedure TMainForm.DevListBoxClick(Sender: TObject);
var
  I: Integer;
  Dev: TJvHidDevice;
begin
  // stop reader thread
  if Assigned(CurrentDevice) then
    CurrentDevice.OnData := nil;
  CurrentDevice := nil;
  WriteBtn.Enabled := False;
  SetReportBtn.Enabled := False;
  GetFeatureBtn.Enabled := False;
  SetFeatureBtn.Enabled := False;
  if (DevListBox.Items.Count > 0) and (DevListBox.ItemIndex >= 0) then
  begin
    Dev := TJvHidDevice(DevListBox.Items.Objects[DevListBox.ItemIndex]);
    // start reader thread
    Dev.OnData := ShowRead;
    CurrentDevice := Dev;
    for I := Low(Edits) to High(Edits) do
      Edits[I].Visible := False;
    for I := 0 to Max(Dev.Caps.OutputReportByteLength, Dev.Caps.FeatureReportByteLength) - 2 do
      Edits[I].Visible := True;
    WriteBtn.Enabled := (Dev.Caps.OutputReportByteLength <> 0) and Dev.HasReadWriteAccess;
    GetReportBtn.Enabled := (Dev.Caps.InputReportByteLength <> 0) and Dev.HasReadWriteAccess;
    SetReportBtn.Enabled := (Dev.Caps.OutputReportByteLength <> 0) and GetReportBtn.Enabled;
    GetFeatureBtn.Enabled := Dev.Caps.FeatureReportByteLength <> 0;
    SetFeatureBtn.Enabled := Dev.Caps.FeatureReportByteLength <> 0;
    AddToHistory('Selection of ' + DeviceName(CurrentDevice));
  end;
end;

procedure TMainForm.AddToHistory(Str: string);
var
  N: Integer;
begin
  HistoryListBox.Canvas.Font := HistoryListBox.Font;
  N := HistoryListBox.Canvas.TextWidth(Str) + 16;
  if HistoryListBox.ScrollWidth < N then
    HistoryListBox.ScrollWidth := N;
  HistoryListBox.ItemIndex := HistoryListBox.Items.Add(Str);
  HistoryListBox.ClearSelection;
end;

procedure TMainForm.ShowRead(HidDev: TJvHidDevice; ReportID: Byte;
  const Data: Pointer; Size: Word);
var
  I: Integer;
  Str: string;
begin
  Str := Format('RD %.2x  ', [ReportID]);
  for I := 0 to Size - 1 do
    Str := Str + Format('%.2x ', [Cardinal(PChar(Data)[I])]);
  AddToHistory(Str);
end;

procedure TMainForm.HidCtlDeviceDataError(HidDev: TJvHidDevice; Error: Cardinal);
begin
  AddToHistory(Format('READ ERROR: %s (%x)', [SysErrorMessage(Error), Error]));
end;

procedure TMainForm.HidCtlArrival(HidDev: TJvHidDevice);
begin
  AddToHistory('Arrival of ' + DeviceName(HidDev));
end;

procedure TMainForm.HidCtlRemoval(HidDev: TJvHidDevice);
begin
  AddToHistory('Removal of ' + DeviceName(HidDev));
end;

procedure TMainForm.InfoBtnClick(Sender: TObject);
begin
  if (DevListBox.Items.Count > 0) and (DevListBox.ItemIndex >= 0) then
    with TInfoForm.Create(Self) do
    begin
      Dev := TJvHidDevice(DevListBox.Items.Objects[DevListBox.ItemIndex]);
      ShowModal;
      Free;
    end;
end;

procedure TMainForm.SaveBtnClick(Sender: TObject);
begin
  ForceCurrentDirectory := True;
  if SaveDialog.Execute then
    HistoryListBox.Items.SaveToFile(SaveDialog.FileName);
end;

procedure TMainForm.ClearBtnClick(Sender: TObject);
begin
  HistoryListBox.Items.Clear;
  HistoryListBox.ScrollWidth := 0;
end;

function TMainForm.Apply(Line: string): TPlaybackResult;
var
  I: Integer;

  procedure CopyToEdits(Line: string);
  var
    I, J: Integer;
  begin
    ReportID.Text := Copy(Line, 4, 2);
    I := 8;
    J := 0;
    while (I < Length(Line)) and Edits[J].Visible and (J <= High(Edits)) do
    begin
      Edits[J].Text := Copy(Line, I, 2);
      Inc(I, 3);
      Inc(J);
    end;
  end;

begin
  if Pos('WR ', Line) = 1 then
  begin
    Result := pbFail;
    if WriteBtn.Enabled then
    begin
      CopyToEdits(Line);
      WriteBtnClick(Self);
      Result := pbSuccess;
    end;
  end
  else
  if Pos('wr ', Line) = 1 then
  begin
    Result := pbFail;
    if SetReportBtn.Enabled then
    begin
      CopyToEdits(Line);
      SetReportBtnClick(Self);
      Result := pbSuccess;
    end;
  end
  else
  if Pos('sf ', Line) = 1 then
  begin
    Result := pbFail;
    if SetFeatureBtn.Enabled then
    begin
      CopyToEdits(Line);
      SetFeatureBtnClick(Self);
      Result := pbSuccess;
    end;
  end
  else
  if Pos('Selection of ', Line) = 1 then
  begin
    Result := pbFail;
    for I := 0 to DevListBox.Items.Count - 1 do
      if 'Selection of ' + DeviceName(TJvHidDevice(DevListBox.Items.Objects[I])) = Line then
      begin
        DevListBox.ItemIndex := I;
        DevListBoxClick(Self);
        Result := pbSuccess;
        Break;
      end;
  end
  else
    Result := pbIgnore;
  Application.ProcessMessages;
  Sleep(50);
  Application.ProcessMessages;
end;

procedure TMainForm.PlaybackBtnClick(Sender: TObject);
var
  I: Integer;
  List: TStringList;
begin
  ForceCurrentDirectory := True;
  if OpenDialog.Execute then
  begin
    List := TStringList.Create;
    List.LoadFromFile(OpenDialog.FileName);
    AddToHistory(Format('Playback of "%s" started', [OpenDialog.FileName]));
    for I := 0 to List.Count - 1 do
      if Apply(List[I]) = pbFail then
      begin
        AddToHistory(Format('PLAYBACK ERROR: %s', [List[I]]));
        Break;
      end;
    AddToHistory(Format('Playback of "%s" ended', [OpenDialog.FileName]));
    List.Free;
  end;
end;

procedure TMainForm.WriteBtnClick(Sender: TObject);
var
  I: Integer;
  Buf: array [0..64] of Byte;
  Written: Cardinal;
  ToWrite: Cardinal;
  Str: string;
  Err: DWORD;
begin
  if Assigned(CurrentDevice) then
  begin
    Buf[0] := StrToIntDef('$' + ReportID.Text, 0);
    ReportID.Text := Format('%.2x', [Buf[0]]);
    ToWrite := CurrentDevice.Caps.OutputReportByteLength;
    for I := 0 to ToWrite - 1 do
    begin
      Buf[I+1] := StrToIntDef('$' + Edits[I].Text, 0);
      Edits[I].Text := Format('%.2x', [Buf[I+1]]);
    end;
    if not CurrentDevice.WriteFile(Buf, ToWrite, Written) then
    begin
      Err := GetLastError;
      AddToHistory(Format('WRITE ERROR: %s (%x)', [SysErrorMessage(Err), Err]));
    end
    else
    begin
      Str := Format('WR %.2x  ', [Buf[0]]);
      for I := 1 to Written - 1 do
        Str := Str + Format('%.2x ', [Buf[I]]);
      AddToHistory(Str);
    end;
  end;
end;

procedure TMainForm.GetReportBtnClick(Sender: TObject);
var
  I: Integer;
  Buf: array [0..64] of Byte;
  Str: string;
  Err: DWORD;
begin
  if Assigned(CurrentDevice) then
  begin
    FillChar(Buf[0], SizeOf(Buf), 0);
    Buf[0] := StrToIntDef('$' + ReportID.Text, 0);
    if CurrentDevice.GetInputReport(Buf[0], SizeOf(Buf)) then
    begin
      Str := Format('rd %.2x  ', [Buf[0]]);
      for I := 1 to CurrentDevice.Caps.InputReportByteLength - 1 do
        Str := Str + Format('%.2x ', [Buf[I]]);
      AddToHistory(Str);
    end
    else
    begin
      Err := GetLastError;
      AddToHistory(Format('GET REPORT ERROR: %s (%x)', [SysErrorMessage(Err), Err]));
    end;
  end;
end;

procedure TMainForm.SetReportBtnClick(Sender: TObject);
var
  I: Integer;
  Buf: array [0..64] of Byte;
  Str: string;
  Err: DWORD;
begin
  if Assigned(CurrentDevice) then
  begin
    Buf[0] := StrToIntDef('$' + ReportID.Text, 0);
    ReportID.Text := Format('%.2x', [Buf[0]]);
    for I := 1 to CurrentDevice.Caps.OutputReportByteLength - 1 do
    begin
      Buf[I] := StrToIntDef('$' + Edits[I-1].Text, 0);
      Edits[I-1].Text := Format('%.2x', [Buf[I]]);
    end;
    if not CurrentDevice.SetOutputReport(Buf[0], CurrentDevice.Caps.OutputReportByteLength) then
    begin
      Err := GetLastError;
      AddToHistory(Format('SET REPORT ERROR: %s (%x)', [SysErrorMessage(Err), Err]));
    end
    else
    begin
      Str := Format('wr %.2x  ', [Buf[0]]);
      for I := 1 to CurrentDevice.Caps.OutputReportByteLength - 1 do
        Str := Str + Format('%.2x ', [Buf[I]]);
      AddToHistory(Str);
    end;
  end;
end;

procedure TMainForm.GetFeatureBtnClick(Sender: TObject);
var
  I: Integer;
  Buf: array [0..64] of Byte;
  Str: string;
  Err: DWORD;
begin
  if Assigned(CurrentDevice) then
  begin
    Buf[0] := StrToIntDef('$' + ReportID.Text, 0);
    ReportID.Text := Format('%.2x', [Buf[0]]);
    if not CurrentDevice.GetFeature(Buf[0], CurrentDevice.Caps.FeatureReportByteLength) then
    begin
      Err := GetLastError;
      AddToHistory(Format('GET FEATURE ERROR: %s (%x)', [SysErrorMessage(Err), Err]));
    end
    else
    begin
      Str := Format('RD %.2x  ', [Buf[0]]);
      for I := 1 to CurrentDevice.Caps.FeatureReportByteLength - 1 do
        Str := Str + Format('%.2x ', [Buf[I]]);
      AddToHistory(Str);
    end;
  end;
end;

procedure TMainForm.SetFeatureBtnClick(Sender: TObject);
var
  I: Integer;
  Buf: array [0..64] of Byte;
  Str: string;
  Err: DWORD;
begin
  if Assigned(CurrentDevice) then
  begin
    Buf[0] := StrToIntDef('$' + ReportID.Text, 0);
    ReportID.Text := Format('%.2x', [Buf[0]]);
    for I := 1 to CurrentDevice.Caps.FeatureReportByteLength - 1 do
    begin
      Buf[I] := StrToIntDef('$' + Edits[I-1].Text, 0);
      Edits[I-1].Text := Format('%.2x', [Buf[I]]);
    end;
    if not CurrentDevice.SetFeature(Buf[0], CurrentDevice.Caps.FeatureReportByteLength) then
    begin
      Err := GetLastError;
      AddToHistory(Format('SET FEATURE ERROR: %s (%x)', [SysErrorMessage(Err), Err]));
    end
    else
    begin
      Str := Format('sf %.2x  ', [Buf[0]]);
      for I := 1 to CurrentDevice.Caps.FeatureReportByteLength - 1 do
        Str := Str + Format('%.2x ', [Buf[I]]);
      AddToHistory(Str);
    end;
  end;
end;

procedure TMainForm.HistoryListBoxDblClick(Sender: TObject);
begin
  if HistoryListBox.ItemIndex <> -1 then
    Apply(HistoryListBox.Items[HistoryListBox.ItemIndex]);
end;

end.
