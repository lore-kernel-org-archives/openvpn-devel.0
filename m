References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1512734870-17133-9-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4d7513af-8331-af07-463b-4a70d8489f25@...2181...>
Date: Fri, 15 Jun 2018 15:46:48 +0800
MIME-Version: 1.0
In-Reply-To: <1512734870-17133-9-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9byA5qnJR7wM4iGl2ChkVSZ5DUzDP07mK"
Subject: Re: [Openvpn-devel] [PATCH 08/10] Move file-related functions from
 misc.c to platform.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9byA5qnJR7wM4iGl2ChkVSZ5DUzDP07mK
Content-Type: multipart/mixed; boundary="6BqaQsrUB5hZMOiSRedCMacpK330RlEMs";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4d7513af-8331-af07-463b-4a70d8489f25@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 08/10] Move file-related functions from
 misc.c to platform.c
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1512734870-17133-9-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1512734870-17133-9-git-send-email-steffan.karger@...1435...>

--6BqaQsrUB5hZMOiSRedCMacpK330RlEMs
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 08/12/17 20:07, Steffan Karger wrote:
> To avoid having to include misc.c - which is a dependency mess - in the
> tls-crypt unit tests, move file-handing related functions to platform.c
> (which is where other file-related functions already reside).
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

I have applied this patch right after the one about PEM and it triggered
the following:

Falling back to patching base and 3-way merge...

How about rebasing it before the actual tls-crypt-v2 patches so that it
could be applied earlier and shrink down this patchset?


On top of that, would you please extend the commit message a little bit
to include the fact that you are adding a new mock'd component
(get_random) needed by the tls-crypt unit-test?

Actually....If I understand correctly, this new mock'd component will
only be used when the other patches will be merged too.
Therefore, I guess this patch could be divided in 2: one part being the
code move and the second part being the introduction of the mock'd
component. The latter may directly be included in the patch adding the
tls-crypt unit-test.

What do you think?

Other than this, the patch looks good.
Checked with "git show --color-moved=3Dzebra" to ensure that the code
being moved wasn't modified.

And +1 for this patch for cleaning up the misc.c mess some more.


Cheers,


