Date: Tue, 27 Jun 2017 19:29:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170627172948.GX97029@...1296...>
References: <20170626211540.32502-1-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dX9OMq+wIuLE1e4+"
Content-Disposition: inline
In-Reply-To: <20170626211540.32502-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Undo cipher push in client options
 state if cipher is rejected
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--dX9OMq+wIuLE1e4+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 26, 2017 at 11:15:40PM +0200, Steffan Karger wrote:
> Because of the way we re-use the options parser for both config files and
> pushed options, we always update the local options state when we accept an
> option.  This resulted in a pushed cipher being rejected the first time it
> was pushed, but being accepted the second time.
>=20
> This patch is a minimal way to resolve this issue in the master and
> release/2.4 branches.  I'll send a more invasive patch for master, to
> reset the entire options state on reconnects, later.

Uh.  While I find the patch totally logical, and have already finished
the ACK-and-merged mail, my compiler disagrees with me...

gcc -DHAVE_CONFIG_H -I. -I../../../openvpn/src/openvpn -I../.. -I../../incl=
ude  -I../../../openvpn/include -I../../../openvpn/src/compat       -DPLUGI=
N_LIBDIR=3D\"/usr/local/lib/openvpn/plugins\"  -g -O2 -std=3Dc99 -MT ssl.o =
-MD -MP -MF .deps/ssl.Tpo -c -o ssl.o ../../../openvpn/src/openvpn/ssl.c
../../../openvpn/src/openvpn/ssl.c: In function 'tls_session_update_crypto_=
params':
../../../openvpn/src/openvpn/ssl.c:1971:29: error: assignment of member 'ci=
phername' in read-only object
         options->ciphername =3D session->opt->config_ciphername;
                             ^

... wut?

(this is 2.4, but I assume master will look similar enough)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dX9OMq+wIuLE1e4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZUpYLAAoJEB2Cnv7KVigS0gAMAKIAZhCZPEB2JB2J4Vl4bmOI
A/zyumkBCCbNUm5NUhecx8hH25wrrAa5X1o1fmHMJZO2L4WhxxclKnqvQT9bQN4W
RzCKK9Edwel+XFGsHJ18jaL7KqqRl3kGClJ5dvbpXKR94SxTcnm7Ls9Zg5ApfOrX
WVXZ0x7wp+ooVGUYxx++FQYXsQ8XTl1ECDyN0PlTWnLyOx8bZkZFXoB3L3OwKB6W
CsUwCfswuZ3owINoe+uoDvVEFovZra/CFuggLgUqsJGFmqDHWTJSb+jTJ8bBGmrY
Kz+IXhdrAQYvvPRHXpQyA03PxvPdF5Ifh4WH6XaKsn99s9YBMUDzxWiRmZlNc6EZ
b9pbRb2UJfNgjbYMf30PNQBJDa5LFlYPKfd++6DvnIpEufM3A5UBI4TpDgG4BP9g
06XJmtJrnxeCQD2iWdJ4IOnitgnL1DL0C4dkfOT3F30ALXnGwxVOgjMV4+qzAClV
h7Gi0QhE/HX9rbyW+D3wC2teZ7BhssCCwLyd5g2mCw==
=60Jg
-----END PGP SIGNATURE-----

--dX9OMq+wIuLE1e4+--

