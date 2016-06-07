Date: Tue, 7 Jun 2016 22:53:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160607205347.GC53051@...1296...>
References: <1464668569-6480-1-git-send-email-selva.nair@...277...>
	<1465162884-32520-1-git-send-email-selva.nair@...277...>
	<1465162884-32520-2-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nc58znKvUQeeXvTG"
Content-Disposition: inline
In-Reply-To: <1465162884-32520-2-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Save exit-notify timer during a
 restart
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--Nc58znKvUQeeXvTG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jun 05, 2016 at 05:41:24PM -0400, Selva Nair wrote:
> When exit-notify is specified, SIGTERM could be lost if a SIGUSR1/SIGHUP
> restart happens during the exit notification interval. This is
> particularly apparent when pull-filter reject causes a repeated SIGUSR1
> restart cycle.
>=20
> - Save the explicit_exit_notification_interval and time_wait
>   across restarts.
> - Check pending SIGTERM (with exit notification) in the SIGUSR1/SIGHUP
>   loop and cause an exit instead of restart.

NAK on this one, as I think the later patch you sent for this is "better"
and easier to understand.  Just for the sake of the archives.

gert=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Nc58znKvUQeeXvTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1c0WqkuBuNlUUl1AQJvwgP+KHxOarPQ/bzKoiATsTwe6hcWen/0iqk2
KKGo7joqsdFaYSMF/xaY7nQNbPu9J3l9SgRZs1LjCLe0xG7QP07nc1NlMMhFMxmP
1pzqKBzLMsMuZA2WdOnA1uSv4p8soFpIuu7urjmwvyR3mTRbxit8Urm8wLdOpBio
bX+hdEVpgx4=
=DrcO
-----END PGP SIGNATURE-----

--Nc58znKvUQeeXvTG--

