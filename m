MIME-Version: 1.0
In-Reply-To: <940951cb-b3e9-f2e9-dea8-43a848bce446@...515...>
References: <586339C7.2606.801611@...2224...>
	<940951cb-b3e9-f2e9-dea8-43a848bce446@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 29 Dec 2016 14:06:49 -0500
Message-ID: <CAKuzo_jG4Qe9oidqkH0Cy63puNTNimQORtFCEDFZvKVajz-vdg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c07481ccc64a60544d0ca20
Subject: Re: [Openvpn-devel] Fwd: Re: [Openvpn-announce] OpenVPN 2.4.0
	released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c07481ccc64a60544d0ca20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 29, 2016 at 5:53 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

> Hi,
>
> Any comments about the forwarded email? Is our documentation regarding
> "or-highest" correct?
>
> Samuli
>
>
> -------- Messaggio Inoltrato --------
> Oggetto:        Re: [Openvpn-announce] OpenVPN 2.4.0 released
> Data:   Tue, 27 Dec 2016 22:04:23 -0600
> Mittente:       Michael French <Mike@...2223...>
> A:      Samuli Sepp=C3=A4nen <samuli@...515...>
>
>
>
> Hi Samuli,
> I installed 2.4 on a couple Windows 7x64 computers and all seems well.
> I even got tls-crypt to work using the old ta.key file on both client
> and server.
>
> However, I noticed in the documentation for 2.4 that the parameter
> tls-version-min is supposed to work with the 'or-highest' option, but it
> does not.
>
> I wish that it did work because I always want to run with the most
> secure version of TLS and the 'or-highest' option would save me the
> trouble of manually editing the TLS number every time it changes.
>

I too find this option somewhat counter-intuitive. I think you can
effectively get it set to the highest available version by specifying an
insanely large number as the first parameter. For example,

--tls-version-min 5.0 or-highest

As 5.0 is larger than any available versions, the minimum will get set to
the highest available (say 1.2).

However, that will also make it impossible to connect to a server that
doesn't support the said version.

Selva

--94eb2c07481ccc64a60544d0ca20
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Dec 29, 2016 at 5:53 AM, Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt=
;<a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":2nh" class=
=3D"a3s aXjCH m1594a39dc0165a81">Hi,<br>
<br>
Any comments about the forwarded email? Is our documentation regarding<br>
&quot;or-highest&quot; correct?<br>
<br>
Samuli<br>
<br>
<br>
-------- Messaggio Inoltrato --------<br>
Oggetto:=C2=A0 =C2=A0 =C2=A0 =C2=A0 Re: [Openvpn-announce] OpenVPN 2.4.0 re=
leased<br>
Data:=C2=A0 =C2=A0Tue, 27 Dec 2016 22:04:23 -0600<br>
Mittente:=C2=A0 =C2=A0 =C2=A0 =C2=A0Michael French &lt;<a href=3D"mailto:Mi=
ke@...2223...">Mike@...2223...</a>&gt;<br>
A:=C2=A0 =C2=A0 =C2=A0 Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samuli@...1186...=
.515...">samuli@...515...</a>&gt;<br>
<br>
<br>
<br>
Hi Samuli,<br>
I installed 2.4 on a couple Windows 7x64 computers and all seems well.<br>
I even got tls-crypt to work using the old ta.key file on both client<br>
and server.<br>
<br>
However, I noticed in the documentation for 2.4 that the parameter<br>
tls-version-min is supposed to work with the &#39;or-highest&#39; option, b=
ut it<br>
does not.<br>
<br>
I wish that it did work because I always want to run with the most<br>
secure version of TLS and the &#39;or-highest&#39; option would save me the=
<br>
trouble of manually editing the TLS number every time it changes.</div></bl=
ockquote></div><br></div><div class=3D"gmail_extra">I too find this option =
somewhat counter-intuitive. I think you can effectively get it set to the h=
ighest available version by specifying an insanely large number as the firs=
t parameter. For example,<br><br></div><div class=3D"gmail_extra">--tls-ver=
sion-min 5.0 or-highest<br><br></div><div class=3D"gmail_extra">As 5.0 is l=
arger than any available versions, the minimum will get set to the highest =
available (say 1.2). <br><br>However, that will also make it impossible to =
connect to a server that doesn&#39;t support the said version.<br><br></div=
><div class=3D"gmail_extra">Selva<br></div></div>

--94eb2c07481ccc64a60544d0ca20--

