Date: Sun, 13 Apr 2014 20:25:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140413182552.GX16637@...1296...>
References: <20140409232527.GA3061@...1890...>
	<20140413125641.GQ16637@...1296...>
	<20140413133920.GA28182@...1890...>
	<20140413170648.GU16637@...1296...>
	<20140413181949.GC28182@...1890...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ujxruKqj3kfWbKNm"
Content-Disposition: inline
In-Reply-To: <20140413181949.GC28182@...1890...>
Subject: Re: [Openvpn-devel] BUG: Windows netsh interface ipv6 delete address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Cedric Tabary <cedric+openvpn@...1891...>
Cc: openvpn-devel@lists.sourceforge.net

--ujxruKqj3kfWbKNm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 13, 2014 at 08:19:49PM +0200, Cedric Tabary wrote:
> This works perfectly on win8.1, win7 sp1 and winXP sp3 :)

Cool.  Thanks a lot for reporting and testing.

I'll try to get a 2.3.4 release out "soonish" with this one and the socks5
fix (and possibly the ssl library version reporting, depending on how that
discussion goes).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ujxruKqj3kfWbKNm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0rWsKkuBuNlUUl1AQLkUwP/Ta8x256RoAU31dt/E3iPwus/XQzdWNuW
QdHBnS3cUbBp0vg3x2Z/6s2dOfdnRH0hXOzqHx+oR0b5XuczNhEUkOoE+vi/YjOF
VBjWYFqqyPmrWJl+iSwpRG9gdDysC/dYA1SmuDxDEdXoCmII+nvtejYv+qzMZ3q5
GqOoWCju5p8=
=KoYi
-----END PGP SIGNATURE-----

--ujxruKqj3kfWbKNm--

