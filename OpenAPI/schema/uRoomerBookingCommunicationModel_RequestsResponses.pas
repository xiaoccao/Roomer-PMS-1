unit uRoomerBookingCommunicationModel_RequestsResponses;

interface

uses
   Classes
   , SysUtils
   , Spring.Collections.Lists
   , Spring.Collections
   , uRoomerSchema
   , XMLIntf
   , OXmlPDOM
   , uRoomerFinancialDataModel_ModelObjects
   ;

const
  cRmrrrNameSpaceURI = 'http://www.promoir.nl/roomer/booking/2014/02';


type


{$REGION 'Invoiceresponse XML Sample data'}
  //<ns2:InvoiceResponse xmlns="http://roomer.promoir.nl/datamodel/canonical/basetypes/2014/01/" xmlns:ns2="http://www.promoir.nl/roomer/booking/2014/02" xmlns:ns3="http://roomer.promoir.nl/datamodel/financial/modelobjects/2014/01/" xmlns:ns4="http://roomer.promoir.nl/datamodel/housing/modelobjects/2014/01/" xmlns:ns5="http://roomer.promoir.nl/datamodel/canonical/simpletypes/2014/01/" xmlns:ns6="http://roomer.promoir.nl/datamodel/canonical/datastructures/2014/01/" xmlns:ns7="http://roomer.promoir.nl/datamodel/booking/modelobjects/2014/01/" xmlns:ns8="http://roomer.promoir.nl/datamodel/payment/basetypes/2014/01/" xmlns:ns9="http://roomer.promoir.nl/datamodel/payment/modelobjects/2014/01/" xmlns:ns10="http://roomer.promoir.nl/datamodel/inventory/modelobjects/2015/11/" xmlns:ns11="http://www.promoir.nl/roomer/application/registration/2014/04" xmlns:ns12="http://www.promoir.nl/roomer/static/resources/2014/04" xmlns:ns13="http://www.promoir.nl/roomer/inventory/2014/08" xmlns:ns14="http://www.promoir.nl/roomer/configuration/2015/12" xmlns:ns15="http://www.promoir.nl/roomer/pos/2014/03" xmlns:ns16="http://www.promoir.nl/roomer/financials/2016/08" xmlns:ns17="http://www.promoir.nl/roomer/services/hotel/2017/01">
  //   <ns2:invoice id="inv397495" reservation="2060" roomReservation="5215" index="0" type="CREDIT" state="OPEN" date="2015-03-18+01:00" printedBy="bg">
  //      <ns3:LineItem index="0" creatorId="ROOMER" creationType="ROOMER_SYSTEM">
  //         <ns3:SalesItem status="UNPAID" applicationDate="2015-03-18+01:00" id="it267027" description="Room 104, 18-03 - 19-03" productId="ROOM" number="1.0" purchaseDateTime="2015-03-18T00:00:00.000+01:00">
  //            <ns3:unitPrice currency="EUR" amount="200"/>
  //            <ns3:convertedUnitPrice currency="EUR" amount="200.0"/>
  //            <ns3:conversionRate from="EUR" to="EUR" factor="1.0" date="2017-03-16T14:18:38.849+01:00"/>
  //            <ns3:totalPrice currency="EUR" amount="200"/>
  //            <ns3:PaymentUnitPrice currency="EUR" amount="200.0"/>
  //            <ns3:PaymentConversionRate from="EUR" to="EUR" factor="1" date="2017-03-16T14:18:38.851+01:00"/>
  //            <ns3:TotalPriceGross currency="EUR" amount="188.679245"/>
  //            <ns3:TotalConvertedPriceGross currency="EUR" amount="188.6792453"/>
  //            <ns3:TotalConvertedPriceNet currency="EUR" amount="200.0"/>
  //            <ns3:TotalPaymentPriceGross currency="EUR" amount="188.6792453"/>
  //            <ns3:TotalPaymentPriceNet currency="EUR" amount="200.0"/>
  //            <ns3:ApplicableTax description="VAT 6 loing descriptionasda" currency="EUR" amount="11.3207547"/>
  //         </ns3:SalesItem>
  //      </ns3:LineItem>
  //      <ns3:CustomerData customer="GUEST-NL" customerReference=""/>
  //      <ns3:GuestData>
  //         <ns3:Name>Bjorn Heidarr Gudmundsson</ns3:Name>
  //         <ns3:Address>
  //            <Address/>
  //            <PostalCode/>
  //            <Locality/>
  //         </ns3:Address>
  //      </ns3:GuestData>
  //      <ns3:CurrencyData>
  //         <ns3:InvoiceCurrency>EUR</ns3:InvoiceCurrency>
  //         <ns3:ConversionFromHotelCurrency from="EUR" to="EUR" factor="160.0" date="2017-03-16T14:18:26.776+01:00"/>
  //      </ns3:CurrencyData>
  //   </ns2:invoice>
  //</ns2:InvoiceResponse>
{$ENDREGION}
  TxsdInvoice = class(TxsdExtendedInvoiceType)
  private const
    cNodeName = 'invoice';
  public
    class function GetNameSpaceURI: string; override;
    class function GetNodeName: string; override;
  end;



{$REGION 'Invoiceresponse xsd definition'}
  //	<element name="InvoiceResponse">
  //		<complexType>
  //			<sequence>
  //				<element name="invoice" type="rmrfmo:ExtendedInvoiceType" maxOccurs="unbounded" />
  //			</sequence>
  //		</complexType>
  //	</element>
{$ENDREGION}
  TxsdInvoiceResponse = class(TxsdBaseObjectList<TxsdInvoice>)
  private const
    cNodeName = 'InvoiceResponse';
  public
    class function GetNameSpaceURI: string; override;
    class function GetNodeName: string; override;
  end;

implementation



{ TxsdInvoice }

class function TxsdInvoice.GetNameSpaceURI: string;
begin
  Result :=cRmrrrNameSpaceURI;
end;

class function TxsdInvoice.GetNodeName: string;
begin
  Result := cNodeName;
end;

{ TxsdInvoiceResponse }

class function TxsdInvoiceResponse.GetNameSpaceURI: string;
begin
  Result := cRmrrrNameSpaceURI;
end;

class function TxsdInvoiceResponse.GetNodeName: string;
begin
  Result := cNodeName;
end;

end.