Date: Mon, 27 Apr 2015 21:33:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150427193326.GU382@...1296...>
References: <CAK6ywb+fMsyvOz+saw9XBO4KDx1srdB92H71OwcKFPZnyxHkqw@...278...>
	<1430162841-5840-1-git-send-email-gert@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gX5Hm7FaHdN5aeGl"
Content-Disposition: inline
In-Reply-To: <1430162841-5840-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] assume res_init() is always there.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--gX5Hm7FaHdN5aeGl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 27, 2015 at 09:27:21PM +0200, Gert Doering wrote:
> Previously, the code tried to find res_init(), and on some systems
> got it wrong in configure, silently not-using res_init(), leading
> to unexpected failures to re-init the resolver.

... for the record: tested on FreeBSD 9.1, Gentoo-something, AIX(!),=20
OpenSolaris and MacOS X - and either it found and added the library
fine, or discovered that it didn't need to do anything, but in any case,
the resulting socket.o always referenced res_init() and linking worked.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gX5Hm7FaHdN5aeGl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVT6PBakuBuNlUUl1AQIBgQP9GQRpGxVW4IFo1TNbEoG8sElhxpk/03Qj
j9SbgITRDF545EkcTUbPTRudXSIjzjAy2bNEgHHsd8dQPWwQn35mwppb3W2cDPRr
W1T13mvVaH1I+Gmdh/7ifo/sgU10OREwtw8ZS89Bbdes2Ofrk58ORg6U3OpXpq+3
JHNDjFsEBZ4=
=3SmY
-----END PGP SIGNATURE-----

--gX5Hm7FaHdN5aeGl--

