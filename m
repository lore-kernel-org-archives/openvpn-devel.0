Date: Fri, 17 Feb 2017 18:42:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170217174223.GV93896@...1296...>
References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
	<20170217164131.GU93896@...1296...>
	<CAKh=nwFeHQ5DaCeRHnYswwfMiNMyysvsx=RHg9kDLZuLw=GwGg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1RfOVxRbNnn9f8MI"
Content-Disposition: inline
In-Reply-To: <CAKh=nwFeHQ5DaCeRHnYswwfMiNMyysvsx=RHg9kDLZuLw=GwGg@...278...>
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

--1RfOVxRbNnn9f8MI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 17, 2017 at 06:37:04PM +0100, Emmanuel Deloget wrote:
> I guess the answer to the riddle is: "how long will the 2.4 branch
> live?". v2.3 shipped in May 2013. If we assume that v2.4 will be the
> stable branch for two more years (I cannot find any roadmap, so this
> is pure speculation) then it might make sense for 2.5 to at least
> remove support for OpenSSL v0.9.8 (it would have been EoL'd for 3
> years by then).=20

We have *plans* to release 2.5 faster than "it takes another 3 years",
but we said so when planning 2.4 as well.

Since David pointed out already that RHEL5 is going to be EOLed soon,
I do not thing 0.9.8 is an important target anymore.  Depending on the
amount of #ifdef etc., it might make sense to drop 0.9.8 support in
2.4, but only add 1.1 support to master/2.5 - we're early in the 2.4
cycle, which allows "somewhat larger" changes, but 500+ insertions
sounds like a bit too intrusive.

> I must admit that the fact that I can build OpenVPN
> against a security-focused library that haven't seen any evolution/bug
> fix/security fix in one year makes me pretty shaky :)

Well, as far as I understand, at least the RHEL guys would backport
anything that shows up while RHEL5 is still supported...  (and since
they never change version numbers, this is/was the goal).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1RfOVxRbNnn9f8MI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYpzX+AAoJEB2Cnv7KVigSrGMMAJshhnj8edjt2aUWniAUBHbG
sUQL+yLQF9xxzZSjcAkLKbVobenmULpGruK2WjM9AXoJJKxHlorJjlKM3I9uOaHf
W0j5RtLrJYD1Pmh5kFXTcC3r0cAASpyjsVFMlV/FartkeNlPlC3jScLkDah0TJI7
p3WbRvKQGzz0Lub+B16u5OAuWC5PhOgEOArkF+I1qagM9gl2ZBJ09Qh44b/C05Wd
WhK73EmjZSI3XJcd/LvY8gRc5/AxhzWEknZPPvo94pB+WK2WR2wrLh6+bSyfOT1b
p9v3a7BSF1z1c/UjSsgdWWX8G0NRD5Y6Wjwoxjk10yEo168HLoG11v4zvmoLXELl
+RynuEe5RQGy3KUWIadTh+nhKdP/kvgM+IZ/CUKORE74Z6wS1olCSYCFUF6bW16a
SDX/OAaeT4YR/FdW/55E51Xjr/KC3YIXjrnsAV9c2JqkLouyhlOUIySciLxamlR4
N+1kWKbH4Dvj52bT7neT0Lsv7C4U24jAhniBAEHi6A==
=+u1G
-----END PGP SIGNATURE-----

--1RfOVxRbNnn9f8MI--

