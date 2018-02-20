Date: Tue, 20 Feb 2018 09:20:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180220082043.GC69387@...1296...>
References: <1519071994-20797-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9BaxaTZrvsRxcpDQ"
Content-Disposition: inline
In-Reply-To: <1519071994-20797-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix format spec errors in Windows builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--9BaxaTZrvsRxcpDQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 19, 2018 at 03:26:34PM -0500, selva.nair@...277... wrote:
> - In route.c print adapter_index as unsigned int as in the rest
>   of the code.

That one confuses me, but that is most likely me vs. windows types.

adapter_index is declared as "DWORD" in tun.h, and=20

  https://msdn.microsoft.com/en-us/library/cc230318.aspx=20

says that DWORD is "typedef unsigned long DWORD".

Since that particular code is only relevant on windows, why not just
use "%lu" and avoid the cast?


The rest looks reasonable to me, and I'm not strictly opposed to the
adapter_index one, just confused.

(As a side note, I assume that this patch is "master only", and have
not looked at which bits and pieces apply to release/2.4 - the error.c
one does not, because the surrounding code is different, plus, I've
already merged Steffan's patch for error.c to 2.4)

[..]
> @@ -3003,7 +3003,7 @@ do_route_service(const bool add, const route_messag=
e_t *rt, const size_t size, H
>=20=20
>      if (ack.error_number !=3D NO_ERROR)
>      {
> -        msg(M_WARN, "ROUTE: route %s failed using service: %s [status=3D=
%u if_index=3D%lu]",
> +        msg(M_WARN, "ROUTE: route %s failed using service: %s [status=3D=
%u if_index=3D%d]",
>              (add ? "addition" : "deletion"), strerror_win32(ack.error_nu=
mber, &gc),
>              ack.error_number, rt->iface.index);
>          goto out;

That one is correct, but arguably a bit annoying - openvpn-msg.h /=20
struct interface_t uses "int index", which maybe should have been a=20
DWORD to keep the windows types.  Or not?

I wouldn't change the message types, though - as it would introduce
possible compatibility issues between openvpn and iservice (if one=20
ends up having different versions installed and running).

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--9BaxaTZrvsRxcpDQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJai9paAAoJEB2Cnv7KVigSLqoL/iEUPY9FfPirwTyozG2i7AaL
0gTgsGBnIrlXv/jWmiMRFcl0+9yvBT9Qeg7ui9fg3HQJRMhdQpYhJQK0ahmsJjDw
NGCfiVccs9hAvznUrRFY0oXbyGXhkKYPBe97ECcQ5KFNkr5qz56/ESXk5FCEixwU
sDaaBFf2/9nIqMr5GvKAMhWTNRHuF8DpTGHb1a+7WYeN4jVPKo0P5u2aKuBzk3qq
muSmiytnK4ohkNoG8pHryjGJFwLaOu/MHJOVkgEwbu0eGjZefbWrXbC049/g+cem
NpEo8LXhg5olr4aqVIMa14QEU9Wuvnnig3VklF58MWR9B0RI+/KCRXoozV0OZSjl
0hCT6pHcStBbelIrNoYzchBP8x+IflRM8EwBPG0EV7mVsjLLr2WAkzv4e9wvULg1
6Uu/WU2ptaW0aQIa9pfGMd2kYUbouRqYHPGX601/hzEN7LYE8gyfLUh2+Y+tcSI9
d186k72EK+7cf0S4uKVcskcUSagaNSHrQeWblJ0+gg==
=mhzi
-----END PGP SIGNATURE-----

--9BaxaTZrvsRxcpDQ--

