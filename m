Date: Wed, 27 Apr 2016 19:51:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160427175118.GY53051@...1296...>
References: <1460918143-408-1-git-send-email-steffan@...1856...>
	<57209BDF.4030202@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YzytRCpZNWCht94M"
Content-Disposition: inline
In-Reply-To: <57209BDF.4030202@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Migrate to mbed TLS 2.x
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

--YzytRCpZNWCht94M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 27, 2016 at 02:00:47PM +0300, Arne Schwabe wrote:
> The rest looks fine, so ACK for me.

While I totally love to just merge stuff other folks have reviewed, this
patch just doesn't apply to my tree :-( - and the rejects are too many
to try to mangle by hand.

Patching file configure.ac using Plan A...
Hunk #1 failed at 291.
Patching file src/openvpn/options.c using Plan A...
Hunk #11 failed at 6584.
Patching file src/openvpn/ssl_verify_polarssl.c using Plan A...
Hunk #2 failed at 35.
Hunk #6 failed at 160.
Hunk #7 failed at 216.
Hunk #8 failed at 232.
Hunk #9 failed at 263.
No such line 417 in input file, ignoring


I'm fairly sure I understand why this is happening - Steffan has polar-
related patches in his tree that have not yet been merged - but "as is",
I can't merge this...

OTOH, it might apply if we get the James-reworked-by-Steffan patch series
in... Arne, did you find time to take a look at them?

(Sorry for having such a messy tree with too many open patches out there)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--YzytRCpZNWCht94M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVyD8FakuBuNlUUl1AQIsWAP/VUUGOCfuK2i7/afp6+eXb9wy4nYUaR96
r1HDJbvUov7KN6Jea+YYpqyZG/IgWI1r3aPHkNTl4OaA8nDobtLs4NU7PtG4gRfm
diV5i3aCh3HRZm0db/OsQKIrrrTX5dPIvUfNGKLD6w1Eio81+YwtB+FzSZAQ7lsi
5jxiTSoR2CE=
=vAkX
-----END PGP SIGNATURE-----

--YzytRCpZNWCht94M--

