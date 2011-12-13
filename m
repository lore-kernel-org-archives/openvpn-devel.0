Date: Tue, 13 Dec 2011 22:19:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111213211924.GQ18948@...1296...>
References: <A273A2F6519C0D42BFF02CA9C6A825112D003E1E@...1531...>
	<4EE52A57.1040906@...1338...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F02@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
	<20111213092241.GO18948@...1296...>
	<1CED409804E2164C8104F9E623B08B90128ACE5B0A@...1436...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005928@...1531...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3snK74p7ddXn3Qrx"
Content-Disposition: inline
In-Reply-To: <A273A2F6519C0D42BFF02CA9C6A825112D005928@...1531...>
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tiran Kaskas <Tiran.Kaskas@...1530...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--3snK74p7ddXn3Qrx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

On Tue, Dec 13, 2011 at 08:22:36PM +0000, Tiran Kaskas wrote:
> The problem is that the nl package was built with 2.1 version, and I have=
 used this.

2.1+nl patches is fine.  2.0 is not what you want.

> On a different topic: I found an issue, you probably want to fix that:
> In reliable_pid_in_range1() function, the third parameter(extent) is an u=
nsigned int.
> However, this function is being called by reliable_pid_min(), passing 0x8=
0000000u as the value to extent.
> On a 16 bit machine (int is 16 bit) this will never work. The type of ext=
ent need to change to unsigned long and not int.

I don't think we currently support any 16bit machines.

What platform and operating system is this?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3snK74p7ddXn3Qrx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTufBXKkuBuNlUUl1AQKN7gP+LbFzd0vX6FcrugB+jGPxzyn1ps63FYfT
Pjp3u8HO4lU+8oGqsayVWdwRWaU1+wq4O9R0uIttjrmnhKzv47k2jqVqaNW/rW5+
VYCxY0u6ezF05fucrC7U+JVa17CuuxY1NRN7YtpF6KDJRwC6HEV6mzn2B5t63xJO
/FDMz01xem8=
=kpM6
-----END PGP SIGNATURE-----

--3snK74p7ddXn3Qrx--

