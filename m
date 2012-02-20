Date: Mon, 20 Feb 2012 19:13:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120220181326.GP7024@...1296...>
References: <CANvbpLQcUnRtvSphye1HtbS7MN2_jcHq-H6ie0gKYddE=fskYw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRtLtq+kfJNLc57H"
Content-Disposition: inline
In-Reply-To: <CANvbpLQcUnRtvSphye1HtbS7MN2_jcHq-H6ie0gKYddE=fskYw@...278...>
Subject: Re: [Openvpn-devel] Better use ip -batch on adding/removing server
	pushed routes on Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Yang Zhe <yangzhe1990@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--QRtLtq+kfJNLc57H
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 21, 2012 at 12:00:37AM +0800, Yang Zhe wrote:
> It's quite slow to add thousands of routes via execve thousands times.
> It's better writing the parameters to a pipe to `ip -batch -` on
> linux.

Well, my VPNs have far less routes ("tens" instead of "thousands"), and
exec()'ing was much easier to implement.

I do agree with Heiko and David, though, that we should have netlink - if
this is a reasonably stable API and useful documentation exists, because
otherwise maintaining this code gets painful and error prone.

(For compatibility reasons with the old linux versions we still support,
we might need to keep the existing ifconfig/iproute2 methods)

Patches welcome :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--QRtLtq+kfJNLc57H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT0KNRqkuBuNlUUl1AQJCZAP9F4EdUxjua+QPAF4y5VQNDR2u7jW2I/cU
K/SWb2B+DbQsgB6BBFUfsHDwx/2oFxM1iiNugcTKjgChb0KF9YM9+PDxXCa5wH58
8UWkHYnf8m2xCacyAQ1eHpD3sWvAiHFlWR08HBlhFKiNsOPevQ22u8lzlTMqf9QH
icVP92ZXuT0=
=x1fK
-----END PGP SIGNATURE-----

--QRtLtq+kfJNLc57H--

