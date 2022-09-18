Date: Sun, 18 Sep 2022 12:12:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yybu8YT8PGGUvDTx@...1296...>
References: <20220917213154.29285-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="F1LbDLQRtTLibV1f"
Content-Disposition: inline
In-Reply-To: <20220917213154.29285-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] is_ipv_X: improve packet consistency
 checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--F1LbDLQRtTLibV1f
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 17, 2022 at 11:31:54PM +0200, Antonio Quartulli wrote:
> This patch brings the following improvements:
> * check that ETH proto and version in IP header are consistent;
> * check that length of the packet is enough to store the expected IP
>   header (it may be an IPv4 or an IPv6 header)

Since this is in the fast path - what is the motivation behind adding
all these extra checks?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--F1LbDLQRtTLibV1f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjJu7xAAoJEB2Cnv7KVigSTaYL/A87yT3j+xbESatnRC9JH5R5
wIchXyJaMCh6LnJOB/5PWyNVQO7cdLE9Sz7ncpQMA77kc4XB+JBts2hLfxBiamOE
HNyUvNCOqKTrp7ronSVblvGNOUl8eDI4lOiQQFq4Qg6UQEW5pLGlIWCTz9LuxRHz
2qXh8OtXKf7wJ93AtAuqU/Gs6PZ0kdZGMiH+ZttIwOp/TCYNQm70gNJxWVYO4lmt
gZ+Z+g0kuMzbp7u/5+mUQ8tOsW6UVYiRUdf7Pth+0O8JP5VwJDbV+PX1u62+Isxe
LjHwsf44MLZinJr5loXskkBcIQ3DeVLeSe5LPddn6ivPtLt+LsaQBJtOjcqnBtg9
zKI1KnUPuZSoV6FQQUpGzkmWpcOKVkoqkdHtuOWOj1m+3PXJ7zrXq8I5Hy9nHbm4
MQ6kjuFHgTA7VzmBmtmazwcCKK6m+xKW0yyE8XshAy9+LTJ/7My/6ODaRa/8maCl
2riKaFF2VPSKJbTgsyN9KroYj2J6C7MH+8R6ad03QA==
=1BfX
-----END PGP SIGNATURE-----

--F1LbDLQRtTLibV1f--

