Date: Mon, 26 Nov 2012 20:00:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121126190037.GZ22465@...1296...>
References: <1CED409804E2164C8104F9E623B08B901323D0B158@...1436...>
	<1353940389-31075-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SSJ6yXlPvEk0CmSI"
Content-Disposition: inline
In-Reply-To: <1353940389-31075-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Properly require --key even if
	defined(MANAGMENT_EXTERNAL_KEY)
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

--SSJ6yXlPvEk0CmSI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 26, 2012 at 03:33:09PM +0100, Arne Schwabe wrote:
> When specifying --tls-client --cert ... without a --key (or --pkcs11) opt=
ion,
> OpenVPN should complain: "You must define private key file (--key)...". E=
nsure
> that this works even when compiling with MANAGMENT_EXTERNAL_KEY.
>=20
> Also fix the other instance where this logic is broken

ACK.  Operator precedence in C, gah.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SSJ6yXlPvEk0CmSI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBULO8VKkuBuNlUUl1AQI7igQAvvtMyPkwMuzMtWvpmOFw0au+Ek4qc3N8
kYZKrUOq9TaCIGHapU6nqDJESkcYIG6ZAIxi0BjedGkW6fKmqS35vWBMgpAsJni8
2vBK31hzv9SRT/+yXGvVm9N8sNINAGUU35iB0fsL8tjn2la2kM3i+n/MKmuj3TlK
c516buNQSa8=
=1iGD
-----END PGP SIGNATURE-----

--SSJ6yXlPvEk0CmSI--

