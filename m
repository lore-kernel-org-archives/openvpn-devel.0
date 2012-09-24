Date: Mon, 24 Sep 2012 11:18:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120924091835.GX742@...1296...>
References: <1348477246.32678.YahooMailNeo@...1765...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Wg5Vd7si6EhrIHA"
Content-Disposition: inline
In-Reply-To: <1348477246.32678.YahooMailNeo@...1765...>
Subject: Re: [Openvpn-devel] multi threading support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ehsan enayati <ehsan_en85@...109...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--1Wg5Vd7si6EhrIHA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 24, 2012 at 02:00:46AM -0700, ehsan enayati wrote:
> Hi, i wanna know how does openvpn server handles multiple requests?
> for example if there is an active connection with a client on 1194
> port and another requests from some other client comes in what will
> happen? Is this task managed in operating system or by openvpn
> itself?

OpenVPN itself (single-threaded with smart work queues).

Multi-Threading might happen in OpenVPN 3.0.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1Wg5Vd7si6EhrIHA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUGAla6kuBuNlUUl1AQLKFwP/YUit4A766oUKD5GT+C8GrnLFfmoelQiz
I2IZHcJn3GyjVn6XgrjzPf6yyk2/c+Zbtne2C5FD16EEKYitC7S2xRz1j6cCftfP
Ibu42aoJ22NTDO1m3FiqZje/Zwmdy1kykD+CbKhmpvXJRpKkH5ma/kMdC5/NzpgP
TNzoHfhnFhQ=
=xzgm
-----END PGP SIGNATURE-----

--1Wg5Vd7si6EhrIHA--

