MIME-Version: 1.0
In-Reply-To: <1305544215-12654-1-git-send-email-davids@...1347...>
References: <1305544215-12654-1-git-send-email-davids@...1347...>
Date: Mon, 16 May 2011 14:16:17 +0300
Message-ID: <BANLkTinxXtn-ynwqeHUps=j_FEi-O=d9-g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Make '--comp-lzo no' the default
 behaviour if LZO is enabled
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

If you have a problem in what can or cannot be pushed to client, why
not do this generic?
Something like:
---
push-allowed=3D"comp-lzo ..."
push-disallow=3D"comp-lzo ..."
---

On Mon, May 16, 2011 at 2:10 PM, David Sommerseth <davids@...1347...> wrote:
>
> This makes 'comp-lzo' pushable without requiring clients to have
> --comp-lzo defined in the client configs. =C2=A0To make 'comp-lzo' not
> pushable on the client, a new 'disabled' argument have been added.
>
> Trac-ticket: 128
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
> =C2=A0openvpn.8 | =C2=A0 12 ++++++------
> =C2=A0options.c | =C2=A0 10 +++++++---
> =C2=A02 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/openvpn.8 b/openvpn.8
> index 5cbf4c5..89759b6 100644
> --- a/openvpn.8
> +++ b/openvpn.8
> @@ -2284,7 +2284,9 @@ limit repetitive logging of similar message types.
> =C2=A0Use fast LZO compression \-\- may add up to 1 byte per
> =C2=A0packet for incompressible data.
> =C2=A0.B mode
> -may be "yes", "no", or "adaptive" (default).
> +may be "yes", "adaptive" or "disabled".
> +If =C2=A0\-\-comp-lzo is used without an argument, it defaults to
> +"adaptive".
>
> =C2=A0In a server mode setup, it is possible to selectively turn
> =C2=A0compression on or off for individual clients.
> @@ -2293,11 +2295,9 @@ First, make sure the client-side config file enabl=
es selective
> =C2=A0compression by having at least one
> =C2=A0.B \-\-comp-lzo
> =C2=A0directive, such as
> -.B \-\-comp-lzo no.
> -This will turn off compression by default,
> -but allow a future directive push from the server to
> -dynamically change the
> -on/off/adaptive setting.
> +
> +If the "disabled" argument is given, \-\-comp-lzo can not be pushed
> +from the server to the client.
>
> =C2=A0Next in a
> =C2=A0.B \-\-client-config-dir
> diff --git a/options.c b/options.c
> index f643acc..dc45282 100644
> --- a/options.c
> +++ b/options.c
> @@ -816,6 +816,10 @@ init_options (struct options *o, const bool init_gc)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 o->tmp_dir =3D "/tmp";
> =C2=A0 }
> =C2=A0#endif /* WIN32 */
> +
> +#ifdef USE_LZO
> + =C2=A0o->lzo =3D LZO_SELECTED;
> +#endif
> =C2=A0}
>
> =C2=A0void
> @@ -5889,13 +5893,13 @@ add_option (struct options *options,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (streq (p[1], "yes"))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options->lzo =3D LZO_SELECTED|LZ=
O_ON;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (streq (p[1], "no"))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options->lzo =3D LZO_SELECTED;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (streq (p[1], "adaptive"))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options->lzo =3D LZO_SELECTED|LZ=
O_ON|LZO_ADAPTIVE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (streq (p[1], "disabled"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options->lzo =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (msglevel, "bad comp-lzo =
option: %s -- must be 'yes', 'no', or 'adaptive'", p[1]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (msglevel, "bad comp-lzo =
option: %s -- must be 'yes', 'adaptive' or 'disabled", p[1]);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> --
> 1.7.4.4
>
>
> -------------------------------------------------------------------------=
-----
> Achieve unprecedented app performance and reliability
> What every C/C++ and Fortran developer should know.
> Learn how Intel has extended the reach of its next-generation tools
> to help boost performance applications - inlcuding clusters.
> http://p.sf.net/sfu/intel-dev2devmay
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

