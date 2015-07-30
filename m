Date: Thu, 30 Jul 2015 13:48:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150730114818.GE382@...1296...>
References: <CALKXstsZLjqxCrzo3E-qGiyhJo3yi9bW1Jf2bKGYphkB+4b0Qg@...278...>
	<CALKXsttsrkPxgrT1A+gpRh5WoxTxw6djkBQJh7BjKTSk5itDig@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fEYHHl3Y7+NLHHJ5"
Content-Disposition: inline
In-Reply-To: <CALKXsttsrkPxgrT1A+gpRh5WoxTxw6djkBQJh7BjKTSk5itDig@...278...>
Subject: Re: [Openvpn-devel] Openvpn is not working with hardware encryption
	enabled CPU.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rahul Arora <rahul1991.arora@...277...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--fEYHHl3Y7+NLHHJ5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 30, 2015 at 12:55:00PM +0530, Rahul Arora wrote:
> *Openvpn --version*
> OpenVPN 2.1.3 arm-fsl-linux-gnueabi [SSL] [LZO2] [EPOLL] built on Jul 29
> 2015

This is, uh, ancient.  2.3.7 is the current stable release.

(It might or might not related, but we're certainly not going back to 2.2
or even 2.1 releases to debug anything.  OpenVPN *should* use the crypto
accelerator just fine, if OpenSSL can use it - if you need to use an
OpenSSL engine, tell OpenVPN with "--engine yourengine".  It might not=20
make an overwhelming difference in speed if you use the wrong crypto
algorithms - like, your hardware accelerates 3DES and you use=20
--cipher blowfish...)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fEYHHl3Y7+NLHHJ5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVboPAqkuBuNlUUl1AQLyIwQAhIdoHT9uGiJXWQ5g11JAmYqAHPgnZEg/
GFa0MlnCR7qOqFF/VVAp36+QiYd2C94kZxe6N+SRsFpFAaAxrD8YNLBqSBzNSSMl
H5Gh+7yUy+Ib8JxYDpLzsnY8YFlyGzYOnwAFaV8Q91Hnn6s9+fMKwJjB2169o2Bf
QDmGBHH/cOg=
=eW4+
-----END PGP SIGNATURE-----

--fEYHHl3Y7+NLHHJ5--

