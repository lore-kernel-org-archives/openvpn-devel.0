References: <20180602034206.9459-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9f251992-0397-41e3-e1a5-506330c33aba@...2181...>
Date: Mon, 4 Jun 2018 10:15:50 +0800
MIME-Version: 1.0
In-Reply-To: <20180602034206.9459-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FrZYEsrC91XJO1FihCq97MyYAmRKKkVfQ"
Subject: Re: [Openvpn-devel] [PATCH 1/2] make tls-auth a
 per-connection-block option
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
--FrZYEsrC91XJO1FihCq97MyYAmRKKkVfQ
Content-Type: multipart/mixed; boundary="JQk5AwErhZI4vmdNnpWI4MAVtWtCYd12B";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Cc: Steffan Karger <steffan@...1856...>
Message-ID: <9f251992-0397-41e3-e1a5-506330c33aba@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] make tls-auth a per-connection-block
 option
References: <20180602034206.9459-1-a@...2181...>
In-Reply-To: <20180602034206.9459-1-a@...2181...>

--JQk5AwErhZI4vmdNnpWI4MAVtWtCYd12B
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On 02/06/18 11:42, Antonio Quartulli wrote:
> Different VPN servers may use different tls-auth keys. For this
> reason it is convenient to make tls-auth a per-connection-block
> option so that the user is allowed to specify one key per remote.
>=20
> If no tls-auth option is specified in a given connection block,
> the global one, if any, is used.
>=20
> Trac: #720
> Cc: Steffan Karger <steffan@...1856...>
> Signed-off-by: Antonio Quartulli <a@...2181...>

as reported by Steffan on IRC, this feature breaks when using
"--persist-key".
It happens because, when moving to the next connection block, OpenVPN
won't load the new tls-auth key and therefore will trigger an assertion.

After further discussing this issue, it was agreed that we have two main
options to tackle this issue:

1) pre-load all the tls-auth keyfiles (like if they were embedded in the
config file)
2) make per-connection-block tls-auth keys mutually exclusive with
--persist-key


while point 2) would be the easiest option and would require the least
amount of code, we believe that 1) is still the best from the user
perspective and from the option semantics point of view (as it would not
lead to any behaviour change).

Therefore a v2 patch will be sent implementing approach 1).

Cheers,

--=20
Antonio Quartulli


--JQk5AwErhZI4vmdNnpWI4MAVtWtCYd12B--

--FrZYEsrC91XJO1FihCq97MyYAmRKKkVfQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsUoNYACgkQB6U8WA7y
zXQFXw/9GGW4jfxcPmnLLK50BjU223GUvT56IGsJ6vqawlkFBYemKotW7CTwnVGF
GjQWy00SjO5qarlWoJl7Fx3gbsEyXFAkrFdWEuCeX4XDumYa6dVPJ9cT0+juSA1Q
sIYSAibCNg/nh4Nhk6B+YJ4MKKetqGtsknZohnSk2Ep2y+BwxwXkWebfMHJWFQhV
vvBxvBDSSMs6nDKxiukKHqhOQJsCoNISRF4DfvfW1lFJSmyQ3UJTmdXUd8kIEL42
j4kAy2h39rYfuw2PawhyvvP87SL75nmJQqgBcWd/lH6CjZqwibdwXBEEdTxel5av
dBiz0K7VdsTEXli1XAg/SyYiqGzHzv540Hi8+4jm+CT/nPzFZFhgV1HVhecZfods
MaDp7mpYgnXuosR6qXa5GSoO1gmekjKiOS4yS4Id1yENucssJZiRuvPkfy7rdNx/
oY+xpa/ZysqokzWyz7sn5ocop61Kcqs1mFqSJrWoRQ3K2fW9LcAKA9BPNaxqPxMG
kDz1LdfBj5afuPhKxTrcrEL75q/goDVlhdXXBgwMKre2ZVX44MBSoAPHsBTIRun5
nl6gk6B7E1CJaexWCYhz4wqqcUdACg0fKhmfqjZYwUHZ+xIqY34HG1fTcKOHoxkW
zDqKuRzoHJrtHqf4cX0c6zGr0lKfcE8KnWGXDK+6j0ilrYS57XQ=
=tV8q
-----END PGP SIGNATURE-----

--FrZYEsrC91XJO1FihCq97MyYAmRKKkVfQ--

