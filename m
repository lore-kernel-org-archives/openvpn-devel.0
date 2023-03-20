Date: Mon, 20 Mar 2023 19:11:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZBihxxfsTW4ByUz1@...1296...>
References: <20230318141330.1315235-1-selva.nair@...277...>
 <202303201757.32KHvjTh071877@...2054...>
 <CAKuzo_hZZT=9tYmi7ZiqAnyMtjifRGuAGZUo1GSbSfQSAiPEaw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Bn2qDywVDG+wY4Xx"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hZZT=9tYmi7ZiqAnyMtjifRGuAGZUo1GSbSfQSAiPEaw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Improve error message on
 short read from socks proxy
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--Bn2qDywVDG+wY4Xx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 20, 2023 at 02:07:14PM -0400, Selva Nair wrote:
> > Thanks, this change makes sense.  I have not actively tried to provoke
> > it (like, by connecting to a "fake SOCKS server" that will trigger it),
> > but the change is obviously an improvement to "if it's not =3D=3D1, it
> > must be a TCP error!").
>=20
> An easy way to "provoke" this is to use openssh proxy (say, -D 1080) and
> use it to proxy to a udp server. SSH will close the connection as it does
> not
> support udp association. Probably it should return one of the socks5 error
> code instead, but doesn't. Even if it did, our recv_socks_reply() is not
> capable of
> handling such errors.

Ah, this is helpful.  I did use "socks -D" for the very first t_client.sh
"test with SOCKS", but I found this cumbersome for regular use (need to
ensure the session is up, etc.) I went for "dante" instead - v4, v6,=20
UDP, TCP.  And a config language worse than OpenVPN... *cough*.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Bn2qDywVDG+wY4Xx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkGKHHAAoJEB2Cnv7KVigSV+oL/1wNwFThG8tigUHjsIFgrF1E
frlXnGzd/wU22ksVJ03bOobI0fDjmTl/oz0eKlKgtk0AcBx00bRiw2giftUua6ak
f2UQfUFxwjMY0Uo/32NleyJVD0ClbsJYc6Yci04YqYT2ltM8c4MpLwRY1ActMIyV
OiAoSfI8eZ+ARIUBCeM/F7SqGl08EkW05m50lLZD4+Yg77o1ZwSXHIzJPEg8Wc8w
jVYhpOFmliEu5wgg0U1bRPzjrLuGoeDUjHJkxkyaoqlr4ZXc+wfKivdt58A/KR/H
T1Tz0dw4wdwtLx9J6ScZDAOWVrVtdQeHlGyy+NO3xfhgabo/0bZn5+LR8A9BEyr7
tTRgAzj2zUgOWXFOmMDAiqw1a/Z7cXyg/YH+l4tvFdyJhm5DoaHRHVz5hpJPuH4X
pLsmvyHzCGOkfuuJftO4Rjn6Ue9lesMqq4F1md6h9UXICWCuCX/VyGhuDRyZ/V/6
kNvV0pA4wKD7M4lMY8ZC60iNuw5HK2u14ykxUp45Hw==
=EjL4
-----END PGP SIGNATURE-----

--Bn2qDywVDG+wY4Xx--

