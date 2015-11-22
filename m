MIME-Version: 1.0
In-Reply-To: <20151122163048.GI24952@...1296...>
References: <1447271171-29141-2-git-send-email-selva.nair@...277...>
	<1447728489-14991-1-git-send-email-selva.nair@...277...>
	<20151122151858.GH24952@...1296...>
	<CAKuzo_jFMSQb98pS8mEeujbRs6WXi9a+aaFGbc6GwKa0ANyD6A@...278...>
	<20151122163048.GI24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 22 Nov 2015 11:50:06 -0500
Message-ID: <CAKuzo_goXu48At9MJzSy=FcAvXhQ5fL2mCKU=nQ+UbdTDUbSHA@...278...>
Content-Type: multipart/alternative; boundary=001a1147471cbe861f052523e78f
Subject: Re: [Openvpn-devel] [PATCH] Handle ctrl-C and ctrl-break events on
	Windows
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

--001a1147471cbe861f052523e78f
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Nov 22, 2015 at 11:30 AM, Gert Doering <gert@...1296...> wrote:

> On Sun, Nov 22, 2015 at 10:49:13AM -0500, Selva Nair wrote:
> >its safer to setup nssm with a delay of  2500 msec
> > between ctrl-C and 'kill without prejudice' (aka Terminate).
>
> Ah, yes.  Thanks :-)  (you and Samuli need to work on the NSSM setup stuff
> then, I don't have an eye on the windows stuff, so won't be able to track
> this so it's not getting lost)
>

For now we only need to add it in the wiki entry on nssm -- I'll try to
edit it or request Samuli. Then if/when we replace the 'aService' with nssm
or start shipping an nssm script, it could be taken from the wiki example.


>
> > [*} actually with exit-notify n, it should only take n-1 seconds to send
> n
> > notifies, but integer arithmetic makes it always a little more than n-1.
> > And for some reason it appears to wait a second even if another notify
> > doesn't have to be sent. I've not looked into that part of the code
> > carefully...
>
> Our timer granularity is "1 second" for most stuff, and we tend to add
> another second "just to be sure"... ran into this when trying to speed
> up client PUSH_REQUEST sending in commit afb93fac803f
>

Well, that explains it. Thanks.

Selva

--001a1147471cbe861f052523e78f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Sun, Nov 22, 2015 at 11:30 AM, Gert Doering <span dir=3D"ltr=
">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">
On Sun, Nov 22, 2015 at 10:49:13AM -0500, Selva Nair wrote:<br>&gt;its safe=
r to setup nssm with a delay of=C2=A0 2500 msec<br>
&gt; between ctrl-C and &#39;kill without prejudice&#39; (aka Terminate).<b=
r>
<br>
</span>Ah, yes.=C2=A0 Thanks :-)=C2=A0 (you and Samuli need to work on the =
NSSM setup stuff<br>
then, I don&#39;t have an eye on the windows stuff, so won&#39;t be able to=
 track<br>
this so it&#39;s not getting lost)<br></blockquote><div><br></div><div>For =
now we only need to add it in the wiki entry on nssm -- I&#39;ll try to edi=
t it or request Samuli. Then if/when we replace the &#39;aService&#39; with=
 nssm or start shipping an nssm script, it could be taken from the wiki exa=
mple.<br>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt; [*} actually with exit-notify n, it should only take n-1 seconds to se=
nd n<br>
&gt; notifies, but integer arithmetic makes it always a little more than n-=
1.<br>
&gt; And for some reason it appears to wait a second even if another notify=
<br>
&gt; doesn&#39;t have to be sent. I&#39;ve not looked into that part of the=
 code<br>
&gt; carefully...<br>
<br>
</span>Our timer granularity is &quot;1 second&quot; for most stuff, and we=
 tend to add<br>
another second &quot;just to be sure&quot;... ran into this when trying to =
speed<br>
up client PUSH_REQUEST sending in commit afb93fac803f<br></blockquote><div>=
<br></div><div>Well, that explains it. Thanks.<br><br></div><div class=3D"h=
5">Selva<br></div></div></div></div></div>

--001a1147471cbe861f052523e78f--

