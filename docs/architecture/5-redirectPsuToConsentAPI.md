# Redirect PSU to consent API

## 1. [ConsentAuthorisationApi](dictionary.md#ConsentAuthorisationApi)
The redirect start with a get request to the entryPoint of the ConsentAuthorisationApi, for authorizing a consent initiated on the TppBankingApi side.

## Diagram
![Session diagram](http://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/adorsys/open-banking-gateway/gh-pages/docs/architecture/diagrams/useCases/5-redirectPsuToConsentAPI.puml&fmt=svg&vvv=1&sanitize=true)  
![Session diagram](https://dg0lden.github.io/mkdocs-demo/architecture/diagrams/useCases/1-loginWithFinTech.png)

## Request processing ConsentAPI

### 2.1 Retrieve Corresponding BankingProtocol
ConsentAuthorisationApi will use the given redirectCode to load the matching BankingProtocol.

### 2.2 .. 2.6 Retrieve associated TppConsentSession
ConsentAuthorisationApi will let BankingProtocol use the redirectCode to retrieve the TppConsentSession
.
### Interacting with the PsuUserAgent

#### 2.7 consentAuthState
The CSRF-State String is called: [consentAuthState](dictionary.md#consentAuthState)

#### 2.8 AuthorizeResponse
The AuthorizeResponse returned to the ConsentAuthorisationUI is used to display info to the PSU.

This AuthorizeResponse object is always synchronized with the ConsentAuthSessionCookie set with the same HTTP response object.

Any session, account or payment information needed to manage the authorization process is stored in both AuthorizeResponse (for display) and in the encrypted in the ConsentAuthSessionCookie.
The consentCookieString is httpOnly

#### 2.9 ConsentAuthSessionCookie
The [ConsentAuthSessionCookie](dictionary.md#ConsentAuthSessionCookie) is used to maintain session between ConsentAuthorisationUI and ConsentAuthorisationApi. It will generated and set as a __httpOnly, Secure__

### 3. Displaying Consent Authorize UI

### 4. Redirecting PSU to the ASPSP
The returned AuthorizeResponse object info information needed to redirect the PSU to the target ASPSP.
BackRedirectURL (OKUrl, NOKURL, etc... dependent of ASPSP API) contains the consentAuthState.
