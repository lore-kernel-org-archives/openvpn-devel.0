Date: Sat, 14 Jan 2012 13:31:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120114123138.GP5060@...1296...>
References: <4F116B5F.1070100@...1114...>
	<4F116C87.5090805@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+E165xXSMiO4rFaE"
Content-Disposition: inline
In-Reply-To: <4F116C87.5090805@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Fix pool logging when IPv6 is not
	enabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--+E165xXSMiO4rFaE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 14, 2012 at 12:52:39PM +0100, David Sommerseth wrote:
> | I'm running the master branch (commit 330baf2aee70b35) on a site where=
=20
> IPv6
> | tunnelling is not enabled.  I found some odd IPv6 addresses in the log=
=20
> file
> | when clients connected.  Attached is a patch solving this issue.  It's
> | basically a bogus message, and nothing seems to be pushed to the client.

ACK, thanks.

(I wouldn't dream of running OpenVPN without IPv6, but it's quite obviously
a useful test case to do so :-) ).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--+E165xXSMiO4rFaE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTxF1qqkuBuNlUUl1AQI35AP9E8jXQ/0lDgnJlaxTCIqtVe0FqgK2ymB1
qi+nbZrqj0/Oaa7pdJBNG7TVbtUT7w4KFD3UBDa8ZdZcCaxS7Yr5g/LPrjezWBPy
pW8ost4a+KzRCo3A6kEJwrMt6KfDrFEfnwELq7h55b74wKKoBc+4mmIqAm8ExftG
hl9mKfBxu1U=
=+ucs
-----END PGP SIGNATURE-----

--+E165xXSMiO4rFaE--

