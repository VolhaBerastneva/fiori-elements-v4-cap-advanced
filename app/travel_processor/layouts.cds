using TravelService from '../../srv/travel-service';
using from '../../db/schema';
using from '@sap/cds/common';
using from '../../db/master-data';




//
// annotatios that control the fiori layout
//

annotate TravelService.Travel with @(
    UI: {
    
        Identification        : [
            {
                $Type : 'UI.DataFieldForAction',
                Action: 'TravelService.acceptTravel',
                Label : '{i18n>AcceptTravel}'
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action: 'TravelService.rejectTravel',
                Label : '{i18n>RejectTravel}'
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'TravelService.deductDiscount',
                Label : '{i18n>DeductDiscount}',
            },
        ],
        HeaderInfo            : {
            TypeName      : '{i18n>Travel}',
            TypeNamePlural: '{i18n>Travels}',
            Title         : {
                $Type: 'UI.DataField',
                Value: Description
            },
            Description   : {
                $Type: 'UI.DataField',
                Value: TravelID
            }
        },
        PresentationVariant   : {
            Text          : 'Default',
            Visualizations: ['@UI.LineItem'],
            SortOrder     : [{
                $Type     : 'Common.SortOrderType',
                Property  : TravelID,
                Descending: true
            }]
        },
        SelectionFields       : [
            to_Agency_AgencyID,
            to_Customer_CustomerID,
            TravelStatus_code,
            BeginDate,
            EndDate,
        ],
        LineItem              : [
            {
                $Type : 'UI.DataFieldForAction',
                Action: 'TravelService.acceptTravel',
                Label : '{i18n>AcceptTravel}'
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action: 'TravelService.rejectTravel',
                Label : '{i18n>RejectTravel}'
            },
            {
                Value            : TravelID,
                ![@UI.Importance]: #High
            },
            {
                Value            : to_Customer_CustomerID,
                ![@UI.Importance]: #High
            },
            {Value: BeginDate},
            {Value: EndDate},
            {Value: BookingFee},
            {Value: TotalPrice},
            {
                $Type            : 'UI.DataField',
                Value            : TravelStatus_code,
                Criticality      : TravelStatus.criticality,
                ![@UI.Importance]: #High
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'TravelService.deductDiscount',
                Label : 'Deduct Discount',
            },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#Progress',
            Label : '{i18n>ProgressOfTravel}',
        },
            {
                $Type : 'UI.DataFieldForAnnotation',
                Target : 'to_Agency/@Communication.Contact#contact',
                Label : '{i18n>AgencyID}',
            },
        ],
        Facets                : [
            {
                $Type : 'UI.CollectionFacet',
                Label : '{i18n>GeneralInformation}',
                ID    : 'Travel',
                Facets: [{ // travel details
                    $Type : 'UI.ReferenceFacet',
                    ID    : 'TravelData',
                    Target: '@UI.FieldGroup#TravelData',
                    Label : '{i18n>GeneralInformation}'
                }]
            },
            { // booking list
                $Type : 'UI.ReferenceFacet',
                Target: 'to_Booking/@UI.PresentationVariant',
                Label : '{i18n>Bookings}'
            }
        ],
        FieldGroup #TravelData: {Data: [
            {Value: TravelID},
            {Value: to_Agency_AgencyID},
            {Value: to_Customer_CustomerID},
            {Value: Description}
        ]},
        FieldGroup #DateData  : {Data: [
            {
                $Type: 'UI.DataField',
                Value: BeginDate
            },
            {
                $Type: 'UI.DataField',
                Value: EndDate
            }
        ]}
    },
    UI.DataPoint #Progress : {
        Value : Progress,
        Visualization : #Progress,
        TargetValue : 100,
    },
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : ![@UI.PresentationVariant],
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : '{i18n>Accepted}',
    },
    UI.LineItem #tableView : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'TravelService.rejectTravel',
            Label : 'rejectTravel',
        },
        {
            $Type : 'UI.DataField',
            Value : Description,
        },
        {
            $Type : 'UI.DataField',
            Value : to_Customer_CustomerID,
        },
        {
            $Type : 'UI.DataField',
            Value : TravelID,
            Label : 'TravelID',
        },
        {
            $Type : 'UI.DataField',
            Value : LastChangedAt,
        },
    ],
    UI.SelectionPresentationVariant #tableView1 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : '{i18n>Accepted}',
    },
    UI.LineItem #tableView1 : [
    ],
    UI.SelectionPresentationVariant #tableView2 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView1',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : '{i18n>Open}',
    },
    UI.LineItem #tableView2 : [
        {
            $Type : 'UI.DataField',
            Value : Description,
        },
        {
            $Type : 'UI.DataField',
            Value : LastChangedAt,
        },
        {
            $Type : 'UI.DataField',
            Value : to_Customer_CustomerID,
        },
        {
            $Type : 'UI.DataField',
            Value : to_Agency_AgencyID,
        },
    ],
    UI.SelectionPresentationVariant #tableView3 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView2',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : '{i18n>Chanceled}',
    },
    UI.DataPoint #TravelStatus_code : {
        $Type : 'UI.DataPointType',
        Value : TravelStatus_code,
        Title : '{i18n>TravelStatus}',
        Criticality : TravelStatus.criticality,
    },
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'TravelStatus_code',
            Target : '@UI.DataPoint#TravelStatus_code',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'TotalPrice',
            Target : '@UI.DataPoint#TotalPrice',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'Progress',
            Target : '@UI.DataPoint#progress',
        },
    ],
    UI.DataPoint #TotalPrice : {
        $Type : 'UI.DataPointType',
        Value : TotalPrice,
        Title : '{i18n>TotalPrice}',
    },
    UI.DataPoint #progress : {
        $Type : 'UI.DataPointType',
        Value : Progress,
        Title : '{i18n>ProgressOfTravel}',
        TargetValue : 100,
        Visualization : #Progress,
    },
);

