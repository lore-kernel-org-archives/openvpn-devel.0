Date: Tue, 16 Feb 2010 14:58:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100216135813.GA15334@...1296...>
References: <1266272893-23926-1-git-send-email-openvpn.list@...1114...>
Mime-Version: 1.0
In-Reply-To: <1266272893-23926-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Reworked the eurephia patch for
	inclusion to the openvpn-testing tree
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: David Sommerseth <openvpn.list@...1114...>
Cc: David Sommerseth <dazo@...384...>, openvpn-devel@lists.sourceforge.net

Hi,

I can't claim to fully understand the crypto side of things, but from
the "coding standards" and "non-intrusiveness" point of view: ACK.

(All it does is sent an extra environment variable based on the 
content of a well-defined memory buffer, using the APIs already existing
for that purpose, format_hex_ex() and setenv_str())

Someone with a better understanding of the crypto stuff should verify
that the ctx->current_cert->sha1_hash is always valid, and points to
a buffer of the necessary length.

gert


On Mon, Feb 15, 2010 at 11:28:13PM +0100, David Sommerseth wrote:
> From: David Sommerseth <dazo@...384...>
> 
> Addedd configure option (--disable-eurephia) to disable the code which the
> eurephia plug-in depends on.
> 
> It was chosen to use --disable-eurephia, as this patch is not much intrusive.  It
> just enables a SHA1 fingerprint environment variable for each certificate being
> used for the connection.
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  configure.ac |    9 +++++++++
>  options.c    |    6 ++++++
>  ssl.c        |   14 ++++++++++++++
>  3 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 116ff7c..e775665 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -99,6 +99,12 @@ AC_ARG_ENABLE(plugins,
>     [PLUGINS="yes"]
>  )
>  
> +AC_ARG_ENABLE(eurephia,
> +   [  --disable-eurephia      Disable support for the eurephia plug-in],
> +   [EUREPHIA="$enableval"],
> +   [EUREPHIA="yes"]
> +)
> +
>  AC_ARG_ENABLE(management,
>     [  --disable-management    Disable management server support],
>     [MANAGEMENT="$enableval"],
> @@ -632,6 +638,9 @@ if test "${WIN32}" != "yes"; then
>             )],
>             [AC_MSG_RESULT([libdl headers not found.])]
>        )
> +      if test "$EUREPHIA" = "yes"; then
> +         AC_DEFINE(ENABLE_EUREPHIA, 1, [Enable support for the eurephia plug-in])
> +      fi
>     fi
>  fi
>  
> diff --git a/options.c b/options.c
> index c5ca8b6..aae954e 100644
> --- a/options.c
> +++ b/options.c
> @@ -7,6 +7,9 @@
>   *
>   *  Copyright (C) 2002-2009 OpenVPN Technologies, Inc. <sales@...515...>
>   *
> + *  Additions for eurephia plugin done by:
> + *         David Sommerseth <dazo@...384...> Copyright (C) 2009
> + *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
>   *  as published by the Free Software Foundation.
> @@ -73,6 +76,9 @@ const char title_string[] =
>  #ifdef ENABLE_PKCS11
>    " [PKCS11]"
>  #endif
> +#ifdef ENABLE_EUREPHIA
> +  " [eurephia]"
> +#endif
>    " built on " __DATE__
>  ;
>  
> diff --git a/ssl.c b/ssl.c
> index 82e04a3..1936f64 100644
> --- a/ssl.c
> +++ b/ssl.c
> @@ -7,6 +7,10 @@
>   *
>   *  Copyright (C) 2002-2009 OpenVPN Technologies, Inc. <sales@...515...>
>   *
> + *  Additions for eurephia plugin done by:
> + *         David Sommerseth <dazo@...384...> Copyright (C) 2008-2009
> + *
> + *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
>   *  as published by the Free Software Foundation.
> @@ -780,6 +784,16 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
>    openvpn_snprintf (envname, sizeof(envname), "tls_id_%d", ctx->error_depth);
>    setenv_str (opt->es, envname, subject);
>  
> +#ifdef ENABLE_EUREPHIA
> +  /* export X509 cert SHA1 fingerprint */
> +  {
> +    struct gc_arena gc = gc_new ();
> +    openvpn_snprintf (envname, sizeof(envname), "tls_digest_%d", ctx->error_depth);
> +    setenv_str (opt->es, envname,
> +		format_hex_ex(ctx->current_cert->sha1_hash, SHA_DIGEST_LENGTH, 0, 1, ":", &gc));
> +    gc_free(&gc);
> +  }
> +#endif
>  #if 0
>    /* export common name string as environmental variable */
>    openvpn_snprintf (envname, sizeof(envname), "tls_common_name_%d", ctx->error_depth);
> -- 
> 1.6.6
> 
> 
> ------------------------------------------------------------------------------
> SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
> Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
> http://p.sf.net/sfu/solaris-dev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

