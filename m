Date: Fri, 13 Apr 2018 20:58:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180413185809.GS69387@...1296...>
References: <CAJ-EccN7eQsSaFn4MH4qRTKx+zZ-1YcGAe0XU8813p7k=W2i4g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OETD7Wup2FdAi+na"
Content-Disposition: inline
In-Reply-To: <CAJ-EccN7eQsSaFn4MH4qRTKx+zZ-1YcGAe0XU8813p7k=W2i4g@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Specify platform and version on command
 line.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Micah Morton <mortonm@...1913...>
Cc: openvpn-devel@lists.sourceforge.net

--OETD7Wup2FdAi+na
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 13, 2018 at 10:23:03AM -0700, Micah Morton wrote:
> From 557d2e73bf21ddb9d07b43f716c7914d610e7392 Mon Sep 17 00:00:00 2001
> From: Micah Morton <mortonm@...1913...>
> Date: Fri, 13 Apr 2018 09:55:22 -0700
> Subject: [PATCH] Specify platform and version on command line.
>=20
> Add --iv-plat and --iv-plat-rel command line args, and use the values
> passed to these args to set IV_PLAT and IV_PLAT_REL info that is pushed
> to the server.
>=20
> IV_PLAT (platform type) is normally inferred from the build target, but
> it would be useful to be able to override this from the command line
> (e.g. for client to set platform as ChromeOS instead of Linux).
>=20
> IV_PLAT_REL (platform release version) would allow for pushing the
> platform (e.g. ChromeOS) release version to the server.

I'm actually less than enthusiastic about "yay, two more special-case
options for OpenVPN" - and even less so to options that enable users
to override a fairly well-defined meaning of IV_PLAT with an arbitrary=20
string.  Even if it's ChromeOS, compiled with #define TARGET_LINUX,=20
IV_PLAT should reflect that.

There is already "--setenv UV_anykey=3Dvalue" to send arbitrary strings
to the server, and in particular, IV_PLAT_VER can already be set by
"--setenv IV_PLAT_VER=3D<version>".

There's one catch to this, though - for some reason that escapes me right=20
now we have decided that IV_PLAT_VER=3D and the UV_ user-defined strings=20
are only sent if --push-peer-info is also configured on the client
(while IV_GUI_VER, also settable with --setenv, is always sent).

So we might want to revisit that decision.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--OETD7Wup2FdAi+na
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGbBAEBAgAGBQJa0P3BAAoJEB2Cnv7KVigS9SoL+MD5SWFENV0RYL1GJ+UsgDBv
VmvpCgSSsiyZ9Anz0KXLAHribPMrIxStjlSrqN88KANvoUGGCvLhE07Ep8WEvVa+
sbSixu5qKGW2Uti9pGR5lumBjm7qK2iSkBdKJkPijQvRsLXParnI/WHD9U8XoPcH
m4uL8KHbIBQUgjqOxvHRoJzHF0kqme9pyVfKERk4/La5TC+j6yROvWqFAjsc9aRH
WdB3C2b6DjYgne//T79UuOaYdlolAnAlYYEgRZO+4b76T8Q8HAScorjxkCzN4pN7
VQYEgyD1NG/JFY+LfCSmbZX99R2mZTENETklxwpBsM46Cs4apMTLJFzxQD8eK/n2
GQ4BCk4Y2up7sou9BVW+qtPlvdL+YRv+k59S6icF/qfHrCfVFOvKNm1c7eX8FZY0
E5n8cINbUePdOpu/V3NHyr9zO4V+bXLX/3YHsfbu8CbkuTZiZpsc7H11TP0OqEZ9
NOi7Ep+rLc89edbQ55gCu65uKeeRPBRNZgj3GnKQ
=b41I
-----END PGP SIGNATURE-----

--OETD7Wup2FdAi+na--

