References: <20190225183531.27399-1-stefan.strogin@...277...>
 <1572e620-4a2d-d840-060b-a1ecbdd224eb@...1227...>
From: Stefan Strogin <stefan.strogin@...277...>
Message-ID: <e8afe242-de9c-d695-1eb2-918e17e8bf02@...277...>
Date: Mon, 4 Mar 2019 12:02:30 +0200
MIME-Version: 1.0
In-Reply-To: <1572e620-4a2d-d840-060b-a1ecbdd224eb@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XkYFd1Ra0d55uuqBnnPAA3yqAeq7NHVvu"
Subject: Re: [Openvpn-devel] [PATCH v2] Use correct ifdefs for LibreSSL
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XkYFd1Ra0d55uuqBnnPAA3yqAeq7NHVvu
Content-Type: multipart/mixed; boundary="SOz27Jy9kz1kNGec3vXkE5DsGJegG8G3N";
 protected-headers="v1"
From: Stefan Strogin <stefan.strogin@...277...>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <e8afe242-de9c-d695-1eb2-918e17e8bf02@...277...>
Subject: Re: [PATCH v2] Use correct ifdefs for LibreSSL support
References: <20190225183531.27399-1-stefan.strogin@...277...>
 <1572e620-4a2d-d840-060b-a1ecbdd224eb@...1227...>
In-Reply-To: <1572e620-4a2d-d840-060b-a1ecbdd224eb@...1227...>

--SOz27Jy9kz1kNGec3vXkE5DsGJegG8G3N
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 04/03/2019 11:41, Arne Schwabe wrote:
> Looks good so far. I am struggling to find a security/release policy how
> long LibreSSL SSL versions are still supported. I would be nice to have
> some idea when we can remove the LibreSSL 2.7.0 defines.

Thanks Arne!

I am not associated with the OpenBSD or LibreSSL projects, but from open
sources I can find that:

=C2=ABLibreSSL transitions to a new stable release branch every 6 months in
coordination with the OpenBSD development schedule. LibreSSL stable branches
are updated for 1 year after their corresponding OpenBSD branch is tagged f=
or
release. See below for the current stable release branches.=C2=BB [1]

LibreSSL 2.6.3 - OpenBSD 6.2 which was released on 9 October 2017.
Therefore LibreSSL 2.6 support should have ended on 9 Oct 2018.
Accordingly LibreSSL 2.7 support will end on 15 April 2019 (one year since
OpenBSD 6.3 release).

[1] https://www.libressl.org/releases.html

--
Stefan


--SOz27Jy9kz1kNGec3vXkE5DsGJegG8G3N--

--XkYFd1Ra0d55uuqBnnPAA3yqAeq7NHVvu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkfUG6Y1yNm+33DMMHWzUMpXJe34FAlx897oACgkQHWzUMpXJ
e34X4xAAgw0QBpgbguCa9Awq2M52ee0gRaqSOXwtIQ8YwSNkebBVxIUJETrlGAFC
evOTmv57LUztdn9avv1iqs+TfbMz6bCaJc5qG+xy2/75lQMlmJo7o1Rtgvx82gUI
3wd6LVac447PA9zptB90wDnT0zhyykbL8u1gevwafLydTdMKhQiZAf0HsIzXNp3W
XK4t+Rez9fxZgqj82wv7nqSu0brltKKPivRcOVDtJ9w2nYsFqSp2oxrdStypQ+dc
QeDp+MoDEIRL6w3TqO3UFfB6L9Mno0bnWldTzE7V+BJWlJZhsXONzVRBNQ0iByHW
AgLFFR2kpkRbVFK3wvO5SlQqPizxlVV82j+6KmBH+HHjQRdZZ0SlCnVaTzQY58uY
Xx47CsNsuXcAXdgZ7/zmdD6RHmpn7AsVWBQcJhzQTRgq8jKEQ3ogxhpOen2MBWjh
65PuytPd06hfVSjpl4+9vzpmpKir2P6fs7y3dNk0QW5pCr8Nir+C3qIHSTMu55Zb
YXRsNQfQwDcRuLj84nC0i5nP3A6OJ+QK12TGVhClG+45tfG4hVce56FJuLDIMNVd
3ujYBbM4eQ6Q/LxsC+2axcJS8uNqnoWaa9/dteWzE46OYWqryKeemvonmRINL9lD
ehfB8JtP32ZSCMh10KMHj1GoJac2//+b3LYXKDlm/rSUVWJccSw=
=pGhD
-----END PGP SIGNATURE-----

--XkYFd1Ra0d55uuqBnnPAA3yqAeq7NHVvu--

