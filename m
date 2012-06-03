Date: Sun, 3 Jun 2012 11:59:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120603095934.GK400@...1296...>
References: <1338642223-20324-1-git-send-email-arne@...1227...>
	<1338642223-20324-4-git-send-email-arne@...1227...>
	<4FCA3F35.5020800@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <4FCA3F35.5020800@...1114...>
Subject: Re: [Openvpn-devel] [PATCH 3/8] Only use tmpdir if tmp_dir is
	really used.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 02, 2012 at 06:28:37PM +0200, David Sommerseth wrote:
> As we're trying to kill off syshead.h in v2.4, it might rather make
> sense to try to avoid extending syshead.h.  I see the benefit from
> code clarity point of view.  But I'd probably just recommend to check
> for P2MP_SERVER, with a comment that --tmp-dir is only used in the
> P2MP_SERVER code; instead of adding the ENABLE_TMPDIR macro.

+1 - another feature-ACK :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT8s1hqkuBuNlUUl1AQJdzgQAj2NxaP5mI4znWE3BZer1/8vj9adIq+Gi
fLC0rAdopZgLqh3lznTPnekEH3Md+H36Oc1egIHjwjB2tYeHO4XzVtkQBPPWLTGz
PRDtceQwGvYtYJIhoztx7SZLF/6yK4aGYiCUBEFB3zugFmvXIRfFsPpGsIWaeJL7
MTVX7xxmtJg=
=JrsB
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--

