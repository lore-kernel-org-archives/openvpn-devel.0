References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
Date: Fri, 16 Dec 2016 21:52:03 +0100
MIME-Version: 1.0
In-Reply-To: <20161216182659.18194-1-jm@...1926...>
Subject: Re: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
 compiler supports them
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

On 16-12-16 19:26, Julien Muchembled wrote:
> The bug in Trac #792 (pointer wrongly truncated as 'int', leading to segf=
aults)
> would have been understood faster with either
>   -Werror=3Dimplicit or -Werror=3Dformat
> (and above all, before running buggy executables in production)
>=20
> Debian already compiles with -Werror=3Dformat-security, and it's indeed a=
 good
> idea for a sensitive software like OpenVPN to use it.
> ---
>> Yes, please!
>>
>> You can put the macro in m4/
>>
>=20
> OK. Not sure about the license. It's GPL3+

GPLv3 is fine as far as I'm aware, and the license is nicely contained
in the file, so I think all is good.

> I also don't include the latest version, which has (among other changes):
> -[AC_PREREQ(2.59)dnl for _AC_LANG_PREFIX
> +[AC_PREREQ(2.64)dnl for _AC_LANG_PREFIX and AS_VAR_IF

Good, 2.59 is reasonable, even RHEL6 has 2.63.  Might be good if David
or Gert gives this a test run on the build farm before applying though.

> configure.ac                |  7 +++++
>  m4/ax_check_compile_flag.m4 | 74 +++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 81 insertions(+)
>  create mode 100644 m4/ax_check_compile_flag.m4
>=20
> diff --git a/configure.ac b/configure.ac
> index 4f086ea..3357ea0 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -412,6 +412,13 @@ ifdef(
>  	]
>  )
>=20=20
> +AX_CHECK_COMPILE_FLAG([ -Werror=3Dimplicit ], [
> +    CFLAGS_EXTRA=3D"$CFLAGS_EXTRA -Werror=3Dimplicit"
> +])
> +AX_CHECK_COMPILE_FLAG([ -Werror=3Dformat -Werror=3Dformat-security ], [
> +    CFLAGS_EXTRA=3D"$CFLAGS_EXTRA -Werror=3Dformat -Werror=3Dformat-secu=
rity"
> +])
> +

Shouldn't there be a CFLAGS=3D"${CFLAGS} ${CFLAGS_EXTRA}" somewhere?  Or
just use CFLAGS directly, instead of _EXTRA.  Without that, I don't see
the flags appear in the make output.

-Steffan

