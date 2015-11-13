Date: Fri, 13 Nov 2015 16:38:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151113153832.GT24952@...1296...>
References: <1447382487-26031-1-git-send-email-selva.nair@...277...>
	<20151113073802.GK24952@...1296...>
	<CAKuzo_iCjV9sa=7=+2cz7JLxYNQ6-K6QYFgv67u31=aV-fQrmQ@...278...>
	<20151113152758.GS24952@...1296...>
	<CAKuzo_hC4E1jXS_7t4D4C=w1SqE+G-efYAE8Wvfo1verMkwt4Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bSr84fpmRhc6ULjY"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hC4E1jXS_7t4D4C=w1SqE+G-efYAE8Wvfo1verMkwt4Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Do not hard-code windows systemroot in
 env_block
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--bSr84fpmRhc6ULjY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 13, 2015 at 10:34:49AM -0500, Selva Nair wrote:
> On Fri, Nov 13, 2015 at 10:27 AM, Gert Doering <gert@...1296...> wrote:
> >> However, if the user specifies --win-sys some_cruft, win_sys_path will
> >> get set to that "some_cruft" (in options.c). User is the king.
> >
> > Yes.  In this case, I do not worry at all - "you get what you ask for".
>=20
> In the current setup its perfectly fine. But I am adding it to my list
> of genies when the privilege separation aka iService can is
> opened...:)

That *should* actually still be a non-issue, as openvpn.exe is run with
the privileges of the requesting user (and the route handling is requested
via service pipe from the iService).  Unlike today, where openvpn.exe has
to run with admin privileges.

But of course there will be surprises in the details.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--bSr84fpmRhc6ULjY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkYD1KkuBuNlUUl1AQLp/AQAlEx0MmOBqpFBB2T1S1yVLObNrp0C42wb
z94emvFmEDjH8WTsZFBu4hjD+0R15Sq9oeGYXs8qiZZLGtReMp0V+1vNZMUtO1lR
xqOWgBUQxdUTgo7+8P51Mz7q/FG/fEiwYCmmRDCosYnpUchj37VlBiEiYWewnExG
T/GRTHCegV0=
=ZG12
-----END PGP SIGNATURE-----

--bSr84fpmRhc6ULjY--

