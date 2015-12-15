MIME-Version: 1.0
In-Reply-To: <20151215205402.GV24952@...1296...>
References: <1450191626-24633-1-git-send-email-samuli@...515...>
	<A9F464ED000E41E49522FF9AE5BCBC84@...2089...>
	<CAKuzo_j-nHghOXSW67kmQyQVk1zOH6tij=Tdf5pD-wFYwn-yUg@...278...>
	<20151215205402.GV24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 15 Dec 2015 16:12:25 -0500
Message-ID: <CAKuzo_g4J=4ZYV9CiWhm5B3LCASxdRTL7jkKHcFby0WA7x88vA@...278...>
Content-Type: multipart/alternative; boundary=001a11444d643bc8590526f640d5
Subject: Re: [Openvpn-devel] [PATCH] Updates to Changes.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11444d643bc8590526f640d5
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, Dec 15, 2015 at 3:54 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, Dec 15, 2015 at 12:25:23PM -0500, Selva Nair wrote:
>
> > 2. release/2.3 (and upcoming 2.3.9)
> > - May be built for target = winxp
> >   (this is the default target in openvpn-build if release/2.3 source is
> > used)
> > - Support for --block-outside-dns determined automatically at run-time:
> >      when run on vista and above the option will be supported
> >      when run on winxp the option will be ignored or cause
> >      a fatal error depending on how it is specified:
> >         if pushed from a server: just a warning in the logs
> >         specified in the config: fatal error unless protected by
> >         ignore-unknown-option or setenv-opt or forward-compatible...
>
> Make that "setenv opt block-outside-dns".  ignore-unknown-option will
> *not* help here, as it is not "unknown", but just "not working".
>

You are right, ignore-unknown .. would have worked with valdikSS patch,
but not any more as its handled right away at msglevel_fc. Which is a
bit disconcerting as on non-windows platforms ignore-unknown-option will
make it non-FATAL but not on XP.

My original comment about this to an early version of valdikSS' patch
was on a different level -- if the user want DNS blocked, failure to block
should be FATAL. But not respecting ignore-unknown-option only on
some platforms doesn't look right.

Selva

--001a11444d643bc8590526f640d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Tue, Dec 15, 2015 at 3:54 PM, Ge=
rt Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div id=3D":4c0" class=3D"a3s" style=3D"overflow:hidden">Hi,<br>
<br>
On Tue, Dec 15, 2015 at 12:25:23PM -0500, Selva Nair wrote:<br><br>
&gt; 2. release/2.3 (and upcoming 2.3.9)<br>
&gt; - May be built for target =3D winxp<br>
&gt;=C2=A0 =C2=A0(this is the default target in openvpn-build if release/2.=
3 source is<br>
&gt; used)<br>
&gt; - Support for --block-outside-dns determined automatically at run-time=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 when run on vista and above the option will be sup=
ported<br>
&gt;=C2=A0 =C2=A0 =C2=A0 when run on winxp the option will be ignored or ca=
use<br>
&gt;=C2=A0 =C2=A0 =C2=A0 a fatal error depending on how it is specified:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if pushed from a server: just a warni=
ng in the logs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0specified in the config: fatal error =
unless protected by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ignore-unknown-option or setenv-opt o=
r forward-compatible...<br>
<br>
Make that &quot;setenv opt block-outside-dns&quot;.=C2=A0 ignore-unknown-op=
tion will<br>
*not* help here, as it is not &quot;unknown&quot;, but just &quot;not worki=
ng&quot;.<br></div></blockquote><div><br></div><div>You are right, ignore-u=
nknown .. would have worked with valdikSS patch, <br>but not any more as it=
s handled right away at msglevel_fc. Which is a<br></div><div>bit disconcer=
ting as on non-windows platforms ignore-unknown-option will <br>make it non=
-FATAL but not on XP. <br><br></div><div>My original comment about this to =
an early version of valdikSS&#39; patch <br>was on a different level -- if =
the user want DNS blocked, failure to block <br>should be FATAL. But not re=
specting ignore-unknown-option only on<br>some platforms doesn&#39;t look r=
ight.<br></div><div><br></div><div>Selva<br></div></div><br></div></div>

--001a11444d643bc8590526f640d5--

