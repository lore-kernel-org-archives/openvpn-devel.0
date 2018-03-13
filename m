MIME-Version: 1.0
In-Reply-To: <CAHODtZSTyD8NOc8cVNaGaZ9z+HZrKK-+L6h_t0gqhAh3pJMk+w@...278...>
References: <20171205121952.13008-1-EngyCZ@...277...>
 <CAKuzo_g6YTkx+-3i=TEFn9b2yPjx9rBweTz=4H7uuOT8VokEdg@...278...>
 <CAHODtZSTyD8NOc8cVNaGaZ9z+HZrKK-+L6h_t0gqhAh3pJMk+w@...278...>
From: =?UTF-8?B?SmnFmcOtIEVuZ2VsdGhhbGVy?= <engycz@...277...>
Date: Tue, 13 Mar 2018 12:36:02 +0100
Message-ID: <CAHODtZQRb48Aa8AsxXoSnUUSLE27u-EjCOWavFJj7nwZqPYd7w@...278...>
Content-Type: multipart/alternative; boundary="f403043ee5b4c96633056749a986"
Subject: Re: [Openvpn-devel] [PATCH] Add a warning for disabled DHCP media
 sense on Window
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--f403043ee5b4c96633056749a986
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Any discussion / opinions ? Here https://github.com/OpenVPN/openvpn
/pull/97#issuecomment-372530059 one user reported, that this patch were
useful for him.

2018-01-31 14:37 GMT+01:00 Ji=C5=99=C3=AD Engelthaler <engycz@...277...>:

