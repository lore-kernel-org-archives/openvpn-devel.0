Date: Sun, 30 Nov 2014 17:48:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20141130164823.GH17158@...1296...>
References: <1416598835-5269-1-git-send-email-yegorslists@...1030...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7UIJfHqpdi+oBJdT"
Content-Disposition: inline
In-Reply-To: <1416598835-5269-1-git-send-email-yegorslists@...1030...>
Subject: Re: [Openvpn-devel] [PATCH] configure.ac: fix default behavior
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Yegor Yefremov <yegorslists@...1030...>
Cc: openvpn-devel@lists.sourceforge.net

--7UIJfHqpdi+oBJdT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

to followup on this:

On Fri, Nov 21, 2014 at 08:40:35PM +0100, Yegor Yefremov wrote:
> Set enable_password_save to "yes", if the option is not given,
> as stated in the description.

For now, I have committed David's patch that just corrects the help
text in configure, without changing the actual default.

As far as --enable-password-save goes, the opinions here on the list
and at the last IRC meeting have been "we can change the default *AND*
completely get rid of the option while at it", so that would be taking
it even further.

Awaiting a patch for this :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7UIJfHqpdi+oBJdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVHtKV6kuBuNlUUl1AQLyEwP7BjuL8pqoYgErcDZDJ1uc50x5cKQ5rPSF
zWQm8vWFtwtiRW5X84OaD0GZntI/MbZctgHB1SjdNxepfis7Ipr/ZsqMDsqQACD7
9igigTEqCw7LXA29P9i8+vEoLMlW26rDw2UxcZp8LCGtmP6PIl0S6qxI7nIrW8ja
Y1sneAqTjoA=
=I9po
-----END PGP SIGNATURE-----

--7UIJfHqpdi+oBJdT--

