Message-ID: <4F3271DB.4030901@...515...>
Date: Wed, 08 Feb 2012 15:00:11 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1328612333-10321-1-git-send-email-davids@...1347...>
	<1328621508-18076-1-git-send-email-davids@...1347...>
In-Reply-To: <1328621508-18076-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix assert() situations where
 gc_malloc() is called without a gc_arena object
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <davids@...1347...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I give this one a feature-ACK as it seems to fix the buffer.c line 313
issue:

<http://thread.gmane.org/gmane.network.openvpn.devel/5346>

All the best,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> In commit bee92b479414d12035b0422f81ac5fcfe14fa645 the gc_malloc() was ha=
rdened
> to always require a gc_arena object for garbage collection.  Some places =
in the
> code expected the old behaviour of a normal malloc() in these cases, that=
 is a
> memory allocation without garbage collection.
>
> This old behaviour is partly restored by allowing string_alloc() to do a =
non-gc
> based allocation if no gc_arena object is available.  In addition some ot=
her
> places string_alloc() will now be called with a gc_arena pointer where su=
ch an
> object is available.
>
> The alloc_buf() function has also been refactored to not use gc_malloc() =
at
> all.
>
> v2: - removes a memleak when --ifconfig-ipv6 is used several times
>     - makes string_alloc() behave properly if DMALLOC is enabled
>
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  buffer.c     |   32 ++++++++++++++++++++++++++++----
>  init.c       |    2 +-
>  openvpn.c    |    2 +-
>  options.c    |    7 ++++++-
>  pf.c         |    2 +-
>  ssl_verify.c |    2 ++
>  6 files changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/buffer.c b/buffer.c
> index c39bbcb..fca6a90 100644
> --- a/buffer.c
> +++ b/buffer.c
> @@ -54,11 +54,21 @@ alloc_buf_debug (size_t size, const char *file, int l=
ine)
>  alloc_buf (size_t size)
>  #endif
>  {
> +  struct buffer buf;
> +
> +  if (!buf_size_valid (size))
> +    buf_size_error (size);
> +  buf.capacity =3D (int)size;
> +  buf.offset =3D 0;
> +  buf.len =3D 0;
>  #ifdef DMALLOC
> -  return alloc_buf_gc_debug (size, NULL, file, line);
> +  buf.data =3D openvpn_dmalloc (file, line, size);
>  #else
> -  return alloc_buf_gc (size, NULL);
> +  buf.data =3D calloc (1, size);
>  #endif
> +  check_malloc_return(buf.data);
> +
> +  return buf;
>  }
>=20=20
>  struct buffer
> @@ -515,11 +525,25 @@ string_alloc (const char *str, struct gc_arena *gc)
>        const int n =3D strlen (str) + 1;
>        char *ret;
>=20=20
> +      if (gc) {
> +#ifdef DMALLOC
> +        ret =3D (char *) gc_malloc_debug (n, false, gc, file, line);
> +#else
> +        ret =3D (char *) gc_malloc (n, false, gc);
> +#endif
> +      } else {
> +        /* If there are no garbage collector available, it's expected
> +         * that the caller cleans up afterwards.  This is coherent with =
the
> +         * earlier behaviour when gc_malloc() would be called with gc =
=3D=3D NULL
> +         */
>  #ifdef DMALLOC
> -      ret =3D (char *) gc_malloc_debug (n, false, gc, file, line);
> +        ret =3D openvpn_dmalloc (file, line, n);
> +        memset(ret, 0, n);
>  #else
> -      ret =3D (char *) gc_malloc (n, false, gc);
> +        ret =3D calloc(1, n);
>  #endif
> +        check_malloc_return(ret);
> +      }
>        memcpy (ret, str, n);
>        return ret;
>      }
> diff --git a/init.c b/init.c
> index 525f441..f0c3693 100644
> --- a/init.c
> +++ b/init.c
> @@ -3012,7 +3012,7 @@ do_close_ifconfig_pool_persist (struct context *c)
>  static void
>  do_inherit_env (struct context *c, const struct env_set *src)
>  {
> -  c->c2.es =3D env_set_create (NULL);
> +  c->c2.es =3D env_set_create (&c->c2.gc);
>    c->c2.es_owned =3D true;
>    env_set_inherit (c->c2.es, src);
>  }
> diff --git a/openvpn.c b/openvpn.c
> index f5f2bce..84289d2 100644
> --- a/openvpn.c
> +++ b/openvpn.c
> @@ -164,7 +164,7 @@ main (int argc, char *argv[])
>  	  gc_init (&c.gc);
>=20=20
>  	  /* initialize environmental variable store */
> -	  c.es =3D env_set_create (NULL);
> +	  c.es =3D env_set_create (&c.gc);
>  #ifdef WIN32
>  	  set_win_sys_path_via_env (c.es);
>  #endif
> diff --git a/options.c b/options.c
> index 6b8ae22..a0b3431 100644
> --- a/options.c
> +++ b/options.c
> @@ -4291,7 +4291,7 @@ add_option (struct options *options,
>      {
>        unsigned int netbits;
>        char * ipv6_local;
> -=09
> +
>        VERIFY_PERMISSION (OPT_P_UP);
>        if ( get_ipv6_addr( p[1], NULL, &netbits, &ipv6_local, msglevel ) =
&&
>             ipv6_addr_safe( p[2] ) )
> @@ -4301,6 +4301,11 @@ add_option (struct options *options,
>  	      msg( msglevel, "ifconfig-ipv6: /netbits must be between 64 and 12=
4, not '/%d'", netbits );
>  	      goto err;
>  	    }
> +
> +          if (options->ifconfig_ipv6_local)
> +            /* explicitly ignoring this is a const char */
> +            free ((char *) options->ifconfig_ipv6_local);
> +
>  	  options->ifconfig_ipv6_local =3D ipv6_local;
>  	  options->ifconfig_ipv6_netbits =3D netbits;
>  	  options->ifconfig_ipv6_remote =3D p[2];
> diff --git a/pf.c b/pf.c
> index 6b4cba4..79915fa 100644
> --- a/pf.c
> +++ b/pf.c
> @@ -566,7 +566,7 @@ pf_init_context (struct context *c)
>          if (plugin_call (c->plugins, OPENVPN_PLUGIN_ENABLE_PF, NULL, NUL=
L, c->c2.es) =3D=3D OPENVPN_PLUGIN_FUNC_SUCCESS)
>            {
>              event_timeout_init (&c->c2.pf.reload, 1, now);
> -            c->c2.pf.filename =3D string_alloc (pf_file, NULL);
> +            c->c2.pf.filename =3D string_alloc (pf_file, &c->c2.gc);
>              c->c2.pf.enabled =3D true;
>  #ifdef ENABLE_DEBUG
>              if (check_debug_level (D_PF_DEBUG))
> diff --git a/ssl_verify.c b/ssl_verify.c
> index e45f149..37d4982 100644
> --- a/ssl_verify.c
> +++ b/ssl_verify.c
> @@ -83,6 +83,7 @@ set_common_name (struct tls_session *session, const cha=
r *common_name)
>      }
>    if (common_name)
>      {
> +      /* FIXME: Last alloc will never be freed */
>        session->common_name =3D string_alloc (common_name, NULL);
>  #ifdef ENABLE_PF
>        {
> @@ -703,6 +704,7 @@ man_def_auth_set_client_reason (struct tls_multi *mul=
ti, const char *client_reas
>        multi->client_reason =3D NULL;
>      }
>    if (client_reason && strlen (client_reason))
> +    /* FIXME: Last alloc will never be freed */
>      multi->client_reason =3D string_alloc (client_reason, NULL);
>  }
>=20=20



