Date: Mon, 24 Aug 2015 23:10:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150824211025.GE34798@...1296...>
References: <551A5509.702@...277...> <20150824181826.GD34798@...1296...>
	<55DB6DD8.4040203@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h9WqFG8zn/Mwlkpe"
Content-Disposition: inline
In-Reply-To: <55DB6DD8.4040203@...277...>
Subject: Re: [Openvpn-devel] Increasing TUN_MTU_MIN to make connection
 establishment faster
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jiri Horky <jiri.horky@...277...>
Cc: FF Systems <ff-system@...2025...>, openvpn-devel@lists.sourceforge.net

--h9WqFG8zn/Mwlkpe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 24, 2015 at 09:17:44PM +0200, Jiri Horky wrote:
> thanks for the information. I see you effectively increased the size to
> 1.2k which, as far as I know, will not work for people with dial ups.

If that wouldn't work, openvpn data transfers would not work either - but
surprisingly, they do :-) - data packets are 1500+ bytes in size, unless
specifically told (--link-mtu) to be smaller.  We do cap the control channel
MTU to a smaller value to give particularily broken setups (like, 1400 MTU
*and* broken fragments) the chance to push smaller --link-mtu from the
server.

"Dial-Up", per se, does not imply a smaller-than-1500 MTU - some folks
do that, for "performance reasons" (reducing MTU actually reduces
performance, as it increases TCP overhead, but what do I know against
glossy computer magazine advice...), but even a 574 byte MTU will still
work *if* fragmentation works.=20=20

Which it normally does in this combination - fragmentation tends to break
if stupid NAT routers are involved, but "dialup with modem links and=20
574 mtu" is usually not connected to a NAT router but modem->PC...

But as I said - I'm waiting for feedback.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--h9WqFG8zn/Mwlkpe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCUAwUBVduIQKkuBuNlUUl1AQKSHAP4tEEksHC3fQkg+bURajXjdDRSXgln51Ek
EuKgqjZBrO8X7zvC6pncn+ItHu0w55dpj+XysBjH27RQsS1qelfdZqHrqB54QyWh
tsI++qbFNPEz6ZhsALHaOpCkwlqQnKTA7yhPmJj7SrCNfQfl35jJfeRFBdsfdQ6u
+z+DIAKvXw==
=E5hY
-----END PGP SIGNATURE-----

--h9WqFG8zn/Mwlkpe--

