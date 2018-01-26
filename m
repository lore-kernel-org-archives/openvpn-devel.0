Date: Fri, 26 Jan 2018 16:35:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180126153505.GY69387@...1296...>
References: <1509930876-30728-1-git-send-email-selva.nair@...277...>
 <1516815105-17882-1-git-send-email-selva.nair@...277...>
 <2f187b23-c53f-94cb-6a58-d5c9c14b5da1@...1147...>
 <663a0e1d-0d21-6f40-851e-78d770bec68f@...1147...>
 <CAKuzo_i4Ge=3cbg3zZY61ps+wDi8eCC1M4dopNJKGoB-LmT0Qw@...278...>
 <cba28408-81d0-5295-c882-f4bfdfcc20c3@...1147...>
 <CAKuzo_gCvfSYi+u4XJd88te-B_XbW1AkEQ3LxsuHaAH29EDVrw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Ec463DdZaKtRhMf1"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gCvfSYi+u4XJd88te-B_XbW1AkEQ3LxsuHaAH29EDVrw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Use lowest metric interface when
 multiple interfaces match a route
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Jan Just Keijser <janjust@...1147...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Ec463DdZaKtRhMf1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 26, 2018 at 10:26:58AM -0500, Selva Nair wrote:
> The mystery (at least for me)  is where that host part is coming
> from... Its zeroed out before setting the route, and I thought the
> same (?) route list pointer is
> passed in while deleting routes.

"I seem to remember code changes related to that, possibly related to
the introduction of the interactive service handle"

Can't look right now, but I think we had 2x zeroing and that was=20
unified and stored, or something like that... need to check, later
this evening.

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--Ec463DdZaKtRhMf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaa0qoAAoJEB2Cnv7KVigSxY0MAIRn0EL/OB2nXwbTL8BU0GVy
fLViZ6AirHCYf7pc+AQCcA7rShko+UouT+Pzvhnl0G5y5wSO4dxn3+pWMjjBH0Kl
yoKAkbDM0OEwFrB3+wfEzHfUTHRIHKfKOqIoWvL76twyrgN7Vccr8UBI5rgnBk0H
WxfefPC8ej19dIypjgZJihrnnKovmQW6QKMEFxJ86/WkoL8h/tu8xH0b55C+a1r4
onofosz9AeH29/rSAnxgl5ariOdVtSMgD0ryTdhuBh+/UyikeQ7vW74SsEqDyvQQ
1wGPbzhbl01bE1fa7MSIqZRpMByGct8uqCvtMHqtbLeRh4ZhwXgIOmt2+K35gTdu
mAPm3GPnDYSyALm7EfMlZrgr++k8v5xgZAP03e96LkIaIRSqxu77y98OwVNNo1VF
JTZti1KSpthHuZctiXb+tU9abuRucDFUn4MrCQMvRlHYsPVYLtqKsQzCPjyWlvO4
xWDpOfJ9cOPHR0A3FClNT8+iAj2NIO8MG4t0aWfNyA==
=hLo4
-----END PGP SIGNATURE-----

--Ec463DdZaKtRhMf1--

