Date: Sun, 13 Apr 2014 15:48:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140413134801.GS16637@...1296...>
References: <20140409232527.GA3061@...1890...>
	<20140413125641.GQ16637@...1296...>
	<20140413133920.GA28182@...1890...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8I9yi/IyADoiQZtC"
Content-Disposition: inline
In-Reply-To: <20140413133920.GA28182@...1890...>
Subject: Re: [Openvpn-devel] BUG: Windows netsh interface ipv6 delete address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Cedric Tabary <cedric+openvpn@...1891...>
Cc: openvpn-devel@lists.sourceforge.net

--8I9yi/IyADoiQZtC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 13, 2014 at 03:39:20PM +0200, Cedric Tabary wrote:
> Bug is still there in this build,
> I think you patched the route removal but not the ipv6 address removal
> on the interface itself.

Oh.  I need to learn to read...  indeed, I patched route removal only.

Will send a new patch + installer tonight.

Sorry,

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8I9yi/IyADoiQZtC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0qVkKkuBuNlUUl1AQKbBgP9HXOd5jMHBX3PnDvBTZXW6GKWmQ7oTpJD
MFlbL6tpfxfsOpQ008oHhKrbXOougI0kLD/cD148kDCi0xkKAmg44CLzl3lavhcg
ut7IaKsvPSrrWZ+DeQcC9JpfJkwU9NtdRIuvaTgy6tuqFWMEhsnreW+aWimmoqKr
W5XHb4JOHh0=
=jnKz
-----END PGP SIGNATURE-----

--8I9yi/IyADoiQZtC--

