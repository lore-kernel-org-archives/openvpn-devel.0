Date: Mon, 15 May 2023 18:34:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZGJfHDGxW9bA2LVR@...1296...>
References: <20230515155339.38600-1-frank@...2641...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ioeTNTd3bTMtFW3P"
Content-Disposition: inline
In-Reply-To: <20230515155339.38600-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] sample-plugins: Fix memleak in
 client-connect example plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--ioeTNTd3bTMtFW3P
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 15, 2023 at 05:53:39PM +0200, Frank Lichtenheld wrote:
> I was looking for memleaks in the code and found
> this one with cppcheck. Only an example, but no
> need to leave this bug in it.
>=20
> Also fix fortify problem in keying-material-exporter-demo
> so I can actually test the compilation of the sample
> plugins.
>=20
> Change-Id: Ibd1b282afc4a28768be3f165f84ab60ca4d24a9b
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  .../sample-plugins/client-connect/sample-client-connect.c   | 6 ++++++
>  .../keying-material-exporter-demo/keyingmaterialexporter.c  | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c=
 b/sample/sample-plugins/client-connect/sample-client-connect.c
> index 391de344..eb242126 100644
> --- a/sample/sample-plugins/client-connect/sample-client-connect.c
> +++ b/sample/sample-plugins/client-connect/sample-client-connect.c
> @@ -454,6 +454,9 @@ openvpn_plugin_client_connect_v2(struct plugin_contex=
t *context,
>      if (!rl->name || !rl->value)
>      {
>          plugin_log(PLOG_ERR, MODULE, "malloc(return_list->xx) failed");
> +        free(rl->name);
> +        free(rl->value);
> +        free(rl);

ACK on that part..

> @@ -155,7 +155,7 @@ session_user_set(struct session *sess, X509 *x509)
>=20=20
>          if (!strncasecmp(objbuf, "CN", 2))
>          {
> -            snprintf(sess->user, sizeof(sess->user) - 1, (char *)buf);
> +            snprintf(sess->user, sizeof(sess->user) - 1, "%s", (char *)b=
uf);
>          }

... but adding "%s" to something that shouldn't have been an snprintf()
in the first place feels wrong.  Don't we have strncpy() or something
for "copy a string over to a limited buffer, and null-terminate"?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ioeTNTd3bTMtFW3P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkYl8cAAoJEB2Cnv7KVigSYU4L+gKlahrKCGE3QNsjmDOABc1b
jKfWFdbXeszf9ppwan1eYYC+wbazmsEyffBPW8huuP/kagDNOVt8NsHoErmS2l4c
S3NzDSYrj8oL0tlywaFnDNIDs0M/h8ISWW/yEPZXZ671Z3z8o1Qt1QcZaLME/gJ1
suenZoDkfb01Y/wrCaXy/VEJZIz0vVphSzzdRPM7t2FBZoDEZgsXERkHZGY1TmLQ
ZoVTliIg6s48xXFoTWkgv+fYvr65g1ZlAo2mZlIq5w9TUuoimGELFX2ufNRO3GF0
Gu3jih4WLgcqnEIdwgQeSqwqnS5Gd0oG3tkFbV8BwOri0ccD67a5F83RItehh7Ek
IrmtGUvpZnObNKQz2uoabxnQZY+At6ylo16LA52SMZFMEi+qspBk8+5t8WlMLe9j
mG7LQ8PxtNRfYzqzhzKkC6RR6sJlUz8dF8j+uxKZ/VlbOhjLERn/6Z3qRMxepJ4Z
kLnMBsrbzFBQvoJFTixOV1cwqa1vfpUaEVdN5Z5r4Q==
=8BfR
-----END PGP SIGNATURE-----

--ioeTNTd3bTMtFW3P--

