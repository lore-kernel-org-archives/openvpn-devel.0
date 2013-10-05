MIME-Version: 1.0
Message-ID: <trinity-d1ec7c6d-965e-46c5-be97-ae3976a4d4f1-1380988265323@...1843...>
From: Max.Muster@...1832...
Date: Sat, 5 Oct 2013 17:51:05 +0200 (CEST)
In-Reply-To: <52501AE3.3070602@...1832...>
References: <0MAQ0o-1VYfA02dyM-00BYQL@...1825...>,
	<0MVuuM-1VL5oS2YOm-00X7Ks@...1825...>
	<trinity-991a1d45-4a26-48b4-b7b3-d50c17a111df-1380980922550@...1842...>,
	<52501AE3.3070602@...1832...>
Subject: Re: [Openvpn-devel] [PATCH] Allow inlining of --auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

and another problem:

Configs without "auth-user-pass" will segfault, for in options_postprocess_=
verify_ce you do a

streq(options->auth_user_pass_file, "stdin")

without checking first, if options->auth_user_pass_file is not NULL.


so here is fix number three for src/openvpn/misc.c (in fact, it is "old" nu=
mber one and three) ;-)

[...]
 #if P2MP
-  if (options->auth_user_pass_file && !options->pull)
+  if ( ( options->auth_user_pass_file || options->auth_user_pass_file_inli=
ne) && !options->pull)
     msg (M_USAGE, "--auth-user-pass requires --pull");
+=20=20
+  if ( ( (options->auth_user_pass_file && !streq(options->auth_user_pass_f=
ile, "stdin")) || options->auth_user_pass_file_inline) && options->auth_noc=
ache)
+    msg (M_USAGE, "Cannot use --auth-nocache with credentials from file");
+
+#ifdef ENABLE_CLIENT_CR
+  if ( ( (options->auth_user_pass_file && !streq(options->auth_user_pass_f=
ile, "stdin")) || options->auth_user_pass_file_inline) && options->sc_info.=
challenge_text)
+    msg (M_USAGE, "Credentials cannot be in a file if using --static-chall=
enge");
+#endif
[...]


A quick test did work with and without user authentication (only tested inl=
ine settzing, not with a file).
=C2=A0
Joerg

-------- Original-Nachricht --------
Gesendet:=C2=A0Samstag, 05. Oktober 2013 um 15:57 Uhr
Von:=C2=A0"Max Muster" <Max.Muster@...1832...>
An:=C2=A0"Davide Brini" <dave_br@...1278...>
Cc:=C2=A0openvpn-devel@lists.sourceforge.net
Betreff:=C2=A0Re: [Openvpn-devel] [PATCH] Allow inlining of --auth-user-pass
oops, just took my "debug" version of src/openvpn/ssl.c ...

Of course output of string length and especially password in log file is
not intended ;-)

Joerg

-------- Original-Nachricht --------
Betreff: Re: [Openvpn-devel] [PATCH] Allow inlining of --auth-user-pass
Von: Max.Muster@...1832...
An: Davide Brini <dave_br@...1278...>
Kopie (CC): openvpn-devel@lists.sourceforge.net
Datum: Sa 05 Okt 2013 15:48:42 CEST

> Hi Davide,
> nice idea. But I think I found two small bugs:
> First, it won't compile in a config w/o ENABLE_CLIENT_CR defined (there i=
s no
> "sc_info").
> Second, if I'm not mistaken, name and password are not copied correctly:
> If # of charachters is (pos - prev), the last charakter is at [pos - prev=
 -1]
