Date: Thu, 6 Oct 2022 21:06:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yz8nU3pSzidhjL/F@...1296...>
References: <20220624104940.2885435-1-wardragon78@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EIP0+f5uuenoHA8O"
Content-Disposition: inline
In-Reply-To: <20220624104940.2885435-1-wardragon78@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Insert client connection data into
 PAM environment v2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Paolo Cerrito <wardragon78@...277...>
Cc: openvpn-devel@lists.sourceforge.net, paolo <paolo.cerrito@...2517...>

--EIP0+f5uuenoHA8O
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

sorry for not handling this in a more timely fashion.  It needs some
changes, though.

On Fri, Jun 24, 2022 at 12:49:41PM +0200, Paolo Cerrito wrote:
> From: paolo <paolo.cerrito@...2517...>
>=20
> "Changes from v1:
> changed sprintf for logging to plugin_log
> "
>=20
> change to reflect current head openvpn repository
>=20
> this patch put remote host ip into pam environment, so this make pam
> module able to use it.
>=20
> in simple, this patch get ip (ipv4 and ipv6) from openvpn, put into pam
> environment and log this operation.

When committing, please use "git commit -s", so the patch gets your
signed-off-by: line.

> ---
>  src/plugins/auth-pam/auth-pam.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-=
pam.c
> index 70339445..c2e66e5c 100644
> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -49,7 +49,7 @@
>  #include <syslog.h>
>  #include <limits.h>
>  #include "utils.h"
> -
> +#include <arpa/inet.h>
>  #include <openvpn-plugin.h>
>=20=20
>  #define DEBUG(verb) ((verb) >=3D 4)
> @@ -121,6 +121,7 @@ struct user_pass {
>      char password[128];
>      char common_name[128];
>      char response[128];
> +    char remote[INET6_ADDRSTRLEN];
>=20=20
>      const struct name_value_list *name_value_list;
>  };
> @@ -529,6 +530,11 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handl=
e, const int type, const cha
>          const char *username =3D get_env("username", envp);
>          const char *password =3D get_env("password", envp);
>          const char *common_name =3D get_env("common_name", envp) ? get_e=
nv("common_name", envp) : "";
> +        const char *remote =3D get_env("untrusted_ip6", envp);
> +
> +        if (remote =3D=3D NULL){
> +                remote =3D get_env("untrusted_ip", envp); //if Null, try=
 to take ipv4 if not set ipv6
> +        }

Please follow the OpenVPN coding style:

+        if (remote =3D=3D NULL)
+        {
+            /*  if Null, try to take ipv4 if not set ipv6 */
+            remote =3D get_env("untrusted_ip", envp);
+        }

(opening "{" is on a new line, always, and 4 space indent, and no // C++
comments)

This also needs some way to handle the case that neither untrusted_ip6
nor untrusted_ip is set (which might be due to changes on the OpenVPN
side) - with your v2 patch, this will pass NULL to send_string(),=20
and then it will crash.

You could do

  remote =3D "";

to make it point to an empty string...

> @@ -789,8 +796,16 @@ pam_auth(const char *service, const struct user_pass=
 *up)
>      status =3D pam_start(service, name_value_list_provided ? NULL : up->=
username, &conv, &pamh);
>      if (status =3D=3D PAM_SUCCESS)
>      {
> +        /* Set PAM_RHOST environment variable */
> +        if (*(up->remote))
> +        {
> +            status =3D pam_set_item(pamh, PAM_RHOST, up->remote);
> +        }

... which would work nicely together with this check for a non-empty
string on the other end of the pipeline.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--EIP0+f5uuenoHA8O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjPydTAAoJEB2Cnv7KVigSI0AL/RJv1wEZglmxjzwLdLdHwF4S
UxQ1q5zav2yt/BvYGY+4P9O3lTjiOW5lm/4n42PbYe28AuI/G3T5AKJZKn8sCMPE
6K/f6pvH0KsF7ekgpDdoE+fkn898s89DBGoyzNDFTyGZiPaTr3AANnB7sxmcuUeO
CJ5BN2nZWwbA/GeMXast1o4RrqPDiMbyvF6eYne/nfUoUahB8HrDdCn6vG5DU/gk
vKgP2i/Eqj1DdwH3VJiJtV7/JZ/kIcV1Dcg1nefTzBgGuV6S2ERiH84aMfBNlUjq
ZBWhhN+kMirVKrn2xg5m1Anu97VSlD656ZVTORpcyKmMosaoBuff6xAWIpFByUaE
nm3FLUSs/YQOGYX23R2SCXARJmaz4/QqAWuKdFjV+SMuErMcabqjEJXkV1+pfDzt
lxcIWwqO25sjn4OOGS6fyvnVcznT0nqDmMxCoPmFKYKshXR5rBVzaAmp3Jbr/NJY
0AWX50gE6DXN2F3BpXZRsPlRSQHTl8GFf1gyEH0rHg==
=3zQ8
-----END PGP SIGNATURE-----

--EIP0+f5uuenoHA8O--

