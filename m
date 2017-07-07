From: Antonio Quartulli <a@...2181...>
References: <20170707044704.7239-1-a@...2181...>
	<3cb90709-9fdb-e9f1-dabe-ad3f8663bcd6@...2181...>
Message-ID: <e33381a4-b8ce-3965-6c46-5791d97015a4@...2181...>
Date: Fri, 07 Jul 2017 10:02:00 +0000
MIME-Version: 1.0
In-Reply-To: <3cb90709-9fdb-e9f1-dabe-ad3f8663bcd6@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="wDwUg8kgVJGafFc6J3sMbxRKMupmCrIok"
Subject: Re: [Openvpn-devel] [PATCH] crypto: create function to initialize
 encrypt and decrypt key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wDwUg8kgVJGafFc6J3sMbxRKMupmCrIok
Content-Type: multipart/mixed; boundary="rJW0Mrt6ROxsdE6W0WUvdB1jcKemF41Bb";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <e33381a4-b8ce-3965-6c46-5791d97015a4@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] crypto: create function to initialize
 encrypt and decrypt key
References: <20170707044704.7239-1-a@...2181...>
 <3cb90709-9fdb-e9f1-dabe-ad3f8663bcd6@...2181...>
In-Reply-To: <3cb90709-9fdb-e9f1-dabe-ad3f8663bcd6@...2181...>

--rJW0Mrt6ROxsdE6W0WUvdB1jcKemF41Bb
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Antonio Quartulli:
>> Acked-by: Antonio Quartulli <antonio@...515...>
>> Signed-off-by: Steffan Karger <steffan@...1856...>
>=20
> I have to retreat my ACK. This patch is generating some new warnings
> that have to be fixed before being considered for merging.
>=20

Sorry, please ignore my previous email. I am working with too many
branches at the same time and I mixed up the warnings.

Cheers,


--=20
Antonio Quartulli


--rJW0Mrt6ROxsdE6W0WUvdB1jcKemF41Bb--

--wDwUg8kgVJGafFc6J3sMbxRKMupmCrIok
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllfXDMACgkQ0+HICM1s
oFBqtQ//RxwoGFtkrAPyPoZyzIy+QlmmiCtPkNi93otFWY3zFB+D6b+m2jJdxl7C
RzY8Q/d0pbPHWgFb80xt8dnNEt52m4BQO6fz28rUD2n7mAzWfKx/KdAZJBJzs5xi
mQ/7oPwEd6k2exjP9mKKLlo7/7/vnYgmHExFYgHyYkcsAotz/9//0yZsSCfduOo8
jh41RfPX7BbApcXDMGiHPleZSdTQ7VbthyoWNji8IaukwPpcwHKp/4qB6YFld/9q
ML3kJgo9Tif7t7pLl6MRFYj+x1GXkjDMrsvQ0V2HUCif5nmrwP9AttrSMUcDmS6X
lVYjVn/azuEK3AIjffSQriXLBQwT62vTTbq+2Oqx4Lxbd/G6erhhCY6wb8mVfKzg
ASs6oynwNiJ0vOFPDderkzXjwC5zdIom7FmNqNj7AI02STgOrKW+D7rbCpmbK+O1
Z3TyhNR0+3P2FKtu1Y+sBKxWyeLiUawb1JTt41d0iQN0TOdbQlZ6GNbNS1TSfBs6
/NqQGmZ2VVJ9GCwA0j/U+uFiRVzJKv6oT1lckKJfcWJq7WvmYPGz7ozkAASuw35C
o+bvDnZqedzFru+rCfYqk52wNy4iurG/ZNGBPJSCR29xsKXVFURrw0VxPXm5V+0T
FRsSs76er7A4Of1/KLrSR8M5JLQK/tGrNJj3JsOhL4c5F6481O4=
=1+Qg
-----END PGP SIGNATURE-----

--wDwUg8kgVJGafFc6J3sMbxRKMupmCrIok--

