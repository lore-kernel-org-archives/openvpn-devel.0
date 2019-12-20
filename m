MIME-Version: 1.0
References: <20191219223917.1614-1-simon@...2293...>
 <20191219223917.1614-2-simon@...2293...>
In-Reply-To: <20191219223917.1614-2-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 20 Dec 2019 10:32:26 +0200
Message-ID: <CAGyAFMWNV0RnyzK7d5SQ_qCWYTHwvY46LRhigVEGNEqeg-zXYA@...278...>
Content-Type: multipart/alternative; boundary="0000000000002157a9059a1e8522"
Subject: Re: [Openvpn-devel] [PATCH 2/7] tun.c: upgrade get_device_guid() to
 return the Windows driver type
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

--0000000000002157a9059a1e8522
Content-Type: text/plain; charset="UTF-8"

Hi,

While at the moment NULL is always passed when calling get_device_guid(),
this change will be needed in 5/7 "intun: add support for --dev-node".

You (or committer :) may want to update comment, since it also returns
optional device type:

/*
 * Lookup a --dev-node adapter name in the registry
 * returning the GUID, optional actual_name and device type
 */

Other than that, looks good.

Acked-by: Lev Stipakov <lstipakov@...277...>


 get_device_guid(const char *name,
>                  char *actual_name,
>                  int actual_name_size,
> +                bool *wintun,
>                  const struct tap_reg *tap_reg,
>                  const struct panel_reg *panel_reg,
>                  struct gc_arena *gc)
> @@ -4145,6 +4146,10 @@ get_device_guid(const char *name,
>          {
>              buf_printf(&actual, "%s", name);
>          }
> +        if (wintun)
> +        {
> +            *wintun = tr->wintun;
> +        }
>          return BSTR(&ret);
>      }
>
> @@ -4154,6 +4159,10 @@ get_device_guid(const char *name,
>          if (tr)
>          {
>              buf_printf(&actual, "%s", name);
> +            if (wintun)
> +            {
> +                *wintun = tr->wintun;
> +            }
>              buf_printf(&ret, "%s", tr->guid);
>              return BSTR(&ret);
>          }
> @@ -4838,7 +4847,7 @@ tap_allow_nonadmin_access(const char *dev_node)
>      if (dev_node)
>      {
>          /* Get the device GUID for the device specified with --dev-node.
> */
> -        device_guid = get_device_guid(dev_node, actual_buffer,
> sizeof(actual_buffer), tap_reg, panel_reg, &gc);
> +        device_guid = get_device_guid(dev_node, actual_buffer,
> sizeof(actual_buffer), NULL, tap_reg, panel_reg, &gc);
>
>          if (!device_guid)
>          {
> @@ -5412,7 +5421,7 @@ netsh_get_id(const char *dev_node, struct gc_arena
> *gc)
>
>      if (dev_node)
>      {
> -        guid = get_device_guid(dev_node, BPTR(&actual), BCAP(&actual),
> tap_reg, panel_reg, gc);
> +        guid = get_device_guid(dev_node, BPTR(&actual), BCAP(&actual),
> NULL, tap_reg, panel_reg, gc);
>      }
>      else
>      {
> @@ -6132,7 +6141,7 @@ tun_open_device(struct tuntap *tt, const char
> *dev_node, const char **device_gui
>      if (dev_node)
>      {
>          /* Get the device GUID for the device specified with --dev-node.
> */
> -        *device_guid = get_device_guid(dev_node, actual_buffer,
> sizeof(actual_buffer), tap_reg, panel_reg, &gc);
> +        *device_guid = get_device_guid(dev_node, actual_buffer,
> sizeof(actual_buffer), NULL, tap_reg, panel_reg, &gc);
>
>          if (!*device_guid)
>          {
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

--0000000000002157a9059a1e8522
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>While at the moment NULL=
 is always passed when calling=20

get_device_guid(),</div><div>this change will be needed in 5/7 &quot;intun:=
 add support for --dev-node&quot;.=C2=A0=C2=A0<br></div><div><br></div><div=
>You (or committer :) may want to update comment, since it also returns opt=
ional device type:</div><div><br></div><div>/*<br>=C2=A0* Lookup a --dev-no=
de adapter name in the registry<br>=C2=A0* returning the GUID, optional act=
ual_name and device type<br>=C2=A0*/<br></div><div><br></div><div></div><di=
v>Other than that, looks good.</div><div><br></div><div>Acked-by: Lev Stipa=
kov &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt;<=
/div><div><br></div><div><br></div><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">=C2=A0get_device_guid(const char *name=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *actual_=
name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int actual_na=
me_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *wintun,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct =
tap_reg *tap_reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct =
panel_reg *panel_reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gc_are=
na *gc)<br>
@@ -4145,6 +4146,10 @@ get_device_guid(const char *name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf(&amp;actual, &qu=
ot;%s&quot;, name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (wintun)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *wintun =3D tr-&gt;wintun;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return BSTR(&amp;ret);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -4154,6 +4159,10 @@ get_device_guid(const char *name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf(&amp;actual, &qu=
ot;%s&quot;, name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (wintun)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *wintun =3D tr-&gt=
;wintun;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf(&amp;ret, &quot;=
%s&quot;, tr-&gt;guid);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return BSTR(&amp;ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -4838,7 +4847,7 @@ tap_allow_nonadmin_access(const char *dev_node)<br>
=C2=A0 =C2=A0 =C2=A0if (dev_node)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get the device GUID for the device spe=
cified with --dev-node. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 device_guid =3D get_device_guid(dev_node, actu=
al_buffer, sizeof(actual_buffer), tap_reg, panel_reg, &amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 device_guid =3D get_device_guid(dev_node, actu=
al_buffer, sizeof(actual_buffer), NULL, tap_reg, panel_reg, &amp;gc);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!device_guid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
@@ -5412,7 +5421,7 @@ netsh_get_id(const char *dev_node, struct gc_arena *g=
c)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (dev_node)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 guid =3D get_device_guid(dev_node, BPTR(&amp;a=
ctual), BCAP(&amp;actual), tap_reg, panel_reg, gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 guid =3D get_device_guid(dev_node, BPTR(&amp;a=
ctual), BCAP(&amp;actual), NULL, tap_reg, panel_reg, gc);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -6132,7 +6141,7 @@ tun_open_device(struct tuntap *tt, const char *dev_no=
de, const char **device_gui<br>
=C2=A0 =C2=A0 =C2=A0if (dev_node)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get the device GUID for the device spe=
cified with --dev-node. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *device_guid =3D get_device_guid(dev_node, act=
ual_buffer, sizeof(actual_buffer), tap_reg, panel_reg, &amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *device_guid =3D get_device_guid(dev_node, act=
ual_buffer, sizeof(actual_buffer), NULL, tap_reg, panel_reg, &amp;gc);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!*device_guid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
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

--0000000000002157a9059a1e8522--

