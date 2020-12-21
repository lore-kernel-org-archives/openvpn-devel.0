MIME-Version: 1.0
References: <20201220105430.GP976@...1296...>
 <093511bd-43c0-a37c-1d8f-335d9df451d6@...1227...>
 <20201220185402.GQ976@...1296...>
In-Reply-To: <20201220185402.GQ976@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 20 Dec 2020 19:31:42 -0500
Message-ID: <CAKuzo_ja=a9XxHkQX5Vv2_UTT1vWNfO8S-XLvvKZ_CQ6f-U1uQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000f7574b05b6ee95fd"
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000f7574b05b6ee95fd
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, Dec 20, 2020 at 5:38 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Sun, Dec 20, 2020 at 04:00:13PM +0100, Arne Schwabe wrote:
> > > ... and the client would then either print this on the console
> > > (if !management) or dump it to management, where the GUI/Tunnelblick
> > > could pick it up and create a popup window.
> > >
> > See --echo.  That is basically what you desribe as info-msg in your mail
>
> While echo sounds as if it would do what I want, it doesn't.
>
> Echo is "something magic" - it is never printed by the 2.x client, it
> is not even logged.  And it's not displayed by the GUIs either, but
> instead it can be used to "do things"...
>

The "not  getting logged" concern is easy to fix.

What echo does is to get a message from the server to the client-side UI.
Currently GUI's do not display them because so far the only meanings we
have assigned to echo commands are as directives like save-password or
forget-password.

But that doesn't mean we can't use them for messages.And, that's exactly
what we discussed 3 years ago -- see the draft implementation from Nov 2017
that I posted. Here is the link again.
https://github.com/selvanair/openvpn-gui/releases/tag/v11-echo-msg
I got no feedback then nor now.


> So less "echo to user" but "send this string to the management interface
> and make the mgmt client do something magic"...
>

A message to the user can be delivered in a useful fashion only if there is
a UI. The core itself can only write the message to log which may not be
seen in time, or to the console if one exists. And, IMO, any decent UI of
openvpn should use the management interface -- almost all do (except NM?).

I thought we already went through this when we discussed the proposed "echo
msg" in considerable detail 3 years ago.

Selva

--000000000000f7574b05b6ee95fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Sun, Dec 20, 2020 at 5:38 PM Gert Doering &lt;<=
a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Sun, Dec 20, 2020 at 04:00:13PM +0100, Arne Schwabe wrote:<br>
&gt; &gt; ... and the client would then either print this on the console<br>
&gt; &gt; (if !management) or dump it to management, where the GUI/Tunnelbl=
ick<br>
&gt; &gt; could pick it up and create a popup window.<br>
&gt; &gt;<br>
&gt; See --echo.=C2=A0 That is basically what you desribe as info-msg in yo=
ur mail<br>
<br>
While echo sounds as if it would do what I want, it doesn&#39;t.<br>
<br>
Echo is &quot;something magic&quot; - it is never printed by the 2.x client=
, it<br>
is not even logged.=C2=A0 And it&#39;s not displayed by the GUIs either, bu=
t<br>
instead it can be used to &quot;do things&quot;...<br></blockquote><div><br=
></div>The &quot;not=C2=A0 getting logged&quot; concern is easy to fix.=C2=
=A0</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Wh=
at echo does is to get a=C2=A0message from the server to the client-side UI=
. Currently GUI&#39;s do not display them because so far the only meanings =
we have assigned to echo commands are as directives like save-password or f=
orget-password.</div><div class=3D"gmail_quote"><br></div><div class=3D"gma=
il_quote">But that doesn&#39;t mean we can&#39;t use them for messages.And,=
 that&#39;s exactly what we discussed 3 years ago -- see the draft implemen=
tation from Nov 2017 that I posted. Here is the link again.</div><div class=
=3D"gmail_quote"><a href=3D"https://github.com/selvanair/openvpn-gui/releas=
es/tag/v11-echo-msg" target=3D"_blank">https://github.com/selvanair/openvpn=
-gui/releases/tag/v11-echo-msg</a>=C2=A0=C2=A0<br></div><div class=3D"gmail=
_quote">I got no feedback then nor now.</div><div class=3D"gmail_quote"><br=
></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
So less &quot;echo to user&quot; but &quot;send this string to the manageme=
nt interface<br>
and make the mgmt client do something magic&quot;...<br></blockquote><div><=
br></div><div>A message to the user can be delivered in a useful fashion on=
ly if there is a UI. The core itself can only write the message to log whic=
h may not be seen in time, or to the console if one exists. And, IMO, any d=
ecent UI of openvpn should use the management interface -- almost all do (e=
xcept NM?).</div><div><br></div><div>I thought we already went through this=
 when we discussed the proposed &quot;echo msg&quot; in considerable detail=
 3 years ago.</div><div><br></div><div>Selva</div></div></div>

--000000000000f7574b05b6ee95fd--