> ---
>  src/openvpn/init.c                         |   2 +-
>  src/openvpn/misc.c                         | 148 -----------------------=
------
>  src/openvpn/misc.h                         |  12 ---
>  src/openvpn/multi.c                        |  25 ++---
>  src/openvpn/pf.c                           |   4 +-
>  src/openvpn/platform.c                     | 148 +++++++++++++++++++++++=
++++++
>  src/openvpn/platform.h                     |  18 ++++
>  src/openvpn/plugin.c                       |   6 +-
>  src/openvpn/ssl_verify.c                   |  12 ++-
>  tests/unit_tests/openvpn/Makefile.am       |   3 +
>  tests/unit_tests/openvpn/mock_get_random.c |  36 +++++++
>  11 files changed, 232 insertions(+), 182 deletions(-)
>  create mode 100644 tests/unit_tests/openvpn/mock_get_random.c
>=20
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index a4603b3..4055f28 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -807,7 +807,7 @@ init_static(void)
>  #ifdef STATUS_PRINTF_TEST
>      {
>          struct gc_arena gc =3D gc_new();
> -        const char *tmp_file =3D create_temp_file("/tmp", "foo", &gc);
> +        const char *tmp_file =3D platform_create_temp_file("/tmp", "foo"=
, &gc);
>          struct status_output *so =3D status_open(tmp_file, 0, -1, NULL, =
STATUS_OUTPUT_WRITE);
>          status_printf(so, "%s", "foo");
>          status_printf(so, "%s", "bar");
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index ad26f3d..b04a9d7 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -313,87 +313,6 @@ openvpn_popen(const struct argv *a,  const struct en=
v_set *es)
>      return ret;
>  }
>=20=20
> -
> -/* return true if filename can be opened for read */
> -bool
> -test_file(const char *filename)
> -{
> -    bool ret =3D false;
> -    if (filename)
> -    {
> -        FILE *fp =3D platform_fopen(filename, "r");
> -        if (fp)
> -        {
> -            fclose(fp);
> -            ret =3D true;
> -        }
> -        else
> -        {
> -            if (openvpn_errno() =3D=3D EACCES)
> -            {
> -                msg( M_WARN | M_ERRNO, "Could not access file '%s'", fil=
ename);
> -            }
> -        }
> -    }
> -
> -    dmsg(D_TEST_FILE, "TEST FILE '%s' [%d]",
> -         filename ? filename : "UNDEF",
> -         ret);
> -
> -    return ret;
> -}
> -
> -/* create a temporary filename in directory */
> -const char *
> -create_temp_file(const char *directory, const char *prefix, struct gc_ar=
ena *gc)
> -{
> -    int fd;
> -    const char *retfname =3D NULL;
> -    unsigned int attempts =3D 0;
> -    char fname[256] =3D { 0 };
> -    const char *fname_fmt =3D PACKAGE "_%.*s_%08lx%08lx.tmp";
> -    const int max_prefix_len =3D sizeof(fname) - (sizeof(PACKAGE) + 7 + =
(2 * 8));
> -
> -    while (attempts < 6)
> -    {
> -        ++attempts;
> -
> -        if (!openvpn_snprintf(fname, sizeof(fname), fname_fmt, max_prefi=
x_len,
> -                              prefix, (unsigned long) get_random(),
> -                              (unsigned long) get_random()))
> -        {
> -            msg(M_WARN, "ERROR: temporary filename too long");
> -            return NULL;
> -        }
> -
> -        retfname =3D gen_path(directory, fname, gc);
> -        if (!retfname)
> -        {
> -            msg(M_WARN, "Failed to create temporary filename and path");
> -            return NULL;
> -        }
> -
> -        /* Atomically create the file.  Errors out if the file already
> -         * exists.  */
> -        fd =3D platform_open(retfname, O_CREAT | O_EXCL | O_WRONLY, S_IR=
USR | S_IWUSR);
> -        if (fd !=3D -1)
> -        {
> -            close(fd);
> -            return retfname;
> -        }
> -        else if (fd =3D=3D -1 && errno !=3D EEXIST)
> -        {
> -            /* Something else went wrong, no need to retry.  */
> -            msg(M_WARN | M_ERRNO, "Could not create temporary file '%s'",
> -                retfname);
> -            return NULL;
> -        }
> -    }
> -
> -    msg(M_WARN, "Failed to create temporary file after %i attempts", att=
empts);
> -    return NULL;
> -}
> -
>  /*
>   * Prepend a random string to hostname to prevent DNS caching.
>   * For example, foo.bar.gov would be modified to <random-chars>.foo.bar.=
gov.
> @@ -416,73 +335,6 @@ hostname_randomize(const char *hostname, struct gc_a=
rena *gc)
>  }
>=20=20
>  /*
> - * Put a directory and filename together.
> - */
> -const char *
> -gen_path(const char *directory, const char *filename, struct gc_arena *g=
c)
> -{
> -#ifdef _WIN32
> -    const int CC_PATH_RESERVED =3D CC_LESS_THAN|CC_GREATER_THAN|CC_COLON
> -                                 |CC_DOUBLE_QUOTE|CC_SLASH|CC_BACKSLASH|=
CC_PIPE|CC_QUESTION_MARK|CC_ASTERISK;
> -#else
> -    const int CC_PATH_RESERVED =3D CC_SLASH;
> -#endif
> -
> -    if (!gc)
> -    {
> -        return NULL; /* Would leak memory otherwise */
> -    }
> -
> -    const char *safe_filename =3D string_mod_const(filename, CC_PRINT, C=
C_PATH_RESERVED, '_', gc);
> -
> -    if (safe_filename
> -        && strcmp(safe_filename, ".")
> -        && strcmp(safe_filename, "..")
> -#ifdef _WIN32
> -        && win_safe_filename(safe_filename)
> -#endif
> -        )
> -    {
> -        const size_t outsize =3D strlen(safe_filename) + (directory ? st=
rlen(directory) : 0) + 16;
> -        struct buffer out =3D alloc_buf_gc(outsize, gc);
> -        char dirsep[2];
> -
> -        dirsep[0] =3D OS_SPECIFIC_DIRSEP;
> -        dirsep[1] =3D '\0';
> -
> -        if (directory)
> -        {
> -            buf_printf(&out, "%s%s", directory, dirsep);
> -        }
> -        buf_printf(&out, "%s", safe_filename);
> -
> -        return BSTR(&out);
> -    }
> -    else
> -    {
> -        return NULL;
> -    }
> -}
> -
> -bool
> -absolute_pathname(const char *pathname)
> -{
> -    if (pathname)
> -    {
> -        const int c =3D pathname[0];
> -#ifdef _WIN32
> -        return c =3D=3D '\\' || (isalpha(c) && pathname[1] =3D=3D ':' &&=
 pathname[2] =3D=3D '\\');
> -#else
> -        return c =3D=3D '/';
> -#endif
> -    }
> -    else
> -    {
> -        return false;
> -    }
> -}
> -
> -/*
>   * Get and store a username/password
>   */
>=20=20
> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
> index 3725fcf..82bff9a 100644
> --- a/src/openvpn/misc.h
> +++ b/src/openvpn/misc.h
> @@ -79,18 +79,6 @@ const char **make_extended_arg_array(char **p, struct =
gc_arena *gc);
>  /* an analogue to the random() function, but use OpenSSL functions if av=
ailable */
>  long int get_random(void);
>=20=20
> -/* return true if filename can be opened for read */
> -bool test_file(const char *filename);
> -
> -/* create a temporary file in directory, returns the filename of the cre=
ated file */
> -const char *create_temp_file(const char *directory, const char *prefix, =
struct gc_arena *gc);
> -
> -/* put a directory and filename together */
> -const char *gen_path(const char *directory, const char *filename, struct=
 gc_arena *gc);