annotate TravelService.Booking with @(
    UI: {
        Identification                : [{Value: BookingID}, ],
        HeaderInfo                    : {
            TypeName      : '{i18n>Bookings}',
            TypeNamePlural: '{i18n>Bookings}',
            Title         : {Value: to_Customer.LastName},
            Description   : {Value: BookingID}
        },
        PresentationVariant           : {
            Visualizations: ['@UI.LineItem'],
            SortOrder     : [{
                $Type     : 'Common.SortOrderType',
                Property  : BookingID,
                Descending: false
            }]
        },
        SelectionFields               : [],
        LineItem                      : [
            {
                Value: to_Carrier.AirlinePicURL,
                Label: '  '
            },
            {Value: BookingID},
            {Value: BookingDate},
            {Value: to_Customer_CustomerID},
            {Value: to_Carrier_AirlineID},
            {
                Value: ConnectionID,
                Label: '{i18n>FlightNumber}'
            },
            {Value: FlightDate},
            {Value: FlightPrice},
            {Value: BookingStatus_code},
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.Chart#TotalSupplPrice',
            Label : '{i18n>Supplements}',
        },
        ],
        Facets                        : [
            {
                $Type : 'UI.CollectionFacet',
                Label : '{i18n>GeneralInformation}',
                ID    : 'Booking',
                Facets: [
                    { // booking details
                        $Type : 'UI.ReferenceFacet',
                        ID    : 'BookingData',
                        Target: '@UI.FieldGroup#GeneralInformation',
                        Label : '{i18n>Booking}'
                    },
                    { // flight details
                        $Type : 'UI.ReferenceFacet',
                        ID    : 'FlightData',
                        Target: '@UI.FieldGroup#Flight',
                        Label : '{i18n>Flight}'
                    }
                ]
            },
            { // supplements list
                $Type : 'UI.ReferenceFacet',
                Target: 'to_BookSupplement/@UI.PresentationVariant',
                Label : '{i18n>BookingSupplements}'
            }
        ],
        FieldGroup #GeneralInformation: {Data: [
            {Value: BookingID},
            {Value: BookingDate, },
            {Value: to_Customer_CustomerID},
            {Value: BookingDate, },
            {Value: BookingStatus_code}
        ]},
        FieldGroup #Flight            : {Data: [
            {Value: to_Carrier_AirlineID},
            {Value: ConnectionID},
            {Value: FlightDate},
            {Value: FlightPrice}
        ]},
    },
    UI.DataPoint #TotalSupplPrice : {
        Value : TotalSupplPrice,
        MinimumValue : 0,
        MaximumValue : 120,
    },
    UI.Chart #TotalSupplPrice : {
        ChartType : #Bullet,
        Measures : [
            TotalSupplPrice,
        ],
        MeasureAttributes : [
            {
                DataPoint : '@UI.DataPoint#TotalSupplPrice',
                Role : #Axis1,
                Measure : TotalSupplPrice,
            },
        ],
    },
    UI.DataPoint #TotalSupplPrice1 : {
        Value : TotalSupplPrice,
        MinimumValue : 0,
        MaximumValue : 120,
    },
    UI.Chart #TotalSupplPrice1 : {
        ChartType : #Bullet,
        Measures : [
            TotalSupplPrice,
        ],
        MeasureAttributes : [
            {
                DataPoint : '@UI.DataPoint#TotalSupplPrice1',
                Role : #Axis1,
                Measure : TotalSupplPrice,
            },
        ],
    },
    UI.DataPoint #TotalSupplPrice2 : {
        Value : TotalSupplPrice,
        MinimumValue : 0,
        MaximumValue : 120,
    },
    UI.Chart #TotalSupplPrice2 : {
        ChartType : #Bullet,
        Title : '{i18n>TotalSupplements}',
        Measures : [
            TotalSupplPrice,
        ],
        MeasureAttributes : [
            {
                DataPoint : '@UI.DataPoint#TotalSupplPrice2',
                Role : #Axis1,
                Measure : TotalSupplPrice,
            },
        ],
    },
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'TotalSupplPrice',
            Target : '@UI.Chart#TotalSupplPrice2',
        },
    ],
);

