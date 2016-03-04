References: <56D8A6C4.5080803@...2070...> <56D97EFA.9010207@...1147...>
	<56D98171.7040103@...2070...>
	<1457096221.43867.161.camel@...1866...>
From: ValdikSS <iam@...2070...>
Message-ID: <56D98A8F.7060702@...2070...>
Date: Fri, 4 Mar 2016 16:15:59 +0300
MIME-Version: 1.0
In-Reply-To: <1457096221.43867.161.camel@...1866...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SjgwtD8crj2flUiAdwMIqRIaE4LRBFWA5"
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>, Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SjgwtD8crj2flUiAdwMIqRIaE4LRBFWA5
Content-Type: multipart/mixed; boundary="84SwFPwsaSGV0Kx3qwIhtXwtQJAcn09p2"
From: ValdikSS <iam@...2070...>
To: David Woodhouse <dwmw2@...1866...>,
	Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net
Message-ID: <56D98A8F.7060702@...2070...>
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
References: <56D8A6C4.5080803@...2070...> <56D97EFA.9010207@...1147...>
	<56D98171.7040103@...2070...>
	<1457096221.43867.161.camel@...1866...>
In-Reply-To: <1457096221.43867.161.camel@...1866...>

--84SwFPwsaSGV0Kx3qwIhtXwtQJAcn09p2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/04/2016 03:57 PM, David Woodhouse wrote:
> On Fri, 2016-03-04 at 15:37 +0300, ValdikSS wrote:
> What you described *was* chained certificates, wasn't it?
>
> From the point of view of a client which only trusts the old CA, the
> server is presenting a chain =E2=80=94 its own cert, followed by the
> "intermediate" new CA which is in turn signed by the trusted 'old CA'.
>
> And from the point of view of a client which trusts the new CA, the
> server is presenting its own certificate, followed by something which
> can (and should) be ignored.
>
> Major CAs have done this, haven't they, resulting in a few crypto
> libraries having to be modified to back up the chain and look for
> *alternative* reasons to trust a cert from further back.
>

Yes, I'm trying to do exactly the same, and it doesn't work. It seems that =
OpenVPN don't want to load multiple certificates on the server side for me.
I'll investigate it further.


--84SwFPwsaSGV0Kx3qwIhtXwtQJAcn09p2--

--SjgwtD8crj2flUiAdwMIqRIaE4LRBFWA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJW2YqPAAoJEFzXIC7viPdyKSEQAIDQDttrirnUm4//oW4VgsNv
ESP/c4ifGPV/k9O5yfhQWf4Ki7SRxySlcNJbCWWvduPMpPD604EnN1rWbC3hAomP
fq5yv+VpM826Pv3NLdPJyr8khOku2c02IOJvgxZ9XrASZZvL8Yl7c2cSHJVqoId6
5M5mrQre653+OFUJ8P0ocuLgAMwJLm4iUbXSpbNbCyD5hciWPxzugG2Nb2UgYL5i
VhQngOGfSrLCDkJR1I+JHePX3TjDr2XOnhPLxSBim/2tz/GdFDuMspRYBodtaxaI
A+CBdEg4/UMqeYyRNs/fSFHKJbjnZ1SBU9POaC+fZg8/PZw9jSCo+zhFh9mU9bkB
0ozpC7Sv1dQ2t+GGZqeoOFoCOadkgHb0DswEInUX5IpVNnIOupGhh1eUo97RTdUB
8aZqJauzs/5PuwetVHBhS85IlHjzCjtOkUzEsdilYvlfHCGQHFCeFZCO2gPZPVh4
otDoyV+Iy/QYE+k0PBem7AYcVklysPMgWY9PDTzQ+CD+1DbCRBKCRmoOhebpbNQA
gY6nyeltrCmlb3COkG5FDh9PYIYLfgiTf7R0S0Ks8dLGWpckz95trgDaKrvkXCCz
zQiM1wJOXoIbWA1GiHad8FgSt7F+LFOyyq6dh/mXiNMncNLDI7sc701S/38f7dXh
+Fgnv+D92UO8gilYGw5x
=PKS0
-----END PGP SIGNATURE-----

--SjgwtD8crj2flUiAdwMIqRIaE4LRBFWA5--

