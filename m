Date: Sun, 8 Apr 2012 12:56:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120408105646.GN1359@...1296...>
References: <CAOazyz1Uy_SxZCjdQ5oA1SAS+yjNC3i23BgMPDBr_gSFD+h_Rg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mEqjsIw1zG9QbE+V"
Content-Disposition: inline
In-Reply-To: <CAOazyz1Uy_SxZCjdQ5oA1SAS+yjNC3i23BgMPDBr_gSFD+h_Rg@...278...>
Subject: Re: [Openvpn-devel] [RFC] tun cleanups
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

--mEqjsIw1zG9QbE+V
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 08, 2012 at 01:43:12PM +0300, Alon Bar-Lev wrote:
> What I am asking is for people that wishes to work with me on this
> (not the ACK/NACK approach) to allow perfecting this *BEFORE* merge.

I would actually ask for "no more cleanup changes to tun.c before 2.3" -=20
I have cleaned up and *tested* all non-Linux-platforms in the previous
months and everything is working well now (not looking very pretty, I'm
the first to agree on this), but *working* *now*.

If we start to break tun.c into pieces now, this will need extensive testing
on all platforms.  Since I seem to be the only developer who does full
testing of tun/tap, ipv4/ipv6 on FreeBSD, NetBSD and OpenBSD, and I do not
have much time right now (conferences and second child due in two months),
I don't see enough testing capacity for this.

What I would really like to see is "get out 2.3 with the (big) improvements
we have right now, and start with 2.4 right after".  The next massive code
refactoring should go into 2.4

We need more user feedback to see which bits of the IPv6 implementation are
incomplete and need to be implemented next - and without exposure, we won't
get that.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mEqjsIw1zG9QbE+V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT4Fu7qkuBuNlUUl1AQJ8gAQApNu3J5M9MypspGeNDgqFTQF4+TLRISvt
lFFe9WFtHaIQchtdJmOs6DO2NRpLIe+S3lem3IxtCYLX484XciuUchseXviQv/w2
Z8Xy8ToikwiZEFyz98enN/14wdrkChU+pdQRp1NsuHlGV2QAYsijkhk3LIvdKJ2/
ITKOapBmHj8=
=Q7y7
-----END PGP SIGNATURE-----

--mEqjsIw1zG9QbE+V--

