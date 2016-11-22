MIME-Version: 1.0
In-Reply-To: <1479814716-20116-1-git-send-email-arne@...1227...>
References: <1479679988-3918-1-git-send-email-arne@...1227...>
	<1479814716-20116-1-git-send-email-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 22 Nov 2016 11:33:36 -0500
Message-ID: <CAKuzo_hS0OYK1DDtTdr-sxYooG1H6mYoSHzyBjRdEp9C8uRbdA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0438e0b7aaef0541e65604
Subject: Re: [Openvpn-devel] [PATCHv2] Handle DNS6 option on Android
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0438e0b7aaef0541e65604
Content-Type: text/plain; charset=UTF-8

Hi,
On Tue, Nov 22, 2016 at 6:38 AM, Arne Schwabe <arne@...1227...> wrote:
...


> -  for (i = 0; i < tt->options.dns_len; ++i) {
> +  /* Prefer IPv6 DNS servers,
> +   * Android will use the DNS server in the order we specify*/
> +  for (int i = 0; i < tt->options.dns6_len; i++) {
> +    management_android_control (management, "DNS6SERVER",
> +                               print_in6_addr (tt->options.dns6[i], 0,
> &gc));
> +  }
> +
> +  for (int i = 0; i < tt->options.dns_len; i++) {
>      management_android_control (management, "DNSSERVER",
>                                 print_in_addr_t(tt->options.dns[i], 0,
> &gc));
>    }


The code looks good to me, so ACK
(Note: the preferred comment closing style may be '*/' on a line by
itself?).

Selva

--94eb2c0438e0b7aaef0541e65604
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>On Tue, Nov 22, 2016 at 6:38 AM, Arne Schwabe &lt;=
<a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:</div><div=
>...</div><div><br><div class=3D"gmail_extra"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;pad=
ding-left:1ex"><span><br>
-=C2=A0 for (i =3D 0; i &lt; tt-&gt;options.dns_len; ++i) {<br>
</span>+=C2=A0 /* Prefer IPv6 DNS servers,<br>
+=C2=A0 =C2=A0* Android will use the DNS server in the order we specify*/<b=
r>
<span class=3D"gmail-m_3832136897675760762m_4352108126340254386m_4498701772=
296070375gmail-m_8183452370917178626gmail-m_3764913519799322067im gmail-m_3=
832136897675760762m_4352108126340254386m_4498701772296070375gmail-m_8183452=
370917178626gmail-m_3764913519799322067HOEnZb">+=C2=A0 for (int i =3D 0; i =
&lt; tt-&gt;options.dns6_len; i++) {<br>
+=C2=A0 =C2=A0 management_android_control (management, &quot;DNS6SERVER&quo=
t;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_in6_addr (tt-&gt;options.dns6[i=
], 0, &amp;gc));<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 for (int i =3D 0; i &lt; tt-&gt;options.dns_len; i++) {<br>
=C2=A0 =C2=A0 =C2=A0management_android_control (management, &quot;DNSSERVER=
&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_in_addr_t(tt-&gt;options.dn<wb=
r>s[i], 0, &amp;gc));<br>
=C2=A0 =C2=A0}</span></blockquote><div><br></div><div>The code looks good t=
o me, so ACK=C2=A0</div><div>(Note: the preferred comment closing style may=
 be &#39;*/&#39; on a line by itself?).=C2=A0</div><div><br></div><div>Selv=
a=C2=A0</div></div></div></div></div>

--94eb2c0438e0b7aaef0541e65604--

