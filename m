Date: Thu, 20 Jun 2013 21:23:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130620192348.GW20843@...1296...>
References: <1371738121-30540-1-git-send-email-arne@...1227...>
	<1371739123-2747-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oeBCTU8dS3Egdm61"
Content-Disposition: inline
In-Reply-To: <1371739123-2747-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [Patch v6] Add support of utun devices under
	Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--oeBCTU8dS3Egdm61
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 20, 2013 at 04:38:43PM +0200, Arne Schwabe wrote:
> Mac OS X 10.7+ natively supports tun devices (called utun). The "standard=
" utun.ko driver is sometimes problematic (e.g. VmWare Fusion 5 and tun.ko =
do not work together).

James brought up a "we need a v7 here"...

If you call "openvpn --dev tap --dev-node utun0", I think the current
code will open an utun device, but the rest of OpenVPN will expect it
to be tappish...

21:18 <@jamesyonan> if utun doesn't support tap, then we need to make sure =
that=20
                    code will fall back to tuntap driver for tap tunnels

... so, two options

 a) utun can do TAP - in that case we need to add the necessary magic bits
    to convert the newly created utun into an utap

 b) it can not do TAP (which I'd expect, tbh), so we should never open
    an utun device if the user wants a tap.

Arne, your call :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oeBCTU8dS3Egdm61
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUcNWxKkuBuNlUUl1AQLkLgP+Pg/NMQce/AGPaLhwnZfz5goRjVEBv2rL
Re4mY6G0UZjMNZ+eG5qZD/DIm49VfPOlIPuVQkO4uWZRckHH+lbZFcvx28sEQ6GE
/I3y6JyG88yzZq8ArHN5u3ztgQcWCUyydcgha/Sekm0pBlQx7Id8CtCGVr5jjLrX
ccAsdbTctc8=
=Uw6+
-----END PGP SIGNATURE-----

--oeBCTU8dS3Egdm61--