> and to terminate the string you should set [pos - prev] to '\0'.
> My suggestion (not sure, if the first one works with management enabled, =
only
> tested w/o).
> Fix in src/openvpn/misc.c (add #ifdef):
> [...]
> +
> + if ( ( !streq(options->auth_user_pass_file, "stdin") ||
> options->auth_user_pass_file_inline) && options->auth_nocache)
> + msg (M_USAGE, "Cannot use --auth-nocache with credentials from file");
> +
> +#ifdef ENABLE_CLIENT_CR
> + if ( ( !streq(options->auth_user_pass_file, "stdin") ||
> options->auth_user_pass_file_inline) && options->sc_info.challenge_text)
> + msg (M_USAGE, "Credentials cannot be in a file if using --static-challe=
nge");
> +#endif
> +
> + if (options->auth_user_pass_file_inline)
> + {
> + int n_inlined =3D 0;
> [...]
> in src/openvpn/ssl.c yo should use [pos - prev] instead of [pos - prev +1]
> [...]
> + {
> + strncpy(inlined_username, prev, pos - prev);
> + inlined_username[pos - prev] =3D '\0';
> + msg (M_INFO, "Using inlined username: %s (POS=3D%d PREV=3D%d)",
> inlined_username, pos, prev);
> + }
> + else
> + {
> + strncpy(inlined_password, prev, pos - prev);
> + inlined_password[pos - prev] =3D '\0';
> + msg (M_INFO, "Using inlined password:
> ...**%s**",inlined_password);
> + }
> [...]
>
> I hope it's o.k. just to give the idea but not post full patches again.
>
> Regards
> Joerg
> *Gesendet:* Donnerstag, 03. Oktober 2013 um 10:30 Uhr
> *Von:* "Davide Brini" <dave_br@...1278...>
> *An:* openvpn-devel@lists.sourceforge.net
> *Betreff:* Re: [Openvpn-devel] [PATCH] Allow inlining of --auth-user-pass
> (previous version contained a leftover debug line left by mistake, sorry)
>
> This patch allows inlining of the --auth-user-pass directive, so it is now
> possible to do
>
> <auth-user-pass>
> myusername
> mypassword
> </auth-user-pass>
>
> or supply just the username, eg
>
> <auth-user-pass>
> myusername
> </auth-user-pass>
>
> (in this case the user is prompted for the password only).
> The most changed files are options.c (sanity check of inlined credentials)
> and ssl.c (actual parsing of the inlined credentials).
>
> Udates to the documentation will be provided in a separate patch if and w=
hen
> the present patch is accepted.
>
> As discussed on IRC, for the time being the non-inlined syntax
>
> auth-user-pass [up]
>
> is still supported and [up] is expected to contain username and password
> on two lines.
>
> Signed-off-by: Davide Brini <dave_br@...1278...>
> ---
> src/openvpn/init.c | 6 +--
> src/openvpn/misc.c | 2 +-
> src/openvpn/options.c | 56 ++++++++++++++++++++++++----
> src/openvpn/options.h | 2 +
> src/openvpn/ssl.c | 98 +++++++++++++++++++++++++++++++++++++------------
> src/openvpn/ssl.h | 2 +-
> 6 files changed, 131 insertions(+), 35 deletions(-)
>
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 031fb20..b11ae8a 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -400,12 +400,12 @@ init_query_passwords (struct context *c)
>
> #if P2MP
> /* Auth user/pass input */
> - if (c->options.auth_user_pass_file)
> + if (c->options.auth_user_pass_file || c->options.auth_user_pass_file_in=
line)
> {
> #ifdef ENABLE_CLIENT_CR
> - auth_user_pass_setup (c->options.auth_user_pass_file, &c->options.sc_in=
fo);
> + auth_user_pass_setup (c->options.auth_user_pass_file,
> c->options.auth_user_pass_file_inline, &c->options.sc_info);
> #else
> - auth_user_pass_setup (c->options.auth_user_pass_file, NULL);
> + auth_user_pass_setup (c->options.auth_user_pass_file,
> c->options.auth_user_pass_file_inline, NULL);
> #endif
> }
> #endif
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 4688444..05bc2f0 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -1036,7 +1036,7 @@ get_user_pass_cr (struct user_pass *up,
>
> if (!up->defined)
> {
> - const bool from_stdin =3D (!auth_file || !strcmp (auth_file, "stdin"));
> + const bool from_stdin =3D (!auth_file || streq (auth_file, "stdin"));
>
> if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
> msg (M_WARN, "Note: previous '%s' credentials failed", prefix);
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 4d0271f..6f2ea66 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1233,6 +1233,7 @@ show_p2mp_parms (const struct options *o)
> SHOW_BOOL (client);
> SHOW_BOOL (pull);
> SHOW_STR (auth_user_pass_file);
> + SHOW_STR (auth_user_pass_file_inline);
>
> gc_free (&gc);
> }
> @@ -2080,7 +2081,7 @@ options_postprocess_verify_ce (const struct options
> *options, const struct conne
> if (options->ifconfig_ipv6_local && !options->tun_ipv6 )
> msg (M_INFO, "Warning: --ifconfig-ipv6 without --tun-ipv6 will not do IPv=
6");
>
> - if (options->auth_user_pass_file)
> + if ( options->auth_user_pass_file || options->auth_user_pass_file_inlin=
e )
> msg (M_USAGE, "--auth-user-pass cannot be used with --mode server (it sho=
uld be
> used on the client side only)");
> if (options->ccd_exclusive && !options->client_config_dir)
> msg (M_USAGE, "--ccd-exclusive must be used with --client-config-dir");
> @@ -2274,7 +2275,7 @@ options_postprocess_verify_ce (const struct options
> *options, const struct conne
> if (sum =3D=3D 0)
> {
> #if P2MP
> - if (!options->auth_user_pass_file)
> + if (!options->auth_user_pass_file && !options->auth_user_pass_file_inli=
ne)
> #endif
> msg (M_USAGE, "No client-side authentication method is specified. You mus=
t use
> either --cert/--key, --pkcs12, or --auth-user-pass");
> }
> @@ -2350,8 +2351,42 @@ options_postprocess_verify_ce (const struct options
> *options, const struct conne
> #endif /* ENABLE_SSL */
>
> #if P2MP
> - if (options->auth_user_pass_file && !options->pull)
> + if ( ( options->auth_user_pass_file || options->auth_user_pass_file_inl=
ine) &&
> !options->pull)
> msg (M_USAGE, "--auth-user-pass requires --pull");
> +
> + if ( ( !streq(options->auth_user_pass_file, "stdin") ||
> options->auth_user_pass_file_inline) && options->auth_nocache)
> + msg (M_USAGE, "Cannot use --auth-nocache with credentials from file");
> +
> + if ( ( !streq(options->auth_user_pass_file, "stdin") ||
> options->auth_user_pass_file_inline) && options->sc_info.challenge_text)
> + msg (M_USAGE, "Credentials cannot be in a file if using --static-challe=
nge");
> +
> + if (options->auth_user_pass_file_inline)
> + {
> + int n_inlined =3D 0;
> + const char *pos =3D options->auth_user_pass_file_inline;
> + const char *prev =3D pos;
> +
> + if ( strlen(pos) =3D=3D 0 )
> + msg (M_USAGE, "Invalid format for inlined --auth-user-pass");
> +
> + while( (pos =3D strchr(pos, '\n')) !=3D NULL )
> + {
> + n_inlined++;
> +
> + if (n_inlined > 2)
> + msg (M_USAGE, "Too many lines in inlined --auth-user-pass");
> +
> + if ( pos - prev > USER_PASS_LEN - 1 )
> + msg (M_USAGE, "Line too long in inlined --auth-user-pass");
> +
> + pos++;
> + prev =3D pos;
> + }
> +
> + if ( (n_inlined =3D=3D 0) || (*prev !=3D '\0') )
> + msg (M_USAGE, "Invalid format for inlined --auth-user-pass");
> +
> + }
> #endif
>
> uninit_options (&defaults);
> @@ -2719,9 +2754,10 @@ options_postprocess_filechecks (struct options *op=
tions)
> "--management user/password file");
> #endif /* ENABLE_MANAGEMENT */
> #if P2MP
> - errs |=3D check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
> - options->auth_user_pass_file, R_OK,
> - "--auth-user-pass");
> + if (!streq(options->auth_user_pass_file, INLINE_FILE_TAG))
> + errs |=3D check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
> + options->auth_user_pass_file, R_OK,
> + "--auth-user-pass");
> #endif /* P2MP */
>
> /* ** System related ** */
> @@ -5894,7 +5930,12 @@ add_option (struct options *options,
> VERIFY_PERMISSION (OPT_P_GENERAL);
> if (p[1])
> {
> - options->auth_user_pass_file =3D p[1];
> + options->auth_user_pass_file =3D p[1];
> + if (streq (p[1], INLINE_FILE_TAG) && p[2])
> + {
> + options->auth_user_pass_file =3D "stdin";
> + options->auth_user_pass_file_inline =3D p[2];
> + }
> }
> else
> options->auth_user_pass_file =3D "stdin";
> @@ -6591,6 +6632,7 @@ add_option (struct options *options,
> else if (streq (p[0], "auth-nocache"))
> {
> VERIFY_PERMISSION (OPT_P_GENERAL);
> + options->auth_nocache =3D true;
> ssl_set_auth_nocache ();
> }
> else if (streq (p[0], "auth-token") && p[1])
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 8e0e367..5ae733a 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -292,6 +292,7 @@ struct options
> bool up_delay;
> bool up_restart;
> bool daemon;
> + bool auth_nocache;
>
> int remap_sigusr1;
>
> @@ -460,6 +461,7 @@ struct options
> bool pull; /* client pull of config options from server */
> int push_continuation;
> const char *auth_user_pass_file;
> + const char *auth_user_pass_file_inline;
> struct options_pre_pull *pre_pull;
>
> int server_poll_timeout;
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 69f77f3..aa249f1 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -354,36 +354,88 @@ static char *auth_challenge; /* GLOBAL */
> #endif
>
> void
> -auth_user_pass_setup (const char *auth_file, const struct static_challen=
ge_info
> *sci)
> +auth_user_pass_setup (const char *auth_file, const char *auth_file_inlin=
e,
> const struct static_challenge_info *sci)
> {
> +
> + int extra_flags =3D 0;
> + int n_inlined =3D 0;
> + char inlined_username[USER_PASS_LEN];
> + char inlined_password[USER_PASS_LEN];
> +
> auth_user_pass_enabled =3D true;
> +
> if (!auth_user_pass.defined)
> {
> + if (auth_file && streq (auth_file, "stdin") && auth_file_inline)
> + {
> + /* check how much is inlined. */
> + const char *pos =3D auth_file_inline;
> + const char *prev =3D pos;
> +
> + while( (pos =3D strchr(pos, '\n')) !=3D NULL)
> + {
> + n_inlined++;
> +
> + if (n_inlined =3D=3D 1)
> + {
> + strncpy(inlined_username, prev, pos - prev);
> + inlined_username[pos - prev + 1] =3D '\0';
> + msg (M_INFO, "Using inlined username: %s", inlined_username);
> + }
> + else
> + {
> + strncpy(inlined_password, prev, pos - prev);
> + inlined_password[pos - prev + 1] =3D '\0';
> + msg (M_INFO, "Using inlined password: ...");
> + }
> +
> + pos++;
> + prev =3D pos;
> + }
> +
> + if (n_inlined =3D=3D 1)
> + extra_flags =3D GET_USER_PASS_PASSWORD_ONLY;
> + }
> +
> + if (n_inlined =3D=3D 2)
> + {
> + strcpy(auth_user_pass.username, inlined_username);
> + strcpy(auth_user_pass.password, inlined_password);
> + auth_user_pass.defined =3D true;
> + }
> + else
> + {
> #if AUTO_USERID
> - get_user_pass_auto_userid (&auth_user_pass, auth_file);
> + get_user_pass_auto_userid (&auth_user_pass, auth_file);
> #else
> # ifdef ENABLE_CLIENT_CR
> - if (auth_challenge) /* dynamic challenge/response */
> - get_user_pass_cr (&auth_user_pass,
> - auth_file,
> - UP_TYPE_AUTH,
> - GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_DYNAMIC_=
CHALLENGE,
> - auth_challenge);
> - else if (sci) /* static challenge response */
> - {
> - int flags =3D
> GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_STATIC_CHA=
LLENGE;
> - if (sci->flags & SC_ECHO)
> - flags |=3D GET_USER_PASS_STATIC_CHALLENGE_ECHO;
> - get_user_pass_cr (&auth_user_pass,
> - auth_file,
> - UP_TYPE_AUTH,
> - flags,
> - sci->challenge_text);
> - }
> - else
> + if (auth_challenge) /* dynamic challenge/response */
> + get_user_pass_cr (&auth_user_pass,
> + auth_file,
> + UP_TYPE_AUTH,
> +
> GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_DYNAMIC_CH=
ALLENGE|extra_flags,
> + auth_challenge);
> + else if (sci) /* static challenge response */
> + {
> + int flags =3D
> GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_STATIC_CHA=
LLENGE|extra_flags;
> + if (sci->flags & SC_ECHO)
> + flags |=3D GET_USER_PASS_STATIC_CHALLENGE_ECHO;
> +
> + get_user_pass_cr (&auth_user_pass,
> + auth_file,
> + UP_TYPE_AUTH,
> + flags,
> + sci->challenge_text);
> + }
> + else
> # endif
> - get_user_pass (&auth_user_pass, auth_file, UP_TYPE_AUTH,
> GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE);
> + get_user_pass (&auth_user_pass, auth_file, UP_TYPE_AUTH,
> GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|extra_flags);
> #endif
> + }
> +
> + if (n_inlined =3D=3D 1)
> + strcpy(auth_user_pass.username, inlined_username);
> +
> }
> }
>
> @@ -1892,9 +1944,9 @@ key_method_2_write (struct buffer *buf, struct tls_=
session
> *session)
> if (auth_user_pass_enabled)
> {
> #ifdef ENABLE_CLIENT_CR
> - auth_user_pass_setup (NULL, session->opt->sci);
> + auth_user_pass_setup (NULL, NULL, session->opt->sci);
> #else
> - auth_user_pass_setup (NULL, NULL);
> + auth_user_pass_setup (NULL, NULL, NULL);
> #endif
> if (!write_string (buf, auth_user_pass.username, -1))
> goto error;
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index cd7cae2..c7554aa 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -388,7 +388,7 @@ void pem_password_setup (const char *auth_file);
> * Setup authentication username and password. If auth_file is given, use =
the
> * credentials stored in the file.
> */
> -void auth_user_pass_setup (const char *auth_file, const struct
> static_challenge_info *sc_info);
> +void auth_user_pass_setup (const char *auth_file, const char *auth_file_=
inline,
> const struct static_challenge_info *sc_info);
>
> /*
> * Ensure that no caching is performed on authentication information
> --
> 1.7.10.4-----------------------------------------------------------------=
-------------
> October Webinars: Code for Performance
> Free Intel webinars can help you accelerate application performance.
> Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most =
from
> the latest Intel processors and coprocessors. See abstracts and register >
> http://pubads.g.doubleclick.net/gampad/clk?id=3D60134791&iu=3D/4140/ostg.=
clktrk_______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel[https://lists.=
sourceforge.net/lists/listinfo/openvpn-devel]
>
>
>
> -------------------------------------------------------------------------=
-----
> October Webinars: Code for Performance
> Free Intel webinars can help you accelerate application performance.
> Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most =
from
> the latest Intel processors and coprocessors. See abstracts and register >
> http://pubads.g.doubleclick.net/gampad/clk?id=3D60134791&iu=3D/4140/ostg.=
clktrk[http://pubads.g.doubleclick.net/gampad/clk?id=3D60134791&iu=3D/4140/=
ostg.clktrk]
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel[https://lists.=
sourceforge.net/lists/listinfo/openvpn-devel]
>


---------------------------------------------------------------------------=
---
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most fr=
om
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=3D60134791&iu=3D/4140/ostg.cl=
ktrk[http://pubads.g.doubleclick.net/gampad/clk?id=3D60134791&iu=3D/4140/os=
tg.clktrk]
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel[https://lists.so=
urceforge.net/lists/listinfo/openvpn-devel]

