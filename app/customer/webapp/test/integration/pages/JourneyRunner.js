sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"sap/fe/cap/customer/test/integration/pages/PassengerList.gen",
	"sap/fe/cap/customer/test/integration/pages/PassengerObjectPage.gen",
	"sap/fe/cap/customer/test/integration/pages/BookingObjectPage.gen"
], function (JourneyRunner, PassengerListGenerated, PassengerObjectPageGenerated, BookingObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('sap/fe/cap/customer') + '/test/flp.html#app-preview',
        pages: {
			onThePassengerListGenerated: PassengerListGenerated,
			onThePassengerObjectPageGenerated: PassengerObjectPageGenerated,
			onTheBookingObjectPageGenerated: BookingObjectPageGenerated
        },
        async: true
    });

    return runner;
});

