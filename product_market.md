# kiezDAO: Market and Product research

Initial function of`kiezDAO` is  that of a tool sharing marketplace for small communities:

- Lend tools to your neighbours. For-profit or for-free.
- Borrow/rent tools from your neighbors instead of buying them.

By promoting better utilization of existing tools, we reduce demand, which should at scale, result in lowered production of new tools (environmental benefit) or at least lower the prices and make tools more affordable (economic benefit).

The software is envisioned as a mobile-friendly website, though in long term one may consider making a proper native app, so that we can use more sophisticated features of mobile phones and provide better user experience to interact with Ethereum ( or maybe Celo?) blockchain.

### Size of target market?

[As we can gleam](https://www.thebusinessresearchcompany.com/report/consumer-goods-and-general-rental-centers-global-market-report)`The consumer goods and general rental centers market expected to reach a value of nearly $239.79 billion by 2022, significantly growing at a CAGR of 9.4% during the forecast period. The growth is due to expected stabilization in global prices, increased demand for leasing.``

Looking at one segment in USA: `Over the past 3 years, the Consumer Electronics and Appliances Rental industry in the U.S. has averaged annual growth of 1.2% to reach $6.3 billion in revenue.``

[Interestingly](https://www.grandviewresearch.com/press-release/global-construction-equipment-rental-market) note that `the global construction equipment rental market size is expected to reach USD 136.5 billion by 2027`, note that consumer-oriented market will be twice the size, much sooner.

### Similar solutions?

There are numerous stationary `low-tech` businesses that offer to rent tools or equipment to consumers. We change the market by eliminating need for those middle-men and providing a platform that allows anyone to act as a lender if they so desire (i.e. Peer2Peer lending).


[RENTO](https://rento-app.io/) is an existing idea very similar to what we hope to propose, although at 1,000+ installs and 18 user reviews on Google Store, their app does not seem to be getting a lot of traction. Whitepaper contains thorough risk analysis, of note to any cryptocurrency project.

Another blockchain-backed rental marketplace, [sLock it](https://slock.it/) allows one to rent access to IoT devices. Interesting avenue, but our focus is mostly `dumb` tools like e.g. woodworking or gardening equipment.

### Demographics we serve?

People from all walks of life who want to rent/borrow a tool instead of buying them. Reasons can be either pragmatic (cheaper to rent than to buy in short term) or idealistic (ecological concerns, zero-waste etc.).

Better description of actual target demographic will be provided by design documents showcasing personas.

### What is your product's value proposition?

> We let you earn money by helping you share** your tools** with **your community**.

> We let you discover tools that your neighbors are willing to share and borrow them in safe, hassle-free manner.


What differentiates us from  traditional competition is use of Ethereum which provides `immutable` and `tamper-proof` way of recording history and transactions associated with a given tool.

What differentiates us from blockchain-rental competition is a narrow market niche we are hoping to address, more on that in future documents.

Likewise, if we opt to allow for cryptocurrency transfers as means to pay for tool rental, app can be used by the `unbanked` so we are being inclusive (if we manage to make UX/UI easy to use, which is a typical obstacle for blockchain startups).

### Distribution, go-to-market

We see it as a B2C product, so we would try to target *customers directly*. With our current marketing budget of 0$ best we can do is to reach out to people we already know or NGOs or other associations working with sharing economy, that might be interested in promoting our solution.

In case the former strategy proves to be difficult or ineffective, one can pivot toward B2B and try to sell the product to enterprises as they could also earn money by renting out assets that are not currently in use (as they often do already).

Regarding actual distribution, MVP of the application itself should be accessible in form of a mobile-friendly website (so that it does not to be installed via app store which adds a lot of additional friction).


### Partners

We could partner up with zero-waste or responsible-consumption oriented organizations.

Alternatively, we could seek to make our tool inter-operable with already existing blockchain-based application for cities, like [Commonshood](https://www.commonshood.eu/) project from university of Turin.

### What are the risks associated with your solution?



- **Injury/Liability** Customer can be injured when operating rented tool (e.g. lawnmower). Is there a way to prevent or at least minimize risk of such action occurring? Once it happens, how does one determine who is liable?

- **Fraud** Bane of all blockchain asset-management solutions. How do we make sure what happens on the blockchain reflects physical reality (e.g. owner insists on renting out a non-functional lawnmower as `working`).

- **Damage/Liability** Customer can damage or destroy the tool. How would owner be compensated? More generally, how to settle a dispute between tool owner and renter?

  Approach: [User Scenario B.1](https://github.com/deora-earth/kiezDAO/blob/master/user_scenarios.md#scenario-b1)

- **Privacy** Advertising that you own expensive tool can make you quite popular in DIY circles, but can also make you a target for thieves. How can tool-owners protect their privacy and assets?  
  
  Approach: People outside of the community can see the tools offered. But only once accepted in the community can see ownership. 

- **Sharing Economy** On one hand it may seem we are helping those less affluent by letting them use tools they cannot afford. On the other we might be hurting them by furthering class divide as we let those who can afford the tools to profit from those who cannot. It would be good to keep this in mind, and use our platform to promote *free sharing* so that we don't turn our platform into something exploitative.   
  
  Approach: [User Scenario A.2](https://github.com/deora-earth/kiezDAO/blob/master/user_scenarios.md#scenario-a2)


### What is the impact of your solution? How will it be measured?
Ideally we would segment all measures by city and time, where appropriate:

**Growth**:
- Number of users.
- Number of registered tools.

**Impact**:
- Time for which tools were rented.
- Value of tools available for rent (could be estimate)
- Total number of rentals.

**Risk**:
- Number of disputes between owner and renter
- Number of tools that were not returned
- Number of tools reported as damaged/destroyed (from use)

In order to maximize  `environmental impact`, once owner informs us that tool has broken down, we could suggest a repair service or worst case scenario environmentally-friendly way of disposing of it.


### Draft Technical Specification

User can act in two roles LENDER (of a tool) and BORROWER, obviously a single user can be both. User can be identified by Ethereum address.


`LENDER STORIES`

S1. As lender, I WANT TO inform neighbours to know that tool I own is `for rent` SO THAT I can earn money.

S2. As lender, I WANT TO receive agreed upon payments for renting my tool SO THAT I can spend it easily.

S3. As good-natured lender, I WANT TO rent my tool free of charge, just SO THAT it is used by someone.

S4. As lender, I WANT TO have neat non-repudiable records of any transactions with borrowers SO THAT I have recourse if something goes wrong.


`BORROWER STORIES`

S5. As borrower, I WANT TO list tools for rent and narrow down search with filters SO THAT I can find the tool I need.

S6. As borrower, I WANT TO make a deal with lender SO THAT I get access to tool I need.


#### Critical path
Short version, mimum viable app requires:

- Screen to `add new tool` for lender.
- Screen to `manage my tools` for lender.
- Screen `see all tools` for borrower.
- Screen `agreement`  that notarizes `start` or `end` of rental agreement on the blockchain, to be signed with two private keys.

Data model for `tool` and `user`:

- For `user` what is important is his `identity` and `reputation`.

- For `tool` we need to record its `properties` (e.g. serial number, category, model) its `condition` (e.g. operational yet slightly rusted could be photo) and its `ownership`.

#### Misc

1. Tools can be represented as Non-Fungible Tokens.
2. Moving token to another address would represent rental. At end of rental period, token should return to lender address.
3. Owner should have special privilege of taking the tool `out of circulation` once he no longer wants to rent it.
4. Neo4j graph database to model the data and analyze data locally? Graph seems like a good abstraction to use in this case, and tool data (which we probably don't need to store on chain) can be unstructured.


**Note 1**
Everyone can mint token for any tool. Introducing vetting at minting stage (e.g. someone else needs to confirm tool actually exists) might be an interesting stretch-goal for later.

**Note 2** Unless we introduce collateral trust is of critical importance i.e. how do we prevent borrower from not returning the tool? With collateral problem is inverted. Not a concern if app is used only within a group of neighbors that know each other, but it limits usability.  See [user scenarios B.1 & B.2](https://github.com/deora-earth/kiezDAO/blob/master/user_scenarios.md#scenario-b1) for an approach of community fund and stake as collateral. 
