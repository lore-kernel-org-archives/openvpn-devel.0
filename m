Date: Tue, 22 Nov 2016 22:44:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161122214428.GL28918@...1296...>
References: <880e3bb4-bc65-0122-c53b-d6886eab0579@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dujhm+tC3mnf5SZX"
Content-Disposition: inline
In-Reply-To: <880e3bb4-bc65-0122-c53b-d6886eab0579@...277...>
Subject: Re: [Openvpn-devel] IPv6 --dev-node error not correctly identified
 (Moved to -devel))
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Dujhm+tC3mnf5SZX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 22, 2016 at 05:01:49PM +0000, debbie10t wrote:
>  >> So the error message is not correctly identifying the problem that the
>  >> specified device does not exist.
>  >
>  > There is no trac for that that I'm aware of.
>  >
>  > I agree that the error message should be more meaningful.
>  >
>  > OTOH, I'm not sure we *can* fix this in 2.3 with reasonable effort -=20
> Heiko
>  > rewrote significant bits of "how we do stuff on Windows" for 2.4 to ma=
ke
>  > this particular error message go away completely - and that change is
>  > not going to be backported to 2.3, because it's way too complex for a
>  > bugfix.
>  >
>=20
> Perhaps there should be a trac with this information ?

The commit in question in master / 2.4 is

commit 533495298bd93ddaaf4418dc666922779ce5ef9b
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Fri Jun 24 18:01:41 2016 +0200

    Windows: do_ifconfig() after open_tun()
=20=20=20=20
    When you had multiple TAP adapters and IPv6 configured you got an error
    message about "you must also specify --dev-node" and openvpn exited.
    Very inconvenient especially since this is only due to the fact that
    Windows tries to set the adapter address before it is opened; for no
    good reason.


it does not reference a trac ticket, so most likely one does not exist
(and we only discussed the issue on #openvpn-devel)

I do not think we have cycles to fix this for 2.3, so a trac would be
pure documentation ("yes, this is nasty in 2.3, but it is fixed in 2.4
and we want you to upgrade anyway") - so if you can do that, it would
certainly be useful.


>  > Could you please try to reproduce this with 2.4_beta1?  I wonder what
>  > the error message for "--dev-node references a non-existing device"
>  > will then be - if it's still a non-useful error, it is much easier to
>  > fix there.  But I do hope that the error might actually be something
>  > useful.
>  >
>=20
> Win10 - Openvpn 2.4_beta1
>=20
> Exact same test, result is:
>=20
> TAP-Windows adapter 'defaultc' not found
> Exiting due to fatal error
>=20
> So that looks ok.

This is what I hoped for - thanks, Heiko :-) - and thanks for testing.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Dujhm+tC3mnf5SZX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWDS8PKkuBuNlUUl1AQKm4QP+OywHbqK2Wvr+uJFoy3UpZwEjtxs6JShw
ftFvwKioeR740HaQ2EtfWV7pPrmnYdOYXr3pwJyUNlWCZJg4igoUMhE4lvQX1Zou
m3ufjd2UtwlSzj0wm0lePujA7gjCJVyT4Sa6B2Djzyf39TEQDqJ6rHa0CAEQpd/T
PPwAGrEgY58=
=EAFa
-----END PGP SIGNATURE-----

--Dujhm+tC3mnf5SZX--

