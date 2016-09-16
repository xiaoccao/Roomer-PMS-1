inherited frmHouseKeepingReport: TfrmHouseKeepingReport
  Caption = 'Simple HouseKeeping report'
  ClientHeight = 586
  ClientWidth = 1123
  Font.Height = -11
  Position = poOwnerFormCenter
  ExplicitWidth = 1139
  ExplicitHeight = 625
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TsPanel
    Width = 1123
    Height = 129
    ExplicitWidth = 1123
    ExplicitHeight = 129
    inherited pnlActionButtons: TsPanel
      Top = 85
      Width = 1121
      ExplicitTop = 85
      ExplicitWidth = 1121
      inherited btnReport: TsButton
        Left = 990
        ExplicitLeft = 990
      end
      inherited btnExcel: TsButton
        Left = 856
        ExplicitLeft = 856
      end
    end
    inherited pnlSelection: TsPanel
      Width = 1121
      Height = 84
      ExplicitWidth = 1121
      ExplicitHeight = 84
      object gbxSelection: TsGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 221
        Height = 78
        Align = alLeft
        Caption = 'Select date and location'
        TabOrder = 0
        Checked = False
        object lblDate: TsLabel
          Left = 47
          Top = 23
          Width = 30
          Height = 13
          Alignment = taRightJustify
          Caption = 'Date: '
        end
        object lblLocation: TsLabel
          Left = 33
          Top = 50
          Width = 44
          Height = 13
          Alignment = taRightJustify
          Caption = 'Location:'
        end
        object dtDate: TsDateEdit
          Left = 91
          Top = 20
          Width = 105
          Height = 21
          AutoSize = False
          Color = clWhite
          EditMask = '!99/99/9999;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 0
          CheckOnExit = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
          DefaultToday = True
          DialogTitle = 'Housekeeping date'
        end
        object cbxLocations: TsComboBox
          Left = 91
          Top = 47
          Width = 105
          Height = 21
          Alignment = taLeftJustify
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = -1
          ParentFont = False
          TabOrder = 1
        end
      end
      object BitBtn1: TBitBtn
        Left = 424
        Top = 24
        Width = 75
        Height = 25
        Caption = 'BitBtn1'
        TabOrder = 1
        OnClick = BitBtn1Click
      end
    end
  end
  inherited grData: TcxGrid
    Top = 129
    Width = 1123
    Height = 437
    ExplicitTop = 129
    ExplicitWidth = 1123
    ExplicitHeight = 437
  end
  object grHouseKeepingList: TcxGrid [2]
    Left = 0
    Top = 129
    Width = 1123
    Height = 437
    Align = alClient
    TabOrder = 2
    LookAndFeel.NativeStyle = False
    ExplicitTop = 131
    object grHouseKeepingListDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsGridData
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsCustomize.DataRowSizing = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      object grHouseKeepingListDBTableView1location: TcxGridDBColumn
        Caption = 'Location'
        DataBinding.FieldName = 'location'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 54
      end
      object grHouseKeepingListDBTableView1floor: TcxGridDBColumn
        Caption = 'Floor'
        DataBinding.FieldName = 'floor'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taTopJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 1
        SortOrder = soAscending
        Width = 57
      end
      object grHouseKeepingListDBTableView1room: TcxGridDBColumn
        Caption = 'Room'
        DataBinding.FieldName = 'room'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taTopJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 2
        SortOrder = soAscending
        Width = 72
      end
      object grHouseKeepingListDBTableView1roomtype: TcxGridDBColumn
        Caption = 'RoomType'
        DataBinding.FieldName = 'roomtype'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taTopJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 74
      end
      object grHouseKeepingListDBTableView1LastGuests: TcxGridDBColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'LastGuests'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taTopJustify
        OnGetDisplayText = grHouseKeepingListDBTableView1ArrivingGuestsGetDisplayText
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 58
      end
      object grHouseKeepingListDBTableView1expectedcot: TcxGridDBColumn
        Caption = 'Checkout time'
        DataBinding.FieldName = 'expectedcot'
        PropertiesClassName = 'TcxTimeEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taTopJustify
        Properties.TimeFormat = tfHourMin
        HeaderAlignmentHorz = taCenter
        Width = 89
      end
      object grHouseKeepingListDBTableView1housekeepingstatus: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'housekeepingstatus'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taLeftJustify
        Options.Editing = False
        Width = 112
      end
      object grHouseKeepingListDBTableView1ArrivingGuests: TcxGridDBColumn
        Caption = 'Arriving Guests'
        DataBinding.FieldName = 'ArrivingGuests'
        PropertiesClassName = 'TcxSpinEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taTopJustify
        OnGetDisplayText = grHouseKeepingListDBTableView1ArrivingGuestsGetDisplayText
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 96
      end
      object grHouseKeepingListDBTableView1expectedtoa: TcxGridDBColumn
        Caption = 'Arrival time'
        DataBinding.FieldName = 'expectedtoa'
        PropertiesClassName = 'TcxTimeEditProperties'
        Properties.Alignment.Vert = taTopJustify
        Properties.TimeFormat = tfHourMin
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 66
      end
      object grHouseKeepingListDBTableView1Roomnotes: TcxGridDBColumn
        Caption = 'Room Notes'
        DataBinding.FieldName = 'roomnotes'
        PropertiesClassName = 'TcxMemoProperties'
        Options.Editing = False
        Width = 441
      end
      object grHouseKeepingListDBTableView1maintenancenotes: TcxGridDBColumn
        Caption = 'Maintenance Notes'
        DataBinding.FieldName = 'maintenancenotes'
        PropertiesClassName = 'TcxMemoProperties'
        Visible = False
        Options.Editing = False
        Width = 441
      end
      object grHouseKeepingListDBTableView1cleaningnotes: TcxGridDBColumn
        Caption = 'Cleaning Notes'
        DataBinding.FieldName = 'cleaningnotes'
        PropertiesClassName = 'TcxMemoProperties'
        Visible = False
        Options.Editing = False
        Width = 441
      end
    end
    object lvHouseKeepingListLevel1: TcxGridLevel
      GridView = grHouseKeepingListDBTableView1
    end
  end
  inherited dxStatusBar: TdxStatusBar
    Top = 566
    Width = 1123
    ExplicitTop = 566
    ExplicitWidth = 1123
  end
  inherited kbmGridData: TkbmMemTable
    FieldDefs = <
      item
        Name = 'room'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'roomtype'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'floor'
        DataType = ftInteger
      end
      item
        Name = 'LastGuests'
        DataType = ftInteger
      end
      item
        Name = 'ArrivingGuests'
        DataType = ftInteger
      end
      item
        Name = 'expectedcot'
        DataType = ftTime
      end
      item
        Name = 'housekeepingstatus'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'location'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'expectedtoa'
        DataType = ftTime
      end
      item
        Name = 'Roomnotes'
        DataType = ftMemo
      end
      item
        Name = 'maintenancenotes'
        DataType = ftMemo
      end
      item
        Name = 'cleaningnotes'
        DataType = ftMemo
      end>
    object kbmGridDataroom: TStringField
      FieldName = 'room'
      Size = 10
    end
    object kbmGridDataroomtype: TStringField
      FieldName = 'roomtype'
      Size = 10
    end
    object kbmGridDatafloor: TIntegerField
      FieldName = 'floor'
    end
    object kbmGridDataLastGuests: TIntegerField
      FieldName = 'LastGuests'
    end
    object kbmGridDataArrivingGuests: TIntegerField
      FieldName = 'ArrivingGuests'
    end
    object kbmGridDataexpectedcot: TTimeField
      FieldName = 'expectedcot'
    end
    object kbmGridDatahousekeepingstatus: TStringField
      FieldName = 'housekeepingstatus'
    end
    object kbmGridDatalocation: TStringField
      FieldName = 'location'
      Size = 10
    end
    object kbmGridDataexpectedtoa: TTimeField
      FieldName = 'expectedtoa'
    end
    object kbmGridDataRoomnotes: TMemoField
      FieldName = 'Roomnotes'
      BlobType = ftMemo
    end
    object kbmGridDatamaintenancenotes: TMemoField
      FieldName = 'maintenancenotes'
      BlobType = ftMemo
    end
    object kbmGridDatacleaningnotes: TMemoField
      FieldName = 'cleaningnotes'
      BlobType = ftMemo
    end
  end
  inherited gridPrinter: TdxComponentPrinter
    inherited gridPrinterLink1: TdxGridReportLink
      ReportDocument.CreationDate = 42628.627292673610000000
      AssignedFormatValues = []
      Styles.BandHeader = nil
      Styles.Caption = nil
      Styles.CardCaptionRow = nil
      Styles.CardRowCaption = nil
      Styles.Content = nil
      Styles.ContentEven = nil
      Styles.ContentOdd = nil
      Styles.FilterBar = nil
      Styles.Footer = nil
      Styles.Group = nil
      Styles.Header = nil
      Styles.Preview = nil
      Styles.Selection = nil
      BuiltInReportLink = True
    end
  end
  inherited cxGridStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
    inherited dxGridReportLinkStyleSheet1: TdxGridReportLinkStyleSheet
      BuiltIn = True
    end
  end
  object dxComponentPrinter1: TdxComponentPrinter
    CurrentLink = dxComponentPrinter1Link1
    Version = 0
    Left = 352
    Top = 464
    object dxComponentPrinter1Link1: TdxGridReportLink
      Active = True
      Component = grData
      PageNumberFormat = pnfNumeral
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 42629.373200659720000000
      AssignedFormatValues = [fvDate, fvTime, fvPageNumber]
      BuiltInReportLink = True
    end
  end
end
