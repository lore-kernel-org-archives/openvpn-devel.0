MIME-Version: 1.0
References: <20191219223917.1614-1-simon@...2293...>
In-Reply-To: <20191219223917.1614-1-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 20 Dec 2019 10:17:57 +0200
Message-ID: <CAGyAFMWxED9NY_=h_jim-4cASMAGv0q5ozmqcVQ+jYTLS5YbPA@...278...>
Content-Type: multipart/alternative; boundary="000000000000580e0b059a1e510a"
Subject: Re: [Openvpn-devel] [PATCH 1/7] tun.c: make Windows device lookup
 functions more general
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000580e0b059a1e510a
Content-Type: text/plain; charset="UTF-8"

Hi,

Build in MSVC, tested and ran in debugger.

The only nitpick is those methods (since you have touched them)

  +get_tap_by_guid(const char *guid, const struct tap_reg *tap_reg)
  +get_tap_by_name(const char *name, const struct tap_reg *tap_reg, const
struct panel_reg *panel_reg)

could be renamed to "get_tuntap_by_*" or even better, "get_adapter_by_*"
since they're
adapter-type agnostic and deal with both tap and wintun.

Acked-by: Lev Stipakov <lstipakov@...277...>

pe 20. jouluk. 2019 klo 0.40 Simon Rozman (simon@...2293...) kirjoitti:

