Date: Thu, 7 Aug 2025 17:29:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aJTGPksgtlTnN4XL@...1296...>
References: <CAOh3LPMvAFtZ7rdBVYZ2raErtNM2=F-r1WQv9+YZE+6SxRfM8Q.ref@...278...>
 <CAOh3LPMvAFtZ7rdBVYZ2raErtNM2=F-r1WQv9+YZE+6SxRfM8Q@...278...>
 <aJQ9IkQIdH6sFNvt@...1296...>
 <CAOh3LPPhraQGp+N2RPPkJ01D64JGpU8ZeT6-Rqkh8fo8M=83zQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OtUgh7vnkiFFViof"
Content-Disposition: inline
In-Reply-To: <CAOh3LPPhraQGp+N2RPPkJ01D64JGpU8ZeT6-Rqkh8fo8M=83zQ@...278...>
Subject: Re: [Openvpn-devel] Bulk mode - Feature request - Patch diff
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Chiappetta <root@...2904...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--OtUgh7vnkiFFViof
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 07, 2025 at 10:29:43AM -0400, Jon Chiappetta wrote:
> Oh nice, thanks, I didn't know about that command as I have never ran it
> myself before. I'll try to work through these errors and figure out how to
> solve them:
>=20
> root@...2048...:tmp/openvpn-fork-bulk# autoreconf -vif
> autoreconf: export WARNINGS=3D
> autoreconf: Entering directory '.'
> autoreconf: configure.ac: not using Gettext
> autoreconf: running: aclocal --force -I m4
> autoreconf: configure.ac: tracing
> autoreconf: configure.ac: not using Libtool

I think that means "you need to install the "libtool" package".

(Frank - is there a way to make autoconf handle this in a smarter way?  In
theory, libtool is optional, but our configure stuff fails later on if
it's not found - ran across this in my fedora-42 experiments as well)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--OtUgh7vnkiFFViof
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJolMY+AAoJEB2Cnv7KVigSIUAMAIoR+TDY4lOQb4c5ziQ+3vVw
RuPf66JMzGf7WxRTr+teiAf6gitvQGrcL4g/48jNT5Jt6rdvqSPfkbd/KXiJnw/T
/FpqY9ZXhCrkGPTay1gJcT4xI1w5AYljyDXx6wH5lo/qnHRRONwr7//ZtU5A5zXo
SMFZusTVSupVqt/1iOVqhW36uKUVBU1uiXOzP2U116TFVHqZ4UiYVKup4fb7FGny
bLNesE6kzs04floYTSCg2mTvWT+jNgeP4JB71uKYNHnm+hW2EQC+ZZnz2M1jrMgw
rWAVnLnGgeGm0StBI8nCTq4WXF1PjpiPMPFbTq0I7dKTDWcnLfxzJ2Qoww2F6X6p
RSB41xaU4Lj478ta9ffQ+ClWueim4h1SSRXoHbDsg0IjfIO3GLAvZeLpaCUgnBSZ
2aStfDpiNxMP3PjgKYBYN/E3bL+3H7TOmqRJrSUWSBsL3xgixG6N10z6gzho64+f
h8sBKFVZk+J4kCbFjJJgJ+Jb1GuAIcQNDoCJlPiXmQ==
=yN/n
-----END PGP SIGNATURE-----

--OtUgh7vnkiFFViof--

