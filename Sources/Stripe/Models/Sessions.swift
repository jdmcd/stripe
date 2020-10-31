//
//  Sessions.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/4/19.
//

import Foundation

/// The [Session Object.](https://stripe.com/docs/api/checkout/sessions/object)
public struct StripeSession: StripeModel {
    /// Unique identifier for the object. Used to pass to redirectToCheckout in Stripe.js.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String?
    /// Total of all items before discounts or taxes are applied.
    public var amountSubtotal: Int?
    /// Total of all items after discounts and taxes are applied.
    public var amountTotal: Int?
    /// The value (`auto` or `required`) for whether Checkout collected the customer’s billing address.
    public var billingAddressCollection: StripeSessionBillingAddressCollection?
    /// The URL the customer will be directed to if they decide to cancel payment and return to your website.
    public var cancelUrl: String?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// A unique string to reference the Checkout Session. This can be a customer ID, a cart ID, or similar, and can be used to reconcile the session with your internal systems.
    public var clientReferenceId: String?
    /// The ID of the customer for this session. A new customer will be created unless an existing customer was provided in when the session was created.
    public var customer: String?
    /// If provided, this value will be used when the Customer object is created. If not provided, customers will be asked to enter their email address. Use this parameter to prefill customer data if you already have an email on file. To access information about the customer once a session is complete, use the `customer` field.
    public var customerEmail: String?
    /// The line items purchased by the customer. This field is not included by default. To include it in the response, [expand](https://stripe.com/docs/api/expanding_objects) the `line_items` field.
    public var lineItems: StripeSessionLineItemList?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Has the `value` true if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// The IETF language tag of the locale Checkout is displayed in. If blank or `auto`, the browser’s locale is used.
    public var locale: StripeSessionLocale?
    /// The mode of the Checkout Session, one of `payment`, `setup`, or `subscription`.
    public var mode: StripeSessionMode?
    /// The ID of the PaymentIntent created if SKUs or line items were provided.
    public var paymentIntent: String?
    /// A list of the types of payment methods (e.g. card) this Checkout Session is allowed to accept.
    public var paymentMethodTypes: [StripeSessionPaymentMethodType]?
    /// The ID of the SetupIntent for Checkout Sessions in setup mode.
    public var setupIntent: String?

    /// When set, provides configuration for Checkout to collect a shipping address from a customer.
    public var shippingAddressCollection: StripeSessionShippingAddressCollection?
    /// Describes the type of transaction being performed by Checkout in order to customize relevant text on the page, such as the submit button. `submit_type` can only be specified on Checkout Sessions in `payment` mode, but not Checkout Sessions in `subscription` or `setup` mode. Supported values are `auto`, `book`, `donate`, or `pay`.
    public var submitType: StripeSessionSubmitType?
    /// The ID of the subscription created if one or more plans were provided.
    public var subscription: String?
    /// The URL the customer will be directed to after the payment or subscription creation is successful.
    public var successUrl: String?
    /// Tax and discount details for the computed total amount.
    public var totalDetails: StripeSessionTotalDetails?
}

public struct StripeSessionList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeSession]?
}

public enum StripeSessionBillingAddressCollection: String, StripeModel {
    case auto
    case required
}

public struct StripeSessionLineItem: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Total before any discounts or taxes is applied.
    public var amountSubtotal: Int?
    /// Total after discounts and taxes.
    public var amountTotal: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// An arbitrary string attached to the object. Often useful for displaying to users. Defaults to product name.
    public var description: String?
    /// The discounts applied to the line item. This field is not included by default. To include it in the response, expand the `discounts` field.
    public var discounts: [StripeSessionLineItemDiscount]?
    /// The price used to generate the line item.
    public var price: StripePrice?
    /// The quantity of products being purchased.
    public var quantity: Int?
    /// The taxes applied to the line item. This field is not included by default. To include it in the response, expand the `taxes` field.
    public var taxes: [StripeSessionLineItemTax]?
}

public struct StripeSessionLineItemDiscount: StripeModel {
    /// The amount discounted.
    public var amount: Int?
    /// The discount applied.
    public var discount: StripeDiscount?
}

public struct StripeSessionLineItemTax: StripeModel {
    /// Amount of tax applied for this rate.
    public var amount: Int?
}

public struct StripeSessionLineItemList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeSessionLineItem]?
}

public enum StripeSessionLocale: String, StripeModel {
    case auto
    case bg
    case cs
    case da
    case de
    case el
    case en
    case enGB = "en-GB"
    case es
    case es419 = "es-419"
    case et
    case fi
    case fr
    case frCA = "fr-CA"
    case hu
    case id
    case it
    case ja
    case lt
    case lv
    case ms
    case mt
    case nb
    case nl
    case pl
    case pt
    case ptBR = "pt-BR"
    case ro
    case ru
    case sk
    case sl
    case sv
    case tr
    case zh
}

public enum StripeSessionMode: String, StripeModel {
    case payment
    case setup
    case subscription
}

public enum StripeSessionPaymentMethodType: String, StripeModel {
    case card
    case ideal
    case fpx
    case bacsDebit = "bacs_debit"
    case bancontact
    case giropay
    case p24
    case eps
}

