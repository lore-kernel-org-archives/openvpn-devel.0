Date: Mon, 21 Jul 2014 14:02:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140721120250.GK1118@...1296...>
References: <11052645.930865.1405935348844.JavaMail.root@...1893...>
	<CAA1Abx+R_ARom8UBH2z-qRz0bqwq7==vT5KY93OWCgeQQc=ShA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2unX6n4w7rMQ5H3"
Content-Disposition: inline
In-Reply-To: <CAA1Abx+R_ARom8UBH2z-qRz0bqwq7==vT5KY93OWCgeQQc=ShA@...278...>
Subject: Re: [Openvpn-devel] OpenSSL in OpenVPN software to be replaced?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: Lisa Minogue <lminogue@...1892...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--f2unX6n4w7rMQ5H3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 21, 2014 at 01:24:53PM +0200, Steffan Karger wrote:
> LibreSSL has just been ported to Linux.=20

I'd stay away from LibreSSL for a while.  "We do OpenBSD, and do not care
for portability" seems to have side effects on things like "seeding RNG"
that should be fully understood before using that.

(Unfortunately I do not have the link that details this particular issue
- came around it last week)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--f2unX6n4w7rMQ5H3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU80BaqkuBuNlUUl1AQKPygP/TTUVcjOe1nfsG1Uoge2luTpOUSbmw0q6
X3acBxob1f9n+SFAy912neuG/CR+aBuUfpO8BO+Z4GE1pVBnB5BCSvqqvenYYi2C
ppE8SF2N333mb8FK3AfzQ7470An1tNFwJaZn/GaRUqQuA+Qgd+LQpmxyFrQt8kwU
ZCZltK3eF1c=
=/FAa
-----END PGP SIGNATURE-----

--f2unX6n4w7rMQ5H3--

