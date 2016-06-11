Date: Sat, 11 Jun 2016 13:29:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160611112936.GP62247@...1296...>
References: <1451730139-25563-1-git-send-email-arne@...1227...>
	<1455624280-3165-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline
In-Reply-To: <1455624280-3165-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCHv2] Complete push-peer-info documentation
 and allow IV_PLAT_VER for other platforms than Windows if the client UI
 supplies it.
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

--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 16, 2016 at 01:04:40PM +0100, Arne Schwabe wrote:
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 5a4efc6..d99aaf5 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8

... took me long enough, but ACK.  I've change the wording related to
IV_NCP=3D2 a bit - there was a typo, and I think the resulting sentence is
easier to understand now.  Also, repaired a bit of tab-to-space change=20
in ssl.c...

Your patch has been applied to the master and release/2.3 branches.

commit 960524a9af899c83dbf2de255e063b7c66536d3e (master)
commit 769bbd6e1002af6b3d8a6c22deec036982566165 (master)
Author: Arne Schwabe <arne@...1227...>
Date:   Tue Feb 16 13:04:40 2016 +0100

    Complete push-peer-info documentation and allow IV_PLAT_VER for other p=
latforms than Windows if the client UI supplies it.
=20=20=20=20
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <1455624280-3165-1-git-send-email-arne@...1227...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/11175
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>


gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1v2HqkuBuNlUUl1AQLKbgQAwD7+qzjFkMaelW3fXjiFJ8Kg5VmXT3IE
QX9NjVO14s85Lyaajg3B4HazXB09k7e6rWH+z2f5tYcEpc19vtKMsszCInW9JFK0
d3CLTVj4qgLlXRV+0vYng2bAQUKkihBv5wWUbCetJTWGp6clalEmFxP8pNw3mS+U
fvBgxfasV9E=
=9RK9
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--

