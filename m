Date: Thu, 27 Nov 2014 16:10:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20141127151058.GC17158@...1296...>
References: <1416755831-21250-1-git-send-email-lstipakov@...277...>
	<20141127142228.GA17158@...1296...>
	<CAGyAFMWeGMnuRObAkLeTZ4iMZE8xOH1QBtnS2FCeGqwRaCe1Bw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DRfr/2Y1Zz/5r+Kb"
Content-Disposition: inline
In-Reply-To: <CAGyAFMWeGMnuRObAkLeTZ4iMZE8xOH1QBtnS2FCeGqwRaCe1Bw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Peer-id patch v7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--DRfr/2Y1Zz/5r+Kb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 27, 2014 at 05:08:09PM +0200, Lev Stipakov wrote:
> As for the second question - hard to say. If we make it opt-in, we
> probably will need to announce this feature loudly to make users aware
> of that. From the other side, it is not inconceivable to assume that
> someone might not want this. Maybe we could make it opt-out and have
> "-no-peer-id" config option?

Definitely not "a new option", as we already have --float :-)

But I can see the argument about opt-in/opt-out - I found it a useful
thing to explicitely enable the feature (so, no surprises here) but if
there is not enough advertising, people won't be able to benefit=20
from it...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--DRfr/2Y1Zz/5r+Kb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVHc/AqkuBuNlUUl1AQJdkwP/bzz/BIaaoOHY10PKRzHntijWhh1b18M8
A1Hx9/gxDB1AOHCxkDPXVNMkjawDSLIdjs+ssCPluQ1xNFVLtTlf2itBn0TBvvzp
ZLecoLIgmDdcBxokwWCnmuYxp5TYVFHCuKQZoL1ob9yUj3N+iWwZQSTA7YIpnBqF
NSV7E1Pf9wE=
=E8qC
-----END PGP SIGNATURE-----

--DRfr/2Y1Zz/5r+Kb--

