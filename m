References: <CAO5O-EKGgpYAsJC5j+osB_LAteoUDbOwVYVqkB2=cA3a6VVHoA@...278...>
	<33FD94D8-6860-45F6-AC9D-7CD7D8D93CD9@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <143540d4-e8ea-b533-ad1a-8ae33bfd1133@...1856...>
Date: Sun, 14 May 2017 21:10:07 +0200
MIME-Version: 1.0
In-Reply-To: <33FD94D8-6860-45F6-AC9D-7CD7D8D93CD9@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8CPv11d062Tv3tEf2iImJAv9BcesFshtf"
Subject: Re: [Openvpn-devel] [PATCH] Avoid a 1 byte overcopy in
 x509_get_subject (ssl_verify_openssl.c)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8CPv11d062Tv3tEf2iImJAv9BcesFshtf
Content-Type: multipart/mixed; boundary="jONFteD0oIWn0hwMhrTFC65PfwqctJc91";
	protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <143540d4-e8ea-b533-ad1a-8ae33bfd1133@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid a 1 byte overcopy in
	x509_get_subject (ssl_verify_openssl.c)
References: <CAO5O-EKGgpYAsJC5j+osB_LAteoUDbOwVYVqkB2=cA3a6VVHoA@...278...>
	<33FD94D8-6860-45F6-AC9D-7CD7D8D93CD9@...2181...>
In-Reply-To: <33FD94D8-6860-45F6-AC9D-7CD7D8D93CD9@...2181...>

--jONFteD0oIWn0hwMhrTFC65PfwqctJc91
Content-Type: multipart/mixed; boundary="------------164918CB3B0D944A98050CAD"

This is a multi-part message in MIME format.
--------------164918CB3B0D944A98050CAD
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 13-05-17 15:40, Antonio Quartulli wrote:
>> On 13 May 2017, at 18:37, Guido Vranken <guidovranken@...277...> wrote:
>>
>> Signed-off-by: Guido Vranken <guidovranken@...277...>
>> ---
>> src/openvpn/ssl_verify_openssl.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_o=
penssl.c
>> index 8374783..d64f83c 100644
>> --- a/src/openvpn/ssl_verify_openssl.c
>> +++ b/src/openvpn/ssl_verify_openssl.c
>> @@ -285,11 +285,11 @@ x509_get_subject (X509 *cert, struct gc_arena *gc)
>>
>>   BIO_get_mem_ptr (subject_bio, &subject_mem);
>=20
> I don=92t think you patch is based on master, isn=92t it?
> The codestyle has been recently revisited and there should be no invocati=
on of a function with a space between its name and the =91(=91. So this cod=
e looks old.
>=20
>>
>> -  maxlen =3D subject_mem->length + 1;
>> -  subject =3D gc_malloc (maxlen, false, gc);
>> +  maxlen =3D subject_mem->length;
>> +  subject =3D gc_malloc (maxlen+1, false, gc);
>=20
>=20
> Please keep the spaces around arithmetical operators (i.e. =93maxlen + 1=
=94);
>=20
>=20
>>
>>   memcpy (subject, subject_mem->data, maxlen);
>=20
> wouldn=92t the patch just be way easier if you had changed =93maxlen=94 w=
ith =93maxlen - 1=94 in the line above? This way you wouldn=92t need to cha=
nge the rest and maxlen would still be the real maxlen.
>=20
> But this is just my personal taste.

This patch indeed seems to be against the release/2.3 branch.  I took
the liberty to 'forward port' the change to master, see the attachment.

As for style, I don't care too much about release/2.3, it's a style mess
anyway...  Seeing that this fixes a real (though not exposed) bug, ACK
to Guido's patch for release/2.3.

-Steffan

--------------164918CB3B0D944A98050CAD
Content-Type: text/x-patch;
	name="0001-Avoid-a-1-byte-overcopy-in-x509_get_subject-ssl_veri.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0001-Avoid-a-1-byte-overcopy-in-x509_get_subject-ssl_veri.pa";
	filename*1="tch"

=46rom 6b26a069052898cca1a1511527857df448a2dd49 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Sun, 14 May 2017 21:00:41 +0200
Subject: [PATCH] Avoid a 1 byte overcopy in x509_get_subject
 (ssl_verify_openssl.c)

This is the equivalent of the patch sent earlier by Guide Vranken, but
adjusted to code in the master and release/2.4 branches.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_verify_openssl.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_op=
enssl.c
index d7202b6..1079759 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -317,7 +317,6 @@ x509_get_subject(X509 *cert, struct gc_arena *gc)
     BIO *subject_bio =3D NULL;
     BUF_MEM *subject_mem;
     char *subject =3D NULL;
-    int maxlen =3D 0;
=20
     /*
      * Generate the subject string in OpenSSL proprietary format,
@@ -348,11 +347,10 @@ x509_get_subject(X509 *cert, struct gc_arena *gc)
=20
     BIO_get_mem_ptr(subject_bio, &subject_mem);
=20
-    maxlen =3D subject_mem->length + 1;
-    subject =3D gc_malloc(maxlen, false, gc);
+    subject =3D gc_malloc(subject_mem->length + 1, false, gc);
=20
-    memcpy(subject, subject_mem->data, maxlen);
-    subject[maxlen - 1] =3D '\0';
+    memcpy(subject, subject_mem->data, subject_mem->length);
+    subject[subject_mem->length] =3D '\0';
=20
 err:
     if (subject_bio)
--=20
2.7.4


--------------164918CB3B0D944A98050CAD--

--jONFteD0oIWn0hwMhrTFC65PfwqctJc91--

--8CPv11d062Tv3tEf2iImJAv9BcesFshtf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZGKuQAAoJEJgCyj0AftKIICgIAMrwAZ3mP8IJsKCPa7KiAamW
jbV2Oxrbpn10g1b3pROMU08yAK6VDcSgNJF0fv7e/8N4ozOfCo0R5jwyoqRCQ0pY
qc39TtPLbuPCQMLUI+PxhrO+AuUU7GLKat81JU2jUnVpubvCtIH3bqLEVli9C82U
Qq5bsuSOvSaqnZVJktcrr0If94VTGl45p88dX538a/jjVAudrZ0CK7drk/p2RREb
MsUzRUpuB2fEQWdr77Ja0/KpQ309ONKyqpFyPZjs74g4ogNDr2T9lKw7IFDLie+p
dHiiO5H7V67dJA0nDWBMu2FR1cz1H+YPeC3deW36MOsWgbVkVT2OsN+/62icbWA=
=yw/a
-----END PGP SIGNATURE-----

--8CPv11d062Tv3tEf2iImJAv9BcesFshtf--

