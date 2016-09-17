Date: Sat, 17 Sep 2016 14:51:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160917125116.GA56952@...1296...>
References: <1474102835-13402-1-git-send-email-arne@...1227...>
	<201609171201.u8HC13GD056462@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <201609171201.u8HC13GD056462@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Prefer RECVDSTADDR to
 PKTINFO for IPv4 in OS X since it actually works (unlike PKTINFO)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 17, 2016 at 02:01:03PM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> commit 3ffe2338c092d7bd4abace3ae9fa0b4f85cf4b87
> Author: Arne Schwabe
> Date:   Sat Sep 17 11:00:35 2016 +0200

Forgot to push and then David put a new patch in between, so the commit-id
changed.  Sorry.

commit e7303ace6f101bbe61c3251c080975cf5c261f71
Author: Arne Schwabe <arne@...1227...>
Date:   Sat Sep 17 11:00:35 2016 +0200

    Prefer RECVDSTADDR to PKTINFO for IPv4 in OS X since it actually works =
(unlike PKTINFO)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV908RKkuBuNlUUl1AQJ8TQP/Su7JknDRMVj0BlC5iu7jFzucmY88sSWt
W44Kqk0VjPT7GArNltSR+mT997gvEVv/4xoJH0qcDAly3go0LsdANqlGAppsp1jg
DATAP1njpFJHutH+8iv7XY6GkphNGAKWv8j/FgbizjTIdZmR9FxUzed/jdqpcYUZ
iV3yTylFdWc=
=GtE/
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

