Date: Sun, 1 Jan 2017 18:31:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170101173105.GD78624@...1296...>
References: <CAFHpkQGebq4V=F-nnaOdHd0OSb7teBTzaLD2=2Tx4SaJuj4sHw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8RzCspYsRAU9V6Ra"
Content-Disposition: inline
In-Reply-To: <CAFHpkQGebq4V=F-nnaOdHd0OSb7teBTzaLD2=2Tx4SaJuj4sHw@...278...>
Subject: Re: [Openvpn-devel] what is the use case of "#ifndef
 SIMULATE_DHCP_FAILED" ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--8RzCspYsRAU9V6Ra
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jan 01, 2017 at 06:23:08PM +0300, ???????? ?????????????? wrote:
> https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/tun.c#L5930
>=20
> how this is supposed to be used ?

This is test code: simulate what happens if the tap driver refuses
our DeviceIoControl() calls.  To enable that code, go to the define
further up

/* #define SIMULATE_DHCP_FAILED */       /* simulate bad DHCP negotiation */

... and remove the comment characters.


Not sure how useful this is, though :)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8RzCspYsRAU9V6Ra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYaTzYAAoJEB2Cnv7KVigSQAkMAK7nC7DLkP0+sSnhS6qP+Qrf
AZEt+c7mKgoKKO+CcNJnNAhK6Ry4lhRbqJPnAyYISvH2Cp1Z8XgcSIwa4Fvbiv0f
JPJMx9ZYEVkQqxDXwtMNowxh8K7WM1wdnXXdbJ6+oa9BFJVWrzGESJb3u6kb6+37
ddvc4OtbhLhN1f9Qcx/59stl/S+yueKlZnstH1PIDX9gSluekp7J32nsDS1SOyht
tidkvJj6rfU13831XmfROFu0YJ/o+Bf63PT3CaBqihQZ3c0L7NTjJm6pWryLpDoN
oQLRhEp5YKPN6G3Gpe5ZhFvxO9BV+qccJDNUIHwboUCSajNI8eqQ5qOJbaom/Rpc
FR+D5y3BP+K6amUFeDXD1QU9v06ceSaaCzZb9Rr2uN04T8xYFn34qILfX3M2X1Mm
ovZy5p6OaoMwVRZQFRtG6XcS61W/eYqVe32+9yx68BemJt8D13UXRxqJoyj05WvN
YkDVlAaatpQCJOlssd4VfpG+4XfXUF2TFmQGhI/b6A==
=owxN
-----END PGP SIGNATURE-----

--8RzCspYsRAU9V6Ra--

