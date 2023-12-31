object MainForm: TMainForm
  Left = 196
  Top = 123
  AutoScroll = False
  Caption = 'SimpleHIDWrite3'
  ClientHeight = 627
  ClientWidth = 879
  Color = clBtnFace
  Constraints.MinHeight = 666
  Constraints.MinWidth = 895
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  DesignSize = (
    879
    627)
  PixelsPerInch = 96
  TextHeight = 16
  object WriteBtn: TSpeedButton
    Left = 400
    Top = 594
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Write'
    Enabled = False
    OnClick = WriteBtnClick
  end
  object SaveBtn: TSpeedButton
    Left = 112
    Top = 594
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Save As...'
    OnClick = SaveBtnClick
  end
  object Label1: TLabel
    Left = 41
    Top = 355
    Width = 412
    Height = 16
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'ReportID'
  end
  object InfoBtn: TSpeedButton
    Left = 16
    Top = 594
    Width = 81
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = 'Info'
    OnClick = InfoBtnClick
  end
  object ClearBtn: TSpeedButton
    Left = 304
    Top = 594
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Clear'
    OnClick = ClearBtnClick
  end
  object GetReportBtn: TSpeedButton
    Left = 496
    Top = 594
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Get Report'
    Enabled = False
    OnClick = GetReportBtnClick
  end
  object SetReportBtn: TSpeedButton
    Left = 592
    Top = 594
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Set Report'
    Enabled = False
    OnClick = SetReportBtnClick
  end
  object GetFeatureBtn: TSpeedButton
    Left = 688
    Top = 594
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Get Feature'
    Enabled = False
    OnClick = GetFeatureBtnClick
  end
  object SetFeatureBtn: TSpeedButton
    Left = 784
    Top = 594
    Width = 81
    Height = 22
    AllowAllUp = True
    Anchors = [akLeft, akBottom]
    Caption = 'Set Feature'
    Enabled = False
    OnClick = SetFeatureBtnClick
  end
  object PlaybackBtn: TSpeedButton
    Left = 208
    Top = 594
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
    Width = 879
    Height = 169
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 16
    TabOrder = 0
    OnClick = DevListBoxClick
  end
  object HistoryListBox: TListBox
    Left = 0
    Top = 176
    Width = 879
    Height = 169
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
    Top = 351
    Width = 25
    Height = 24
    Anchors = [akLeft, akBottom]
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 8
    Top = 383
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
