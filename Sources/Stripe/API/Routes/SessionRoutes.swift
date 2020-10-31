//
//  SessionRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/4/19.
//

import Vapor

public struct StripeSessionRoutes {
    public var headers: HTTPHeaders = [:]

    private let request: StripeRequest
    private let sessions = APIBase + APIVersion + "checkout/sessions"

    init(request: StripeRequest) {
        self.request = request
    }

    public func create(cancelUrl: String,
                       paymentMethodTypes: [StripeSessionPaymentMethodType],
                       successUrl: String,
                       billingAddressCollection: StripeSessionBillingAddressCollection?,
                       clientReferenceId: String?,
                       customer: String?,
                       customerEmail: String?,
                       lineItems: [[String: Any]]?,
                       locale: StripeSessionLocale?,
                       metadata: [String: String]?,
                       mode: StripeSessionMode?,
                       paymentIntentData: [String: Any]?,
                       setupIntentData: [String: Any]?,
                       submitType: StripeSessionSubmitType?,
                       subscriptionData: [String: Any]?,
                       expand: [String]?) throws -> EventLoopFuture<StripeSession> {
        var body: [String: Any] = ["cancel_url": cancelUrl,
                                   "payment_method_types": paymentMethodTypes.map { $0.rawValue },
                                   "success_url": successUrl]

        if let billingAddressCollection = billingAddressCollection {
            body["billing_address_collection"] = billingAddressCollection.rawValue
        }

        if let clientReferenceId = clientReferenceId {
            body["client_reference_id"] = clientReferenceId
        }

        if let customer = customer {
            body["customer"] = customer
        }

        if let customerEmail = customerEmail {
            body["customer_email"] = customerEmail
        }

        if let lineItems = lineItems {
            body["line_items"] = lineItems
        }

        if let locale = locale {
            body["locale"] = locale.rawValue
        }

        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let mode = mode {
            body["mode"] = mode
        }

        if let paymentIntentData = paymentIntentData {
            paymentIntentData.forEach { body["payment_intent_data[\($0)]"] = $1 }
        }

        if let setupIntentData = setupIntentData {
            setupIntentData.forEach { body["setup_intent_data[\($0)]"] = $1 }
        }

        if let submitType = submitType {
            body["submit_type"] = submitType
        }

        if let subscriptionData = subscriptionData {
            subscriptionData.forEach { body["subscription_data[\($0)]"] = $1 }
        }

        if let expand = expand {
            body["expand"] = expand
        }

        return try request.send(method: .POST, path: sessions, query: "", body: body.queryParameters, headers: headers)
    }

    public func retrieve(id: String, expand: [String]?) throws -> EventLoopFuture<StripeSession> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }

        return try request.send(method: .GET, path: "\(sessions)/\(id)", query: queryParams, headers: headers)
    }

    public func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeSessionList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }

        return try request.send(method: .GET, path: sessions, query: queryParams, headers: headers)
    }

    public func retrieveLineItems(session: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeSessionLineItemList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }

        return try request.send(method: .GET, path: "\(sessions)/\(session)/line_items", query: queryParams, headers: headers)
    }
}