> Since the introduction of Wintun, not all network devices in Windows are
> TAP-Windows6. Rather than returning a simple true/false answer, a couple
> of functions were reworked to return a corresponding struct tap_reg *
> or NULL instead.
>
> As it would make the code `tr = is_tap_win(...)` a bit awkward those
> functions (both static) were renamed to better reflect their nature.
>
> Signed-off-by: Simon Rozman <simon@...2293...>
> ---
>  src/openvpn/tun.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index ad497a71..053a8232 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -3976,10 +3976,10 @@ show_tap_win_adapters(int msglev, int warnlev)
>  }
>
>  /*
> - * Confirm that GUID is a TAP-Windows adapter.
> + * Lookup a TAP-Windows or Wintun adapter by GUID.
>   */
> -static bool
> -is_tap_win(const char *guid, const struct tap_reg *tap_reg)
> +static const struct tap_reg *
> +get_tap_by_guid(const char *guid, const struct tap_reg *tap_reg)
>  {
>      const struct tap_reg *tr;
>
> @@ -3987,11 +3987,11 @@ is_tap_win(const char *guid, const struct tap_reg
> *tap_reg)
>      {
>          if (guid && !strcmp(tr->guid, guid))
>          {
> -            return true;
> +            return tr;
>          }
>      }
>
> -    return false;
> +    return NULL;
>  }
>
>  static const char *
> @@ -4010,16 +4010,16 @@ guid_to_name(const char *guid, const struct
> panel_reg *panel_reg)
>      return NULL;
>  }
>
> -static const char *
> -name_to_guid(const char *name, const struct tap_reg *tap_reg, const
> struct panel_reg *panel_reg)
> +static const struct tap_reg *
> +get_tap_by_name(const char *name, const struct tap_reg *tap_reg, const
> struct panel_reg *panel_reg)
>  {
>      const struct panel_reg *pr;
>
>      for (pr = panel_reg; pr != NULL; pr = pr->next)
>      {
> -        if (name && !strcmp(pr->name, name) && is_tap_win(pr->guid,
> tap_reg))
> +        if (name && !strcmp(pr->name, name))
>          {
> -            return pr->guid;
> +            return get_tap_by_guid(pr->guid, tap_reg);
>          }
>      }
>
> @@ -4116,6 +4116,7 @@ get_device_guid(const char *name,
>  {
>      struct buffer ret = alloc_buf_gc(256, gc);
>      struct buffer actual = clear_buf();
> +    const struct tap_reg *tr;
>
>      /* Make sure we have at least one TAP adapter */
>      if (!tap_reg)
> @@ -4131,7 +4132,8 @@ get_device_guid(const char *name,
>      }
>
>      /* Check if GUID was explicitly specified as --dev-node parameter */
> -    if (is_tap_win(name, tap_reg))
> +    tr = get_tap_by_guid(name, tap_reg);
> +    if (tr)
>      {
>          const char *act = guid_to_name(name, panel_reg);
>          buf_printf(&ret, "%s", name);
> @@ -4148,11 +4150,11 @@ get_device_guid(const char *name,
>
>      /* Lookup TAP adapter in network connections list */
>      {
> -        const char *guid = name_to_guid(name, tap_reg, panel_reg);
> -        if (guid)
> +        tr = get_tap_by_name(name, tap_reg, panel_reg);
> +        if (tr)
>          {
>              buf_printf(&actual, "%s", name);
> -            buf_printf(&ret, "%s", guid);
> +            buf_printf(&ret, "%s", tr->guid);
>              return BSTR(&ret);
>          }
>      }
> @@ -4696,11 +4698,14 @@ get_adapter_index_flexible(const char *name)  /*
> actual name or GUID */
>      {
>          const struct tap_reg *tap_reg = get_tap_reg(&gc);
>          const struct panel_reg *panel_reg = get_panel_reg(&gc);
> -        const char *guid = name_to_guid(name, tap_reg, panel_reg);
> -        index = get_adapter_index_method_1(guid);
> -        if (index == TUN_ADAPTER_INDEX_INVALID)
> +        const struct tap_reg *tr = get_tap_by_name(name, tap_reg,
> panel_reg);
> +        if (tr)
>          {
> -            index = get_adapter_index_method_2(guid);
> +            index = get_adapter_index_method_1(tr->guid);
> +            if (index == TUN_ADAPTER_INDEX_INVALID)
> +            {
> +                index = get_adapter_index_method_2(tr->guid);
> +            }
>          }
>      }
>      if (index == TUN_ADAPTER_INDEX_INVALID)
> --
> 2.24.1.windows.2
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


-- 
-Lev

--000000000000580e0b059a1e510a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Build in MSVC, tes=
ted and ran in debugger.</div><div><br></div><div>The only nitpick is those=
 methods (since you have touched them)</div><div><br></div><div>=C2=A0 +get=
_tap_by_guid(const char *guid, const struct tap_reg *tap_reg)=C2=A0</div><d=
iv>=C2=A0

+get_tap_by_name(const char *name, const struct tap_reg *tap_reg, const str=
uct panel_reg *panel_reg)

<br></div><div><br></div><div>could be renamed to &quot;get_tuntap_by_*&quo=
t; or even better, &quot;get_adapter_by_*&quot; since they&#39;re</div><div=
>adapter-type agnostic and deal with both tap and wintun.</div><div><br></d=
iv><div>Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277...">l=
stipakov@...277...</a>&gt;</div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">pe 20. jouluk. 2019 klo 0.40 Simon Rozman (=
<a href=3D"mailto:simon@...2293...">simon@...2293...</a>) kirjoitti:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Since the introduction=
 of Wintun, not all network devices in Windows are<br>
TAP-Windows6. Rather than returning a simple true/false answer, a couple<br>
of functions were reworked to return a corresponding struct tap_reg *<br>
or NULL instead.<br>
<br>
As it would make the code `tr =3D is_tap_win(...)` a bit awkward those<br>
functions (both static) were renamed to better reflect their nature.<br>
<br>
Signed-off-by: Simon Rozman &lt;<a href=3D"mailto:simon@...2293..." target=
=3D"_blank">simon@...2293...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/tun.c | 39 ++++++++++++++++++++++-----------------<br>
=C2=A01 file changed, 22 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index ad497a71..053a8232 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -3976,10 +3976,10 @@ show_tap_win_adapters(int msglev, int warnlev)<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
- * Confirm that GUID is a TAP-Windows adapter.<br>
+ * Lookup a TAP-Windows or Wintun adapter by GUID.<br>
=C2=A0 */<br>
-static bool<br>
-is_tap_win(const char *guid, const struct tap_reg *tap_reg)<br>
+static const struct tap_reg *<br>
+get_tap_by_guid(const char *guid, const struct tap_reg *tap_reg)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const struct tap_reg *tr;<br>
<br>
@@ -3987,11 +3987,11 @@ is_tap_win(const char *guid, const struct tap_reg *=
tap_reg)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (guid &amp;&amp; !strcmp(tr-&gt;guid, =
guid))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return tr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 return NULL;<br>
=C2=A0}<br>
<br>
=C2=A0static const char *<br>
@@ -4010,16 +4010,16 @@ guid_to_name(const char *guid, const struct panel_r=
eg *panel_reg)<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
<br>
-static const char *<br>
-name_to_guid(const char *name, const struct tap_reg *tap_reg, const struct=
 panel_reg *panel_reg)<br>
+static const struct tap_reg *<br>
+get_tap_by_name(const char *name, const struct tap_reg *tap_reg, const str=
uct panel_reg *panel_reg)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const struct panel_reg *pr;<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (pr =3D panel_reg; pr !=3D NULL; pr =3D pr-&gt;next=
)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (name &amp;&amp; !strcmp(pr-&gt;name, name)=
 &amp;&amp; is_tap_win(pr-&gt;guid, tap_reg))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (name &amp;&amp; !strcmp(pr-&gt;name, name)=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return pr-&gt;guid;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_tap_by_guid(pr-&gt;gu=
id, tap_reg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -4116,6 +4116,7 @@ get_device_guid(const char *name,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct buffer ret =3D alloc_buf_gc(256, gc);<br>
=C2=A0 =C2=A0 =C2=A0struct buffer actual =3D clear_buf();<br>
+=C2=A0 =C2=A0 const struct tap_reg *tr;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Make sure we have at least one TAP adapter */<br>
=C2=A0 =C2=A0 =C2=A0if (!tap_reg)<br>
@@ -4131,7 +4132,8 @@ get_device_guid(const char *name,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Check if GUID was explicitly specified as --dev-node=
 parameter */<br>
-=C2=A0 =C2=A0 if (is_tap_win(name, tap_reg))<br>
+=C2=A0 =C2=A0 tr =3D get_tap_by_guid(name, tap_reg);<br>
+=C2=A0 =C2=A0 if (tr)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *act =3D guid_to_name(name, pa=
nel_reg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf(&amp;ret, &quot;%s&quot;, name=
);<br>
@@ -4148,11 +4150,11 @@ get_device_guid(const char *name,<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Lookup TAP adapter in network connections list */<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *guid =3D name_to_guid(name, tap_re=
g, panel_reg);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (guid)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tr =3D get_tap_by_name(name, tap_reg, panel_re=
g);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf(&amp;actual, &qu=
ot;%s&quot;, name);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_printf(&amp;ret, &quot;%s&qu=
ot;, guid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_printf(&amp;ret, &quot;%s&qu=
ot;, tr-&gt;guid);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return BSTR(&amp;ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -4696,11 +4698,14 @@ get_adapter_index_flexible(const char *name)=C2=A0 =
/* actual name or GUID */<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct tap_reg *tap_reg =3D get_tap=
_reg(&amp;gc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct panel_reg *panel_reg =3D get=
_panel_reg(&amp;gc);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *guid =3D name_to_guid(name, tap_re=
g, panel_reg);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D get_adapter_index_method_1(guid);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (index =3D=3D TUN_ADAPTER_INDEX_INVALID)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct tap_reg *tr =3D get_tap_by_name(n=
ame, tap_reg, panel_reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D get_adapter_index_meth=
od_2(guid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D get_adapter_index_meth=
od_1(tr-&gt;guid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (index =3D=3D TUN_ADAPTER_IND=
EX_INVALID)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D get_adap=
ter_index_method_2(tr-&gt;guid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (index =3D=3D TUN_ADAPTER_INDEX_INVALID)<br>
-- <br>
2.24.1.windows.2<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div></div>

--000000000000580e0b059a1e510a--

