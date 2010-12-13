MIME-Version: 1.0
In-Reply-To: <1292234169-12388-1-git-send-email-dazo@...384...>
References: <1292234169-12388-1-git-send-email-dazo@...384...>
Date: Mon, 13 Dec 2010 12:17:15 +0200
Message-ID: <AANLkTi=NP1rL9m4PM1G0B4nZ853cig2Eh5ETFiUP6fod@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Use \r\n as newline in log files on
	Windows
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
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

Use text mode file io, don't mess with the constants.

On Mon, Dec 13, 2010 at 11:56 AM, David Sommerseth
<dazo@...384...> wrote:
> The newline style is different from most Unices and Windows, where
> Windows uses \r\n instead of just \n.
>
> Reported-by: Thomas Reifferscheid
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
> =C2=A0config-win32.h | =C2=A0 =C2=A03 +++
> =C2=A0error.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 12 ++++++++----
> =C2=A02 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/config-win32.h b/config-win32.h
> index be0b320..56c40cd 100644
> --- a/config-win32.h
> +++ b/config-win32.h
> @@ -275,6 +275,9 @@ typedef unsigned long in_addr_t;
> =C2=A0#error The Windows version of OpenVPN does not support PTHREAD yet
> =C2=A0#endif
>
> +/* Windows uses a different NL style than *nix for logging */
> +#define NEWLINE "\r\n"
> +
> =C2=A0#ifdef _MSC_VER
> =C2=A0/* MSVC++ hacks */
> =C2=A0#pragma warning(disable:4244) // conversion from 'foo' to 'bar', po=
ssible loss of data
> diff --git a/error.c b/error.c
> index 873718c..40c8107 100644
> --- a/error.c
> +++ b/error.c
> @@ -49,6 +49,10 @@
> =C2=A0#endif
> =C2=A0#endif
>
> +#ifndef NEWLINE
> +#define NEWLINE "\n"
> +#endif
> +
> =C2=A0/* Globals */
> =C2=A0unsigned int x_debug_level; /* GLOBAL */
>
> @@ -326,7 +330,7 @@ void x_msg (const unsigned int flags, const char *for=
mat, ...)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 prefix,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 prefix_sep,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 m1,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(flags&M_NOLF) ? "" : "\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(flags&M_NOLF) ? "" : NEWLINE);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> @@ -337,14 +341,14 @@ void x_msg (const unsigned int flags, const char *f=
ormat, ...)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 prefix,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 prefix_sep,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 m1,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(flags&M_NOLF) ? "" : "\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(flags&M_NOLF) ? "" : NEWLINE);
> =C2=A0#else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf (fp, "%s %s%s%s%s=
",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 time_string (0, 0, show_usec, &gc),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 prefix,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 prefix_sep,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 m1,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(flags&M_NOLF) ? "" : "\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(flags&M_NOLF) ? "" : NEWLINE);
> =C2=A0#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fflush(fp);
> @@ -411,7 +415,7 @@ assert_failed (const char *filename, int line)
> =C2=A0void
> =C2=A0out_of_memory (void)
> =C2=A0{
> - =C2=A0fprintf (stderr, PACKAGE_NAME ": Out of Memory\n");
> + =C2=A0fprintf (stderr, PACKAGE_NAME ": Out of Memory" NEWLINE);
> =C2=A0 exit (1);
> =C2=A0}
>
> --
> 1.7.2.3
>
>
> -------------------------------------------------------------------------=
-----
> Oracle to DB2 Conversion Guide: Learn learn about native support for PL/S=
QL,
> new data types, scalar functions, improved concurrency, built-in packages,
> OCI, SQL*Plus, data movement tools, best practices and more.
> http://p.sf.net/sfu/oracle-sfdev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

