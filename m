MIME-Version: 1.0
In-Reply-To: <563083B1.2020908@...2070...>
References: <562EB0A1.8010403@...2070...> <56307DAA.30700@...2070...>
	<563083B1.2020908@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 16 Nov 2015 01:17:02 -0500
Message-ID: <CAKuzo_hhRVGfPkEaE93oqGO89baPD1=9qVFYZ2=yQSuHC7Fs9g@...278...>
Content-Type: multipart/alternative; boundary=001a11443d9eae173b0524a25c80
Subject: Re: [Openvpn-devel] [PATCH v2] Add Windows DNS Leak fix using WFP
	('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11443d9eae173b0524a25c80
Content-Type: text/plain; charset=UTF-8

Hi,

Here are some comments on the code -- there is one apparent memory leak
(see below).

 .\"*********************************************************
>  .TP
> +.B \-\-block\-outside\-dns
> +Block external DNS servers on other network adapters to prevent
>

the word "external" is not required nor appropriate as it blocks all, isn't
it?


> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1468,6 +1468,22 @@ do_open_tun (struct context *c)
>                    "up",
>                    c->c2.es);
>  +#if _WIN32_WINNT >= 0x0600
> +      if (c->options.block_outside_dns)
> +      {
> +          if (!win_wfp_init())
> +            msg (M_NONFATAL, "Initialising WFP failed!");
> +            else
> +            {
> +                dmsg (D_LOW, "Blocking outside DNS");
> +                if (!win_wfp_block_dns(c->c1.tuntap->adapter_index))
> +                    msg (M_NONFATAL, "Blocking DNS failed!");
> +            }
> +      }
> +      else
> +           msg (M_NONFATAL, "Can't block outside DNS without configured
> DNS server");
>

This error/warning is unnecessary and confusing. If the user does not want
to block-outside-dns, why say "can't block"? And why the "without
configured DNS server" remark?

in win32.c
+
+    ret = ConvertInterfaceIndexToLuid(index, &tapluid);
+    if (ret == NO_ERROR)
+        dmsg (D_LOW, "Tap Luid: %I64d", tapluid.Value);
+

Is it safe to ignore the ret != NO_ERROR case? May be it is...

+
> +    /* Get OpenVPN path. */
> +    GetModuleFileNameW(NULL, openvpnpath, MAX_PATH);
> +
> +    if (FwpmGetAppIdFromFileName0(openvpnpath, &openvpnblob) !=
> ERROR_SUCCESS)
>

openvpnblob is allocated here, but not freed anywhere. Need to free it
before return.

Finally, to nitpick,
There are a couple of unused variables
Some local vars could be eliminated (rpcStatus, dwFwAPIRetCode, ret)
FIREWALL_NAME defined as const, but passed to non-const
ZeroMemory --> CLEAR
CopyMemory --> memcpy

Regards,

Selva

--001a11443d9eae173b0524a25c80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><div><br>Here are some c=
omments on the code -- there is one apparent memory leak (see below).<br></=
div><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0.\&quot;*********************************************************<br>
=C2=A0.TP<br>
+.B \-\-block\-outside\-dns<br>
+Block external DNS servers on other network adapters to prevent<br></block=
quote><div><br></div><div>the word &quot;external&quot; is not required nor=
 appropriate as it blocks all, isn&#39;t it? <br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
--- a/src/openvpn/init.c<br>
+++ b/src/openvpn/init.c<br>
@@ -1468,6 +1468,22 @@ do_open_tun (struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
up&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;=
<a href=3D"http://c2.es" rel=3D"noreferrer" target=3D"_blank">c2.es</a>);<b=
r>
=C2=A0+#if _WIN32_WINNT &gt;=3D 0x0600<br>
+=C2=A0 =C2=A0 =C2=A0 if (c-&gt;options.block_outside_dns)<br>
+=C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!win_wfp_init())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_NONFATAL, &quot;Initialis=
ing WFP failed!&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg (D_LOW, &quot=
;Blocking outside DNS&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!win_wfp_block=
_dns(c-&gt;c1.tuntap-&gt;adapter_index))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =
(M_NONFATAL, &quot;Blocking DNS failed!&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_NONFATAL, &quot;Can&#39;t =
block outside DNS without configured DNS server&quot;);<br>
</blockquote><div><br></div><div>This error/warning is unnecessary and=20
confusing. If the user does not want to block-outside-dns, why say=20
&quot;can&#39;t block&quot;? And why the &quot;without configured DNS serve=
r&quot; remark?<br></div><br></div><div class=3D"gmail_extra">in win32.c<br=
>+<br>
+=C2=A0 =C2=A0 ret =3D ConvertInterfaceIndexToLuid(index, &amp;tapluid);<br>
+=C2=A0 =C2=A0 if (ret =3D=3D NO_ERROR)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg (D_LOW, &quot;Tap Luid: %I64d&quot;, tapl=
uid.Value);<br>
+<br><br></div><div class=3D"gmail_extra">Is it safe to ignore the ret !=3D=
 NO_ERROR case? May be it is...<br><br></div><div class=3D"gmail_extra"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 /* Get OpenVPN path. */<br>
+=C2=A0 =C2=A0 GetModuleFileNameW(NULL, openvpnpath, MAX_PATH);<br>
+<br>
+=C2=A0 =C2=A0 if (FwpmGetAppIdFromFileName0(openvpnpath, &amp;openvpnblob)=
 !=3D ERROR_SUCCESS)<br></blockquote><div><br></div><div>openvpnblob is all=
ocated here, but not freed anywhere. Need to free it before return.<br><br>=
</div><div>Finally, to nitpick, <br></div><div>There are a couple of unused=
 variables<br></div><div>Some local vars could be eliminated (rpcStatus, dw=
FwAPIRetCode, ret)<br></div><div>FIREWALL_NAME defined as const, but passed=
 to non-const<br></div><div><div>ZeroMemory --&gt; CLEAR<br></div>CopyMemor=
y --&gt; memcpy<br><br></div><div>Regards,<br><br></div><div>Selva<br></div=
></div></div>

--001a11443d9eae173b0524a25c80--

