Date: Tue, 18 Jul 2017 23:26:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170718212609.GC70062@...1296...>
References: <82384304.20170718084649@...1934...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <82384304.20170718084649@...1934...>
Subject: Re: [Openvpn-devel] iOS key decrypts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Greg Sloop <gregs@...1934...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 18, 2017 at 08:46:49AM -0700, Gregory Sloop wrote:
> But in iOS, unified confg files can't be pulled from a website -=20
> essentially you either email the config, or transfer it via itunes.

Downloading from a website works just fine.  You need to coax Apache
to set a few headers, but then, all good :-)

This is what I have in my apache conf:

<FilesMatch "\.ovpn$">
    SetEnvIf Request_URI "^.*/([^/]*)$" FILENAME=3D$1
    Header set "Content-Disposition" "attachment; filename=3D\"%{FILENAME}e=
\""
    UnsetEnv FILENAME
</FilesMatch>

(it looks slightly convoluted, but I found no other way to specify the
filename, and that's needed)

In addition, mime.types has

application/x-openvpn-profile                   ovpn=20=20=20


no idea about the encrypted keys in iOS, though.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZbnzxAAoJEB2Cnv7KVigSBXsL/20Z2WNXoV7SaXE1yFTfxers
PgAGvgbIaU3BiZJzrxqCH4c6CS+kGoPLLj3bT1KwODv5J4TvNMWRTJ+sHvPe4vux
5FSOCjohpUx+WmW9b9QK/E3jw7QC3419nNV+PxfhCo+bsxI7CRpcjM5Na2fCZ1Ds
BrV2d4pi9zZls3r4nUJztoLIb155rkrQKgw/evpPBnisSsXgNH9RHKDKo1TCla02
HQlAZYXR7//SnslUiB/MEEWppydWJixdgLipjt5BZiEj5sPennI+1UqSM5hTpCJU
Ka0jTy2ePo7fYOqkFubBtPyiucEh3tZ+YlVmEFT8sBlxgp4CCRdgpao+nBUbHGz6
cxRravluekLzquXoSCkS/UzDIey4kw3AyOCNd503YZKfZBxWjtly+VEIgflE38/C
1OYIk5PR5Ul9gi9R8JJiP07Hip1wDVrZnFqsYHPLjT4XZNORHJCxNvrQI02Rs/js
ZcR77QD5GxHNnaZPc7OV7YtjWmbfNZ1YuBfF8uZsog==
=d+W7
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--

