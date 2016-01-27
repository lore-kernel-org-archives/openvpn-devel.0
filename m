MIME-Version: 1.0
In-Reply-To: <20160127082046.GY24952@...1296...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<20160126191913.GV24952@...1296...> <56A7D1F6.8030805@...515...>
	<20160126212431.GW24952@...1296...>
	<CAKuzo_jKX6+KAw3cfPR-VTGe1A_bMh=R93i+4p=eC4BbCqWtAg@...278...>
	<56A87C5A.3050104@...515...> <20160127082046.GY24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 27 Jan 2016 10:37:33 -0500
Message-ID: <CAKuzo_gzKE9p+fev58_5dJZps=8tKXbLVu6jEnCH0wBdhHWMnA@...278...>
Content-Type: multipart/alternative; boundary=001a1137d28adb6ad7052a529553
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
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

--001a1137d28adb6ad7052a529553
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2016 at 3:20 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Wed, Jan 27, 2016 at 10:14:18AM +0200, Samuli Sepp=C3=A4nen wrote:
> > An added bonus is that openvpnserv2 is written in C#, which means it can
> > be developed on Linux using Mono, and the language choice probably helps
> > getting new contributions from people not fluent with C.
>
> I'm not totally convinced that "mixing in a new language" is a *bonus*
> (as it means that the core team won't be able to help unless also fluent
> with the other language).
>

Currently the service is a part of the openvpn repo, but there is no reason
to keep it thus. In fact, once the interactive service is available, in my
view, it may not be even necessary to ship the original service with the
windows binary distribution. Only advanced users would need the original
service or its equivalent (openvpnserv2 or NSSM) usage of which could be
made available as documentation in the wiki pages.


>
> Given that services run with maximum privileges, strong review is as
> important there as for core openvpn...
>
> If the only reason why everyone is disliking the old openvpnserv is
> "it is not restarting openvpn.exe when it breaks" - *that* should be
> fairly easy to add.  So, what is that people consider "broken"?
>

Although it is called a service, it only works like a one time task or an
rc script. However, unlike a startup script, it does not terminate after
spawning openvpn.exe processes, giving it the appearance of a service. It
does not keep track of the spawned processes, has no way of knowing any of
the processes stopped or crashed, has no way of editing one config and then
restart only that connection leaving others up etc.

Having said that, on the only windows 10 machine I have, the original
service works the same way as on Windows 7. Early reports of "not working
on windows 10" might have had more to do with unrelated TAP6 issues.

Selva

--001a1137d28adb6ad7052a529553
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Jan 27, 2016 at 3:20 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div style=3D"overflow:hidden">H=
i,<br>
<span><br>
On Wed, Jan 27, 2016 at 10:14:18AM +0200, Samuli Sepp=C3=A4nen wrote:<br>
&gt; An added bonus is that openvpnserv2 is written in C#, which means it c=
an<br>
&gt; be developed on Linux using Mono, and the language choice probably hel=
ps<br>
&gt; getting new contributions from people not fluent with C.<br>
<br>
</span>I&#39;m not totally convinced that &quot;mixing in a new language&qu=
ot; is a *bonus*<br>
(as it means that the core team won&#39;t be able to help unless also fluen=
t<br>
with the other language).<br></div></blockquote><div><br></div><div>Current=
ly the service is a part of the openvpn repo, but there is no reason to kee=
p it thus. In fact, once the interactive service is available, in my view, =
it may not be even necessary to ship the original service with the windows =
binary distribution. Only advanced users would need the original service or=
 its equivalent (openvpnserv2 or NSSM) usage of which could be made availab=
le as documentation in the wiki pages.</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><div style=3D"overflow:hidden">
<br>
Given that services run with maximum privileges, strong review is as<br>
important there as for core openvpn...<br>
<br>
If the only reason why everyone is disliking the old openvpnserv is<br>
&quot;it is not restarting openvpn.exe when it breaks&quot; - *that* should=
 be<br>
fairly easy to add.=C2=A0 So, what is that people consider &quot;broken&quo=
t;?</div></blockquote></div><br>Although it is called a service, it only wo=
rks like a one time task or an rc script. However, unlike a startup script,=
 it does not terminate after spawning openvpn.exe processes, giving it the =
appearance of a service. It does not keep track of the spawned processes, h=
as no way of knowing any of the processes stopped or crashed, has no way of=
 editing one config and then restart only that connection leaving others up=
 etc.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=
Having said that, on the only windows 10 machine I have, the original servi=
ce works the same way as on Windows 7. Early reports of &quot;not working o=
n windows 10&quot; might have had more to do with unrelated TAP6 issues.</d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</d=
iv></div>

--001a1137d28adb6ad7052a529553--

