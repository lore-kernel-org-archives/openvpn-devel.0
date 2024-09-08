MIME-Version: 1.0
References: <20240906103734.36633-1-frank@...2641...>
 <202409082041.488KfLeN094702@...2054...>
In-Reply-To: <202409082041.488KfLeN094702@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 8 Sep 2024 18:44:24 -0400
Message-ID: <CAKuzo_jPJ1WPBTn8hwOcwR=sx18j-KgHfbKF9WKOOdYgOZX7RQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000c28cb00621a36202"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Interpret --key and --cert
 option argument as URI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000c28cb00621a36202
Content-Type: text/plain; charset="UTF-8"

>
>
>   But anyway, there might be an undefined variable lurking
> in
>
>         /* If pkcs#11 Use custom prompt similar to pkcs11-helper */
>         if (strstr(prompt, "PKCS#11"))
>         {
>             struct user_pass up;
>             get_user_pass(&up, NULL, "PKCS#11 token", ...
>
> "up" is not initialized, and the first thing get_user_pass_cr() does
> is look at "if (!up->defined)".  So if I'm not misreading this, a
> followup patch to initialize "up" would be good.  At this point it
> might be nice to add a comment explaining how the wrapping of
> "pem_password_callback()" works ;-)
>

Thanks for catching this. A patch is on its way.

Selva

--000000000000c28cb00621a36202
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br>=C2=A0 But anyway, there might be an undefined varia=
ble lurking<br>
in<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If pkcs#11 Use custom prompt similar to pkcs=
11-helper */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strstr(prompt, &quot;PKCS#11&quot;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct user_pass up;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_user_pass(&amp;up, NULL, &quo=
t;PKCS#11 token&quot;, ...<br>
<br>
&quot;up&quot; is not initialized, and the first thing get_user_pass_cr() d=
oes<br>
is look at &quot;if (!up-&gt;defined)&quot;.=C2=A0 So if I&#39;m not misrea=
ding this, a<br>
followup patch to initialize &quot;up&quot; would be good.=C2=A0 At this po=
int it<br>
might be nice to add a comment explaining how the wrapping of<br>
&quot;pem_password_callback()&quot; works ;-)<br></blockquote><div><br></di=
v><div>Thanks for catching this. A patch is on its way.</div><div><br></div=
><div>Selva</div></div></div>

--000000000000c28cb00621a36202--

