Date: Thu, 8 Oct 2015 21:25:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151008192551.GG22054@...1296...>
References: <CAExzePLr5Fhpk+m-LS1LPcrn4cwSXstUQfzvcAxgNRWLeU7UnQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="livrSZtJkVq9DDdS"
Content-Disposition: inline
In-Reply-To: <CAExzePLr5Fhpk+m-LS1LPcrn4cwSXstUQfzvcAxgNRWLeU7UnQ@...278...>
Subject: Re: [Openvpn-devel] prefix delegation for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fred Templin <fltemplin@...1901...>
Cc: openvpn-devel@lists.sourceforge.net

--livrSZtJkVq9DDdS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 08, 2015 at 10:40:24AM -0700, Fred Templin wrote:
> Hi - I would like to propose a new address assignment method for openvpn
> where the server delegates an entire IP prefix to the client instead of
> just a
> singleton address. The client can then configure multiple IP addresses fr=
om
> the prefix and assign them to the TUN/TAP interface. The mechanism for
> this is DHCPv6 Prefix Delegation. Can this be taken into consideration?

Uh.  DHCPv6 PD is not "for the TUN/TAP interface" but for stuff "behind"
the TUN/TAP interface.

So what is it that you want?  Multiple addresses on the tun/tap, or=20
"be assigned a prefix to be used for *other* interfaces, or even other
hosts behind the tun/tap"?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--livrSZtJkVq9DDdS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVhbDP6kuBuNlUUl1AQI9nwQAn3MDWNcxP/L9EwSeypKa5O7aaYoA7WDY
Ih+Q+tqOhUva7+UODr17wtHB+WM6DFrekGo8uYk7gEx5gBFosMw5DfFPZ10NYcw9
kMx6GlU53A43CrWqsdjezO2nmsfbeg+fb2wQ6Pf+eljt3OpjN1QZC9fJNo3TjJij
A3Uy+VgqTrs=
=kAD5
-----END PGP SIGNATURE-----

--livrSZtJkVq9DDdS--

