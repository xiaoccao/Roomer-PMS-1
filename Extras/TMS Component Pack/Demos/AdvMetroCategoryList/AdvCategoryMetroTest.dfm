object Form96: TForm96
  Left = 0
  Top = 0
  Caption = 'TAdvMetroCategoryList demo'
  ClientHeight = 561
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object AdvMetroCategoryList2: TAdvMetroCategoryList
    Left = 24
    Top = 24
    Width = 329
    Height = 513
    Categories = <
      item
        Items = <
          item
            Checked = True
            Text = 
              '<b>TMS VCL Subscription</b><br>All components for VCL Windows ap' +
              'plication development'
          end
          item
            Text = 
              '<b>TMS Component Studio</b><br>The best of TMS components for Wi' +
              'ndows, Web & cross platform'
          end
          item
            Text = '<b>TMS Component Pack</b><br>Set of over 375 VCL components'
          end
          item
            Text = 
              '<b>TMS Pack for FireMonkey</b><br>Fully cross platform component' +
              's for Windows, Mac-OSX, iOS, Android'
          end
          item
            Text = 
              '<b>TMS IntraWeb Component Pack Pro</b><br>Component set for web ' +
              'application development with IntraWeb & Delphi'
          end
          item
            Text = 
              '<b>TMS Cloud Pack</b><br>Seamless integration with cloud service' +
              's from Delphi'
          end>
        Text = 'TMS components'
      end
      item
        Items = <
          item
            ShowCheckBox = False
            Text = '<img src="weather1" align="middle">&nbsp;Sunny'
          end
          item
            ShowCheckBox = False
            Text = '<img src="weather2" align="middle">&nbsp;Cloudy day'
          end
          item
            ShowCheckBox = False
            Text = '<img src="weather3" align="middle">&nbsp;Cloudy night'
          end
          item
            ShowCheckBox = False
            Text = '<img src="weather4" align="middle">&nbsp;Rainy night'
          end
          item
            ShowCheckBox = False
            Text = '<img src="weather5" align="middle">&nbsp;Rainy day'
          end
          item
            ShowCheckBox = False
            Text = '<img src="weather6" align="middle">&nbsp;Rainy'
          end>
        ShowCheckBox = False
        Text = '<b>Weather conditions</b>'
      end>
    CategoryFont.Charset = DEFAULT_CHARSET
    CategoryFont.Color = clWindowText
    CategoryFont.Height = -13
    CategoryFont.Name = 'Tahoma'
    CategoryFont.Style = [fsBold]
    ImageChecked.Data = {
      89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
      610000000467414D410000B18F0BFC6105000000097048597300000EC200000E
      C20115284A800000001A74455874536F667477617265005061696E742E4E4554
      2076332E352E313147F34237000000D449444154384FA590311284200C452D29
      2D3D82A5A525A525A5B7F108961CC1D2D223700C4A4A4BCBAC099065579959D9
      3FF321C0FC37241500FC65BF9C5B893F004F5504B0D686AA00B0AE2B85E679A6
      F323803106841014426BADF300E75CA8BCF0DB4DD370B86D5B388EE31EB06D1B
      D475CDDFDCF71DBAAEE33082E21C2E80D863F4B22C300C039FB1056C250AEF68
      F37545DFEAFB9E03DF46602ABCA3CDD774A0FED361454FD344EFA94286D6B3F6
      00D4388E1C44DF85512143EB59BF013824A5144829692E396501BFEA02283103
      CA0DD50B5CE7A961CC39B7430000000049454E44AE426082}
    ImageCollapse.Data = {
      89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
      6100000006624B474400FF00FF00FFA0BDA7930000006949444154388DEDCDBD
      0D82501486E127A196EA763A8138040BDC056E6CD880CD9CC34E1B1D079A5350
      006A221D6F729293EF271F3B9BD3C72D52AD781DAE3863C0E397E5823B0EA8E3
      2FDF96339E48132D85963F955BBC709CF14E784766911B9A15FF12999D7F3202
      D2150C7812C28DB10000000049454E44AE426082}
    ImageExpand.Data = {
      89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
      6100000006624B474400FF00FF00FFA0BDA7930000007149444154388DEDCEBB
      0983601486E1071CC1CA8085C415CC002EA07B9851B24556B1B2314D304D76B1
      F9058B788394BE709AEF72CEE1E4EF3C715DF1F39059E48601D90F2FC307C5D6
      1725DE4866DA2568E55679A2468F38CC0BD5DEF2C41D6D98662914AD2CE890E2
      8BC7D1EB270718019DA50D61708BEC0F0000000049454E44AE426082}
    ImageGrayed.Data = {
      89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
      61000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
      00097048597300000EC300000EC301C76FA8640000001A74455874536F667477
      617265005061696E742E4E45542076332E352E313147F3423700000040494441
      54384F63F8FFFF3F451842002972308A01A402DA190062E3C33000658349207B
      D40074097C1806A06C3009640F26038805D437801C0C37807CFC9F0100562665
      B720D01B600000000049454E44AE426082}
    ImageUnChecked.Data = {
      89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
      610000000467414D410000B18F0BFC6105000000097048597300000EC200000E
      C20115284A800000001A74455874536F667477617265005061696E742E4E4554
      2076332E352E313147F342370000002849444154384F63F8FFFF3F4518420029
      72308A01A4825103460D0081E1680039186E00F9F83F0300469125063C47E949
      0000000049454E44AE426082}
    ItemFont.Charset = DEFAULT_CHARSET
    ItemFont.Color = clWindowText
    ItemFont.Height = -11
    ItemFont.Name = 'Tahoma'
    ItemFont.Style = []
    PictureContainer = PictureContainer1
    TabOrder = 0
    TopCategoryIndex = 0
    Version = '1.0.0.0'
  end
  object Button9: TButton
    Left = 376
    Top = 24
    Width = 153
    Height = 25
    Caption = 'Add TMS product'
    TabOrder = 1
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 376
    Top = 55
    Width = 153
    Height = 25
    Caption = 'Check all TMS products'
    TabOrder = 2
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 376
    Top = 86
    Width = 153
    Height = 25
    Caption = 'Close TMS products'
    TabOrder = 3
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 376
    Top = 328
    Width = 153
    Height = 25
    Caption = 'Select sunny weather'
    TabOrder = 4
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 376
    Top = 512
    Width = 153
    Height = 25
    Caption = 'Add category with items'
    TabOrder = 5
    OnClick = Button13Click
  end
  object PictureContainer1: TPictureContainer
    Items = <
      item
        Picture.Stretch = False
        Picture.Frame = 1
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000009524944415478DAAD575B6F5CD5155E6BEF7DAE7366C673F53DC171AE
          909084D000497A890A22942054894A9578ED0FE843D5DFC15BD5A74A95AAAA45
          A22A94141EA256850492900B09B9919860C7F6D81EDB733B33E7B6CF5EDD9EA4
          494D8020E048F330D2CC5EDFFABE6F7D7B1D84EFE151A79E47F6D4BB74EF7B08
          8CD9A0BEC97FF1DB144C2F3EC7D2DC4D663E724BF6BF9F3B98A1F16B81A8ACA8
          74EE51A4FC9425BC28FC5E00C81099B0695D37E9F9175CF06609882730374234
          502BC2D0C20A6BEE4130EB42552E0B910BBADF0F8056C684684089EA9CBC4FF9
          91AACACC07A85206CDA252E5C50A1AE9346B6FB4A83C5BA0CCCABC28AF903CF7
          12134FBCA5BE350075F6058372F329E516077071AC07712F41E916099301C498
          C86C18189441151A39D6C9CF92B2112AAB2EDFF4F9A7F2C323AE78FA9DDE3DD6
          CE1D11FC8977E4370290AC5ACC28464A7D740421512555BC1942626DC1A8358F
          8AAA84F62826BC4C4E0B21B2253A894341B60146EA83D15A80887D06F1D62C3F
          7062419E7951902217F38B3E55AE8351F2D54301C82B7B4D2C2C71A86D362826
          8E71BC0587AE096AE62750B4895273970CD996587519258C8403D214F6129A2C
          0568BD81F16806F8E2694A37488886B55FD20E0D7EC6C4E8ADF6573290F88086
          07242FEF13E0174D26E2BCCA2C6558C3C912768710C3DDA9E8EC684DCB4712B9
          F331EE6E2B08B78CDAA298C65D92DD9900E5859A37B87ADC71AD4F01D5690A26
          18029FA5E10020726730CE182A570FD3EA15B23C490F301076C0E289C7B136A1
          B0592C01EF6C00DEDD0514547B4DFF407B69E280B7F9689EE72C40AE9B4502D4
          27F4674431A0C484DECC2729846F9D2C8E65CE21186721633420AA7CAC259454
          9AAF5365C624B3179B19905F2A41D2458EDD4C1167272A18E0A364AE6CF1EBC1
          CBFEE2A67DD9DD8705B3253083037006C8F0CE11A42732559ABE145444902CF9
          14CEBF3E55DD65FD1B65F638C4EC2A0D75A6A9B28C2092A691017A40827520CE
          4F1ACCA96F82D8792E5AA1E797CE769E2D1C7CC5E659039865009A4233C00034
          80B50348030045A012091449480309BD2B978889EB674B9B9D3FA3A32E2B965C
          103BDA8B6BE7C7CB7993B49BC9F6E53D00EADC51A4105C88130BAC9A0D18EC06
          6379C7DC99CEAFAD6C61DC7DF487C05C1398AD0108DE07708781FB00482A5071
          02AA174352AF41F3CCC978F090F727DB93BF2747CE913D40288B0645F90659DD
          B6B1E932DD03909E3FCA2101A6FF6D0235B6035BDD19F8ED1756CE357E91D9E1
          307BE341E01917D0125F00807700FC4F82447F82350037A077ED06A06D5DAAEE
          2ABD0B51E1434C0A1F2BD7AD219A09214AB1E72D750F80BCF9A4C0C0F62060A3
          10477B3480DDCBB7168EA6BDCE0E7BC206A3320462E01160A636A07117007E81
          8174CD035A825E43FBE006C48B3E74A7993FFEC3D26B28CB6750556B84998676
          590B6CE828A5A2FE0961CB401E67394961B010B318C4633A800ECC7F10FCC6CC
          271BCD918C0E103DDA1907B833A03DE068136A291887BB087471ADBF8CF44DD8
          D6003A209B3DCD820FFED5540DEF1F3F6618D97F02D8EF01946F911021DFFFF6
          FA2948CFFE640D8089B2A787BBF91889F68FE74E2DFECA1E4ECBE6B007465103
          702D60CE5D0FDC95616D0EFB13A0BB274D3FC56B0C4420DB8166A103FE95844A
          4F7AAF3939FE3A907D993FB1B82E8CFA00D4C9A30EA49001852E51B3ACCD37A9
          E7FFE0DC478BAFDA8349D91CF1EE30B006C036B504DA0786ADC7D1BC034026BA
          78A8F54FEE0368AD0168F70154F60DFFD5320AC721C95DA678608EC80A99A52D
          6F51F0600E7CB223C393D55162C1FE8573C16FB92977D9E35A82B2072C636909
          3C2D415117CF6916ECBB0C441A405B4F40434BE06B1F477D09E2C50E74AEAB64
          EC50F58F8CB2C710DCD30AF2AB60CB58EC3D795F82A40B6BAD18286D019D6C06
          7D671202B5BF35E3BF12CC359E72B6D868543C10390FB837A6B36048171FD03E
          70EFCE70A05968E9EE9774F77390FA1D4856BA10CDFB10AD180BA34FE77F0782
          9F0033BF0C797F81EC4E08462F0121E53A06D26B3F702834CB68D43783EC6D4F
          A3E4C0DC7BCBAF7893609B550DA0540191DFAC7DB0413350D541E4DD05E06B00
          75DDFDAC2E7E0B92E662DF80C18D88DC8D850FF283958B601A17C152A7202ECD
          831337F8D6D3D13A13CADBDB739026598C8C1CD64B82A03782667DCBF274F3E7
          71DD3FEC6C32D1AC0E6A291ED32C6CD579A047525474A6AE65802E1ECDE8EEA7
          34F5D7B5F6F310D77A102C8BDAD833D563CC898F53B77009B0286160550F836A
          81C0361FB9D1ED03905D6E41734C617D23E77BFE13CA933FF510E7AAC8BB1B09
          E28373E71BAF1A22DE6E8DBB600EEF0051DCA941E8ACB226D678D3C53FD7BADF
          D4C6BBA675BFDA375F4FDF7D957DB93F389E794C85651F3D91901D7C0232D344
          B21D2AD624146FD303264C3F7EC9A42861289B161A0B25A2E871153BBF5CB85A
          3B844930626FC8A039B85987D2A49E886ADF842AAC43DAD6D4AF4CE9CE5BBA73
          DE2DEFCAFFCD754B351D16FF2293BD0F940BC08EF3946D72AD7DDD189B79F03A
          5E07E4C46144156CD319B313B24B9B75055A9DEE1DF467E2674D27B58D928BCC
          75FB69A8A24053AF4DD7A4D4C83BD3A56DD65F4C2C3508AD0B3A826DC4CC1471
          B8CA0FDD59DDA385210BCCD5D82AC6F4D500DE3F3A0C5C5FF099FA242435CDB1
          3102ACB74D7175C89F859170399D9461886B31CC0D21CD01D1F22AD93973402D
          4164BEAB7FBFA80DE76BAA9AA0F8DABE10F01FFD63E92B37A275C5CFFCCC03D3
          97E0FA4310F31AF67464B0DB7ABFB08E800863BDAC6C8254DF19667B1A581C42
          6A59646019BA8515C8356B20733670F106754A594463196DD441C7745C2AC99E
          793BFC5A0074EA28A6DE0AA8E28CCD9488C4E8747F894C2FEEDEAA97501F63B6
          15DA458992721ACC2A09BF8749DE25279D44DF9B223BF128D7FE147B15C5F77E
          30AB4EBCE8B2836FF7D4D997105204B6FF4D7A28030FA4E3B5C70DC834AB6875
          7CBCF57811C0018CA40166D224082348742E175A63D81B5D22EC31F0961A60C9
          A25E68A6F9F64BF475677F2300727E43418CCC34E4EDF1322E4F7621CDEA9715
          D2EB117548A984586CB14A6D90E2619D40A9C2CC52994C7F01C9F0F8C6A9D677
          0290B4B2DAE69C1985669ADC1ECFB1D6640763CFA004B95E4923F1D49B4A5E38
          CCB1325DA2D8AB43AFC8307B3BCB374C3593A5A261545793EFCC40DF033DE03A
          FAD3BE4FCEBF2C70EFDFD7BDE5C8E5AA0BD20AC5D06D952E671918FA85221FD1
          C3CEFD566FC75FF6C41D579FC5C0CCFA0F2DFAFFCF7F017516E06E1CF3153100
          00000049454E44AE426082}
        Name = 'weather1'
        Tag = 0
      end
      item
        Picture.Stretch = False
        Picture.Frame = 1
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000007BA4944415478DAED96598C1C571586CFBD756BEB5A7A1D8F6749EC8C
          67BC2FF24A14146C841CCB02A128CF918044E20D21051E58848422441E9CA748
          C4201EF0D8D884D8209012EC2881388EC01BC4A0241A3BC00CC30C9ED5D33D5D
          D5B5D7BD9C5B3DB614219258F2A35B1AF5742DF77CF7FFFF73AA08DC834F36FB
          1061AB27447EE990C66BD3A9BAFE7D218FE7A1C21433CF3EEA5E72B7C5920E25
          9AC5C59DE2638734A2CD3165DD5F83FCC2E1321FFCA043B21A275AC878759CA8
          E520BEA700E9525927ADD5091BBA514064571FAB82394745C29BC46FF489BEF1
          251A3D08602FBACA436373D93B8729DB7596DF1380FCD26195D7278128DC256D
          DA8298DA40E82AA091034AFBA608FA87A13C334DC30121AAB718446C1CA22143
          D9F35A28EFE77F39C8E8EED7B3BB06C8FF3380D72900F3C31412A8F355D71565
          C1E80116E49019DB4140BFD0DA4D489D3E50A249102E0175FE5D92D46F0137E7
          216F70416C0B6AB3BE5835C1597589DF1DC0B5FDAAB09B0E494B82F8992BD274
          2B7167D7F128B13AB7F2BD6950DF048AABE2A58C88B979B396CE184E7C46A455
          9FD0F82A743668C2661EEF598869A4FACAFA6B9F0C208D8042683332BB9E9265
          D7167A7384C4591F90E511BFD93918057B3E65F43F62B1728500EDAE29720592
          F97FF3ECD65B334EEF8D931A5B3D2988F21E718D4511D6A6C16C27D0F38F1CAC
          E59C99C03F568134044A42CB2153C35512242382751E5B9A681F24F6E7B7190F
          0C604BE02E18C528E052184BC139888C038F14E8DCB81CD98DBFFDCEAC399720
          70FE006EFC2F31783305BDD36125C83FB905EFADA3A0B6D640A07FB13D153E11
          35FB1FB577EC23B4A402D51802603EE8CA523902A439F03885DCCF61F9CA2BD1
          AA1DE2A7CC116F083BBACAD67566D2B906059AB19CC6D9470204171F57A20E58
          3A9B73295B1CCEA07368F1EAFCD7CADBB75A5ADF302825BD0BA050DC8A5C4AA0
          02A2AB8004E844105EBF0259B078BD77A7F25D30604C90DE9470D7E35C5F5237
          5F49FF2FC0ABA7BE45862AB3D64CCB59AB386BBE5073B5FD567DC3EE64FC973D
          3554D31EDC00D45C0160B701562C4005449241E677209EBC0CDE5898F67FBAF7
          2596D77F0D50B92A54D70785C54423F187008E3CFF3C299926618C8DA82A1D71
          DDCACECD9B363D59ADD5870811143748306524983F0375F304186E190174EC50
          B2525FAC6420C30C7890B567209D5F82F04600A5C19E379D4ADF6F21AF5E04CD
          9E261ACE11154272F4E8514D5194439C73A354B2FA708978EB962D5F6D341A5B
          08218A611814CF439A26906719C1EBF07006BAF715706BCB002A43000694C940
          61F13C4505220488D18218D2050FA27FFAC02CE3D5DA90714424E57780AFF595
          47CE1793948C8E1EDF76E0C081B7F16ECBF37CCC1017AE6D13F9C162B8B6020A
          A54408019CE70500880844EBDB408D0A64641804ED05551D8346F50A188A8700
          31027433902CF808E001332B17AB83AB4F90C8FA23E4B5796046041A0FC8B973
          E71EDFB37BF7AF52946DE1D612602161972CC8724C320218868E8B33CC19850C
          1588A38888A2DF420C5FA96824A990943F4DDE87BAFD7370F409E0610B322F84
          680E15F8C017F683E5379C46E52450EB4DA11873A08709DBF8AE20A74F9FD9FB
          F0C3FBDE8AE2D468B5DB801910866EA08D59E16BC5756426886CD83CCF895429
          4D5384D280A13AAAAA16DF12441EEFF87F06473D0B91D784285A03493200D952
          5338A58BBF1974267F462D7A4DD84940CD760CA6979063A3A36BF77FE6D1CB0A
          633D519C805D2A616122E204BDC48D964C0DDB5C2952CE734EA452393EE22955
          0A85A43512404310D25509AF4B204E726823AC6C4B195DE0699CDF3CF28263CD
          9EAF97FD3153D366CDCD7F8AC8E8F1E3D475DD27464686BF5FAB5637EABA4ED3
          342B162EE68A7C9FC0FF09914D20308839B96D4F710D82A98C81691A08C22464
          718E0B0E0B8B4B90A5A99039926A264916C4A1B7D09AFEFD77F66D39F75AB567
          CA2B9AE7E5974F372AD5CA0B8EED1CA8D7EBBD32803A7A2F4F5A96251521CD56
          4B844158640333496E5B80A7644801C10BE06C45A1EEFF392469D2B553CA8050
          3917627C7CE264D8BAF2D4934F3DD79D84C7468FD7B0DFCF371AF5AD7192148B
          4A491DD701A6301284114A1A0302E0622991A193DEEB9A8630B4D8B1FC2D1549
          F07E59B068B1E2F920A45D02BB0B43DA3DE7FBED89EBD7CFEE7DFAE91F2E1500
          3F7AF1C7C471DC2F6FDEBCE1595CBC81C5752967A55226D26B0C1FA4598AF2A2
          AF6DAF28A81B064AAF4A3564EBA2D459A18EB45B82E03A283D2B0653C182BF7D
          9C8CD8CA72BDCE85B72FECFAE633DFF8FB9D49F88B974EEBD86B1B7DCFFBD2AE
          9D3BBE8EDD40354D5B49F8ED2927A0138610C7711150AB542A4EC8C2110E1E09
          268128E645D5D43BAA501960FCF6FC404471247F73B4E1D4F4D4D4331F1AC5AF
          9C7BDDF4DAEDCF3D30D0F7134D536B481A6311577A2E53D4FDEAEE38403B4C54
          4126BF2B7D5AB4A128024BE4EC28408A0126BAEF0A7192090921E78A0CC4C4C4
          C48BFFF3303A76E294D25E6ED7D02B6B7272BCB17DDBF6EF0D0CF47F162F34D0
          6F457A8E1572F45ADE1BA1B49A9C41323618BA18A1E5ACC6C368BC10B9746345
          C114B550A224C30CE17338CDA6DACBCD331FFB3EF0EC0F9EC3ACE90D24AE1185
          38B8AB0C05589605B08A87CF0813958950091DA7784064080ACB8924C5C72261
          A8804C638C56E908C8102BC6D66CE25F78D7AFE5F7FA731FE03EC07D80FF0292
          CE1EBB6E5F5D260000000049454E44AE426082}
        Name = 'weather2'
        Tag = 0
      end
      item
        Picture.Stretch = False
        Picture.Frame = 1
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000005FF4944415478DAED966D68956518C7EFFB7939EFE7ECECECCCBDC8DC
          464E9D3AE7664E739B6DF42110C1F28344540B3FF421846C1A8411844405E907
          F3ADE88B5B66E14A08822D4B6BFA452BE6070B916C536CEC7D673EE7F539CFCB
          DDFFBA370723282A23046F7878CEF3765FBFEB7FFDEFEB3E9CFDCF833F00B8EF
          016EDCB8C13D1E8F3E393919F3FBFD56341A35F2F9BC5D595929FE5380818101
          0D8176D8B6BDD3B2AC47162D5A14F07ABD2291488CEBBAFE8DAAAA47717D79D9
          B265EE3D07B870E142E5D0D0D049FC6CF1F97CB31371CEA000735D9709215861
          61A10BB00FC3E170E7860D1B32F70CA0B7B7B7F2D2A54BDF2258755151114BA5
          52CC711C191CF2330464082C41086E7474B4AFB6B6F6C9969696DCBF06E8EFEF
          D7CE9C39730EF26EA6E077B3A5A1280A2B292991BF93C9A40C1E8944E43B78F6
          4E7575F5BEE6E666F18F018E1C39ACFA7CFEA74E62D4D4D4B0AAAA2A964EA765
          601AA150886467333333F2A0FBA83F334D938D8F8FE710BCB6BDBDFDE6DF0238
          78F0A0820CCB90D91648BBBCACB4F499B367CF960C5CB9C2CACBCB6596301FD3
          344D0682E9D8F4F434CBE57212A2A0A040AA323636C6EAEBEB5FEBE8E878EB4F
          01DE3D708007FC7E8E096B702CC5048DA8DFD3B158EC21988C0BD7551DD7E530
          21BB76ED1ACB64326CC992252C9BCDB2A9A9290940F2931F507B79BFB8B85802
          5654547CD5DADABAA5A9A969C1AAE0C78F1FF7A0A68FA356BE40205826983057
          AF5AF5423C1E5FC5B902D9BD5C55356E597961D9B6EAC27054D743870E312C37
          86F764C63482C1A054043D8196A9342741915AE81557B76DDBD6D8D0D0602F00
          E8EAEAAE6B6B6BBB082D82C9241CEDBA22120A71369B31533595A9A827790D13
          420147BABCBBAB4B062F2D2D635008D966A4FC748F025FBF7E5DAE10F405A94E
          5D5DDD95AD5BB7AE5FBB76ADB300A0AFAFEF8987D7ADFB1CD9B189A96972B508
          0582CC9ECB140AC84C01C1F10E47B69C9C6FE5F3C8CA2BD73F4132008E8E8EB0
          E9C4B4049E989860232323CC300C40CC0060F5176BEAEBB7376FDAB4B0043D3D
          9FADDFB8B1A93F675ABE19BC0C0F089FD727D0E1E4E4D148883CC1C92D8EED30
          2395E6F9BCC53C80D2748DE9A8AFAEABD24E7928333C3CCCC6507F4551250499
          D0802F52C9E4614DD7F7763CF76C7E01C089AEAEAA4737B75E5635AD3867E659
          281090EA9B0842B207FC1EA6A92A9584B98ECB48055287B2BCDB07342840401C
          F72CCB41096C469046323DD7274857619C3F7F6E0796EE80A66AD3FBF6BDEACE
          7AA0BB5B41C3D85E53B3F48D5861E10A9846B12C7BBEC1D06444024342652155
          00009F6F42002315FC7E9F743B41D23357B86C623241C048800B4A0A50D9543A
          3DFCF3D59F76EFDAF562EFFC323C7DBA271E2D8CBE170E85DBD0E14A68C97951
          7B3EE76CBA4ECCCC886C262BBD013B705DF7C8CCA5079039B99D06954E42CBDF
          2ECA9247392D41120A4039AE108383373F1E1A1ADCB9774FA72D014E7475C756
          D6D67E178F17AD36612E9A94240D47C2A0D778269B6366DE6400A0C9B02C5569
          4CAFC7233B1E654CD7A40876480941BA73854BF5C80F585DD2B8F40C9EF8F5FB
          1F7E5CB7E7E5DD8604387AEC7D1E0E479E5FB972F97E4C1E47702FC9198D1670
          F931B2B66C6C30381B465206F4A20BEA9A2EA0869CDC46D9481D4E8542508284
          AF182D65525A5155914AA5F12D79C449F7F75F6C7C656FE72FF39DF0934F7BD0
          719415706B476343FD4B580D0A9A87947976606257B034BA1BB55D2A7F1086C5
          DCC286E4B99C39B7F170A6C02FBA479F57452103E39C4C6544CECCD1B53B3838
          74EAB7DBB73B17B4E22FFBBEF6270DE3B18AC5651FE04F4E0CA4268244A8E664
          B6D9D36CC61994C30F15B86C5242BA9E1A9490868531B1440984AEC99034CCBC
          2D0802CF209470F19FE2D81F36A3131F9D528D3B460CB50ADEBA35185F53B7E6
          F5C58BCBDBF1A20FF556E5EEC7B9835AD3B73948EB813816D9C6B61D13D02EA7
          1EAE2A2A823B548D39052D68A1E6F2363CA49828D96DE34EE2B3BFDC8EF7BFF9
          36BCE68D8338C6551E46563604B843011025893DC20F657250C28B2E9EE16402
          59724EA40EACA8410172A3098F7801A801CB44F74CE0C8DEFFFF8A1F003C00B8
          EF017E0727ED366DCCC1A6190000000049454E44AE426082}
        Name = 'weather3'
        Tag = 0
      end
      item
        Picture.Stretch = False
        Picture.Frame = 1
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000049C4944415478DAED964B48A35714C7EF9798C4F88A26F1AD69CC80A8
          0856519916716151114A37A5140A15850EB36A17B39DC540BBEDAAAE2A2828A5
          74364265A0F541179652EA502D8E05C5F1818E568DA331C6BCCCA3BF73EB94DA
          76D156A7B3F183C3FDEEFDEE3DE77FFEE77F6E62A817FC18D700AEC2C9E6E6A6
          E1F178D2FF2B80B9B9B9926432F98EC56269CBCDCD759B4CA64028147A68369B
          3FAFABAB5B7D6E002627274D9148E483A3A3A38F089C236B0455369B4DA55229
          65B55AE3BC0F00E86E5B5B5BEC4A018C8F8F1B5B5B5B1F13FC4E6161A18A46A3
          2A914828802897CBA581C4E37165B7DBD5DEDEDE03CAF266575757FCCA008C8E
          8EBE35313171BFB6B6D6906CD3E9B4320C43072C2828502727277AEE743AF5C8
          F70F7B7B7BEF5D09809999998CA1A1A1477EBFBFA6A9A949674EFD1554ABECEC
          6C959797A7D6D7D775E0929212FDEDE0E020D4DADAEAEBE9E9F15F1AC0D8D858
          CBE0E0E0AC042C2B2BD3417D3E9F4288EAF8F8589D9E9EEAE081404097A1AAAA
          4AEDEFEFAB969696F7FAFBFB872E0D606464E4D6D4D4D4A0D45B1EA1BCBCBC5C
          391C0E1D5C1891C04B4B4B7A2EA22C2E2E56D5D5D503CDCDCD77EAEBEB139702
          303C3CFC3EADF78938CDCACA529595952A232343E5E7E7ABCCCC4C0D4044B9B6
          B6A6470141091481BFA8A8A8B8DDDDDD1DFCC7003A3B3B8DF6F676119AA5B1B1
          D168686830969797DFC5F9A7E170585A4DABDEED76ABD2D252AD7E012025A045
          D5E1E1A12EC5CACA8A087200E0F7106F8CBDD1D9D9D9D4DF02C0A14156A6A2A2
          221BA81D8070D14676C4E422E3AA9C9C9C3644F63625304BDD45646242BB3C32
          4A57487720D4DF4734709F327D0D233FACAEAE2E7774745C04C006AB508868D2
          A8B7A0AFAFAF10CAECD06B21A37CC69718CBC41617175F63EE7D263CB90B840D
          D1813CD286DC86BA040286FB6217263F03DC4FB0340BE03DB6C9E574C6390DC4
          585858F0E02C9FCCD350178756370132391443640E0EBD0AC03C1C1C11203C3D
          3D7D175A7310976E3D119BD02F19C7623109AA6B4F80A4D7EBFD127041BE17E0
          E7DBB3B3B3872472C8DE04A55C216E4A6AEBE360ABB0406BE542F54DDEE7D8F4
          23756C847E1F174D0DA09264BFC341F7F6F6F61B38B449E6C2803022198B3ECE
          DB3049F93629EB53D67731BAD71422C16FD8FB009D444826150C06A306C19D2C
          FAA0AE92D101DA20F57A42F66602A6081466ED750E1731B702300E1B2D38A825
          A094C8F4EC06E47C9AFD4148FC19AD1C4A09097E225433FE02B0AFD0C5773014
          617E4A7B9E1992181B5D807A99D10385E5ACED43AF1FDBE6503687BC38B670A8
          90E05994C0464637A0F429FB0DCEB2E434604A7A3D0C0B019829C2CF293FD58F
          A07A8D607ED87CCC5A80DF931897D86F1AC0A9988D77339685D357B00E3273E3
          E498B5142C6DC0C216183CBC3FC6914BBEF32D20D4F31C615E122867BE0423DF
          EFEEEE6E1238BEB3B3A33636360CEE81504D4D8D01D369D849FFA50D3968C641
          527A9F692EEF37CF1D47B06CC9EC7C6B14BB81C9BE2D2C84D9B132CC8AAD6022
          34A9BF0163998C49988C22D8047E2FFC71F957BF86F3F3F306379F49F0D2B617
          FA5912908100A93FADE9752CF9C76FFF09C0F378AE015C03B806700DE08503F8
          15AB5C9F2E81AEECEC0000000049454E44AE426082}
        Name = 'weather4'
        Tag = 0
      end
      item
        Picture.Stretch = False
        Picture.Frame = 1
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000096F4944415478DABD567B7054E5153FDF7DEDEEDDF766379B8498F008
          9010DE20A060138BB50C8A236AA733F40FAB637D52B5D28E33D6FAEED4511014
          79D6AA61D056AC63C780E2F84040684191201A8A204920C96E76937DEFBD7B9F
          5FCFB7019DD696C14AFB65EEECDC7BBF7BCEEFFC7EBF73BE1038CFCBDEB780E7
          666FB7CEDC6B8A441CB24EFFD37E723E929A071671544A13BC783E5721D1489F
          4AF4806DBBD34EEA4996247FFEFC03D0E2218953A38638EA08B5F65F42808320
          750E00C9B91D343A9025C57A4AFD718F50DF95343BAEE284A96FD8E70D80F5F1
          A53CF52644E02D3F29EA69D0B810B1DCA3A9AB4F234AA5DFF627E3A43882838A
          8114E4226930221A3FEB3DDBFE78A1C4CD7C53FF4E00B4EE7A41C8D670441143
          34F4A59FE4A43A4A8A41B0C4269B2BB9C1141D9C640D017161A2F456302A0DA0
          CE1E02352EEA2B94A89CD684917FB7FF2B0066E74C89945C4EE24A4720CF07C0
          54671B42724A21169C660B531B89232A03E10835D225CEEAEC953D2777485EAB
          1DD4FA0C71BA06A8C74C514D562090D084BAA3F45B0148C4029CA4C92E3951EB
          E22DAD01F8E2654A3A3D4B2DCDBD5C1E3DDD41240B083F1C8EDA14A8C143A9FF
          A421E86FEDF156F2DB40F076801E3862476319A8889BA2B7A47D2B006B9E7D88
          F738065DF327BF1BAEE6F5F96A3A7B652151BFC83DF1429E970520125E3CF735
          00DD045B3540ED3A658B64EF1E6FD4BD81060AFBA94F3F2956A99A990AF04228
          639D15C08A152B384A697555557461C02B4FA81FD5304F4DEEFC689C73792C77
          B0EF17DEC91705A5CA5AE06509882830F6CB250D336021001DCC9C02993DEDA5
          E81CF70AC1A36DA672B00056C0445FA484B187F47F02F0E493CB892CBB882008
          63F16AF0FBFDD39B9A9A968442A13104D73063364D1FFF4BC273ECBE6ADF841A
          22558E05CE89C9456E18006380DA080019281960A462A0741E04C1E13E10ACAB
          FA3D5815EF832390001055CA890659B76E9DC4F3FC0F6DDB76CAB25C8DCED026
          3637DF1C0E879B31272F490E228A02D10D835A2606B56D426C9DD89F2E22C1DA
          22F0C13070AE20F02801C7338858BDCD00E8602919301180D68B9DDA2FC4AB27
          D63F0776C5DBC0FBBFA0BC90E567B76BA4AD6DD3A4D6D6D6DD98CC9DCA64CA0C
          FABCDE72B598140CBC5C2E27F018DD4400581EA1B64ACCA34B8918A9042A4FC0
          62AA41E03F8770C57EDC8BDE320DB01903AA06665605AD2F03CA713351332770
          2FCE8BB7B8592707BE6AC3EDDBB75F3D73E68CD718C3F98202AA5AA212EA5954
          55281615969444C215E0F1608B63505DD799C804A84A3841C60804785E60C483
          A11F82706033F8E47EB0B53C58C512E81915F43E64A0C71CA89E56FD3898DE77
          918504E1C512387895BCFAEA9F2FBCF8E2393B5DAC4C8C52544AAC6A5AC22E61
          D53B9D12F1FBBC288304B66521C822B2AB1351129957805D2851D91E6CBF52FC
          04BCCEF74153F3A02A95086A04D8852490D83BDD0D63634F890E71B7ED82539C
          5C50A8A46BE4C5B6B69197B6B4ECF3F9BC114238B0503FA6B78600D0CCE0728A
          200A226106B32D1B0C94C144201C526622D56CBF03C1399C0EE038AE2C936D19
          A0611BE6F20554ECF439848EE4FB1F6F7338865EF2399D9D9EC8C0907B5C8745
          DA366DE27C3EDF35E3C78D7BA822146A144481D375E3EBB96F31DD19D3C83AFE
          B177C6692F308F98A60532928731CA4C30906854046F43722885B2192811C7BE
          47E60C4D5572035AF68D07A7D4FDB53D50D59B29F7CD962DAF8603C1C0335E8F
          A755767BA2889A04830156256067B08FC9502A45F3F93CD0D36098621C1BBB08
          4A44196497ABEC07C64019341BDD2663532B3F23D81EAC3D2D9BD21327BA5FD2
          727B6F5CF2D327CC328017DB36852634357D100E574C54D07C8C34161001315A
          4901CDC8F42D140A1473106C5BCAB497907A5EC0F98BA844512CD3CD5839DDAE
          D8961C630AE703472D940D1900F65B28E4BA3A3A76CDB8E38E5F0F33B066CD7A
          E2F17AAF6F6E6E7C58E0F94A0CE6902409700011469FA2A850D23460732693C9
          A2BE7A3921564C3D6E3763822527EC397E8F94F38052B279504E6C5A2631B1F4
          3C7A421478B6B7B86BD7AEE9BF5CB6ECD85793F0E9D5EB395529042549BCB5B5
          E59247907A0EA722151108B61E194E62432299844C365766C7EBF50E0F3EAC52
          2D95CA92B16E1130091AB7ACFD19564AF83E9B2F943D8920EDAEAEAE977B4F9D
          BAE71B67C1737F78615E7DFD05AF701C1F921C4E55E088DF300D8E55C6B467F3
          41D374C0CA299A0FBB83C742AD617362A233AE67123100169A92B1C02451548D
          6AB88F99950DBC783CBEE61B00563FBB9EA0CB2B50404F2C431D2322CEC71219
          B27844C0607EE0CA470273B451BE37906EE144C64D46FAF22C37CA6C20CBBC85
          C9896198244702A4944A435588D350068101C0181682E8C686FBD3594FC3F937
          AEF373C4AC974169ACAC945283F1DC144FD4DF92EC1EDA397AC6E441A3FFE85E
          576D4DEB679FC403A3C6447B537DB1180FBA6754AD7858F3D55E7BB247BD2CE4
          4AAC35B8A86A6B9C9ECF66BE17F4097B753C3E6533BBAFBE52C89F15C08C1F3F
          53552A2AC9AABAC8189E339B53F101D9B6B4D79D9EB02BDEDDB3A0BA467839DC
          30FDAE9ECFBBD48AA8FF602A59ECC779941424211C8C08375BA6B37530A9DE24
          88F6909A533D132E9EB5F7C89EDD53C74CBF70DA17FB0F7ED8D1FE807A560053
          AE7DE637875EBBF3D1E605F7F1C188A735DED5DD7BFCC38D475B6E5A395BF6C8
          B7BCB5EA961BC7CFBFABC6D28BA9E3BB9F2B8D9ABBF4725F4568875EB278257D
          92935CC4ABE8232E052BF78AEC329C2EAF7CEBA7DB56AD1CD77A3BF7C5076BED
          B3FE473469E1ADC41DB8E0F178AF76B87BD7239BD9B3698B1FBCFFE0EB0F3FD6
          34FF36B43FF578A34D53FA8E767ED47760C3D065B7ADFA3E05E19AF7D62D5D3A
          6EC1CA07F203479FA86D8C088D73AEE8DBB9F9F9064E922776EF59B5E35FF39C
          9D81AB96F9EB9A2F3AD0FEBBEB1AD8FDD42BEEB8BD63DB9AB5E1C977370C7EBA
          EAF8BC1B96CF8D1DEF120AE9C17E7F4048E0549442758DF9892D57A4DF5CBB7A
          7C788433AE95E0679224AF95FDA107123D5F3EDAFDB717EC730230FA07AB8327
          DEF979BA66D2959162CE28667BDE56D8F34B6E5EED76CA551F7DB6636B73EC50
          1BFDC993ED2FEFDFFAF61F8FED7CB6FDCCB7D593AE9C1D3BBC751F9CC3FAB700
          E6DEF4BCE8747B37BEF7F48F6E28839977E72D4A36FE7AFCF096C4AC25F707F5
          BC7A7747FB8A07D9BB59D7DDFBDB422ABDB6F3FD8D7DE792F09C2598B0E09E40
          E7F6A7323316FF4A9AB9F0EA236FAEDFB0E4D4814DE754D5790170668D6FB9DE
          17AA1EB97CB0B77BD9B10FDBF2FF7700FFEBF50F5C56B97842D8F1D700000000
          49454E44AE426082}
        Name = 'weather5'
        Tag = 0
      end
      item
        Picture.Stretch = False
        Picture.Frame = 1
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000006E34944415478DAED967B7054D51DC7CFB9F7EEDEDDBDFBC8661F5450
          0386842410D15204634752FB105A6D3B8A038E8A2F8C88B4E5A183C53FA0CE28
          0AD69918798C5A2429380AD2521D4D661CA21914E4E193C710C8633164375936
          FBB8FBB8BBF775FAFB6D80A9433B5D671CFD873BB38FB3E777CFEF73BEDFDFEF
          DCA5E407BEE825804B0097004A0D5CBF6E1D6F326617AD5665E9B265C6F702D0
          DCDCCCE9BA3E36180CCE71399D932A2B2B6FECE9E97967381A7D71D1A245A9EF
          1C60E3C68DD4E57261D22A9EE7ABE0FBB593AAABEF2CF7F92A29C6527867CCEC
          EDEBFB87CFE75B3171E24499E338108619F0C24F1320CDD3A74FB39201366DDA
          648564379BA669733A5D97518EAAB535354D7EBFAF8E108EB78A566A11040A50
          4C370C621A26705035954AFEAAAAAAAA3B954A19994CD61404410D87C3DA9A35
          ABCDF6F6F6922DA2ADAD6DF58D8D8D7B6151299E4CA224CCE37653DC6FA1A012
          4DD388C3E1209080E8F0DD304D8CC90F0C7CBD249D4E5B29E5A6C0FCE5D1E8F0
          C7B158AC95178491C58F3C52BA021D1D1DBF9F3EFD27BB6021924E678892CF33
          5114F1934202A66A3AFD5130409C92443450219FCFE37D0C801578D9700D5010
          AD3423E1F0A17024F28786EB671E0760160A85485F5F3F5F28147488D5162CB8
          E72230BA73E75BD31B1A66763925A70D67B3D91C486D927C21CFE04662030BCA
          3C1E6AB55A40019DC9E92C4355AC562BE1051EECE1095844B03E344D2791A1A1
          BD40D392CD662525AF4CE379A11AD649448787B71554754FD3430B0BDF00D8DA
          DA3AFE67B3661D28F39605A0A08A1EABB05325A714E586BEC364201025866E10
          50040075C241425DD728C6406B12BBDD4E388E473806F5026EE97C4ACE109315
          2DA35063E9CECE3DF372D9EC6700155FB5EA0973B406DADA38B7DB7D1B54FB9A
          40C05F238A364E5555629A06143CC12420380402008364055583DFF4223DEE18
          611C901C5422160BA804856AC06F26F44434162FAA0542E14554555332D9ECE0
          B12347972E59B2B8FD421BEED8B1D3EFF57A5B40854687430A62017A6141BC70
          671837128F33594E0314839D5222414D80F7C5315A2039248862988468B001B4
          53D70DA8211594D3B17328AA611826EBEB0B6DEFEFEF7BE0B115CBF522C0D6D6
          B6F2BADADA0F83630253A006085A8145E7901C04B5873603E935285299A19CB0
          5366B3D98A3B1E85401B44581C2C52473BC7C46E39A7DA680C29CE21106CA4F7
          E0A1C3D3562C5B2A1701366CDC4CE10CB8B77E4ADD5FA0B082E0B96887045E6F
          1945989C92277905ABDF248944B20863B381E73CC71014E545253001D60626C4
          4E4220B40B6CA26849322517D503A86C57D7DE1F3FFED8F253174EC2E696CD9C
          92CB7845D1B2A871D68D4F399D4E0E646658ED50C598A3B8ABA1E16182C55556
          E621705E145B12CE4080548ACA592C02783E0A70DE2204C3F978526626400902
          6F427BBE7E666060F945CF8257FFF6DA4F2B2AAE7C136E2E971C8E0C28520E07
          1287E4B8BB0C5804E7012477319807D77143A349CE9D11C844AC162B110006EA
          E09C2506DCAB302C628483311B8A0C6DB808A0E5A5CD1412F800C0C9F35C010E
          94F5D06AB7E19A1C8FAE621570D81D0CDA49831881E0B380101E24D720810011
          06142687CF861C118568CC20157E2DAFEBA600F314AC332C3C1F829037FEEFE3
          F8D9E7FE2AAABAE14FE78D31DD03FA5CBBCF7D753C2A1FBC3CE8E80A48AC17EC
          29172CD6547F589DE771B14E25A706827EFBD1EE53B179D5536B778722A4BEDC
          9218A9080A278F9E88FE7CC215D2A73681A9A24D8C02A452F2FF81D94DCF4DB6
          F927AC3971F0F3BB28D535C91DA0A938739FFA6065B2FED74F8D0B8E1FF37C66
          2475772EA3DBC755965F433871B541B9B9E9B305FB27DB9A86E63CBC4EB08D99
          F8F999C37BAE3EF4DE860B4772C9007537DD6F354C2AB9C75D27CB89BC687768
          F37D632BBB638383FB275F5F3BED48D7BEC8D8CAF18A922DD8A931325B2BD05F
          ECDBBE72FEF9FBA7FE66995BF2B89F3EFBF5E93F9EFA68EBB707387FDDBAFA6D
          FFC0919EABAE9A7CD9B3BD5FF5DDFEE5BF9E4C342C78BE428E25A20E8F071E21
          2671FB5C36AF3F5017099DF94C4E149C3939AD0FEC7F46F96FEB950C5036A9C9
          9EEC7E5999B1A085CB9C3D4372232167FFC137659CF3D7CCAD8E9D78EB247E6F
          78B0EDCA484FCF0C875DDB75AC63AD397F6DFBB4AF3EFAA2E6F8BB7FDEFEAD00
          2A7FB9C1DBFBFEA389F3E319F76ED9153EB66FEEC0E157BFF1489DB5703DCDC8
          DAEE4F77ACFA1D8E1F7A65EF4BFBFFD9291F7D6FF52A1C5F37FFE972F88FF0F0
          FE6D2BD7960C70C3C22D169BE47A794FF31DF7E3F89ADF2EE61C9E2BB6864F9E
          BC2F74E035F33F63A7DEF2A79913EAEAB7EC5EB7B00EC753E63C3A3D1B9707FB
          0FFC3D5C8AB2FF5381BAD9CBCB8E77BC902C659171936FB20C1EEBD44AB5B324
          80EFEBFAC101FE0D710B914299E6AD320000000049454E44AE426082}
        Name = 'weather6'
        Tag = 0
      end>
    Version = '2.0.0.0'
    Left = 488
    Top = 416
  end
end