annotate TravelService.BookingSupplement with @UI: {
    Identification     : [{Value: BookingSupplementID}],
    HeaderInfo         : {
        TypeName      : '{i18n>BookingSupplement}',
        TypeNamePlural: '{i18n>BookingSupplements}',
        Title         : {Value: BookingSupplementID},
        Description   : {Value: BookingSupplementID}
    },
    PresentationVariant: {
        Text          : 'Default',
        Visualizations: ['@UI.LineItem'],
        SortOrder     : [{
            $Type     : 'Common.SortOrderType',
            Property  : BookingSupplementID,
            Descending: false
        }]
    },
    LineItem           : [
        {Value: BookingSupplementID},
        {
            Value: to_Supplement_SupplementID,
            Label: '{i18n>ProductID}'
        },
        {
            Value: Price,
            Label: '{i18n>ProductPrice}'
        }
    ],
};

annotate TravelService.Flight with @UI: {PresentationVariant #SortOrderPV: { // used in the value help for ConnectionId in Bookings
SortOrder: [{
    Property  : FlightDate,
    Descending: true
}]}};
annotate TravelService.Currencies with @(
    Communication.Contact #contact : {
        $Type : 'Communication.ContactType',
        fn : name,
        tel : [
            {
                $Type : 'Communication.PhoneNumberType',
                type : #work,
            },
        ],
        adr : [
            {
                $Type : 'Communication.AddressType',
                type : #work,
            },
        ],
    }
);

annotate TravelService.TravelAgency with @(
    Communication.Contact #contact : {
        $Type : 'Communication.ContactType',
        fn : Name,
        tel : [
            {
                $Type : 'Communication.PhoneNumberType',
                type : #work,
                uri : PhoneNumber,
            },
        ],
        adr : [
            {
                $Type : 'Communication.AddressType',
                type : #work,
                street : Street,
                locality : City,
                code : PostalCode,
                country : CountryCode.name,
            },
        ],
    }
);

