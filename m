Date: Mon, 6 Jun 2022 18:26:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yp4qt6MI1fDnUGDI@...1296...>
References: <20220606103144.1988077-1-wardragon78@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Cv7H98a/THNUypf6"
Content-Disposition: inline
In-Reply-To: <20220606103144.1988077-1-wardragon78@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Single patch:
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Paolo Cerrito <wardragon78@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--Cv7H98a/THNUypf6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 06, 2022 at 12:31:43PM +0200, Paolo Cerrito wrote:
> 1) changed lenght of remote to 46
>=20
> 2) refactored call to get_env
> ---
>  src/plugins/auth-pam/auth-pam.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-=
pam.c
> index 9d8dfb95..c03e178b 100644
> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -48,7 +48,7 @@
>  #include <signal.h>
>  #include <syslog.h>
>  #include "utils.h"
> -
> +#include <arpa/inet.h>
>  #include <openvpn-plugin.h>
>=20=20
>  #define DEBUG(verb) ((verb) >=3D 4)
> @@ -115,7 +115,7 @@ struct user_pass {
>      char password[128];
>      char common_name[128];
>      char response[128];
> -    char remote[128];
> +    char remote[INET6_ADDRSTRLEN];

This seems to be the second patch only (the changes according to the
comments received).

Please combine all changes into a single patch, and do also include
a commit message that describes the overall change.

(To combine multiple patches into one, look at "git rebase --interactive"
and "squash")

Part of the reason we do this review dance is that we want patches that
are all "good in itself", not "need a second patch to fix the first one".

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

--Cv7H98a/THNUypf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiniq3AAoJEB2Cnv7KVigSePcL/j9blaA9K82VIvf1D+Cq+4hf
fFc6I7utIvjdyuZ+cGHHg5UKnTio+nMcXprUVksYlhesk7GKT0X5Y5oD9AxAQTbZ
mjAuxJIqUEqv2zanUs9oMz3G3ZuJmBra4GfewoPKpkw4bBUJFa0+KOBFEoW8Gjhz
Xy46UMIw1/gQn4LVLpBDu3/8seMP0xukIJDFe4DgsyCTqzvAYpnhBRjQSsHG2GUQ
l6Q8pxOOGLTg8uS+6AUBJjHMJrve7efjm5gC3Dg7kVmKwwOYNl0J//R9mf2FE0jS
fKqsJ51gbVORgIrzgLq7GFfyE/da3uJ0tVfPyfoqwIy5JbaLKBlCTYxHMB5r6ncZ
0yxCXaNqKLAib3I3hD+FWWEyiIS8R15VhD4mqEef4b4nfJ80lUjTpDgxW5EAj519
sdUqw2vkpfi2dRBYaMCJ7bw53dNytjeZrCfVKqWE8okltc9i/4QawjdPIfTPXDhy
2cbZWQTxwOuAIn08liY9Dq0GjBLXBBhv5L9lGta4mA==
=ccge
-----END PGP SIGNATURE-----

--Cv7H98a/THNUypf6--

