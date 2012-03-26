Date: Mon, 26 Mar 2012 19:55:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120326175543.GX1359@...1296...>
References: <20120326160546.GV1359@...1296...>
	<CAOazyz1W7ZcVEhDwq0DWCOjQ_DetcjP6yDg1MhOPiMYqu2Sr6w@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4oXbDkBXUa6Hvs/m"
Content-Disposition: inline
In-Reply-To: <CAOazyz1W7ZcVEhDwq0DWCOjQ_DetcjP6yDg1MhOPiMYqu2Sr6w@...278...>
Subject: Re: [Openvpn-devel] [DISCUSS] much more complicated gcc invocations
	now
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--4oXbDkBXUa6Hvs/m
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 26, 2012 at 07:51:01PM +0200, Alon Bar-Lev wrote:
> The benefit is to divide the code into libraries and core which is
> easier to maintain and reuse.

I'm not sure I understand what's so hard about "compile stuff, use
'ar' to pack into libopenvpn.a" that stuff needs more convolutions.

We're not building a shared library - which I agree is major pains unless
handled by libtool.  But static libraries are easy on about everything
(except Windows, can't speak about that).

> Anyway, new automake does support silent rules, try the following[1]
> patch and see if it makes you happier.

This is missing the point: I think what automake/autoconf is doing now
is much too complicated.  I *like* to see what it's doing, and hiding
complexity by just not showing it is a step into the wrong direction.

> Again, this demonstrate how current merge procedure is inappropriate,
> as instead of single build system rewrite merge we have aftershocks.
> Branch should be tested and  reviewed, and tested and reviewed until
> no known issues found, and all happy of its quality.

We're doing that now: branch is called "master".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4oXbDkBXUa6Hvs/m
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3Ctn6kuBuNlUUl1AQJkIAP/csQZqibMlCVU6sR3B8/JLymepWGUaYjT
c0UPWOEhpQj+wX3n51i16dfw+ZdLBeuL1OAjIrTZn5Avb9qHq+sM8GQqnmrkQdP1
PbgNBfSpUa/pytj0PqgcqYmzvzqXmpYbuohAR73BQKWf9me1HNn1f6A5v7vWgNKl
BpxxWE8Tg48=
=puXO
-----END PGP SIGNATURE-----

--4oXbDkBXUa6Hvs/m--

