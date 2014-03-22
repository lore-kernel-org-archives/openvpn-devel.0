Date: Sat, 22 Mar 2014 19:35:08 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140322183508.GZ16637@...1296...>
References: <1395017376-24554-1-git-send-email-james@...515...>
	<20140317202910.GM16637@...1296...>
	<532775DD.4050106@...515...>
	<1CED409804E2164C8104F9E623B08B90155646D4C1@...1436...>
	<53281720.2050504@...1147...> <5328463F.7090704@...1114...>
	<53284DA8.1010709@...1147...>
	<1CED409804E2164C8104F9E623B08B9016F95AD5DC@...1436...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kivFfCkDq2bCCRcA"
Content-Disposition: inline
In-Reply-To: <1CED409804E2164C8104F9E623B08B9016F95AD5DC@...1436...>
Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
	context for OpenSSL builds,
	to disable TLS stateless session resumption.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--kivFfCkDq2bCCRcA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 18, 2014 at 05:40:41PM +0100, Steffan Karger wrote:
> > So it seems I spoke too soon... sorry for the noise, although I must
> > say that I'm still in favour of checking for the existence of an IFDEF
> > instead of relying on a particular version...
>=20
> Point taken, just checking the OpenSSL version does not suffice.
> Still, I'd like to prevent more #ifdef's in the code. We could
> check the #ifdef in configure.ac, and refuse to build when it's
> not present. Any objections against requiring SSL_OP_NO_TICKET to
> be present for OpenVPN 2.4+? We have to drop support for 'ancient
> stuff' at some point.

If I understood this all right, this feature improves OpenVPN security
against yet-unknown attacks using a feature of OpenSSL that we don't
use anyway.  Right?

So in that case, I'm fine with your proposal - do something on configure.ac
that will check for SSL_OP_NO_TICKET and complain (with a useful error
message :) ) if it's not there.

For 2.3, I'd propose to add code to ssl_openssl.h like this:

/* SSL_OP_NO_TICKET tells OpenSSL to disable "stateless session resumption",
 * as this is something we do not want nor need, but could potentially be
 * used for a future attack.  For compatibility reasons, in the 2.3.x=20
 * series, we keep building if the OpenSSL version is too old to support
 * this.  2.4 requires it and will fail configure if not present.
 */
#ifndef SSL_OP_NO_TICKET
# define SSL_OP_NO_TICKET 0
#endif


ACK?  Is the message correct?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kivFfCkDq2bCCRcA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUy3X26kuBuNlUUl1AQKBDwP/XvQQJqNq+H+V8kNXVeOYajlBSWltMAlh
ajnPJZUqdYZ6X8QFBm6Vn3Jgmjc5Rfe1NxfN6cr51jzKNvUFzqFRiCaQJ9xHNaPI
2J/P6jIELl+z4CzmT2w6s/o5cDzUMvJ4h/rpMd4EiqS/p78Y9wlHV2yFD/3ZJO/7
z+Ao++RqynA=
=1WcC
-----END PGP SIGNATURE-----

--kivFfCkDq2bCCRcA--

