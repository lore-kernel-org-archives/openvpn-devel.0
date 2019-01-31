Date: Thu, 31 Jan 2019 17:40:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20190131164010.GG962@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="q8IxIpMDqG8rnqCC"
Content-Disposition: inline
Subject: Re: [Openvpn-devel] OpenVPN 2.4: crypto api patches for OpenSSL
 1.1.1? cryptoapicert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--q8IxIpMDqG8rnqCC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I have changed the Subject: and started a new thread, so that this
isn't lost in the discussion specific to commit ce1c1beef1eb.

On Thu, Jan 31, 2019 at 11:28:52AM -0500, Selva Nair wrote:
> So now the question -- do we want to support Windows builds with OpenSSL
> 1.1.1 in 2.4?

Basically, we already do.

Could you summarize what is current not working right in 2.4 + 1.1.1,=20
and which patches we need to make it work?

I admit I have lost track (many many patches related to TLS 1.3... some
bring new features, some bugfixes) and could imagine everyone else being
in the same boat.  Maybe except Arne ;-)

thanks,

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--q8IxIpMDqG8rnqCC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcUyTpAAoJEB2Cnv7KVigSOjwMALVeK7cVsu9UDWWQg5U2QGZw
vCCMR5hVxPNK+g7on4XzTgYbpPOiZnoopK2gOa/t2wlm/pjr0gPwij8IBpVJ9e80
qE8rAC6TR1o2RR13qI8HAqtlZ4UjC3wXwMphrF7MCtrqew3hTNPGbL0fpQRjR1xg
pqS/ZhKBXN/TWCwvnqxO+JPE4qDKhkeD0hnN64jyCMAzz3mQBN3v/5++Ag5yFOUv
GvKGGM9+92yuT2hPZMWj39L1OwyQ8EiXEaHzFaNxHLpJNIvJP1BC8Voes3dTvesW
mUWBWjscR2qM5mqTHLhzgioIBCZPbiUMlHg9ZDG8bD3AExFJuMKeJnNtnfMUnyVJ
Ef8A+W4+HUS/UZFWXXyW3xI/2rCrqQ4TKqb1DBMRglyQS/m+gnaQSpcsC6isMTX5
tCd/8w04M2Lti1DxXpQjohcC6x/igZzxSDV6uoYFXadNim38DmJAiq4TBxp8+3vw
/GFyT8c4U2aWk4JpaWkvaVfpPZ0VKj0qKhptD+HLug==
=3kn6
-----END PGP SIGNATURE-----

--q8IxIpMDqG8rnqCC--

