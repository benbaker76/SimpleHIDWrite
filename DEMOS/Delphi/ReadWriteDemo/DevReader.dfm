object MainForm: TMainForm
  Left = 192
  Top = 116
  AutoScroll = False
  Caption = 'SimpleHIDWrite - a HID utility'
  ClientHeight = 516
  ClientWidth = 521
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  DesignSize = (
    521
    516)
  PixelsPerInch = 96
  TextHeight = 16
  object WriteBtn: TSpeedButton
    Left = 8
    Top = 483
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Write'
    Enabled = False
    OnClick = WriteBtnClick
  end
  object SaveBtn: TSpeedButton
    Left = 104
    Top = 451
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Save As...'
    OnClick = SaveBtnClick
  end
  object Label1: TLabel
    Left = 41
    Top = 300
    Width = 54
    Height = 16
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'ReportID'
  end
  object InfoBtn: TSpeedButton
    Left = 8
    Top = 451
    Width = 81
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = 'Info'
    OnClick = InfoBtnClick
  end
  object ClearBtn: TSpeedButton
    Left = 296
    Top = 451
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Clear'
    OnClick = ClearBtnClick
  end
  object GetReportBtn: TSpeedButton
    Left = 104
    Top = 483
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Get Report'
    Enabled = False
    OnClick = GetReportBtnClick
  end
  object SetReportBtn: TSpeedButton
    Left = 200
    Top = 483
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Set Report'
    Enabled = False
    OnClick = SetReportBtnClick
  end
  object GetFeatureBtn: TSpeedButton
    Left = 296
    Top = 483
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Get Feature'
    Enabled = False
    OnClick = GetFeatureBtnClick
  end
  object SetFeatureBtn: TSpeedButton
    Left = 392
    Top = 483
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Set Feature'
    Enabled = False
    OnClick = SetFeatureBtnClick
  end
  object PlaybackBtn: TSpeedButton
    Left = 200
    Top = 451
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Playback...'
    OnClick = PlaybackBtnClick
  end
  object DevListBox: TListBox
    Left = -1
    Top = 0
    Width = 521
    Height = 81
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 16
    TabOrder = 0
    OnClick = DevListBoxClick
  end
  object HistoryListBox: TListBox
    Left = 0
    Top = 84
    Width = 521
    Height = 206
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 1
    OnDblClick = HistoryListBoxDblClick
  end
  object ReportID: TEdit
    Left = 8
    Top = 296
    Width = 25
    Height = 24
    Anchors = [akLeft, akBottom]
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 8
    Top = 328
    Width = 25
    Height = 24
    Anchors = [akLeft, akBottom]
    TabOrder = 3
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text Files *.txt|*.txt|All Files *.*|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing, ofDontAddToRecent]
    Title = 'Save History'
    Left = 288
  end
  object HidCtl: TJvHidDeviceController
    OnArrival = HidCtlArrival
    OnEnumerate = HidCtlEnumerate
    OnDeviceChange = HidCtlDeviceChange
    OnDeviceDataError = HidCtlDeviceDataError
    OnRemoval = HidCtlRemoval
    Left = 368
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Text Files *.txt|*.txt|All Files *.*|*.*'
    Options = [ofEnableSizing]
    Title = 'Playback History'
    Left = 328
  end
end
