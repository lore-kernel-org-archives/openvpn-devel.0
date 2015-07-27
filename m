Date: Mon, 27 Jul 2015 09:28:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150727072801.GO382@...1296...>
References: <55B1FF56.4000209@...1147...>
	<COL128-W59456CBB4B786DDF3AECEECA800@...512...>
	<55B56347.7010304@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HviMa7Dn1oS3f0ef"
Content-Disposition: inline
In-Reply-To: <55B56347.7010304@...1147...>
Subject: Re: [Openvpn-devel] Does Openvpn really support cryptodev hardware
	accelerators
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--HviMa7Dn1oS3f0ef
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 27, 2015 at 12:46:31AM +0200, Jan Just Keijser wrote:
> >>>as our way to do --daemon wasn't compatible with cryptodev...
> >do you mean it is suggested in daemon mode when running openvpn with=20
> >cryptodev?
> >
> Gert's comment was about freebsd crypyodev support ... on Linux openvpn=20
> 2.3.7 builds and runs just fine.

2.3.*7* has the same issues everywhere, that --daemon and passphrase-
protected keys just do not work together anymore... (already fixed in git)

Up to 2.3.6 had the issue *on FreeBSD* that cryptodev + --daemon did not
work together - which would not have been such a big issue, *if* the
FreeBSD people hadn't decided to always enable cryptodev in openssl=20
(so, no --engine cryptodev needed)...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--HviMa7Dn1oS3f0ef
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVbXdgakuBuNlUUl1AQLu0AQAncxDjTYRAW+EjYqAej4pIrZBktqJmrdR
ni+Ca0RBpCaOsWPyg1uJ/NX4V8ql3eKAZZcx+eGHNfqr9ofyyJI371t0zuvWVmTt
GkmQnrtFU03Arfy79405Tw93I4mcimEOZ7w/tfDxdSKl4oQXlsgfN/Aug0q2bNXX
GERbhY5Wx1g=
=IX4m
-----END PGP SIGNATURE-----

--HviMa7Dn1oS3f0ef--

