Date: Mon, 16 Dec 2013 21:59:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131216205912.GP161@...1296...>
References: <1387221007-17736-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+Zda2Xvr9MtBV5S"
Content-Disposition: inline
In-Reply-To: <1387221007-17736-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add warning for using connection block
	variables after connection blocks
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

--R+Zda2Xvr9MtBV5S
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 16, 2013 at 08:10:07PM +0100, Arne Schwabe wrote:
> In 2.3  some options that were allowed only in global config before have =
been moved to connection blocks. This changes the behaviour if the variable=
s were defined after connection block. This patch adds a warning to catch t=
hese mistakes.
> ---

Basically, I'm OK with that, just a few things...

> diff --git a/src/openvpn/common.h b/src/openvpn/common.h
> index 2f85bec..4f32ef1 100644
> --- a/src/openvpn/common.h
> +++ b/src/openvpn/common.h
> @@ -98,6 +98,11 @@ typedef unsigned long ptr_type;
>  #define INLINE_FILE_TAG "[[INLINE]]"
>=20=20
>  /*
> + * Pseudo filename for connection blocks=20
> + */
> +#define CONNECTION_FILE_TAG "[CONNECTION-OPTIONS]"
> +

... as this is only referenced once, is it really worth adding a #define
which is about as long as the string it's replacing?

> +/*
>   * Script security warning
>   */
>  #define SCRIPT_SECURITY_WARNING "WARNING: External program may not be ca=
lled unless '--script-security 2' or higher is enabled. See --help text or =
man page for detailed info."
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 07a9b89..4066a67 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3465,7 +3465,7 @@ int
>  parse_line (const char *line,
>  	    char *p[],
>  	    const int n,
> -	    const char *file,
> +const char *file,

Yeah, whitespace :-) (I can fix that).

>  	    const int line_num,
>  	    int msglevel,
>  	    struct gc_arena *gc)
> @@ -3805,7 +3805,7 @@ read_config_string (const char *prefix,
>  	{
>  	  bypass_doubledash (&p[0]);
>  	  check_inline_file_via_buf (&multiline, p, &options->gc);
> -	  add_option (options, p, NULL, line_num, 0, msglevel, permission_mask,=
 option_types_found, es);
> +	  add_option (options, p, prefix, line_num, 0, msglevel, permission_mas=
k, option_types_found, es);
>  	}

Is that "NULL" a generic oversight?  It doesn't seem like it's needed
for the new functionality, more like "it should have been like that",=20
right?   (Ah, I can see it now, we want it to not print "[CMD-LINE]"=20
for these cases, right?)


>        CLEAR (p);
>      }
> @@ -3925,27 +3925,43 @@ void options_string_import (struct options *optio=
ns,
>=20=20
>  #if P2MP
>=20=20
> -#define VERIFY_PERMISSION(mask) { if (!verify_permission(p[0], file, (ma=
sk), permission_mask, option_types_found, msglevel)) goto err; }
> +#define VERIFY_PERMISSION(mask) { if (!verify_permission(p[0], file, lin=
e, (mask), permission_mask, option_types_found, msglevel, options)) goto er=
r; }
>=20=20
>  static bool
>  verify_permission (const char *name,
>  		   const char* file,
> +		   int line,
>  		   const unsigned int type,
>  		   const unsigned int allowed,
>  		   unsigned int *found,
> -		   const int msglevel)
> +		   const int msglevel,
> +		   struct options* options)
>  {
>    if (!(type & allowed))
>      {
>        msg (msglevel, "option '%s' cannot be used in this context (%s)", =
name, file);
>        return false;
>      }
> -  else
> +
> +  if (found)
> +    *found |=3D type;
> +
> +#ifndef ENABLE_SMALL
> +  /* Check if this options is allowed in connection block,
> +   * but we are currently not in a connection block
> +   * Parsing a connection block uses a temporary options struct without
> +   * connection_list
> +   */
> +
> +  if ((type & OPT_P_CONNECTION) && options->connection_list)
>      {
> -      if (found)
> -	*found |=3D type;
> -      return true;
> +      if (file)
> +	msg (M_WARN, "Option '%s' in %s:%d is ignored by previous <connection> =
blocks ", name, file, line);
> +      else
> +	msg (M_WARN, "Option '%s' is ignored by previous <connection> blocks", =
name);
>      }
> +#endif
> +  return true;
>  }

OK :-)

(This is actually not changing the "if (*found)..." logic, it just looks
that way due to the way git diff sometimes produces patches where=20
whitespace changes close to code additions...)

>  #else
> @@ -4377,7 +4393,7 @@ add_option (struct options *options,
>=20=20
>  	  init_options (&sub, true);
>  	  sub.ce =3D options->ce;
> -	  read_config_string ("[CONNECTION-OPTIONS]", &sub, p[2], msglevel, OPT=
_P_CONNECTION, option_types_found, es);
> +	  read_config_string (CONNECTION_FILE_TAG, &sub, p[2], msglevel, OPT_P_=
CONNECTION, option_types_found, es);
>  	  if (!sub.ce.remote)
>  	    {
>  	      msg (msglevel, "Each 'connection' block must contain exactly one =
'remote' directive");

... see above...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--R+Zda2Xvr9MtBV5S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUq9poKkuBuNlUUl1AQKpDgP/R3G+XU/gTOXCdfpLqvGIcWDctQhZyEIF
N6S2w8P+CJ/dAtz4tzUN3wucGdrRyaACP2BmbPct6acxImuN4Uf61OyMju38ODfB
aC65sWWV77JRH2U2B8QjAzDH/skZTp/z5CROFYF5Wac0a6ogxufzXqRp6MBkZepa
N2P7cuthQDk=
=m9xK
-----END PGP SIGNATURE-----

--R+Zda2Xvr9MtBV5S--

