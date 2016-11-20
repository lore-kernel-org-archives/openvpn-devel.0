Date: Sun, 20 Nov 2016 22:39:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161120213943.GB28918@...1296...>
References: <1479676734-21630-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="msgqYNMsb2nHSR7s"
Content-Disposition: inline
In-Reply-To: <1479676734-21630-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Do not set ipv6 address if '--ip-win32
 manual' is used
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

--msgqYNMsb2nHSR7s
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 20, 2016 at 04:18:54PM -0500, Selva Nair wrote:
> This also applies to --ifconfig-noexec.
>=20
> Resolves Trac #723
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>

The patch is fine code-wise, but I'm not sure if it is the best approach.

We have this funny bit of special-case code:

options.c, around line 2550

#ifdef _WIN32
...
  if (options->ifconfig_noexec)
    {
      options->tuntap_options.ip_win32_type =3D IPW32_SET_MANUAL;
      options->ifconfig_noexec =3D false;
    }
#endif

I skimmed through init.c and tun.c / do_ifconfig(), and even though
Heiko normalized the IFCONFIG_BEFORE_TUN_OPEN part, Windows is still
not "normal" - part of the ifconfig is done in open_tun(), which is
always called, but *only* if ip_win32 is not "IPW32_SET_MANUAL"...


So, I wonder if just removing the "options->ifconfig_noexec =3D false;"
line from the code above would achieve the desired effect, with a=20
smaller windows special case code base?  It would still call open_tun(),
which would not touch anything (because IPW32_SET_MANUAL) and then
skip do_ifconfig() later on, so IPv6 would not happen.

Of course there is a slight asymmetry if someone insists on explicitely
configuring "ip-win32 manual" - in that case, v4 would not happen and
v6 would.  This was partly intentional when doing the IPv6 stuff, as I
consider the whole "ip-win32" nightmare to be not applicable to IPv6...


Please do not consider this a NAK, just a "what if..." thinking loud.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--msgqYNMsb2nHSR7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWDIYH6kuBuNlUUl1AQIvkgP/eXoKDoH2NsHsexoQv/rf8bodMP4HTlnN
UKwwhZ6iNoJQy09tIF0eZyDlO0O8Bd8du4RoMJScffAzWK0tQ3NmDSqUISLdYdrU
jIO3gwlMtZ6EC49Px0bApmXM6BBKsRTUQ7iKCJQIC3aek+QWUlb8hutBF2jPbtgi
JEllmiPgp+M=
=JOzj
-----END PGP SIGNATURE-----

--msgqYNMsb2nHSR7s--

