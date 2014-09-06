Date: Sat, 6 Sep 2014 13:53:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140906115300.GX1118@...1296...>
References: <1404419045-14728-1-git-send-email-floppym@...594...>
	<5409C39F.1050009@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4RzVFyjIcZfAa5OY"
Content-Disposition: inline
In-Reply-To: <5409C39F.1050009@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Add configure check for the path to
	systemd-ask-password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

--4RzVFyjIcZfAa5OY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 05, 2014 at 04:07:27PM +0200, David Sommerseth wrote:
> On 03/07/14 22:24, Mike Gilbert wrote:
> > Gentoo Linux installs this in /usr/bin by default. Also, the user
> > may have installed it in /usr/local/bin if building from source.
>=20
> ACK.  Also considering that Fedora have moved /{bin,sbin} to
> /usr/{bin,sbin}, this makes a lot of sense.  More Linux distros may be
> on the same path as well.

Yeah, double-ACK.  Hardcoding program paths in the middle of C code is
something we should have never merged in the first place :)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4RzVFyjIcZfAa5OY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVAr1nKkuBuNlUUl1AQLQBgQAqhZ696JyuzFa/QlCfxQRW6+w+uVZzB4y
Foot7+Krs67/YX1vqTKpupf9DC4nlhuj+Xf39Uo+HWwrD7yAjQeGmqtfzUZi3dV6
+/7CUof5BSIe2tdIY2KxvHKQ1Z/YtErjXrjmnPhW59/l2KQUW6bqfS66JNmJtdZM
/4GXazp0vv0=
=iPIb
-----END PGP SIGNATURE-----

--4RzVFyjIcZfAa5OY--

