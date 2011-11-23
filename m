MIME-Version: 1.0
In-Reply-To: <1322057700-15531-1-git-send-email-heiko.hund@...1489...>
References: <1322057700-15531-1-git-send-email-heiko.hund@...1489...>
Date: Wed, 23 Nov 2011 16:55:57 +0200
Message-ID: <CAOazyz1uPqYfVRJp0H5vjgxgBo0Mc2oqYJt=KDUWXrjzU+615w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Windows UTF-8 input/output
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

OpenVPN output is not always a console.
I am not sure this patch is valid.

On Wed, Nov 23, 2011 at 4:15 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> This patch makes openvpn read unicode from the console and convert the in=
put
> to UTF-8. And then display UTF-8 output to the console correctly.
>
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
> =C2=A0configure.ac | =C2=A0 =C2=A01 +
> =C2=A0openvpn.c =C2=A0 =C2=A0| =C2=A0 =C2=A04 ++++
> =C2=A0win32.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A08 +++++++-
> =C2=A03 files changed, 12 insertions(+), 1 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index a4d68e6..169d616 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -343,6 +343,7 @@ case "$host" in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPENVPN_ADD_LIBS(-lcrypt32)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPENVPN_ADD_LIBS(-liphlpapi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPENVPN_ADD_LIBS(-lwinmm)
> + =C2=A0 =C2=A0 =C2=A0 OPENVPN_ADD_LIBS(-lshell32)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> =C2=A0*-*-dragonfly*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_DEFINE(TARGET_DRAGONFLY, 1, [Are we running=
 on DragonFlyBSD?])
> diff --git a/openvpn.c b/openvpn.c
> index 520fda1..611dffa 100644
> --- a/openvpn.c
> +++ b/openvpn.c
> @@ -131,6 +131,10 @@ main (int argc, char *argv[])
> =C2=A0 return 1;
> =C2=A0#endif
>
> +#ifdef TARGET_WIN32
> + =C2=A0SetConsoleOutputCP (CP_UTF8);
> +#endif
> +
> =C2=A0 CLEAR (c);
>
> =C2=A0 /* signify first time for components which can
> diff --git a/win32.c b/win32.c
> index cf6cc2d..0f4d11c 100644
> --- a/win32.c
> +++ b/win32.c
> @@ -763,6 +763,7 @@ get_console_input_win32 (const char *prompt, const bo=
ol echo, char *input, const
> =C2=A0 =C2=A0 =C2=A0 bool is_console =3D (GetFileType (in) =3D=3D FILE_TY=
PE_CHAR);
> =C2=A0 =C2=A0 =C2=A0 DWORD flags_save =3D 0;
> =C2=A0 =C2=A0 =C2=A0 int status =3D 0;
> + =C2=A0 =C2=A0 =C2=A0WCHAR *winput;
>
> =C2=A0 =C2=A0 =C2=A0 if (is_console)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> @@ -777,10 +778,15 @@ get_console_input_win32 (const char *prompt, const =
bool echo, char *input, const
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is_console =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0status =3D ReadFile (in, input, capacity, &len, NUL=
L);
> + =C2=A0 =C2=A0 =C2=A0winput =3D malloc (capacity * sizeof (WCHAR));
> + =C2=A0 =C2=A0 =C2=A0if (winput =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 return false;
>
> + =C2=A0 =C2=A0 =C2=A0status =3D ReadConsoleW (in, winput, capacity, &len=
, NULL);
> + =C2=A0 =C2=A0 =C2=A0WideCharToMultiByte (CP_UTF8, 0, winput, len, input=
, capacity, NULL, NULL);
> =C2=A0 =C2=A0 =C2=A0 string_null_terminate (input, (int)len, capacity);
> =C2=A0 =C2=A0 =C2=A0 chomp (input);
> + =C2=A0 =C2=A0 =C2=A0free (winput);
>
> =C2=A0 =C2=A0 =C2=A0 if (!echo)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0WriteFile (err, "\r\n", 2, &len, NULL);
> --
> 1.7.5.4
>
>
> -------------------------------------------------------------------------=
-----
> All the data continuously generated in your IT infrastructure
> contains a definitive record of customers, application performance,
> security threats, fraudulent activity, and more. Splunk takes this
> data and makes sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-novd2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

