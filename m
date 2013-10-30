Date: Wed, 30 Oct 2013 22:27:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131030212736.GP161@...1296...>
References: <1383163946-24298-1-git-send-email-avalentin@...1847...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OLq6itPlQwcDjwuA"
Content-Disposition: inline
In-Reply-To: <1383163946-24298-1-git-send-email-avalentin@...1847...>
Subject: Re: [Openvpn-devel] [PATCH] Floating: Add support for floating in
	TLS mode (upd.)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?Q?Andr=E9?= Valentin <avalentin@...1847...>
Cc: openvpn-devel@lists.sourceforge.net

--OLq6itPlQwcDjwuA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 30, 2013 at 09:12:26PM +0100, Andr=E9 Valentin wrote:
> Add support for floating in tls mode using the HMAC of a packet. It costs
> a roundtrip through the clients. Its security comes from a secret key, bo=
th
> peers have. This key and the data form the signature used, which is then
> checked againts existing peer connections. Therefore a good auth algo is
> recommended.

Uh.  Could you remark on what changed between this and the previous
patch, and possibly add a "version X" identifier to Subject: or the
commit text?

Should people actually start reviewing the code (ahem...) it is enormously
helpful to see which version a review is for - and when I commit it, it
also eases attribution to which version of the patch went in.

(Arne, David and I are famous for sending patches with versions on=20
versions...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--OLq6itPlQwcDjwuA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUnF5yKkuBuNlUUl1AQIRtgP+O51j+88R6+TIDsd2pfYXwzcnLeTzLlhV
rWRInq50FaaDmJ8N+MwM5eTXCyiQhv3Vgm7drgHi/B+QuWH7Je7BqZSzp1SV3rDJ
LJYGWYUUHCF4j/9Vqf2jS4IO2WiGAQwzW8HGEuSts46wbdeu4r3LsMIChiaryW9a
qWwQtBcJfQY=
=6Q/G
-----END PGP SIGNATURE-----

--OLq6itPlQwcDjwuA--

