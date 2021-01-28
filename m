Date: Thu, 28 Jan 2021 08:54:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210128075444.GM976@...1296...>
References: <CAKuzo_jUJ58K5VirzjgvP=dJZ_qy+H0gGzNJ4hkiAyjSKQdMUQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nSymKG4Q86w85U5x"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jUJ58K5VirzjgvP=dJZ_qy+H0gGzNJ4hkiAyjSKQdMUQ@...278...>
Subject: Re: [Openvpn-devel] rfc: mingw and the interactive service code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nSymKG4Q86w85U5x
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 27, 2021 at 10:04:49PM -0500, Selva Nair wrote:
> I see two options:
> (i) force __USE_MINGW_ANSI_STDIO =3D 0 in configure.
> (ii) Change all stdio function calls to be compatible building with and
> without this macro defined. AFICT, the only change required would be to
> replace %s and %S by %ls and %hs in some places -- mostly in interactive
> service, one instance in tun.c
>=20
> Any thoughts? I'm leaning towards option (ii).

configure-fiddling-with-#define tends to be a never-ending story, so
I second going for (ii) - if that is compatible with MSVC.  Lev?

And maybe we should write this down somewhere - "which format specifiers
are used, and why?" - style guide page?  or something else?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--nSymKG4Q86w85U5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgEm3DAAoJEB2Cnv7KVigSRpsL/3qHABK2NStFcjvN9/KbTNHI
II9R3MMmhKqxOka177Wz/Ul//ZUkdmoPd+GDNMcN0dFl3VhtWvHHcQM1cn5wemkP
nii+/nRmoc2pcvQ1T9dmCTavWEF8Lmb1l9FV6wgzJ6UeL4Be8uAV1I5esMcptXR7
7OpbF/i5RFxaRJdhhyzLd61sOHQ11/sMv4yGuw4c+1bOehag1N+/TYCKgToMztlN
f4alhSwCZkC1LzETB9TFuFB/ivOyf+Nx3QGsDrs3QCggs9Ykz3k+v9lrMPFVvzJO
IGSUTbGW015fF8oAbfwRZsyHJa8JOKWKTIn1LUvNf/sC6WRPV2jFwscQ4OITUGec
4jLb1bIcZEF3EGJPEmKvlWwuwbzfhDto7rzn+67IuZNA+I/avSHLWRgxRrIfGLBA
F+/NiJ5GFagD9V4TCpzS2cenWMzrqC28cyZHkazF8IqnND4wkqJbP1VITo3b9Lz/
OnJHr0ttQHRZp6kaI8BBLmkKvoYby4hRsCSD8MfGvQ==
=obyc
-----END PGP SIGNATURE-----

--nSymKG4Q86w85U5x--

