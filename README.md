# kiezDAO: Reconnecting Neighbourhoods 🏘

As team behind [DEORA](https://twitter.com/deora_earth) we think that we don't really know our neighbours as well, as past generations did. In the scope of [Blockchain for Social Impact Incubator](https://blockchainforsocialimpact.com/) we have prototyped a platform that would reconnect neighbourhoods and allow communities to form. Since the goal is ambitious, we would start with **small tool-sharing and tool-renting platform**.  
🙎‍♀️ 🤝🙎🏽‍♂️

In one sentence summary, KiezDAO is a mobile-friendly decentralized aplication designed to: 
> "Let users make or save money, by *easily* and *safely* sharing tools with *local community*"

If you would like to learn more about the intent behind KiezDAO, you can take a look at the following materials:

1. [Pitch Deck](https://github.com/deora-earth/kiezDAO/blob/master/kiezDAO%20Pitch%20Deck%20for%20BSIC.pdf) (slides)
2. [Video Pitch](https://github.com/deora-earth/kiezDAO/blob/master/KiezDAO_Deora_Video_Pitch.mp4) 
3. [Whitepaper](https://github.com/deora-earth/kiezDAO/blob/master/KiezDAO%20Whitepaper.pdf)

You can also look at other documents inside the repository or the example smart contracts serving as POC technical implementation. 

![solarpunk lesbian summer](img/solarpunk123.jpeg "reconnecting neighbourhoods")

kiezDAO would allow interested people to advertise they own tools they would like to rent or share. The platform would notarialize all exchanges of tools on Ethereum blockchain so that people would have indisputable proof of who is supposedly holding given tool at a time. Likewise, collateral coupled with dispute resolution scheme would reduce **trust** needed to give expensive tools away and address possible financial risk involved in strangers stealing or breaking borrowed tools. 

### How to use KiezDAO? 

You can take a look at our [video pitch](https://github.com/deora-earth/kiezDAO/blob/master/KiezDAO_Deora_Video_Pitch.mp4) to see the flow of our prototype. As for the bigger picture:

As a lender:
1. Register your profile. 
2. Snap pictures of tools you own, and advertise them as aviable for rent. 
3. Wait for prospective borrowers interested in your tools to contact you via the app.
4. Give tool to the borrower and record tool exchange on the blockchain (Ethereum mainnet or Celo). 
5. For as long as agreement is in place, borrower would give you aggreed-upon amount of cryptocurrency each day. 

As a borrower:
1. Register your profile.
2. Add some funds to your account (e.g. via credit card), those would be converted to cryptocurrency used to pay for rentals.
3. Find tools you are interested in, contact borrower and sign rental agreeement (actually a smart-contract). 
4. Each day agreement is in place, rent would be deducted from your account balance and paid to the lender.

Once the rental period is over, both sides can conclude the agreement, rent would stop being paid and tool would return to rightful owner. If this does not happen, and there is a dispute of any sort, application would allow users to call on community (other users of the application) to mediate and resolve the disagreement.

### Benefits of KiezDAO? 
Benefits of using our blockchain-backed platform over simply renting the items *manually* are as follows: 

- **Record keeping**, you will have indisputable proof that person X borrowed your tool at time Y.
- **Automated money transfers**, hand your tool over to borrower and have money from rent transfered to your account on a daily basis.
- **Dispute resolution** if you encounter any problems such as having your tools stolen or broken, your *community* has access to special fund that can be used to cover your loss. We call this fund *community collateral*. A set percentage of profits from rentals is set aside to grow said fund. 

From user point of view, by using KiezDAO you could earn money by renting your unused tool. Alternatively, looking at it from the other side, you could save money by borrowing infrequently-used tools from your neighbours instead of buying them. 

In a broader context, by promoting sharing of tools within a local community, we would strenghten community bonds, by encouraging people to interact with each other if they need something, instead of ordering tools from overseas. 

Furthermore, the solution has great potential to benefit less affluent members of society or frugal hobbyists, as they would have better access to tools that they could not afford to buy. 

We showcased the solution in a real neighbourhood to gather feedback on how it performs and what actual users think of the idea. 

### Blockchain For Social Impact 
To showcase kiezDAO we have produced two prototypes. A technical one and user facing one:

- Front-end prototype showcasing functionality of our application. You could see it on [figma](https://www.figma.com/proto/LpKMJEGglqbQHbDtNmGD99/KiezDAO--Rent-User-flow?node-id=0%3A1&scaling=scale-down).
- Set of smart contracts interacting with Celo blockchain, inside this repository. 

In the table below you will find a summary of weekly deliverables that have been created during the incubator. 

| Week          | Deliverables    |
| ------------- |:-------------:  |
| Week 1        | [Market and Product exploration](https://github.com/deora-earth/kiezDAO/blob/master/product_market.md) |
| Week 2        | [Pain Points, Personas](https://github.com/deora-earth/kiezDAO/blob/master/personas_and_use_cases.md) |
| Week 3&4      | Prototype (see repository), [MVP Testing Document](https://github.com/deora-earth/kiezDAO/blob/master/testing_approach.md) |
| Week 5        | [Draft Pitch](https://github.com/deora-earth/kiezDAO/blob/master/Draft%20kiezDAO%20Pitch%20Deck(1).pdf) |



