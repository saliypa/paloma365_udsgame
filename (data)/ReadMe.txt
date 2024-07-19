https://udsgame.com/api-docs/partner
https://udsgame.com/api-docs/partner?_escaped_fragment_=/partner/post_purchase#!/partner/post_purchase
https://udsgame.com/static/ru/

test-game2@setinbox.com
gDFtff5gjkD

b@gmail.com
rootpas


https://udsgame.com/v1/partner

curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' --header 'X-Origin-Request-Id: A368AB49-3EA6-4B42-A964-73977EF75F13' --header 'X-Timestamp: 2016-10-10T07:47:32.284Z' --header 'X-Api-Key: a6136d8d4ee31469d020a7e3f85960982a0031b9816495b7f3f3ab1c8b58763bf39e475ad39fcb0a581cd5cae0de237d4da402eb99c42ddcd8efd5a864014862' -d '{"customerId":0,"code":"693848","total":100,"scores":0,"cash":90,"invoiceNumber":"1","cashierExternalId":"2"}' 'https://udsgame.com/v1/partner/purchase'


{
  "operation": {
    "cash": 90,
    "cashier": {
      "email": "kkodzhaev@gmail.com",
      "externalId": "2",
      "name": "Kodzhaev Konstantin Eduardovich"
    },
    "customer": {
      "id": 824634121067,
      "name": "p",
      "surname": "t"
    },
    "dateCreated": "2016-10-10T09:04:41.685Z",
    "id": 2070498,
    "marketingSettings": {
      "discountBase": 10,
      "discountLevel1": 5,
      "discountLevel2": 3,
      "discountLevel3": 2,
      "maxScoresDiscount": 100
    },
    "scoresDelta": 0,
    "scoresNew": 0,
    "total": 100
  }
}