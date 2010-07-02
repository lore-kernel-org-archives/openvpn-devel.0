MIME-Version: 1.0
In-Reply-To: <20100626114157.GV361@...1296...>
References: <AANLkTikEA95y8ojAyWAJoJmYbt_MZBT23dbi-IyAUa0Y@...278...> 
	<4C20D014.7050802@...1147...>
	<AANLkTim766amj5ebXyzKWKKqjk2ndJiqyu-Drw26Mt1e@...278...> 
	<4C21B352.1030203@...1147...> <20100623194825.GA361@...1296...> 
	<AANLkTikd4bxVpYdOHRO-JXnx-o1Dv4OC-AxuuT2J7044@...278...> 
	<20100626114157.GV361@...1296...>
From: =?UTF-8?Q?Henno_T=C3=A4ht?= <henno.taht@...277...>
Date: Fri, 2 Jul 2010 17:35:21 +0300
Message-ID: <AANLkTikVOjdqfIkL7EcVW6US3nJTZsbF7wBzxEBdWb7t@...278...>
Content-Type: multipart/alternative; boundary=00032555f4ee5bb0c7048a6880a5
Subject: Re: [Openvpn-devel] [Openvpn-users] Is it possible to access
	Windows XP shares over port 445?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, OpenVPN Users <openvpn-users@lists.sourceforge.net>

--00032555f4ee5bb0c7048a6880a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FWIW, I posted this issue to Microsoft's forum:
http://social.answers.microsoft.com/Forums/en-US/xpnetwork/thread/82388e04-=
1791-43a0-a678-de8475bce537

Everyone who like this to be answered can mark that article to up the "X
persons needs an answer" thing.
<http://social.answers.microsoft.com/Forums/en-US/xpnetwork/thread/82388e04=
-1791-43a0-a678-de8475bce537>
Henno


2010/6/26 Gert Doering <gert@...1296...>

> Hi,
>
> On Wed, Jun 23, 2010 at 10:50:45PM +0300, Henno T=C3=A4ht wrote:
> > On Wed, Jun 23, 2010 at 22:48, Gert Doering <gert@...1296...> wrote:
> > > On Wed, Jun 23, 2010 at 09:10:10AM +0200, Jan Just Keijser wrote:
> > > > assigns a 169.254 address. If this works for you as well then maybe
> the
> > > > tap-win32 developers can dive deeper into this and find out why
> windows
> > > > treats the 'always connected' adapter differently from an
> 'application
> > > > controlled' adapter .
> > >
> > > I'd assume that windows services are not "bound" to "dynamic"
> interfaces...
> >
> > By dynamic interface you mean an interface which has  "Obtain IP address
> > automatically" set?
>
> No, I was thinking about interfaces that sort of "are not always there".
>
> But that was a misconception, the TAP interface *is* always there - what's
> application controlled is whether it's "connected to an ethernet cable"
> (virtual, of course) all the time, or only if openvpn tells it so.
>
> But in that my idea doesn't really make sense - it's as if windows wouldn=
't
> start windows sharing if the ethernet cable is not plugged in at boot tim=
e.
>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                           //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>

--00032555f4ee5bb0c7048a6880a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FWIW, I posted this issue to Microsoft&#39;s forum:<div><a href=3D"http://s=
ocial.answers.microsoft.com/Forums/en-US/xpnetwork/thread/82388e04-1791-43a=
0-a678-de8475bce537">http://social.answers.microsoft.com/Forums/en-US/xpnet=
work/thread/82388e04-1791-43a0-a678-de8475bce537</a></div>

<div><br></div><div>Everyone who like this to be answered can mark that art=
icle to up the &quot;X persons needs an answer&quot; thing.</div><div><a hr=
ef=3D"http://social.answers.microsoft.com/Forums/en-US/xpnetwork/thread/823=
88e04-1791-43a0-a678-de8475bce537"></a><br clear=3D"all">

Henno<br>
<br><br><div class=3D"gmail_quote">2010/6/26 Gert Doering <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt;</span><br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex;">

Hi,<br>
<div class=3D"im"><br>
On Wed, Jun 23, 2010 at 10:50:45PM +0300, Henno T=C3=A4ht wrote:<br>
&gt; On Wed, Jun 23, 2010 at 22:48, Gert Doering &lt;<a href=3D"mailto:gert=
@...1296...">gert@...1296...</a>&gt; wrote:<br>
</div><div class=3D"im">&gt; &gt; On Wed, Jun 23, 2010 at 09:10:10AM +0200,=
 Jan Just Keijser wrote:<br>
&gt; &gt; &gt; assigns a 169.254 address. If this works for you as well the=
n maybe the<br>
&gt; &gt; &gt; tap-win32 developers can dive deeper into this and find out =
why windows<br>
&gt; &gt; &gt; treats the &#39;always connected&#39; adapter differently fr=
om an &#39;application<br>
&gt; &gt; &gt; controlled&#39; adapter .<br>
&gt; &gt;<br>
&gt; &gt; I&#39;d assume that windows services are not &quot;bound&quot; to=
 &quot;dynamic&quot; interfaces...<br>
&gt;<br>
&gt; By dynamic interface you mean an interface which has =C2=A0&quot;Obtai=
n IP address<br>
&gt; automatically&quot; set?<br>
<br>
</div>No, I was thinking about interfaces that sort of &quot;are not always=
 there&quot;.<br>
<br>
But that was a misconception, the TAP interface *is* always there - what&#3=
9;s<br>
application controlled is whether it&#39;s &quot;connected to an ethernet c=
able&quot;<br>
(virtual, of course) all the time, or only if openvpn tells it so.<br>
<br>
But in that my idea doesn&#39;t really make sense - it&#39;s as if windows =
wouldn&#39;t<br>
start windows sharing if the ethernet cable is not plugged in at boot time.=
<br>
<div><div></div><div class=3D"h5"><br>
gert<br>
<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //<a href=3D"http:/=
/www.muc.de/~gert/" target=3D"_blank">www.muc.de/~gert/</a><br>
Gert Doering - Munich, Germany =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:g=
ert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:gert@...1297...">gert@...1386...=
297...</a><br>
</div></div></blockquote></div><br></div>

--00032555f4ee5bb0c7048a6880a5--

