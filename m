Date: Mon, 8 Oct 2018 19:52:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181008175242.GS962@...1296...>
References: <1539016554-23503-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/z4P6UMu7uOEsbeQ"
Content-Disposition: inline
In-Reply-To: <1539016554-23503-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] interactive.c: fix usage of potentially
 uninitialized variable
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--/z4P6UMu7uOEsbeQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 08, 2018 at 07:35:54PM +0300, Lev Stipakov wrote:
> @@ -1350,7 +1354,7 @@ RunOpenvpn(LPVOID p)
>  {
>      HANDLE pipe =3D p;
>      HANDLE ovpn_pipe, svc_pipe;
> -    PTOKEN_USER svc_user, ovpn_user;
> +    PTOKEN_USER svc_user =3D NULL, ovpn_user =3D NULL;
>      HANDLE svc_token =3D NULL, imp_token =3D NULL, pri_token =3D NULL;
>      HANDLE stdin_read =3D NULL, stdin_write =3D NULL;
>      HANDLE stdout_write =3D NULL;

Oh, another nag for v2 :-) - if you initialize these to NULL here
at the top, the lines

    svc_user =3D NULL;
...
    ovpn_user =3D NULL;

further down could go...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/z4P6UMu7uOEsbeQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbu5lqAAoJEB2Cnv7KVigSPRcL/1cS2JwWmD6HvuAlfZj5nCHn
ZwH+jWFUfl0x9N4/Z42/0nUhS9GkL/hQ6GB6kXJ4KKtCOqKcY4iMx1lWnz/5qwOJ
iQhqOZYzpKe1CVxEhsdQ5SlLn4ndhlYEuhZIuE6XnbReVnVtVIaaHJrjoEgx1srl
UuET+Nka0MtxBPIpCIAQnzZJ1D1KxAsXa4l1WO/pRAs44G6V2XpAyE+tohl3te2i
K5BBHCDNLT25keo5MbNLvDRLVDQ4Pn0xv99s/ZdReCcWPjmVliBkyJ19tjuqnkPY
vSiyEd+fL6GYLA8q3PHQ+JQHULw5w1nnNqTm114fuvRmg+zgrnTUy5j8tCbI3vvX
+93THDJYy15P8/n9VmzHgq/4nG7ehKe2EWA0hDWnLAjYn09cQPxA2pw9UAO25KRz
NSNnQBWoK6tmyQ3tiyx4AKKlCRilUD6IWumjAuNKoqqVkNom+bhG3hrx201BSjmU
E94knI/tKI6RpxoW6LkO5RAcW4WoRzRPPBEcqcq5iQ==
=AgSq
-----END PGP SIGNATURE-----

--/z4P6UMu7uOEsbeQ--

