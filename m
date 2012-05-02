MIME-Version: 1.0
In-Reply-To: <1335981252-7390-1-git-send-email-davids@...1347...>
References: <1335981252-7390-1-git-send-email-davids@...1347...>
Date: Wed, 2 May 2012 21:16:36 +0300
Message-ID: <CAOazyz2_BbFgKYPJkyKNVTuwYo-DdbJp__NZGqs_8Ckym36hVw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Simplify check_cmd_access() function
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
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

Looks good.
If you testing this one, please ensure symbolic links also works properly..=
. :)

On Wed, May 2, 2012 at 8:54 PM, David Sommerseth <davids@...1347...> wrote:
> To avoid confusion between check_file_access() and check_cmd_access() in =
the
> future, remove unneeded arguments from check_cmd_access()
>
> As a command will always be a file, it should always check for CHKACC_FIL=
E and
> nothing else. =C2=A0And as the commands always will need X_OK, check only=
 for that.
>
> One change from earlier behaviour is that R_OK is not checked for. =C2=A0=
The reason
> is that only scripts require R_OK to work. =C2=A0However, a system might =
be installed
> with binaries with only X_OK set. =C2=A0If a script is missing R_OK, then=
 the execution
> will fail due to lacking permissions.
>
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
> =C2=A0src/openvpn/options.c | =C2=A0 48 ++++++++++++++++++++++++++-------=
---------------
> =C2=A01 files changed, 26 insertions(+), 22 deletions(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 5da2eb6..7769625 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2690,7 +2690,7 @@ check_file_access(const int type, const char *file,=
 const int mode, const char *
> =C2=A0* check_file_access() arguments.
> =C2=A0*/
> =C2=A0static bool
> -check_cmd_access(const int type, const char *command, const int mode, co=
nst char *opt)
> +check_cmd_access(const char *command, const char *opt)
> =C2=A0{
> =C2=A0 struct argv argv;
> =C2=A0 bool return_code;
> @@ -2705,7 +2705,11 @@ check_cmd_access(const int type, const char *comma=
nd, const int mode, const char
>
> =C2=A0 /* if an executable is specified then check it; otherwise, complai=
n */
> =C2=A0 if (argv.argv[0])
> - =C2=A0 =C2=A0 =C2=A0return_code =3D check_file_access(type, argv.argv[0=
], mode, opt);
> + =C2=A0 =C2=A0/* Scripts requires R_OK as well, but that might fail on b=
inaries which
> + =C2=A0 =C2=A0 * only requires X_OK to function on Unix - a scenario not=
 unlikely to
> + =C2=A0 =C2=A0 * be seen on suid binaries.
> + =C2=A0 =C2=A0 */
> + =C2=A0 =C2=A0return_code =3D check_file_access(CHKACC_FILE, argv.argv[0=
], X_OK, opt);
> =C2=A0 else
> =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': No pa=
th to executable.",
> @@ -2797,26 +2801,26 @@ options_postprocess_filechecks (struct options *o=
ptions)
>
> =C2=A0 /* ** Script hooks that accept an optionally quoted and/or escaped=
 executable path, ** */
> =C2=A0 /* ** optionally followed by arguments ** */
> - =C2=A0errs |=3D check_cmd_access (CHKACC_FILE, options->auth_user_pass_=
verify_script,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0R_OK|X_OK, "--auth-user-pass-verify script");
> - =C2=A0errs |=3D check_cmd_access (CHKACC_FILE, options->client_connect_=
script,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0R_OK|X_OK, "--client-connect script");
> - =C2=A0errs |=3D check_cmd_access (CHKACC_FILE, options->client_disconne=
ct_script,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0R_OK|X_OK, "--client-disconnect script");
> - =C2=A0errs |=3D check_cmd_access (CHKACC_FILE, options->tls_verify,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0R_OK|X_OK, "--tls-verify script");
> - =C2=A0errs |=3D check_cmd_access (CHKACC_FILE, options->up_script,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0R_OK|X_OK, "--up script");
> - =C2=A0errs |=3D check_cmd_access (CHKACC_FILE, options->down_script,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0R_OK|X_OK, "--down script");
> - =C2=A0errs |=3D check_cmd_access (CHKACC_FILE, options->ipchange,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0R_OK|X_OK, "--ipchange script");
> - =C2=A0errs |=3D check_cmd_access (CHKACC_FILE, options->route_script,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0R_OK|X_OK, "--route-up script");
> - =C2=A0errs |=3D check_cmd_access (CHKACC_FILE, options->route_predown_s=
cript,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0R_OK|X_OK, "--route-pre-down script");
> - =C2=A0errs |=3D check_cmd_access (CHKACC_FILE, options->learn_address_s=
cript,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0R_OK|X_OK, "--learn-address script");
> + =C2=A0errs |=3D check_cmd_access (options->auth_user_pass_verify_script,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0"--auth-user-pass-verify script");
> + =C2=A0errs |=3D check_cmd_access (options->client_connect_script,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0"--client-connect script");
> + =C2=A0errs |=3D check_cmd_access (options->client_disconnect_script,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0"--client-disconnect script");
> + =C2=A0errs |=3D check_cmd_access (options->tls_verify,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0"--tls-verify script");
> + =C2=A0errs |=3D check_cmd_access (options->up_script,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0"--up script");
> + =C2=A0errs |=3D check_cmd_access (options->down_script,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0"--down script");
> + =C2=A0errs |=3D check_cmd_access (options->ipchange,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0"--ipchange script");
> + =C2=A0errs |=3D check_cmd_access (options->route_script,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0"--route-up script");
> + =C2=A0errs |=3D check_cmd_access (options->route_predown_script,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0"--route-pre-down script");
> + =C2=A0errs |=3D check_cmd_access (options->learn_address_script,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0"--learn-address script");
> =C2=A0#endif /* P2MP_SERVER */
>
> =C2=A0 if (errs)
> --
> 1.7.4.4
>
>
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

