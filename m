Date: Tue, 27 Mar 2012 09:42:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120327074201.GD1359@...1296...>
References: <CAOazyz0qskX3taZW7amei-tEt=LcARsuE=hQCZ+010hRGVNC4w@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xyF51EaUT3XiWnZP"
Content-Disposition: inline
In-Reply-To: <CAOazyz0qskX3taZW7amei-tEt=LcARsuE=hQCZ+010hRGVNC4w@...278...>
Subject: Re: [Openvpn-devel] build solaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--xyF51EaUT3XiWnZP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 26, 2012 at 10:33:01PM +0200, Alon Bar-Lev wrote:
> Seems to compile using sun studio compiler and sun tool chain.
> ---
> $ src/openvpn/openvpn --version
> OpenVPN 2.3_alpha1 sparc-sun-solaris2.10 [SSL (OpenSSL)] [eurephia]
> [PF_INET6] [IPv6 payload 20110522-1 (2.2.0)] built on Mar 26 2012

Cool!

I have an OpenSolaris 10 / i386 VM that I'll turn into a buildslave
"as soon as time permits", so we'll have continuous test coverage there.

I don't have a dedicated Solaris/Sparc* installation anymore, though,
but do occasionally run tests on FreeBSD9/Sparc64, which is quite useful
to uncover endianness bugs...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--xyF51EaUT3XiWnZP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3FvSKkuBuNlUUl1AQIRLAP/SzsC+HP+qHkYe06tayUi6fBNLL+POEng
9tK9/d1J+F81mqE4zTA90aPhpx/VmlLGSKgbRn0B5/ioQ5EjEuJq1fQFS9x6CgPp
6M39u9IzIwKkk5NmCMQ6CWety6Q9/f3oEnQlIeqOBPQNmqBG5b0MTl2dlshRQk0a
EgdrMsuID68=
=+Bpw
-----END PGP SIGNATURE-----

--xyF51EaUT3XiWnZP--

