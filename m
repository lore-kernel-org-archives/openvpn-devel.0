Date: Tue, 29 Nov 2016 20:16:40 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161129201038.2d3f3828@...1799...>
In-Reply-To: <aca99453-61e3-05aa-f683-cf385a7e90f6@...1435...>
References: <20161129063843.14526-1-a@...2181...>
	<aca99453-61e3-05aa-f683-cf385a7e90f6@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/TH/UKKQF_MNQ9t59h86djHc";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] reload CRL only if file was modified
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <a@...2181...>

--Sig_/TH/UKKQF_MNQ9t59h86djHc
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Steffan Karger <steffan.karger@...1435...> on Tue, 2016/11/29 17:43:
> Hi,
>=20
> Thanks for following up.  I did some stare-at-code and trivial tests.
> Will test more thoroughly tonight (hopefully on Windows too), but have a
> lot of faith that those will succeed.  I have some comments from staring
> at the code though, see below.

Oops, missed that in my logs (and did not find the code)... You are right,
cache is cleared.

Either of both is just fine and it works as-is. So ignore my patch.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/TH/UKKQF_MNQ9t59h86djHc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlg91BgACgkQiUUh18yA
9HbBkQgA13/+85bWVDEOm/GB4kBUkAz8JVFAcrtX7Jjw6E67+tjpb2dJbxfbX+1O
VpXd60dyXeEiGjaUBdMNohgX2Juw+E6HivAYB54tt3djip1nPZJ/nMlHelB8N1F3
9EIUR2zgHLc++WxAMzd5HAMFxP7D8p9JXRLuUYJq9zu25zAXDj2wPGzJIsmVYFW9
Rsd8dK0pHauGylV1K1cjkRqOYKrbEgpRdSz1zYHiz3NABOY4XIO74lcXeM/kVDmI
7OL97zr+1bvx3AjmL6i1cu5g3oDzgpbcx6PKrWX8mNbv3nr5IEQPKpQeUVTfr+R/
fLkyi6EnioRmf8q8pfPC6/scG1qdwg==
=Hdi7
-----END PGP SIGNATURE-----

--Sig_/TH/UKKQF_MNQ9t59h86djHc--

