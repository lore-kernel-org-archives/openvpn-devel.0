Reply-To: openvpn-devel@lists.sourceforge.net
References: <1494008642-7239-1-git-send-email-selva.nair@...277...>
	<1494008642-7239-2-git-send-email-selva.nair@...277...>
	<20170612181403.GK97029@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e9c7eff1-0638-12b6-b5cb-85473483de59@...2080...>
Date: Mon, 12 Jun 2017 20:27:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170612181403.GK97029@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ssN8i0dMNrsXgnhrxRB9m8EOHJVWonDrJ"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Parse static challenge response in
 auth-pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ssN8i0dMNrsXgnhrxRB9m8EOHJVWonDrJ
Content-Type: multipart/mixed; boundary="IBXWm55590gMA6NDEP2gbPb1o39U6AEq3";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <e9c7eff1-0638-12b6-b5cb-85473483de59@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Parse static challenge response in
 auth-pam plugin
References: <1494008642-7239-1-git-send-email-selva.nair@...277...>
 <1494008642-7239-2-git-send-email-selva.nair@...277...>
 <20170612181403.GK97029@...1296...>
In-Reply-To: <20170612181403.GK97029@...1296...>

--IBXWm55590gMA6NDEP2gbPb1o39U6AEq3
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 12/06/17 20:14, Gert Doering wrote:
>=20
> What is the status of this one?  Does it need updating after 1/2 got
> changed to v2 and v3 are these independent enough that 2/2 is standalone?
>=20
> From a cursory glance, it calls secure_memzero() which is now, I think,
> plugin_secure_memzero() - right?

Yes, that seems to be correct to me.  A v2 is needed .... but ...

> I also seem to remember discussions between you and David regarding
> base64 function exporting - what's the state on this?

... I have managed to inadvertently managed to drop this ball.  Yes, we
should export the base64 functions.  I had a patch out, which Selva
reviewed and he discovered a few issues with the plug-in v3 API.  And I
remember Selva sent some patches fixing this too - but I've lost track
on those patches too.

Regardless, we should get the API fixes and the base64 export in place,
then a v2 of this patch makes far more sense.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--IBXWm55590gMA6NDEP2gbPb1o39U6AEq3--

--ssN8i0dMNrsXgnhrxRB9m8EOHJVWonDrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZPt0xAAoJEIbPlEyWcf3yS4YP/iCLflwVmmEMAyAkU3QiKSVD
kv+Nv1q5/weyHujcnhK/mx6MvdnhIHK8AFEABTYOF9MoA6cTjHRqWKUOt+yGaWZy
20bF1whD2aMJP3nYMoH578Ud0qf0rgethzKoC/whpEXK+UxUC4BwG9/PuXgmn88G
TgVghvSvMm41a4fFbPeVn3jxpIMjC3JXn0X8NrLr1s95txR/NkWOvKbIVzmCXWsW
yzenTTRLSmXeEXlya6Ig6rUMcEF2apBqla6/nYIbKODDm1ufqpvwmW1zvo1q37fI
5VQjkH6oYWXHo7CcZoQp1XoWIlNXNmH/GLXzQrUC0x3ZKMPpw6m5MEmUFdXf/l+e
Lt6GV/4umNbLuRK3erQPm/qi66Vye8ISy3uQB+PTAFzcV4hOZpwRdJTCXy2d3vI+
CfNs4VyfKt+JM79wS8QetcaQE4laQPkJkMiidGcEqGij88HnNJLd8XDjidkjHedy
VfJKC4gQQPJLcyJHyr6NdrlXKa4udWgDPai09z76Qqyi5qF7EozLbb5tuGmY/lbp
NfuG1L4wqo1GvKb9MnqUgq29LAdThEip4hHLjAn2llbGl2PjQeESYXfNDxvqUIQp
KMRR4joMbW4cHpfNC6lNCtaFfPSgq+mlhGkypDYNySW4vd1s+koQ937pjgvmrcj5
g4hpKqBSOUuFd2IcQ4wD
=U4jo
-----END PGP SIGNATURE-----

--ssN8i0dMNrsXgnhrxRB9m8EOHJVWonDrJ--

