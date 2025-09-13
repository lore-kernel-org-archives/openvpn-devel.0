Date: Sat, 13 Sep 2025 22:41:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aMXW3jwQJ9TyvOae@...1296...>
References: <65233605-9738-4B2C-8401-37AA5C43D797@...2913...>
 <aMWo1HvleNGzIEDO@...1296...>
 <E4C462D1-FB86-40BE-B218-C0242E946FFD@...2913...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="z7yLDQ2PjZg0RMS/"
Content-Disposition: inline
In-Reply-To: <E4C462D1-FB86-40BE-B218-C0242E946FFD@...2913...>
Subject: Re: [Openvpn-devel] [PATCH] Bugfix: Set broadcast address on
 interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Sebastian Marsching <sebastian@...2913...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--z7yLDQ2PjZg0RMS/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 13, 2025 at 10:10:41PM +0200, Sebastian Marsching wrote:
> Thanks for pointing me to the netbits_to_netmask function. Using this fun=
ction, the code looks so much cleaner. See the updated patch below.

Close...

> @@ -760,6 +761,7 @@ sitnl_addr_set(int cmd, uint32_t flags, int ifindex, =
sa_family_t af_family,
>  {
>      struct sitnl_addr_req req;
>      uint32_t size;
> +    inet_address_t broadcast;
>      int ret =3D -EINVAL;
>=20=20
>      CLEAR(req);
> @@ -803,6 +805,13 @@ sitnl_addr_set(int cmd, uint32_t flags, int ifindex,=
 sa_family_t af_family,
>          SITNL_ADDATTR(&req.n, sizeof(req), IFA_LOCAL, local, size);
>      }
>=20=20
> +    if (af_family =3D=3D AF_INET && local && !remote && prefixlen <=3D 3=
0)
> +    {
> +        broadcast =3D *local;
> +        broadcast.ipv4 |=3D htonl(~netbits_to_netmask(prefixlen));
> +        SITNL_ADDATTR(&req.n, sizeof(req), IFA_BROADCAST, &broadcast, si=
ze);

... but we do want local-scoped things to be declared locally (C99), so

  +        inet_address_t broadcast =3D *local;

here (SITNL_ADDATTR() will copy the struct content, not the reference).

When sending a v3, can you send that with "git send-email -v3" in
its own mail, "--in-reply-to <this_thread>"?  This makes it easy to
see which version is the latest.

thanks,

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--z7yLDQ2PjZg0RMS/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJoxdbeAAoJEB2Cnv7KVigS3o8MAJuUI0QXI61iyvGrQZFyoyjb
TC100Q5rMS67j7RHEmLYwarYyiydo3n39c+rrQzHGS9UUphq8X2uE8hM2FDSR1o4
lyl70UKHV4jGJh7RMQ5Y3BAuhJTNXYbvJgDiySv6PB0vnD8xybg1Kq+myWdYz2Q/
1aXhE6J0aBiQtBhvWpIoA/h8+thhc5GwALI7NnVqlT3M491HLleWZ4arrubOZEYD
NhwPlPJnNTw9WqKhfNwV6UqcnIL+R8Ru7Cg3gnCysC4Ha3qW861KjUjQVH9/psmX
SMYGKI3n+ujbQBvHgmv7b13gi0YcedNA1cwjhZcYNTKggls+4n77hHLieIsK/8pR
L/K86KBWS11URKPaf05N/kpbgsuPlHE5cj+69Jc3J6doy11RrBuKWsK6/Lba1VHJ
TqGY1k+C9DtApmYfVbS1DdOyOdUeDsP+9ONwsFsKWWa0JBlNbC5OzCIRM9Eu/E4W
3EmX262hNs9hv8BNUGGjLcwMH1OjkjMQUVZgAfZvKA==
=YBgi
-----END PGP SIGNATURE-----

--z7yLDQ2PjZg0RMS/--

