From: Antonio Quartulli <a@...2181...>
References: <20180608052017.6696-5-a@...2181...>
 <20180623200844.32598-1-a@...2181...>
Message-ID: <56af49a7-4568-5282-a926-e90fe4b78ae9@...2181...>
Date: Sun, 24 Jun 2018 12:44:30 +0800
MIME-Version: 1.0
In-Reply-To: <20180623200844.32598-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7zrCMcUdmmJK3TU1ZplrKAAu2XxkG879S"
Subject: Re: [Openvpn-devel] [PATCH v3 4/8] pool: allow to configure an
 IPv6-only ifconfig-pool
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
--7zrCMcUdmmJK3TU1ZplrKAAu2XxkG879S
Content-Type: multipart/mixed; boundary="9Kw31VVV6HCyIHYgEc5IJlvUrF8y7VJ2b";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <56af49a7-4568-5282-a926-e90fe4b78ae9@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 4/8] pool: allow to configure an
 IPv6-only ifconfig-pool
References: <20180608052017.6696-5-a@...2181...>
 <20180623200844.32598-1-a@...2181...>
In-Reply-To: <20180623200844.32598-1-a@...2181...>

--9Kw31VVV6HCyIHYgEc5IJlvUrF8y7VJ2b
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/06/18 04:08, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> With this change a server is allowed to allocate an
> IPv6-only pool. This is required to make it capable
> of managing an IPv6-only tunnel.

After discussing with Gert, I'd say that maybe this last sentence can be
removed because "an ipv6-only tunnel" is already possible on a server
(just without a pool).

>=20
> Trac: #208
> Signed-off-by: Antonio Quartulli <antonio@...515...>

This single patch has been applied on top of master and thrown at
buildbot. No failure has been recorded.

Cheers,

--=20
Antonio Quartulli


--9Kw31VVV6HCyIHYgEc5IJlvUrF8y7VJ2b--

--7zrCMcUdmmJK3TU1ZplrKAAu2XxkG879S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsvIa4ACgkQB6U8WA7y
zXS87w/9FMS0xyUiHOY3ScRQxdHuOvYY1mJq6WLxumFylPPtqpnFqZcHHpo/rTZH
Eluxrykp3Pm+VXA2uEDJ61S9JkSVDDEOaiUNUohOFQGkKvSMXGehxUrtxOrdYkLi
H+1iwm6vbpp3SLzLMoGjJgLwfhpgYPqIGN2ziPSZb2/SlkeIBlajd2aLW+9PG8Tl
wzoikPb0+mYOzReYQbHhl1KHnblxUzjWLnZmmLqroVhVmJteWYUJnt0V0OiLzYa7
y4nXrrTiayH+dDTJR8vqh50JWHQwDYO9AvHfSxvq3+eiCT0Tniv0qJgJBb8ESxcI
F4IWv7VwNk8h3O2xNU+iBD+Nh38W2Rx5f1F0r46LzIkKzMX+HzA5WWzhQo1+rsK1
8bu5hYAVRJ6PokgUuE7L4+/0UeJDPE1VMyIGCsn2Uj3bjbl1BL3W8XnfQnyjI9o5
ImwJbjZseEdainBisgqvhIbMeRW5RYHqPW7bSEvjGitUImGHM5fOYPAjMya47Cmp
3dynrsWBGeVpA228yHT/FVTrc81faFOUerz+TC354eV0ZjxaMJTf21JkynkNCjhJ
m7SStrvs2eOAnI+n80js3jpwghcSLhyzl9xhAdgigepsppH90r1QF123inMlMFnB
XO8AgO7DlglbJrKewEV0M5nXKHfW4JWZEapk6bi6FJNVJ6kN5G4=
=h0lU
-----END PGP SIGNATURE-----

--7zrCMcUdmmJK3TU1ZplrKAAu2XxkG879S--

