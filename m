Date: Thu, 26 Apr 2012 20:17:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120426181708.GX1359@...1296...>
References: <1335441085-18186-1-git-send-email-davids@...1347...>
	<CAOazyz3-f2YkXE_vV2Oum+p4exQTUis=Q9RTOrvZ7WC0WEZymg@...278...>
	<20120426172410.GT1359@...1296...>
	<4F9986A2.10900@...1114...>
	<CAOazyz0Tv0_9Fqr_b8smQ0z00qk5fQ2AUaHz_75K-gQoEANDOg@...278...>
	<20120426180156.GU1359@...1296...>
	<CAOazyz3NsxGOaG97DXaksx6zfAXGBSvM-1YCbB=wkFKY5fmm-w@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x5H/dHEtcMgsAT6y"
Content-Disposition: inline
In-Reply-To: <CAOazyz3NsxGOaG97DXaksx6zfAXGBSvM-1YCbB=wkFKY5fmm-w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Presume that Linux is always IPv6
	capable at build time
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

--x5H/dHEtcMgsAT6y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 26, 2012 at 09:06:19PM +0300, Alon Bar-Lev wrote:
> Right, the ipv6 was added indeed differently, without this conditionals.

You missed the part that JJO's IPv6 code *was* added with conditionals,
and that caused problems.  We *removed* the conditionals, and the resulting
code is easier to maintain now.

> Because of this I did not perform this task as part of the major build
> cleanup, and left this for the next phase.
> Most of the lowlevel network code already has #ifdefs, I will try my
> best to find a way to do the conditional without much changes.

I don't think that this is a useful way to spend your time.

Nobody has ever asked for it, and I don't see anybody volunteering to
maintain the resulting extra complications.

We want to *reduce* the number of #ifdef in the code.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--x5H/dHEtcMgsAT6y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT5mRJKkuBuNlUUl1AQLdLgQAvDWNRyCn5p5PB0MvFB3z7ZlWKJEuDJg7
pY3zepOevPnA9LnwdJH8MwNLFjS9CmS1Wy4B2VZFdy24XhtM54il8ZUJf79B+P/k
mA3vP5z7AgLErKn7eqVvj0KFX9Mv8uB8saAtiq7ODOU48Kqm/jXORKgIurSuRE3M
OlqzVVN4uGM=
=eMs8
-----END PGP SIGNATURE-----

--x5H/dHEtcMgsAT6y--

