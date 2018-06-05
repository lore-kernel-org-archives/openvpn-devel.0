References: <20180605032902.26440-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <2e92bec7-1374-2895-d255-f7fbc7ecfd2f@...2181...>
Date: Tue, 5 Jun 2018 14:20:38 +0800
MIME-Version: 1.0
In-Reply-To: <20180605032902.26440-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fER95oN8rqdSYTPL69IQMOLrbH54Laa6M"
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] crypto: always reload
 tls-auth/crypt key contexts
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
--fER95oN8rqdSYTPL69IQMOLrbH54Laa6M
Content-Type: multipart/mixed; boundary="6rcrsPYu4i2ivT6cXHgHAl20UG4ZF27Yr";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <2e92bec7-1374-2895-d255-f7fbc7ecfd2f@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] crypto: always reload
 tls-auth/crypt key contexts
References: <20180605032902.26440-1-a@...2181...>
In-Reply-To: <20180605032902.26440-1-a@...2181...>

--6rcrsPYu4i2ivT6cXHgHAl20UG4ZF27Yr
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/06/18 11:29, Antonio Quartulli wrote:
> In preparation to having tls-auth/crypt keys per connection
> block, it is important to ensure that such material is always
> reload upon SIGUSR1, no matter is persist-key was specified or
> not.
>=20
> This is required because when moving from one remote to the
> other the key may change and thus the key context needs to
> be refreshed.
>=20
> Trac: #720
> Cc: Steffan Karger <steffan@...1856...>
> Signed-off-by: Antonio Quartulli <a@...2181...>

as clarified on IRC with Gert, applying this patch alone temporary
breaks the persist-key logic and this would not be good when doing bisect.

I'll send v3 implementing what is needed to ensure everything still
works, even after having applied this patch alone.


Cheers,

--=20
Antonio Quartulli


--6rcrsPYu4i2ivT6cXHgHAl20UG4ZF27Yr--

--fER95oN8rqdSYTPL69IQMOLrbH54Laa6M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsWK7YACgkQB6U8WA7y
zXTxvg/8DZ69iruGC0bhRE3GX9JMqtxEjTngl7q7wG38yTDOc2Sxq2FMsOfygpW6
bGO3ioSxfKSdA6bmRcOaF8lBKvtyE7av5C7HOCkg3+A7xAKuWWj9r/e+4N62sdaB
VE66aF2nerHKXOQE1Nu1pVkHVNcNWMIQY/CykgduRbMURzzH9pNAwjyokeT4O7CY
xQUi9Enpj5q8RFUMYdU7Fv0qxTLm9PnJAad/MpEZSjoS1TngZ8tTKAjFPncP//se
F3dSKM7psj+Z/wdNtf2f/V8GeUV09xSinKLA73yKubijqQ5ESG+d7jo5TSkWPYog
XJzS1Ed9zlOWNgknO/pgLdTnhILnNhwlqUJNhj+Ug9as/G+NKmjnwFAMyOeA/2lK
9f1Rv747ASUgdNlWGZFzHrwN5KQHF1qFc1cD4PF4ReNwfz9GOKJqpTADanQKr/U9
tF3n6VIvG9toBBZ3hUPAnnI4Axy4ZML0HzgzIW1jWRA0I0qXNKFO+2EZZqgxsfHt
1iHu4GlEKUuNaIU77qQGl1m+C8HK3xjkY0OabzpQW8Cud3LewqUPhYliDS6qq8Hp
hkCa9UpoB2GP5Q4N8No+e8Xbn9zWNvQGSeG07lb6o1AdwCyZ5MoVERZyPX5L7Iwf
C93Rbh3pdo/BUYiqHgtWDhkC0FOZaistyo9TtTFrq+Z8qYfj53c=
=7waF
-----END PGP SIGNATURE-----

--fER95oN8rqdSYTPL69IQMOLrbH54Laa6M--

