Date: Thu, 14 May 2015 16:30:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150514143049.GE382@...1296...>
References: <20130524215902.GM5874@...1818...>
	<20130525115819.GS20843@...1296...>
	<20130526223639.GK26337@...1818...>
	<20130527072512.GY20843@...1296...>
	<20130527200519.GD5918@...1818...>
	<20150514141029.GD2981@...1818...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oIZeFZfK2rom9VmH"
Content-Disposition: inline
In-Reply-To: <20150514141029.GD2981@...1818...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn ipv6 pool env variables
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuel Thibault <samuel.thibault@...1817...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--oIZeFZfK2rom9VmH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 14, 2015 at 04:10:29PM +0200, Samuel Thibault wrote:
> Any news on this issue?

Embarassing as it might be, haven't had time to work on that corner of
OpenVPN :-(

But re-reading your mail to understand what this was about (two years
about... *sigh*), something else sprung up:

> > Actually in our case iroute is fed by radiusplugin, which happens to
> > also already add the route for us, so we didn't have to add that one.
> > But it could be better to have radiusplugin just pass iroute to openvpn,
> > and let the userscript add the route if needed.

... if you are using radiusplugin, you could use "ifconfig-ipv6-push"
to have *radius* set up which IPv6 address a given client gets (as for
the iroute-ipv6), so you have that information out of band, not having
to rely on OpenVPN's pool handling.

Of course this is only sidestepping the underlying issue, which I agree
should be fixed.

(Someone having 2-4 weeks of spare time available I could use?)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oIZeFZfK2rom9VmH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVVSxmakuBuNlUUl1AQLtagP/fpP4Obnv7A2VEx2KFgDX+2k3QdIziBtP
XV2SBpnFHPLCnhQh0FTpYvcP8xjLLsAWBi1hAFdgdHucJTd0//C6yeUa7WCFi7fk
jjzRLcNHwfpIpjX0FJt3vZL0gZQdtZAzmPAyn1jAVRlDapLD3GaMPO8laoPUqFPb
NyRAnjxeaKo=
=XVTb
-----END PGP SIGNATURE-----

--oIZeFZfK2rom9VmH--

