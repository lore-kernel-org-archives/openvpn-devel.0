References: <1502207741-31750-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4bea390a-1882-6c22-63d4-bf2c9f8fbd43@...2181...>
Date: Wed, 9 Aug 2017 06:17:56 +0800
MIME-Version: 1.0
In-Reply-To: <1502207741-31750-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hWo1pGLmi6V7WaaRcJdov6IHdrK3g0goA"
Subject: Re: [Openvpn-devel] [PATCH] Add coverity static analysis to Travis
 CI config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hWo1pGLmi6V7WaaRcJdov6IHdrK3g0goA
Content-Type: multipart/mixed; boundary="lmI1G9C3r5ss4wkBb0XRVOq4GVqDjuddI";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4bea390a-1882-6c22-63d4-bf2c9f8fbd43@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Add coverity static analysis to Travis CI
 config
References: <1502207741-31750-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1502207741-31750-1-git-send-email-steffan.karger@...1435...>

--lmI1G9C3r5ss4wkBb0XRVOq4GVqDjuddI
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 08/08/17 23:55, Steffan Karger wrote:
> Enable coverity analysis for the release/2.4 branch.
>=20
> We can only do a limited number of coverity scans per week with our FOSS
> account, but since we only occasionally push commits, that should work out
> fine.  But this limit is the reason we don't use the standard travis addo=
n,
> because that would cause the coverity script to run on all of our matrix
> builds.  That would cause us to reach our limit faster, and waste travis'
> resources.
>=20
> Since our FOSS coverity account doesn't handle multiple branches very wel=
l,
> we have to pick one branch to run coverity on.  I think it's best to use
> the most recent stable branch for that (i.e. for now, release/2.4).
> Though for ease of maintenance, it's probably best to apply the patch to
> both master and release/2.4.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

ACK. This would allow to run the coverity scan on a periodic base
without having to push yet another branch every time.



--=20
Antonio Quartulli


--lmI1G9C3r5ss4wkBb0XRVOq4GVqDjuddI--

--hWo1pGLmi6V7WaaRcJdov6IHdrK3g0goA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmKOJgACgkQ0+HICM1s
oFARAA/9EVxEzktBTG5csZpVEMVwqtNAOTVxSlG8IoB+g6T/wW6pBQXHpdqA6/SE
JZpuytroNSf0WLlj8rvtnlsCjppy5r/Hex3ayKTPl0HDilAtf754qfdsePou9wp1
PLoVMmMCwb+LcxWKB3AywYzav9sBpeMaaZw2oE3WvMkUQBV6XjwG/oqSwXd0JpW1
BqjjxuYxR3hmm51H1RuqN1or2vGj00+fSg/SX2Ta7gUmzvk/7uHw57pGOkmluQDb
GW98MJbp4zUzM9tsuCt4T5I6P3LMPPLJzZ4gcLuHtZNi03ViPHo26pIlgJPqxYmY
Y2RcpfazdzwPYP3DztQntP8GB0N41B4jrHoQmVP65hCUNSL9E70nktPFqQ/jeLpm
6KCGWRvTufUlPI/gfyARtgxncrv5iCFg+KvaIir9JIB7JXZUebvqKlUM1lGDiCj7
K5vHZYkWwb/JQx+rSW0D4iYD0wFsvTfcw+lyxGbggEfoVKG84je6NltPO7Cy7NRg
G6DGGPty2Hh2JFkP+RRCy2617AdauMne/lQ0EsnwndfwSR9M2JnlzvmBvVuSkwBW
iHzUoLm6v3lgi3hOWMsWEm3nXgBU29IcPSouJFYlOeH2csCO3DJp2C9mfmHXObay
hlajaxziEZWtpuMamUag66f24jiWaVc8nF9wrMgBJthSYkoUBGw=
=GjFx
-----END PGP SIGNATURE-----

--hWo1pGLmi6V7WaaRcJdov6IHdrK3g0goA--

