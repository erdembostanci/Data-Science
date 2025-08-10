-- Bir market zincirinin veri tabaninda satin alim yapmis musteriler bulunmaktadir.
-- Bu market zincirinin belirli sartini saglamis musterilerine tekrar satisin gerceklesmesi icin
-- bir pazarlama kampanyasi icin telefon numaralarina SMS push islemi gerceklestirilecektir. 
-- Kampanya 1: toplam alisveris tutari 200tl uzerinde olan kisilere bir dahaki alisverislerinde
-- %10 indirim saglanacaktir. Kisilere SMS bilgilendirmesi yapilmasi icin Pazarlama ekibi
-- Bu kisilerin telefon numaralarini istemektedir.
SELECT 
USERS.NAMESURNAME AS ISIM_SOYISIM, 
USERS.TELNR1 AS TEL_NUMARASI,
SUM(INVOICEDETAILS.LINETOTAL) AS TOPLAM_TUTAR
FROM ORDERS
--Tablolari inceledigimde iliskisel veri tabaninin
--tum ID'leri barindiran tablomuz ORDERS tablosudur.
INNER JOIN USERS ON USERS.ID = ORDERS.USERID
INNER JOIN INVOICES ON INVOICES.ORDERID = ORDERS.ID
--Alttaki join işlemleri ile tüm satın almalar gelir.
INNER JOIN INVOICEDETAILS ON INVOICEDETAILS.INVOICEID = INVOICES.ID
GROUP BY NAMESURNAME,TELNR1
HAVING SUM(INVOICEDETAILS.LINETOTAL) > 500
ORDER BY ISIM_SOYISIM

-- Kampanya 2: Okulların açılışına özel oyuncak alımlarında kırtasiye ürünlerinde %25 indirim geçerli olacaktır.
-- Kırtasiye ürünlerine özel indirimin bildirilmesi için kullanıcıların telefon numarası istenmektedir.
SELECT
	DISTINCT USERS.NAMESURNAME AS ISIM_SOYISIM, 
	USERS.TELNR1 AS TEL_NUMARASI,
	ITEMS.CATEGORY3 AS KATEGORI
FROM ORDERS
	INNER JOIN USERS ON USERS.ID = ORDERS.USERID
	INNER JOIN INVOICES ON INVOICES.ORDERID = ORDERS.ID
	INNER JOIN INVOICEDETAILS ON INVOICEDETAILS.INVOICEID = INVOICES.ID
	INNER JOIN ORDERDETAILS ON ORDERDETAILS.ORDERID = ORDERS.ID
	INNER JOIN ITEMS ON ITEMS.ID = ORDERDETAILS.ITEMID
WHERE ITEMS.CATEGORY3 = 'KIRTASIYE'
ORDER BY USERS.NAMESURNAME