> -
> -/* return true if pathname is absolute */
> -bool absolute_pathname(const char *pathname);
> -
>  /* prepend a random prefix to hostname */
>  const char *hostname_randomize(const char *hostname, struct gc_arena *gc=
);
>=20=20
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 25b2d09..acc6912 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1639,7 +1639,7 @@ multi_client_connect_post(struct multi_context *m,
>                            unsigned int *option_types_found)
>  {
>      /* Did script generate a dynamic config file? */
> -    if (test_file(dc_file))
> +    if (platform_test_file(dc_file))
>      {
>          options_server_import(&mi->context.options,
>                                dc_file,
> @@ -1826,12 +1826,13 @@ multi_connection_established(struct multi_context=
 *m, struct multi_instance *mi)
>          {
>              const char *ccd_file;
>=20=20
> -            ccd_file =3D gen_path(mi->context.options.client_config_dir,
> -                                tls_common_name(mi->context.c2.tls_multi=
, false),
> -                                &gc);
> +            ccd_file =3D platform_gen_path(mi->context.options.client_co=
nfig_dir,
> +                                         tls_common_name(mi->context.c2.=
tls_multi,
> +                                                         false),
> +                                         &gc);
>=20=20
>              /* try common-name file */
> -            if (test_file(ccd_file))
> +            if (platform_test_file(ccd_file))
>              {
>                  options_server_import(&mi->context.options,
>                                        ccd_file,
> @@ -1842,11 +1843,11 @@ multi_connection_established(struct multi_context=
 *m, struct multi_instance *mi)
>              }
>              else /* try default file */
>              {
> -                ccd_file =3D gen_path(mi->context.options.client_config_=
dir,
> -                                    CCD_DEFAULT,
> -                                    &gc);
> +                ccd_file =3D platform_gen_path(mi->context.options.clien=
t_config_dir,
> +                                             CCD_DEFAULT,
> +                                             &gc);
>=20=20
> -                if (test_file(ccd_file))
> +                if (platform_test_file(ccd_file))
>                  {
>                      options_server_import(&mi->context.options,
>                                            ccd_file,
> @@ -1876,7 +1877,8 @@ multi_connection_established(struct multi_context *=
m, struct multi_instance *mi)
>          if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CO=
NNECT))
>          {
>              struct argv argv =3D argv_new();
> -            const char *dc_file =3D create_temp_file(mi->context.options=
.tmp_dir, "cc", &gc);
> +            const char *dc_file =3D platform_create_temp_file(mi->contex=
t.options.tmp_dir,
> +                                                            "cc", &gc);
>=20=20
>              if (!dc_file)
>              {
> @@ -1938,7 +1940,8 @@ script_depr_failed:
>=20=20
>              setenv_str(mi->context.c2.es, "script_type", "client-connect=
");
>=20=20
> -            dc_file =3D create_temp_file(mi->context.options.tmp_dir, "c=
c", &gc);
> +            dc_file =3D platform_create_temp_file(mi->context.options.tm=
p_dir,
> +                                                "cc", &gc);
>              if (!dc_file)
>              {
>                  cc_succeeded =3D false;
> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
> index 6e4107c..fd9f215 100644
> --- a/src/openvpn/pf.c
> +++ b/src/openvpn/pf.c
> @@ -621,8 +621,8 @@ pf_init_context(struct context *c)
>  #ifdef PLUGIN_PF
>      if (plugin_defined(c->plugins, OPENVPN_PLUGIN_ENABLE_PF))
>      {
> -        c->c2.pf.filename =3D create_temp_file(c->options.tmp_dir, "pf",
> -                                             &c->c2.gc);
> +        c->c2.pf.filename =3D platform_create_temp_file(c->options.tmp_d=
ir, "pf",
> +                                                      &c->c2.gc);
>          if (c->c2.pf.filename)
>          {
>              setenv_str(c->c2.es, "pf_file", c->c2.pf.filename);
> diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
> index e942ba9..5281267 100644
> --- a/src/openvpn/platform.c
> +++ b/src/openvpn/platform.c
> @@ -31,6 +31,7 @@
>=20=20
>  #include "buffer.h"
>  #include "error.h"
> +#include "misc.h"
>  #include "win32.h"
>=20=20
>  #include "memdbg.h"
> @@ -335,3 +336,150 @@ platform_stat(const char *path, platform_stat_t *bu=
f)
>  #endif
>  }
>=20=20
> +/* create a temporary filename in directory */
> +const char *
> +platform_create_temp_file(const char *directory, const char *prefix, str=
uct gc_arena *gc)
> +{
> +    int fd;
> +    const char *retfname =3D NULL;
> +    unsigned int attempts =3D 0;
> +    char fname[256] =3D { 0 };
> +    const char *fname_fmt =3D PACKAGE "_%.*s_%08lx%08lx.tmp";
> +    const int max_prefix_len =3D sizeof(fname) - (sizeof(PACKAGE) + 7 + =
(2 * 8));
> +
> +    while (attempts < 6)
> +    {
> +        ++attempts;
> +
> +        if (!openvpn_snprintf(fname, sizeof(fname), fname_fmt, max_prefi=
x_len,
> +                              prefix, (unsigned long) get_random(),
> +                              (unsigned long) get_random()))
> +        {
> +            msg(M_WARN, "ERROR: temporary filename too long");
> +            return NULL;
> +        }
> +
> +        retfname =3D platform_gen_path(directory, fname, gc);
> +        if (!retfname)
> +        {
> +            msg(M_WARN, "Failed to create temporary filename and path");
> +            return NULL;
> +        }
> +
> +        /* Atomically create the file.  Errors out if the file already
> +         * exists.  */
> +        fd =3D platform_open(retfname, O_CREAT | O_EXCL | O_WRONLY, S_IR=
USR | S_IWUSR);
> +        if (fd !=3D -1)
> +        {
> +            close(fd);
> +            return retfname;
> +        }
> +        else if (fd =3D=3D -1 && errno !=3D EEXIST)
> +        {
> +            /* Something else went wrong, no need to retry.  */
> +            msg(M_WARN | M_ERRNO, "Could not create temporary file '%s'",
> +                retfname);
> +            return NULL;
> +        }
> +    }
> +
> +    msg(M_WARN, "Failed to create temporary file after %i attempts", att=
empts);
> +    return NULL;
> +}
> +
> +/*
> + * Put a directory and filename together.
> + */
> +const char *
> +platform_gen_path(const char *directory, const char *filename,
> +                  struct gc_arena *gc)
> +{
> +#ifdef _WIN32
> +    const int CC_PATH_RESERVED =3D CC_LESS_THAN|CC_GREATER_THAN|CC_COLON
> +                                 |CC_DOUBLE_QUOTE|CC_SLASH|CC_BACKSLASH|=
CC_PIPE|CC_QUESTION_MARK|CC_ASTERISK;
> +#else
> +    const int CC_PATH_RESERVED =3D CC_SLASH;
> +#endif
> +
> +    if (!gc)
> +    {
> +        return NULL; /* Would leak memory otherwise */
> +    }
> +
> +    const char *safe_filename =3D string_mod_const(filename, CC_PRINT, C=
C_PATH_RESERVED, '_', gc);
> +
> +    if (safe_filename
> +        && strcmp(safe_filename, ".")
> +        && strcmp(safe_filename, "..")
> +#ifdef _WIN32
> +        && win_safe_filename(safe_filename)
> +#endif
> +        )
> +    {
> +        const size_t outsize =3D strlen(safe_filename) + (directory ? st=
rlen(directory) : 0) + 16;
> +        struct buffer out =3D alloc_buf_gc(outsize, gc);
> +        char dirsep[2];
> +
> +        dirsep[0] =3D OS_SPECIFIC_DIRSEP;
> +        dirsep[1] =3D '\0';
> +
> +        if (directory)
> +        {
> +            buf_printf(&out, "%s%s", directory, dirsep);
> +        }
> +        buf_printf(&out, "%s", safe_filename);
> +
> +        return BSTR(&out);
> +    }
> +    else
> +    {
> +        return NULL;
> +    }
> +}
> +
> +bool
> +platform_absolute_pathname(const char *pathname)
> +{
> +    if (pathname)
> +    {
> +        const int c =3D pathname[0];
> +#ifdef _WIN32
> +        return c =3D=3D '\\' || (isalpha(c) && pathname[1] =3D=3D ':' &&=
 pathname[2] =3D=3D '\\');
> +#else
> +        return c =3D=3D '/';
> +#endif
> +    }
> +    else
> +    {
> +        return false;
> +    }
> +}
> +
> +/* return true if filename can be opened for read */
> +bool
> +platform_test_file(const char *filename)
> +{
> +    bool ret =3D false;
> +    if (filename)
> +    {
> +        FILE *fp =3D platform_fopen(filename, "r");
> +        if (fp)
> +        {
> +            fclose(fp);
> +            ret =3D true;
> +        }
> +        else
> +        {
> +            if (openvpn_errno() =3D=3D EACCES)
> +            {
> +                msg( M_WARN | M_ERRNO, "Could not access file '%s'", fil=
ename);
> +            }
> +        }
> +    }
> +
> +    dmsg(D_TEST_FILE, "TEST FILE '%s' [%d]",
> +         filename ? filename : "UNDEF",
> +         ret);
> +
> +    return ret;
> +}
> diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
> index cd2bbc9..e116fd5 100644
> --- a/src/openvpn/platform.h
> +++ b/src/openvpn/platform.h
> @@ -49,6 +49,7 @@
>  #endif
>=20=20
>  #include "basic.h"
> +#include "buffer.h"
>=20=20
>  /* Get/Set UID of process */
>=20=20
> @@ -143,4 +144,21 @@ typedef struct stat platform_stat_t;
>  #endif
>  int platform_stat(const char *path, platform_stat_t *buf);
>=20=20
> +/**
> + * Create a temporary file in directory, returns the filename of the cre=
ated
> + * file.
> + */
> +const char *platform_create_temp_file(const char *directory, const char =
*prefix,
> +                                      struct gc_arena *gc);
> +
> +/** Put a directory and filename together. */
> +const char *platform_gen_path(const char *directory, const char *filenam=
e,
> +                              struct gc_arena *gc);
> +
> +/** Return true if pathname is absolute. */
> +bool platform_absolute_pathname(const char *pathname);
> +
> +/** Return true if filename can be opened for read. */
> +bool platform_test_file(const char *filename);
> +
>  #endif /* ifndef PLATFORM_H */
> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
> index 7387f8b..9dfa744 100644
> --- a/src/openvpn/plugin.c
> +++ b/src/openvpn/plugin.c
> @@ -249,7 +249,7 @@ plugin_init_item(struct plugin *p, const struct plugi=
n_option *o)
>       * was parsed.
>       *
>       */
> -    if (!absolute_pathname(p->so_pathname)
> +    if (!platform_absolute_pathname(p->so_pathname)
>          && p->so_pathname[0] !=3D '.')
>      {
>          char full[PATH_MAX];
> @@ -259,7 +259,7 @@ plugin_init_item(struct plugin *p, const struct plugi=
n_option *o)
>      }
>      else
>      {
> -        rel =3D !absolute_pathname(p->so_pathname);
> +        rel =3D !platform_absolute_pathname(p->so_pathname);
>          p->handle =3D dlopen(p->so_pathname, RTLD_NOW);
>      }
>      if (!p->handle)
> @@ -271,7 +271,7 @@ plugin_init_item(struct plugin *p, const struct plugi=
n_option *o)
>=20=20
>  #else  /* ifndef _WIN32 */
>=20=20
> -    rel =3D !absolute_pathname(p->so_pathname);
> +    rel =3D !platform_absolute_pathname(p->so_pathname);
>      p->module =3D LoadLibraryW(wide_string(p->so_pathname, &gc));
>      if (!p->module)
>      {
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index ebb1da2..3568bad 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -547,7 +547,7 @@ verify_cert_export_cert(openvpn_x509_cert_t *peercert=
, const char *tmp_dir, stru
>=20=20
>      /* create tmp file to store peer cert */
>      if (!tmp_dir
> -        || !(peercert_filename =3D create_temp_file(tmp_dir, "pcf", gc)))
> +        || !(peercert_filename =3D platform_create_temp_file(tmp_dir, "p=
cf", gc)))
>      {
>          msg (M_WARN, "Failed to create peer cert file");
>          return NULL;
> @@ -887,7 +887,7 @@ key_state_gen_auth_control_file(struct key_state *ks,=
 const struct tls_options *
>      struct gc_arena gc =3D gc_new();
>=20=20
>      key_state_rm_auth_control_file(ks);
> -    const char *acf =3D create_temp_file(opt->tmp_dir, "acf", &gc);
> +    const char *acf =3D platform_create_temp_file(opt->tmp_dir, "acf", &=
gc);
>      if (acf)
>      {
>          ks->auth_control_file =3D string_alloc(acf, NULL);
> @@ -1100,7 +1100,8 @@ verify_user_pass_script(struct tls_session *session=
, const struct user_pass *up)
>          {
>              struct status_output *so;
>=20=20
> -            tmp_file =3D create_temp_file(session->opt->tmp_dir, "up", &=
gc);
> +            tmp_file =3D platform_create_temp_file(session->opt->tmp_dir=
, "up",
> +                                                 &gc);
>              if (tmp_file)
>              {
>                  so =3D status_open(tmp_file, 0, -1, NULL, STATUS_OUTPUT_=
WRITE);
> @@ -1510,8 +1511,9 @@ verify_final_auth_checks(struct tls_multi *multi, s=
truct tls_session *session)
>          struct gc_arena gc =3D gc_new();
>=20=20
>          const char *cn =3D session->common_name;
> -        const char *path =3D gen_path(session->opt->client_config_dir_ex=
clusive, cn, &gc);
> -        if (!cn || !strcmp(cn, CCD_DEFAULT) || !test_file(path))
> +        const char *path =3D platform_gen_path(session->opt->client_conf=
ig_dir_exclusive,
> +                                             cn, &gc);
> +        if (!cn || !strcmp(cn, CCD_DEFAULT) || !platform_test_file(path))
>          {
>              ks->authenticated =3D false;
>              wipe_auth_token(multi);
> diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/open=
vpn/Makefile.am
> index 7b41363..b69da84 100644
> --- a/tests/unit_tests/openvpn/Makefile.am
> +++ b/tests/unit_tests/openvpn/Makefile.am
> @@ -19,6 +19,7 @@ argv_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(openvpn_s=
rcdir) -I$(compat_srcdir) \
>  argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wra=
p=3Dparse_line \
>  	$(OPTIONAL_CRYPTO_LIBS)
>  argv_testdriver_SOURCES =3D test_argv.c mock_msg.c \
> +	mock_get_random.c \
>  	$(openvpn_srcdir)/platform.c \
>  	$(openvpn_srcdir)/buffer.c \
>  	$(openvpn_srcdir)/argv.c
> @@ -26,6 +27,7 @@ argv_testdriver_SOURCES =3D test_argv.c mock_msg.c \
>  buffer_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(comp=
at_srcdir)
>  buffer_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--w=
rap=3Dparse_line
>  buffer_testdriver_SOURCES =3D test_buffer.c mock_msg.c \
> +	mock_get_random.c \
>  	$(openvpn_srcdir)/buffer.c \
>  	$(openvpn_srcdir)/platform.c
>=20=20
> @@ -50,6 +52,7 @@ packet_id_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
>  packet_id_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \
>  	$(OPTIONAL_CRYPTO_LIBS)
>  packet_id_testdriver_SOURCES =3D test_packet_id.c mock_msg.c \
> +	mock_get_random.c \
>  	$(openvpn_srcdir)/buffer.c \
>  	$(openvpn_srcdir)/otime.c \
>  	$(openvpn_srcdir)/packet_id.c \
> diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_test=
s/openvpn/mock_get_random.c
> new file mode 100644
> index 0000000..da92a9b
> --- /dev/null
> +++ b/tests/unit_tests/openvpn/mock_get_random.c
> @@ -0,0 +1,36 @@
> +/*
> + *  OpenVPN -- An application to securely tunnel IP networks
> + *             over a single UDP port, with support for SSL/TLS-based
> + *             session authentication and key exchange,
> + *             packet encryption, packet authentication, and
> + *             packet compression.
> + *
> + *  Copyright (C) 2017 Fox Crypto B.V. <openvpn@...1435...>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License al=
ong
> + *  with this program; if not, write to the Free Software Foundation, In=
c.,
> + *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <stdarg.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <setjmp.h>
> +#include <cmocka.h>
> +
> +unsigned long
> +get_random(void)
> +{
> +    /* rand() is not very random, but it's C99 and this is just for test=
ing */
> +    return rand();
> +}
>=20

--=20
Antonio Quartulli


--6BqaQsrUB5hZMOiSRedCMacpK330RlEMs--

--9byA5qnJR7wM4iGl2ChkVSZ5DUzDP07mK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsjbukACgkQB6U8WA7y
zXSSSg//e9Mkguu1oWe+gtVs+6VcEF95vEbJy5FGn5uKB0eW1OyxKCS7VBX/AGEn
D3sy8SwFF9GYpWcmQu0UEYed8PRC3HW9YjjescgqLFlnFiDrOJgB6Ioo1UjFr9ZR
8GmOr7itbnsVrbN1rlHNhvfm2//ZIiMaztzZBXp8GJZAv+LdNQwQ0/Dq/+sAhaf7
rkxxS/QuxuED3hckKZLgWmS9DIHinDZU+Ze1KDd5v82Dy59FEHAJpKoy2OSMnuBZ
auP8QyCwtfC+gMY4BjJ3zLUK1Jfbr0h5krn6TXEh1uM4vVVsg9lI0sDX84Fx/8Fx
6UjqsWl6gJwbdqTgw5gxeIhPBVAw0yGdMwbLOtbTIBGVnuu4eEt72QKcWji7+4xb
Fu/FXbnIwpv5JveOmPK01hXP4lKKuEqG8pfBcg7xdNx92wdafQ4vcnHUfoYFI1ud
N70FCrD3sf3/p3sTrP9sZv6Yfu/TE8b+GBAuSVld+jtSsJ82C7jfIfTvo2NEr6fh
QvRs6WELu/OjLtBCVE3hT0UYvkqTStQY8g7Yg4nXKTXDTtbs22VFWIUlNCj+AdiF
AjtCMG31HLaC9MUHg/r97zgRITeyjpCC2GJJmVrsIvOuBfXoeCOmHu7qtlabjM8W
BB5NRYBjdcHBiybDIuAu7HZmBwDG0a8hEQ3cdpcX83yoN6pw8w4=
=bb+j
-----END PGP SIGNATURE-----

--9byA5qnJR7wM4iGl2ChkVSZ5DUzDP07mK--

