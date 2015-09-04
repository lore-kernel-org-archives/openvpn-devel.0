Date: Fri, 4 Sep 2015 22:55:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150904205551.GF34798@...1296...>
References: <1440541753-9172-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f9lFb+Z4UT82L8vr"
Content-Disposition: inline
In-Reply-To: <1440541753-9172-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Add missing strdup() return value checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--f9lFb+Z4UT82L8vr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 26, 2015 at 12:29:13AM +0200, Steffan Karger wrote:
> As reported by Bill Parker in trac #600, strdup() return values are not
> always correctly checked for failed allocations.  This patch adds missing
> checks.
>=20
> Note that in misc.c and options.c, the check is after the dirname() or
> basename() call, because these can deal with NULL params and we need to
> keep MSVC happy with its ancient no-declaration-after-statement policy.

Even though Arne has already ACKed it, I'm not merging it - I started
merging it today, but the more I stare at the code, the more I'm convinced
that we should just get rid of strdup() instead and/or the code is not
needed.

Why...?  Let me comment...

> diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
> index b7fc11e..62f30be 100644
> --- a/src/openvpn/cryptoapi.c
> +++ b/src/openvpn/cryptoapi.c
> @@ -127,6 +127,7 @@ static char *ms_error_text(DWORD ms_err)
>  		    break;
>  	    }
>      }
> +    check_malloc_return(rv);
>      return rv;
>  }

This is not needed, as the code does

        rv =3D strdup(lpMsgBuf);
        LocalFree(lpMsgBuf);
        /* trim to the left */
        if (rv)
            for (p =3D rv + strlen(rv) - 1; p >=3D rv; p--) {
                if (isspace(*p))
                    *p =3D '\0';
                else
                    break;
            }
    }
    return rv;

... so if the strdup() fails, the function falls into "return NULL",
which is the same return value as for "if (!lpMsgBuf)", so I assume
the caller expects this - with the extra check, a failure in
FormatMessage() would be flagged as memory allocation failure (because
rv is set to NULL at start), which it isn't.

So, just not needed.

> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index b7c153b..0809cc7 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -817,6 +817,7 @@ init_options_dev (struct options *options)
>  {
>    if (!options->dev && options->dev_node) {
>      char *dev_node =3D strdup(options->dev_node); /* POSIX basename() im=
plementaions may modify its arguments */
> +    check_malloc_return(dev_node);
>      options->dev =3D basename (dev_node);
>    }
>  }

I'd need to look into this in more detail, but I think we never modify
options->dev_node afterward - so a simple strrchr() to find the "/" and
point options->dev there might be sufficient... but if it actually needs
to be a true copy, we should just use=20

  char *dev_node =3D string_alloc(options->dev_node, NULL)

instead - string_alloc() is OpenVPN's strdup(), and "NULL" tells it
"do not use gc, use calloc" (side note: someone seriously overengineered
the "we really want clean memory!" bit here - allocating <n> bytes and
immediately overwriting with a n-byte memcpy() should be good enough,
no?) - *and* string_alloc() actually does...

      if (gc) {
...
      } else {
        ret =3D calloc(1, n);
        check_malloc_return(ret);
      }
      memcpy (ret, str, n);

... so the check_malloc_return() is built-in.


> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index a5bad0d..b543b65 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -1608,6 +1608,7 @@ argv_extract_cmd_name (const char *path)
>      {
>        char *path_cp =3D strdup(path); /* POSIX basename() implementaions=
 may modify its arguments */
>        const char *bn =3D basename (path_cp);
> +      check_malloc_return(path_cp);
>        if (bn)
>  	{
>  	  char *ret =3D string_alloc (bn, NULL);

This is totally weird code, using strdup() first, and then string_alloc()
later, inside an "if (bn)" check on a variable that will never be NULL
anyway, since basename(NULL) is documented to return "." - and it very
much looks like two different persons wrote this part :-)

Dunno, this really smells like refactor the function to use strrchr()
on the original path, and then use string_alloc($ptr, NULL) to make
a copy of that... throw out the if(bn) block, and be done...  or just
change the strdup() to string_alloc() as well.


> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 2784580..dba7c9d 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2588,6 +2588,7 @@ check_file_access(const int type, const char *file,=
 const int mode, const char *
>      {
>        char *fullpath =3D strdup(file);  /* POSIX dirname() implementaion=
 may modify its arguments */
>        char *dirpath =3D dirname(fullpath);
> +      check_malloc_return(fullpath);
>=20=20
>        if (platform_access (dirpath, mode|X_OK) !=3D 0)
>            errcode =3D errno;

string_alloc()  (pity we do not have a gc around here :-) )

> diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
> index 3fc811e..673dbbe 100644
> --- a/src/openvpn/ssl_polarssl.c
> +++ b/src/openvpn/ssl_polarssl.c
> @@ -198,6 +198,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, co=
nst char *ciphers)
>    /* Parse allowed ciphers, getting IDs */
>    i =3D 0;
>    tmp_ciphers_orig =3D tmp_ciphers =3D strdup(ciphers);
> +  check_malloc_return(tmp_ciphers);
>=20=20
>    token =3D strtok (tmp_ciphers, ":");
>    while(token)

I could mention string_alloc() again, but I'm sure interested readers
already recognize the pattern :-))

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--f9lFb+Z4UT82L8vr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVeoFVqkuBuNlUUl1AQIlgQQAryyWbvG1x28VGpb5+GQjYNCEX8BqhxbK
8aEfY5NrmAKTEI6oBGcC9accxiTS8B5aZHRe/tcRH9DL0ULJcgmY8GCtguTzm1rA
urUo42N6IMA7WDieP0lppsg+ZYQqhYwiat+qyBHgyl1K/f/9aiIoO7Drqngjcfy4
FP1qq3eRkOQ=
=4Dio
-----END PGP SIGNATURE-----

--f9lFb+Z4UT82L8vr--

