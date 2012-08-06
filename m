Message-ID: <501FBA69.4010102@...1114...>
Date: Mon, 06 Aug 2012 14:36:57 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1343837470-3923-2-git-send-email-arne@...1227...>
	<1343914668-10696-1-git-send-email-arne@...1227...>
In-Reply-To: <1343914668-10696-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig89E6EA23F8D02324EDF1D7CD"
Subject: Re: [Openvpn-devel] [PATCH 1/4] Fixes error: --key fails with
 EXTERNAL_PRIVATE_KEY: No such file or directory if
 --management-external-key is used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig89E6EA23F8D02324EDF1D7CD
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 02/08/12 15:37, Arne Schwabe wrote:
> Warn if both options are used at the same time.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/options.c |   17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 9f4ddbb..39dceb8 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1581,6 +1581,12 @@ show_settings (const struct options *o)
>    SHOW_STR (ca_path);
>    SHOW_STR (dh_file);
>    SHOW_STR (cert_file);
> +
> +#ifdef MANAGMENT_EXTERNAL_KEY
> +  if((options->management_flags & MF_EXTERNAL_KEY))
> +	SHOW_PARM ("priv_key_file","EXTERNAL_PRIVATE_KEY","%s");
> +  else=20
> +#endif

Please test compile without any special ./configure settings too before sub=
mitting patches ;-)  The piece of code above won't compile.  Look at the fu=
nction declaration, it's not 'options' but 'o' which needs to be used.  Thi=
s time I fixed it before pushing out the patch, just because it was too sim=
ple fix to insist on another patch.

So, applied to master - with a minor fix :)


commit 4806cc102655f1a829d656f6deb83e5953c5eab2
Author: Arne Schwabe <arne@...1227...>
Date:   Thu Aug 2 15:37:48 2012 +0200

    Fixes error: --key fails with EXTERNAL_PRIVATE_KEY: No such file or dir=
ectory if --management-external-key is used
=20=20=20=20=20=20=20=20
    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1343914668-10696-1-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6943


kind regards,

David Sommerseth


--------------enig89E6EA23F8D02324EDF1D7CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAfumkACgkQDC186MBRfrqU3gCfdBYPUlZ23qYv3VXkqI/NnFIZ
27cAoJ7H4Ygyy2QNtnbx0eiH74Oazino
=7QOm
-----END PGP SIGNATURE-----

--------------enig89E6EA23F8D02324EDF1D7CD--

