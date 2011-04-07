MIME-Version: 1.0
In-Reply-To: <1302106222-10256-1-git-send-email-davids@...1347...>
References: <1302106222-10256-1-git-send-email-davids@...1347...>
Date: Thu, 7 Apr 2011 15:15:23 +0300
Message-ID: <BANLkTik3QGpmced2mqhxDv6cmNJDZcxFMw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Change the default --tmp-dir path to a
 more suitable path
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

On Wed, Apr 6, 2011 at 7:10 PM, David Sommerseth <davids@...1347...> wrote:
> In commit 4e1cc5f6dda22e9 the create_temp_filename() function was
> reviewed and hardened, which in the end renamed this function to
> create_temp_file() in commit 495e3cec5d156.
>
> With these changes it became more evident that OpenVPN needs a directory
> where it can create temporary files. =C2=A0The create_temp_file() will cr=
eate
> such files f.ex. if --client-connect or --plugin which makes use of
> the OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY hook, such as openvpn-auth-pam.s=
o.
>
> When this happens, OpenVPN will normally create these files in the direct=
ory
> OpenVPN was started. =C2=A0In many cases, this will fail due to restricte=
d access.
> By using --tmp-dir and pointing it to a directory writeable to the user
> running OpenVPN, it works again.
>
> This patch makes OpenVPN use a more suitable temproary directory by defau=
lt,
> instead of the current working directory. =C2=A0On non-Windows platforms =
this
> default value is set to '/tmp', but can be modified at compile-time by
> running ./configure --with-tmp-dir-path=3D<TEMP DIR PATH>. =C2=A0On Windo=
ws, it
> will look up %TEMP% and %TMP% first, and if that doesn't give any clues, =
it
> will fallback to C:\WINDOWS\Temp in the end.

I don't understand,
if you use windows environment variables, then why not do the same on Unix?
You have the standard TMPDIR [1] variable, and fallback to /tmp.

Also, at Windows you should go into %SystemRoot%\Temp using
ExpandEnvironmentVariable() and not hardcode C:\

And if you have a sane fallback ot system location, why you need to
add a compile time option to override?

[1] http://en.wikipedia.org/wiki/TMPDIR

> +AC_ARG_WITH(tmp-dir-path,
> + =C2=A0 [ =C2=A0--with-tmp-dir-path=3DPATH =C2=A0Default tmp-dir to use =
when not configured (unset defaults to /tmp)],
> + =C2=A0 [TMPDIRPATH=3D"$withval"]
> +)
> +

<snip>

> +dnl set the default temporary directory
> +if test -z "$TMPDIRPATH"; then
> + =C2=A0 TMPDIRPATH=3D"/tmp"
> +fi
> +AC_DEFINE_UNQUOTED(DEFAULT_TMPDIR, "$TMPDIRPATH", [Default --tmp-dir])
> +

Both should be something like:
---
AC_ARG_WITH(
   [tmp-dir-path],
   [AS_HELP_STRING([--with-tmp-dir-path=3DPATH], [Default tmp-dir to use
when not configured (unset defaults to /tmp)])],
   [TMPDIRPATH=3D"$withval"],
   [
      case "${host}" in
         *-mingw*) TMPDIRPATH=3D"%SystemRoot%/Temp" ;;
         *) TMPDIRPATH=3D"/tmp" ;;
      esac
)
AC_DEFINE_UNQUOTED([DEFAULT_TMPDIR], [${TMPDIRPATH}], [Default --tmp-dir])
---

Alon.

