References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-4-git-send-email-heiko.hund@...1489...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b8bdf72a-bbba-51e7-c82c-11d1d92a367c@...2080...>
Date: Tue, 8 Nov 2016 11:49:47 +0100
MIME-Version: 1.0
In-Reply-To: <1477672963-5724-4-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="O8Evmfsiw9eLP209prXFp1XO4pE6fLMWO"
Subject: Re: [Openvpn-devel] [PATCH 3/7] remove unused system_str from
 struct argv
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O8Evmfsiw9eLP209prXFp1XO4pE6fLMWO
Content-Type: multipart/mixed; boundary="8kHgq0bj3crTHbDidINCoPDOUMEsg9blL";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net
Message-ID: <b8bdf72a-bbba-51e7-c82c-11d1d92a367c@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 3/7] remove unused system_str from struct
	argv
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-4-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-4-git-send-email-heiko.hund@...1489...>

--8kHgq0bj3crTHbDidINCoPDOUMEsg9blL
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/10/16 18:42, Heiko Hund wrote:
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/argv.c | 86 ------------------------------------------------=
------
>  src/openvpn/argv.h |  1 -
>  2 files changed, 87 deletions(-)

ACK.  Looks good.  Valgrind also reports less heap usage, which is
expected due to not allocating buffers for system_str.  Otherwise tests
passed.

As for the prior patches in this series, I will wait with applying this
patch to the git tree until all the other patches in this series have
been reviewed and ACKed.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--8kHgq0bj3crTHbDidINCoPDOUMEsg9blL--

--O8Evmfsiw9eLP209prXFp1XO4pE6fLMWO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYIa3LAAoJEIbPlEyWcf3yvjQQAKfALAlhl1QogmasKnG2PFq/
JY8J8Zjj3WnMyQqJaMViznLTtI5MGb7Sy9JaN8rKZlV6RuLd5sTjjZh9YRmtSy6q
TyL3NuZpPpZyUcgWFvBefyRD3kvKCn6RG4bPmJBBtASJq3n62QNRU7wc2T7I32d3
UDLbxAh6w+AkATQyc3iFeq8F+Q2ViyzO/v6wp9kj1bMioFNqC7d44AlwN5xBjJPE
zl4DmxxkEfubN16c6Y+SDHkHqgkWKMLIiA10iejGVt6w7cPPFqvFThAQLs3XfYEe
ouk1hboTqEyqUqsWoT1mcUFuYH47BK55BR9lsfnMllPEQlAdvWkCyQdxliYcxJZA
TO13LUOIBRvR+r1uIYzPgz7NySjeRTO2tWiLvTkM7Ey0vA48gMv8ZcSptmpSeO3j
12lN1n04JNNq3MIaukAi5I+XsRdoB//mbg+cyGRb+q91e6T2eIJRyug7dRbpJD6t
vwnNUE2s+jG8I+5G9iPrjKWSt+gcCwUFJ7gs3V/0V1VOa+wKb1WNYHOGtGff54Fx
8IvXx6hx3mdbemh7rxbYWNd1LHd7y4fKaJxpTtZFtSBJupKGujfvVay3Q989i5Uh
U0LqMa82gbMGB5nA4WehKhnwcRo461NyMd+g7XjV97w7VYRVKuuP8RplAywz63IB
kBKvApzBPOzdadmpgnEy
=Clfu
-----END PGP SIGNATURE-----

--O8Evmfsiw9eLP209prXFp1XO4pE6fLMWO--