public struct StripeSessionShippingAddressCollection: StripeModel {
    /// An array of two-letter ISO country codes representing which countries Checkout should provide as options for shipping locations. Unsupported country codes: `AS, CX, CC, CU, HM, IR, KP, MH, FM, NF, MP, PW, SD, SY, UM, VI`.
    public var allowedCountries: [String]?
}

public enum StripeSessionSubmitType: String, StripeModel {
    case auto
    case book
    case donate
    case pay
}

public struct StripeSessionTotalDetails: StripeModel {
    /// This is the sum of all the line item discounts.
    public var amountDiscount: Int?
    /// This is the sum of all the line item tax amounts.
    public var amountTax: Int?
    /// Breakdown of individual tax and discount amounts that add up to the totals. This field is not included by default. To include it in the response, expand the breakdown field.
    public var breakdown: StripeSessionTotalDetailsBreakdown?
}

public struct StripeSessionTotalDetailsBreakdown: StripeModel {
    /// The aggregated line item discounts.
    public var discounts: [StripeSessionLineItemDiscount]?
    /// The aggregated line item tax amounts by rate.
    public var taxes: [StripeSessionLineItemTax]?
}

/// The [Price Object](https://stripe.com/docs/api/prices/object)
public struct StripePrice: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Whether the price can be used for new purchases.
    public var active: Bool?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The ID of the product this price is associated with.
     public var product: String?
    /// The recurring components of a price such as `interval` and `usage_type`.
    public var recurring: StripePriceRecurring?
    /// One of `one_time` or `recurring` depending on whether the price is for a one-time purchase or a recurring (subscription) purchase.
    public var type: StripePriceType?
    /// The unit amount in cents to be charged, represented as a whole integer if possible.
    public var unitAmount: Int?
    /// Describes how to compute the price per period. Either `per_unit` or `tiered`. `per_unit` indicates that the fixed amount (specified in `unit_amount` or `unit_amount_decimal`) will be charged per unit in quantity (for prices with `usage_type=licensed`), or per unit of total usage (for prices with `usage_type=metered`). `tiered` indicates that the unit pricing will be computed using a tiering strategy as defined using the `tiers` and `tiers_mode` attributes.
    public var billingScheme: StripePriceBillingScheme?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// A lookup key used to retrieve prices dynamically from a static string.
    public var lookupKey: String?
    /// Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to tiered. See also the documentation for `billing_scheme`. This field is not included by default. To include it in the response, expand the `tiers` field.
    public var tiers: [StripePriceTier]?
    /// Defines if the tiering price should be `graduated` or `volume` based. In `volume`-based tiering, the maximum quantity within a period determines the per unit price. In `graduated` tiering, pricing can change as the quantity grows.
    public var tiersMode: StripePriceTierMode?
    /// Apply a transformation to the reported usage or set quantity before computing the amount billed. Cannot be combined with `tiers`.
    public var transformQuantity: StripePriceTransformQuantity?
    /// The unit amount in cents to be charged, represented as a decimal string with at most 12 decimal places.
    public var unitAmountDecimal: String?
}

public struct StripePriceRecurring: StripeModel {
    /// Specifies a usage aggregation strategy for prices of `usage_type=metered`. Allowed values are sum for summing up all usage during a period, `last_during_period` for using the last usage record reported within a period, `last_ever` for using the last usage record ever (across period bounds) or `max` which uses the usage record with the maximum reported usage during a period. Defaults to `sum`.
    public var aggregateUsage: StripePriceRecurringAggregateUsage?
    /// The frequency at which a subscription is billed. One of `day`, `week`, `month` or `year`.
    public var interval: StripePlanInterval?
    /// The number of intervals (specified in the `interval` attribute) between subscription billings. For example, `interval=month` and `interval_count=3` bills every 3 months.
    public var intervalCount: Int?
}

public enum StripePriceRecurringAggregateUsage: String, StripeModel {
    case sum
    case lastDuringPeriod = "last_during_period"
    case lastEver = "last_ever"
    case max
}

public enum StripePriceType: String, StripeModel {
    case oneTime = "one_time"
    case recurring
}

public enum StripePriceBillingScheme: String, StripeModel {
    case perUnit = "per_unit"
    case tiered
}

public struct StripePriceTier: StripeModel {
    /// Price for the entire tier.
    public var flatAmount: Int?
    /// Same as `flat_amount`, but contains a decimal value with at most 12 decimal places.
    public var flatAmountDecimal: String?
    /// Per unit price for units relevant to the tier.
    public var unitAmount: Int?
    /// Same as `unit_amount`, but contains a decimal value with at most 12 decimal places.
    public var unitAmountDecimal: String?
    /// Up to and including to this quantity will be contained in the tier.
    public var upTo: Int?
}

public enum StripePriceTierMode: String, StripeModel {
    case graduated
    case volume
}

public struct StripePriceTransformQuantity: StripeModel {
    /// Divide usage by this number.
    public var divideBy: Int?
    /// After division, either round the result `up` or `down`.
    public var round: StripePriceTransformQuantityRound?
}

public enum StripePriceTransformQuantityRound: String, StripeModel {
    case up
    case down
}

public struct StripePriceList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripePrice]?
}
