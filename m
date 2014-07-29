Date: Tue, 29 Jul 2014 23:20:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140729212054.GB1118@...1296...>
References: <1406667144-17674-1-git-send-email-steffan@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bi1c4c+m8JUixgIF"
Content-Disposition: inline
In-Reply-To: <1406667144-17674-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Fix frame size calculation for non-CBC
	modes.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--Bi1c4c+m8JUixgIF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 29, 2014 at 10:52:24PM +0200, Steffan Karger wrote:
> CBC mode is the only mode that OpenVPN supports that needs padding. So,
> only include the worst case padding size in the frame size calculation wh=
en
> using CBC mode.
>=20
> While doing so, rewrite crypto_adjust_frame_parameters() to be better
> readable, and provide debug output (for high debug levels).

Is this a bugfix or performance/packet size optimization?  I assume=20
"master only"?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Bi1c4c+m8JUixgIF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU9gQNqkuBuNlUUl1AQIUQgP6AksCihdnAWzFJoNUKYm4bzRQog8vshWu
HubAoC2WSI+apGEmcsky6++1xMZcPZqm5BZyoJ6UCQribbLZxpAAMMfFzVInUJJB
+YzK3HwydB4Zx4ICIgZhLdl7NBxsp/YDHuXFyqYAP9GbxwnbNxVrzQDq8fUxqHOZ
+KUt8eb1CyE=
=lKuS
-----END PGP SIGNATURE-----

--Bi1c4c+m8JUixgIF--