> Comments accepted. Thank you Selva. This patch is also as pull request
> https://github.com/OpenVPN/openvpn/pull/97
>
>
> When DHCP media sense configuration is disabled, network applications
> including DHCP client will not receive information about link status
> changes and the link seems to be always connected. This lead to the
> non-renewal DHCP address on OpenVPN connect.
>
> DHCP media sense status can by shown with command
> "netsh interface ipv4 show global"
>
> There are several reports of problems with DHCP address renewal.
> https://community.openvpn.net/openvpn/ticket/665
> https://community.openvpn.net/openvpn/ticket/807
>
> Added checking of disabled DHCP media sense and print a warning with
> forced dhcp-renew option and suggestion to enable DHCP media sense.
>
> Signed-off-by: Ji=C4=B9=E2=84=A2=C4=82=C2=AD Engelthaler <EngyCZ@...1663...=
.>
> ---
>  src/openvpn/tun.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 2644d996..c8ab8796 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -3827,6 +3827,46 @@ get_panel_reg(struct gc_arena *gc)
>      return first;
>  }
>
> +/*
> + * Return DhcpMediaSense enabled value
> + */
> +static bool
> +get_dhcp_media_sense(void)
> +{
> +    const char registry_tcpip_params[] =3D
> "SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters";
> +    const char disable_dhcp_media_sense_string[] =3D
> "DisableDHCPMediaSense";
> +    HKEY tcpip_params;
> +    LONG status;
> +    DWORD len;
> +    DWORD disable_dhcp_media_sense;
> +    DWORD data_type;
> +    bool ret_value =3D true;
> +
> +    status =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, registry_tcpip_params,
> 0, KEY_READ, &tcpip_params);
> +
> +    if (status !=3D ERROR_SUCCESS)
> +    {
> +        msg(M_WARN, "Error opening registry key: %s",
> registry_tcpip_params);
> +    }
> +    else
> +    {
> +        len =3D sizeof(disable_dhcp_media_sense);
> +        status =3D RegQueryValueEx(tcpip_params,
> disable_dhcp_media_sense_string, NULL, &data_type,
> (PBYTE)&disable_dhcp_media_sense, &len);
> +
> +        if (status =3D=3D ERROR_SUCCESS && data_type =3D=3D REG_DWORD)
> +        {
> +            if (disable_dhcp_media_sense !=3D 0)
> +            {
> +                ret_value =3D false;
> +            }
> +        }
> +
> +        RegCloseKey(tcpip_params);
> +    }
> +
> +    return ret_value;
> +}
> +
>  /*
>   * Check that two addresses are part of the same 255.255.255.252 subnet.
>   */
> @@ -5898,6 +5938,13 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>      {
>          uint32_t ep[4];
>
> +        /* Check DHCP media sense value */
> +        if (!tt->options.dhcp_renew && !get_dhcp_media_sense())
> +        {
> +            msg(M_WARN, "WARNING: DHCP media sense disabled,
> dhcp_renew option forced. You can enable media sense with \"netsh
> interface ipv4 set global dhcpmediasense=3Denabled\" shell command");
> +            tt->options.dhcp_renew =3D true;
> +        }
> +
>          /* We will answer DHCP requests with a reply to set IP/subnet
> to these values */
>          ep[0] =3D htonl(tt->local);
>          ep[1] =3D htonl(tt->adapter_netmask);
> --
> 2.14.2.windows.3
>
>
>
> 2018-01-21 23:21 GMT+01:00 Selva Nair <selva.nair@...277...>:
> > Hi,
> >
> > I haven't tested this, but looks like a useful thing to do. The code
> > looks good too. Some minor comments below:
> >
> > On Tue, Dec 5, 2017 at 7:19 AM, Ji=C5=99=C3=AD Engelthaler <EngyCZ@...1665...=
77...>
> wrote:
> >> When DHCP media sense configuration is disabled, network applications
> >> including DHCP client will not receive information about link status
> >> changes and the link seems to be always connected. This lead to the
> >> non-renewal DHCP address on OpenVPN connect.
> >>
> >> DHCP media sense status can by shown with command
> >> "netsh interface ipv4 show global"
> >>
> >> There are several reports of problems with DHCP address renewal.
> >> https://community.openvpn.net/openvpn/ticket/665
> >> https://community.openvpn.net/openvpn/ticket/807
> >>
> >> Added checking of disabled DHCP media sense and print a warning with
> >> forced dhcp-renew option and suggestion to enable DHCP media sense.
> >
> > Typo in commit header: "Window" should be "Windows"
> >
> >>
> >> Signed-off-by: Ji=C5=99=C3=AD Engelthaler <EngyCZ@...277...>
> >> ---
> >>  src/openvpn/tun.c | 59 ++++++++++++++++++++++++++++++
> +++++++++++++++++++++++++
> >>  1 file changed, 59 insertions(+)
> >>
> >> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> >> index 25831ce3..35811975 100644
> >> --- a/src/openvpn/tun.c
> >> +++ b/src/openvpn/tun.c
> >> @@ -62,6 +62,8 @@
> >>  #define NI_IP_NETMASK  (1<<1)
> >>  #define NI_OPTIONS     (1<<2)
> >>
> >> +#define TCPIP_PARAMS "SYSTEM\\CurrentControlSet\\
> Services\\Tcpip\\Parameters"
> >> +
> >
> > This is only used inside get_dhcp_media_sense. Better move it there as
> > a const char *. Less macros, the better.
> >
> >>  static void netsh_ifconfig(const struct tuntap_options *to,
> >>                             const char *flex_name,
> >>                             const in_addr_t ip,
> >> @@ -3827,6 +3829,56 @@ get_panel_reg(struct gc_arena *gc)
> >>      return first;
> >>  }
> >>
> >> +/*
> >> + * Return DhcpMediaSense enabled value
> >> + */
> >> +static bool
> >> +get_dhcp_media_sense(void)
> >> +{
> >> +    HKEY tcpip_params;
> >> +    LONG status;
> >> +    DWORD len;
> >> +    char  disable_dhcp_media_sense_string[] =3D "DisableDHCPMediaSens=
e";
> >
> > This would benefit from a const.
> >
> >> +    DWORD disable_dhcp_media_sense;
> >> +    DWORD data_type;
> >> +    bool ret_value =3D true;
> >> +
> >> +    status =3D RegOpenKeyEx(
> >> +        HKEY_LOCAL_MACHINE,
> >> +        TCPIP_PARAMS,
> >> +        0,
> >> +        KEY_READ,
> >> +        &tcpip_params);
> >
> > I'm not sure whether its specified in the newly adopted style, but
> > please avoid writing one argument per line.  Original has many such,
> > but not preferred in new code.
> >
> >> +
> >> +    if (status !=3D ERROR_SUCCESS)
> >> +    {
> >> +        msg(M_WARN, "Error opening registry key: %s", TCPIP_PARAMS);
> >> +    }
> >> +    else
> >> +    {
> >> +        len =3D sizeof(disable_dhcp_media_sense);
> >> +        status =3D RegQueryValueEx(
> >> +            tcpip_params,
> >> +            disable_dhcp_media_sense_string,
> >> +            NULL,
> >> +            &data_type,
> >> +            (PBYTE)&disable_dhcp_media_sense,
> >> +            &len);
> >
> > Same here.
> >
> >> +
> >> +        if (status =3D=3D ERROR_SUCCESS && data_type =3D=3D REG_DWORD)
> >> +        {
> >> +            if (disable_dhcp_media_sense !=3D 0)
> >> +            {
> >> +                ret_value =3D false;
> >> +            }
> >> +        }
> >> +
> >> +        RegCloseKey(tcpip_params);
> >> +    }
> >> +
> >> +    return ret_value;
> >> +}
> >> +
> >>  /*
> >>   * Check that two addresses are part of the same 255.255.255.252
> subnet.
> >>   */
> >> @@ -5901,6 +5953,13 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
> >>      {
> >>          uint32_t ep[4];
> >>
> >> +        /* Check DHCP media sense value */
> >> +        if (!tt->options.dhcp_renew && !get_dhcp_media_sense())
> >> +        {
> >> +            msg(M_WARN, "WARNING: DHCP media sense disabled,
> dhcp_renew option forced. You can enable media sense with \"netsh interfa=
ce
> ipv4 set global dhcpmediasense=3Denabled\" shell command");
> >> +            tt->options.dhcp_renew =3D true;
> >> +        }
> >> +
> >>          /* We will answer DHCP requests with a reply to set IP/subnet
> to these values */
> >>          ep[0] =3D htonl(tt->local);
> >>          ep[1] =3D htonl(tt->adapter_netmask);
> >
> > Thanks,
> >
> > Selva
>

--f403043ee5b4c96633056749a986
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">
Any discussion / opinions ? Here <a href=3D"https://github.com/OpenVPN/open=
vpn/pull/97#issuecomment-372530059" target=3D"_blank">https://github.com/<s=
pan class=3D"gmail-il">OpenVPN</span>/<wbr><span class=3D"gmail-il">openvpn=
</span>/pull/97#issuecomment-<wbr>372530059</a> one user reported, that thi=
s patch were useful for him.

<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2018-01=
-31 14:37 GMT+01:00 Ji=C5=99=C3=AD Engelthaler <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:engycz@...277..." target=3D"_blank">engycz@...277...</a>&gt;</s=
pan>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">Comments accepted. Thank you Selva.=
 This patch is also as pull request<br>
<a href=3D"https://github.com/OpenVPN/openvpn/pull/97" rel=3D"noreferrer" t=
arget=3D"_blank">https://github.com/OpenVPN/<wbr>openvpn/pull/97</a><br>
<span class=3D""><br>
<br>
When DHCP media sense configuration is disabled, network applications<br>
including DHCP client will not receive information about link status<br>
changes and the link seems to be always connected. This lead to the<br>
non-renewal DHCP address on OpenVPN connect.<br>
<br>
DHCP media sense status can by shown with command<br>
&quot;netsh interface ipv4 show global&quot;<br>
<br>
There are several reports of problems with DHCP address renewal.<br>
<a href=3D"https://community.openvpn.net/openvpn/ticket/665" rel=3D"norefer=
rer" target=3D"_blank">https://community.openvpn.net/<wbr>openvpn/ticket/66=
5</a><br>
<a href=3D"https://community.openvpn.net/openvpn/ticket/807" rel=3D"norefer=
rer" target=3D"_blank">https://community.openvpn.net/<wbr>openvpn/ticket/80=
7</a><br>
<br>
Added checking of disabled DHCP media sense and print a warning with<br>
forced dhcp-renew option and suggestion to enable DHCP media sense.<br>
<br>
</span>Signed-off-by: Ji=C4=B9=E2=84=A2=C4=82=C2=AD Engelthaler &lt;<a href=
=3D"mailto:EngyCZ@...277...">EngyCZ@...277...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/tun.c | 47 ++++++++++++++++++++++++++++++<wbr>+++++++++++=
++++++<br>
=C2=A01 file changed, 47 insertions(+)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 2644d996..c8ab8796 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -3827,6 +3827,46 @@ get_panel_reg(struct gc_arena *gc)<br>
<span class=3D"">=C2=A0 =C2=A0 =C2=A0return first;<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Return DhcpMediaSense enabled value<br>
+ */<br>
+static bool<br>
+get_dhcp_media_sense(void)<br>
+{<br>
</span>+=C2=A0 =C2=A0 const char registry_tcpip_params[] =3D<br>
<span class=3D"">&quot;SYSTEM\\CurrentControlSet\\<wbr>Services\\Tcpip\\Par=
ameters&quot;;<br>
</span>+=C2=A0 =C2=A0 const char disable_dhcp_media_sense_<wbr>string[] =3D=
 &quot;DisableDHCPMediaSense&quot;;<br>
<span class=3D"">+=C2=A0 =C2=A0 HKEY tcpip_params;<br>
+=C2=A0 =C2=A0 LONG status;<br>
+=C2=A0 =C2=A0 DWORD len;<br>
</span><span class=3D"">+=C2=A0 =C2=A0 DWORD disable_dhcp_media_sense;<br>
+=C2=A0 =C2=A0 DWORD data_type;<br>
+=C2=A0 =C2=A0 bool ret_value =3D true;<br>
+<br>
</span>+=C2=A0 =C2=A0 status =3D RegOpenKeyEx(HKEY_LOCAL_<wbr>MACHINE, regi=
stry_tcpip_params,<br>
0, KEY_READ, &amp;tcpip_params);<br>
<span class=3D"">+<br>
+=C2=A0 =C2=A0 if (status !=3D ERROR_SUCCESS)<br>
+=C2=A0 =C2=A0 {<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;Error opening registr=
y key: %s&quot;, registry_tcpip_params);<br>
<span class=3D"">+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D sizeof(disable_dhcp_media_<wbr>sense);=
<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D RegQueryValueEx(tcpip_params=
,<br>
disable_dhcp_media_sense_<wbr>string, NULL, &amp;data_type,<br>
(PBYTE)&amp;disable_dhcp_media_<wbr>sense, &amp;len);<br>
<span class=3D"">+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status =3D=3D ERROR_SUCCESS &amp;&amp; dat=
a_type =3D=3D REG_DWORD)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (disable_dhcp_media_sense !=
=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret_value =3D fals=
e;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RegCloseKey(tcpip_params);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return ret_value;<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Check that two addresses are part of the same 255.255.255.252 subn=
et.<br>
=C2=A0 */<br>
</span>@@ -5898,6 +5938,13 @@ open_tun(const char *dev, const char *dev_typ=
e,<br>
<span class=3D"im HOEnZb">const char *dev_node, struct tun<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ep[4];<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check DHCP media sense value */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tt-&gt;options.dhcp_renew &amp;&amp; !get=
_dhcp_media_sense())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;WARNING: DHCP =
media sense disabled,<br>
dhcp_renew option forced. You can enable media sense with \&quot;netsh<br>
interface ipv4 set global dhcpmediasense=3Denabled\&quot; shell command&quo=
t;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt-&gt;options.dhcp_renew =3D tr=
ue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We will answer DHCP requests with a re=
ply to set IP/subnet<br>
to these values */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ep[0] =3D htonl(tt-&gt;local);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ep[1] =3D htonl(tt-&gt;adapter_netmask);<=
br>
</span><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.14.2.windows.3<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<br>
2018-01-21 23:21 GMT+01:00 Selva Nair &lt;<a href=3D"mailto:selva.nair@...1665...=
77...">selva.nair@...277...</a>&gt;:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I haven&#39;t tested this, but looks like a useful thing to do. The co=
de<br>
&gt; looks good too. Some minor comments below:<br>
&gt;<br>
&gt; On Tue, Dec 5, 2017 at 7:19 AM, Ji=C5=99=C3=AD Engelthaler &lt;<a href=
=3D"mailto:EngyCZ@...277...">EngyCZ@...277...</a>&gt; wrote:<br>
&gt;&gt; When DHCP media sense configuration is disabled, network applicati=
ons<br>
&gt;&gt; including DHCP client will not receive information about link stat=
us<br>
&gt;&gt; changes and the link seems to be always connected. This lead to th=
e<br>
&gt;&gt; non-renewal DHCP address on OpenVPN connect.<br>
&gt;&gt;<br>
&gt;&gt; DHCP media sense status can by shown with command<br>
&gt;&gt; &quot;netsh interface ipv4 show global&quot;<br>
&gt;&gt;<br>
&gt;&gt; There are several reports of problems with DHCP address renewal.<b=
r>
&gt;&gt; <a href=3D"https://community.openvpn.net/openvpn/ticket/665" rel=
=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/<wbr>openvp=
n/ticket/665</a><br>
&gt;&gt; <a href=3D"https://community.openvpn.net/openvpn/ticket/807" rel=
=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/<wbr>openvp=
n/ticket/807</a><br>
&gt;&gt;<br>
&gt;&gt; Added checking of disabled DHCP media sense and print a warning wi=
th<br>
&gt;&gt; forced dhcp-renew option and suggestion to enable DHCP media sense=
.<br>
&gt;<br>
&gt; Typo in commit header: &quot;Window&quot; should be &quot;Windows&quot=
;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Ji=C5=99=C3=AD Engelthaler &lt;<a href=3D"mailto:En=
gyCZ@...277...">EngyCZ@...277...</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 src/openvpn/tun.c | 59 ++++++++++++++++++++++++++++++<wbr>++=
+++++++++++++++++++++++<br>
&gt;&gt;=C2=A0 1 file changed, 59 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
&gt;&gt; index 25831ce3..35811975 100644<br>
&gt;&gt; --- a/src/openvpn/tun.c<br>
&gt;&gt; +++ b/src/openvpn/tun.c<br>
&gt;&gt; @@ -62,6 +62,8 @@<br>
&gt;&gt;=C2=A0 #define NI_IP_NETMASK=C2=A0 (1&lt;&lt;1)<br>
&gt;&gt;=C2=A0 #define NI_OPTIONS=C2=A0 =C2=A0 =C2=A0(1&lt;&lt;2)<br>
&gt;&gt;<br>
&gt;&gt; +#define TCPIP_PARAMS &quot;SYSTEM\\CurrentControlSet\\<wbr>Servic=
es\\Tcpip\\Parameters&quot;<br>
&gt;&gt; +<br>
&gt;<br>
&gt; This is only used inside get_dhcp_media_sense. Better move it there as=
<br>
&gt; a const char *. Less macros, the better.<br>
&gt;<br>
&gt;&gt;=C2=A0 static void netsh_ifconfig(const struct tuntap_options *to,<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *flex_name,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const in_addr_t ip,<br>
&gt;&gt; @@ -3827,6 +3829,56 @@ get_panel_reg(struct gc_arena *gc)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 return first;<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; +/*<br>
&gt;&gt; + * Return DhcpMediaSense enabled value<br>
&gt;&gt; + */<br>
&gt;&gt; +static bool<br>
&gt;&gt; +get_dhcp_media_sense(void)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 HKEY tcpip_params;<br>
&gt;&gt; +=C2=A0 =C2=A0 LONG status;<br>
&gt;&gt; +=C2=A0 =C2=A0 DWORD len;<br>
&gt;&gt; +=C2=A0 =C2=A0 char=C2=A0 disable_dhcp_media_sense_<wbr>string[] =
=3D &quot;DisableDHCPMediaSense&quot;;<br>
&gt;<br>
&gt; This would benefit from a const.<br>
&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 DWORD disable_dhcp_media_sense;<br>
&gt;&gt; +=C2=A0 =C2=A0 DWORD data_type;<br>
&gt;&gt; +=C2=A0 =C2=A0 bool ret_value =3D true;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 status =3D RegOpenKeyEx(<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 HKEY_LOCAL_MACHINE,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCPIP_PARAMS,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 KEY_READ,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;tcpip_params);<br>
&gt;<br>
&gt; I&#39;m not sure whether its specified in the newly adopted style, but=
<br>
&gt; please avoid writing one argument per line.=C2=A0 Original has many su=
ch,<br>
&gt; but not preferred in new code.<br>
&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (status !=3D ERROR_SUCCESS)<br>
&gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;Error opening regis=
try key: %s&quot;, TCPIP_PARAMS);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 else<br>
&gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D sizeof(disable_dhcp_media_<wb=
r>sense);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D RegQueryValueEx(<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcpip_params,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disable_dhcp_media_sens=
e_<wbr>string,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;data_type,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (PBYTE)&amp;disable_dhc=
p_media_<wbr>sense,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;len);<br>
&gt;<br>
&gt; Same here.<br>
&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status =3D=3D ERROR_SUCCESS &amp;=
&amp; data_type =3D=3D REG_DWORD)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (disable_dhcp_media_=
sense !=3D 0)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret_value=
 =3D false;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 RegCloseKey(tcpip_params);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 return ret_value;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 /*<br>
&gt;&gt;=C2=A0 =C2=A0* Check that two addresses are part of the same 255.25=
5.255.252 subnet.<br>
&gt;&gt;=C2=A0 =C2=A0*/<br>
&gt;&gt; @@ -5901,6 +5953,13 @@ open_tun(const char *dev, const char *dev_t=
ype, const char *dev_node, struct tun<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t ep[4];<br>
&gt;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check DHCP media sense value */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tt-&gt;options.dhcp_renew &amp;&=
amp; !get_dhcp_media_sense())<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;WARNI=
NG: DHCP media sense disabled, dhcp_renew option forced. You can enable med=
ia sense with \&quot;netsh interface ipv4 set global dhcpmediasense=3Denabl=
ed\&quot; shell command&quot;);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt-&gt;options.dhcp_ren=
ew =3D true;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We will answer DHCP requests =
with a reply to set IP/subnet to these values */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ep[0] =3D htonl(tt-&gt;local);<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ep[1] =3D htonl(tt-&gt;adapter_n=
etmask);<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Selva<br>
</div></div></blockquote></div><br></div>

--f403043ee5b4c96633056749a986--

