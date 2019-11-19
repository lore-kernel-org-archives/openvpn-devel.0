MIME-Version: 1.0
References: <CAGyAFMWXS9F3OzSchqGtizgBoj+7E5JTEnKrnCQqMiejTuHs4g@...278...>
 <1573234655-905-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1573234655-905-1-git-send-email-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 18 Nov 2019 23:17:33 -0500
Message-ID: <CAKuzo_iQD0ehZHisNQyTN1LtcwEogAgdTOBouPrbBb5OPyg8uA@...278...>
Content-Type: multipart/alternative; boundary="000000000000d885d80597ab5834"
Subject: Re: [Openvpn-devel] [PATCH v3] wintun: add --windows-driver config
 option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--000000000000d885d80597ab5834
Content-Type: text/plain; charset="UTF-8"

Hi,

I have been late to this wintun party (no time for anything fun, these days)
and this has already been committed, it seems. But some concerns below..


> +    /* for wintun kernel doesn't send DHCP requests, so use ipapi to set
> IP address and netmask */
> +    if (options->wintun)
> +    {
> +        options->tuntap_options.ip_win32_type = IPW32_SET_IPAPI;
> +    }
>

Looks like this will most likely break any dhcp-related options
in the client config.. Say "dhcp-option DNS xxx". We currently require
ip_win32_type to be  adaptive or dynamic when such options are specified.
I think we should set this to adaptive here, and then handle it in tun.c

Although there is no dhcp when wintun is used, we'll still support
dhcp-options such as DNS etc using netsh or service, right?

Selva

--000000000000d885d80597ab5834
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I have been late to this=
 wintun party (no time for anything fun, these days)</div><div>and this has=
 already been committed, it seems. But some concerns below..</div><div><br>=
</div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><br>
+=C2=A0 =C2=A0 /* for wintun kernel doesn&#39;t send DHCP requests, so use =
ipapi to set IP address and netmask */<br>
+=C2=A0 =C2=A0 if (options-&gt;wintun)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;tuntap_options.ip_win32_type =3D I=
PW32_SET_IPAPI;<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Looks like this will m=
ost likely break any dhcp-related options</div><div>in the client config.. =
Say &quot;dhcp-option DNS xxx&quot;. We currently require=C2=A0</div><div>i=
p_win32_type to be=C2=A0 adaptive or dynamic when such options are specifie=
d.</div><div>I think we should set this to adaptive here, and then handle i=
t in tun.c</div><div><br></div><div>Although there is no dhcp when wintun i=
s used, we&#39;ll still support</div><div>dhcp-options such as DNS etc usin=
g netsh or service, right?</div><div><br></div><div>Selva</div></div></div>

--000000000000d885d80597ab5834--

