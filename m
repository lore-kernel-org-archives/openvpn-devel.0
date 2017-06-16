Date: Fri, 16 Jun 2017 07:23:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170616052332.GN97029@...1296...>
References: <7860b0e6a671e51e0853cf7a351d874e@...2277...>
	<20170615074739.GI97029@...1296...>
	<1649446.B7buzjzcZ2@...2279...>
	<9e766589-ac6e-e418-1b07-41a2889e0a17@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RxS2pBdBEF8h1t8h"
Content-Disposition: inline
In-Reply-To: <9e766589-ac6e-e418-1b07-41a2889e0a17@...2080...>
Subject: Re: [Openvpn-devel] Bug or Feature? Username in environment in
 auth-user-pass-verify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Steven Haigh <netwiz@...2277...>

--RxS2pBdBEF8h1t8h
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 16, 2017 at 12:01:03AM +0200, David Sommerseth wrote:
> > That still poses the question, is a plugin supposed to be able to alter=
 the=20
> > environment presented to the auth-user-pass-verify script?
>=20
> You have discovered something I've not been thinking of.  But yes,
> plug-ins can actually manage to do that if they manipulate the
> environment pointer provided to it.  All plug-ins runs within the same
> memory scope as the main OpenVPN process - in fact, plug-ins is a way to
> extend the features of the core OpenVPN process.

While plugins *can* do this, it's not actually what is happening -=20
OpenVPN proper (ssl_verify.c) is doing this.

"username" ends in the environment, *if* one of these is set:

  - you use a plugin
  - you use management-verify-password (or whatever it's called)
  - you use auth-user-pass-verify with "via-env"


> That said ... this needs to be changed, I think it makes sense to take
> some action to reduce this possibility.  By manipulating pointers
> provided to you via the the plug-in interface, you can make the OpenVPN
> process crash and burn ... and it is fairly easily.  If you manage to
> modify memory regions too much so other OpenVPN data structures gets
> corrupted, it will explode in interesting ways.

Well, this is what you get if you link in other code into the same
process...  power and risk.  Not sure how to do it differently - fork()
off a helper process that talks over a socket/pipe with openvpn main
and then links in the plugins?  (Like openssh privilege separation).

Can be done, but would be quite an intrusive change - sounds we've found
something to break for 2.5 :)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RxS2pBdBEF8h1t8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZQ2tUAAoJEB2Cnv7KVigS9WML/RFfQTFJrMXvR1+wXuG7p4By
8QobFQkyQbRVYOERgTWXXCGJRBjbd07UiDGrWaLtVnIlpDmqtUNzpjDySr6Nxby+
jTwas1vkjqTj1ub3fQSCdDkNTGdmSyyLk5tVl6UUOXf2VlTbc6azcr8PRNwJTGvU
rh1Ud+jRlPOlfpj3R/hTEYNKd/7dKnG9HVOwDjV34ahvpAIM8GJAEwfqjWo2qsyG
rJ7jpHaRz5dDhVhrxGeHYsjNzgoj2zayGJhdTunxlKUWbn7FKlXdUE1Iphn+uJM4
Z1IEXZ6rQwqsn9Gx7FCYE8l9D6lB6/a8cp/GqWRi2RTpbWdBU/TWs0XhUQXzWH7o
TwznLIKWm1Ns4LK9ZsNKSgM90+mrBgHYEICWzt/BWM6H5KKNjHYBgk3QyyOHRjJL
Dfu7zN+7gYEr7mjfq1V2Zm3zbAIJPS6YoA54YrKSHjyo+ogw9Jeci/ffBO57cLOb
zHTvwhKWxWC1wrY46t16ZbMvdd/Yo1ZbqFIedNLVOQ==
=h29H
-----END PGP SIGNATURE-----

--RxS2pBdBEF8h1t8h--

