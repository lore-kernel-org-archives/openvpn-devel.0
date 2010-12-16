Message-ID: <4D0A17B0.3050805@...1147...>
Date: Thu, 16 Dec 2010 14:44:16 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <AANLkTikEA95y8ojAyWAJoJmYbt_MZBT23dbi-IyAUa0Y@...278...>
	<4C20D014.7050802@...1147...>
	<AANLkTim766amj5ebXyzKWKKqjk2ndJiqyu-Drw26Mt1e@...278...>
	<4C21B352.1030203@...1147...> <20100623194825.GA361@...1296...>
	<AANLkTikd4bxVpYdOHRO-JXnx-o1Dv4OC-AxuuT2J7044@...278...>
	<20100626114157.GV361@...1296...>
	<AANLkTikVOjdqfIkL7EcVW6US3nJTZsbF7wBzxEBdWb7t@...278...>
In-Reply-To: <AANLkTikVOjdqfIkL7EcVW6US3nJTZsbF7wBzxEBdWb7t@...278...>
Content-Type: multipart/alternative;
	boundary="------------090906020407000305040208"
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
To: =?UTF-8?B?SGVubm8gVMOkaHQ=?= <henno.taht@...277...>
Cc: openvpn-devel@lists.sourceforge.net, OpenVPN Users <openvpn-users@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090906020407000305040208
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Henno,

Henno T=C3=A4ht wrote:
> FWIW, I posted this issue to Microsoft's forum:
> http://social.answers.microsoft.com/Forums/en-US/xpnetwork/thread/82388e0=
4-1791-43a0-a678-de8475bce537
>
> Everyone who like this to be answered can mark that article to up the=20
> "X persons needs an answer" thing.
>
>
I think I finally figured it out (I ran into this issue myself this=20
morning so I started hacking ;-)) :

if I set "Non-Admin Access" to "Not allowed" in the TAP-Win32 Adapter V9=20
Advanced properties page and reboot the box then I can access the shares=20
on my WinXP box using
  smbclient -L -p 445 \\192.168.200.2
(where 192.168.200.2 is the VPN IP).

Of course, the problem with not allowing this is that non-Admin users=20
can no longer start a VPN connection. You'd need to run
  runas /env /profile user:AdminUser "openvpn ..."
to get around this.

Can somebody verify this? It sounds like a nice one for the FAQ.

share and enjoy,

JJK

>
> 2010/6/26 Gert Doering <gert@...1296... <mailto:gert@...1296...>>
>
>     Hi,
>
>     On Wed, Jun 23, 2010 at 10:50:45PM +0300, Henno T=C3=A4ht wrote:
>     > On Wed, Jun 23, 2010 at 22:48, Gert Doering <gert@...1296...
>     <mailto:gert@...1296...>> wrote:
>     > > On Wed, Jun 23, 2010 at 09:10:10AM +0200, Jan Just Keijser wrote:
>     > > > assigns a 169.254 address. If this works for you as well
>     then maybe the
>     > > > tap-win32 developers can dive deeper into this and find out
>     why windows
>     > > > treats the 'always connected' adapter differently from an
>     'application
>     > > > controlled' adapter .
>     > >
>     > > I'd assume that windows services are not "bound" to "dynamic"
>     interfaces...
>     >
>     > By dynamic interface you mean an interface which has  "Obtain IP
>     address
>     > automatically" set?
>
>     No, I was thinking about interfaces that sort of "are not always
>     there".
>
>     But that was a misconception, the TAP interface *is* always there
>     - what's
>     application controlled is whether it's "connected to an ethernet
>     cable"
>     (virtual, of course) all the time, or only if openvpn tells it so.
>
>     But in that my idea doesn't really make sense - it's as if windows
>     wouldn't
>     start windows sharing if the ethernet cable is not plugged in at
>     boot time.
>
>     gert
>
>     --
>     USENET is *not* the non-clickable part of WWW!
>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
>     //www.muc.de/~gert/ <http://www.muc.de/%7Egert/>
>     Gert Doering - Munich, Germany=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>     gert@...1296... <mailto:gert@...1296...>
>     fax: +49-89-35655025=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20
>      gert@...1297...
>     <mailto:gert@...1297...>
>
>


--------------090906020407000305040208
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type">
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
Hi Henno,<br>
<br>
Henno T=C3=A4ht wrote:
<blockquote
 cite=3D"mid:AANLkTikVOjdqfIkL7EcVW6US3nJTZsbF7wBzxEBdWb7t@...278..."
 type=3D"cite">FWIW, I posted this issue to Microsoft's forum:
  <div><a moz-do-not-send=3D"true"
 href=3D"http://social.answers.microsoft.com/Forums/en-US/xpnetwork/thread/=
82388e04-1791-43a0-a678-de8475bce537">http://social.answers.microsoft.com/F=
orums/en-US/xpnetwork/thread/82388e04-1791-43a0-a678-de8475bce537</a></div>
  <div><br>
  </div>
  <div>Everyone who like this to be answered can mark that article to
up the "X persons needs an answer" thing.</div>
  <div><br clear=3D"all">
  <br>
  </div>
</blockquote>
I think I finally figured it out (I ran into this issue myself this
morning so I started hacking ;-)) :<br>
<br>
if I set "Non-Admin Access" to "Not allowed" in the TAP-Win32 Adapter
V9 Advanced properties page and reboot the box then I can access the
shares on my WinXP box using<br>
=C2=A0 smbclient -L -p 445 \\192.168.200.2<br>
(where 192.168.200.2 is the VPN IP). <br>
<br>
Of course, the problem with not allowing this is that non-Admin users
can no longer start a VPN connection. You'd need to run<br>
=C2=A0 runas /env /profile user:AdminUser "openvpn ..."<br>
to get around this.<br>
<br>
Can somebody verify this? It sounds like a nice one for the FAQ.<br>
<br>
share and enjoy,<br>
<br>
JJK<br>
<br>
<blockquote
 cite=3D"mid:AANLkTikVOjdqfIkL7EcVW6US3nJTZsbF7wBzxEBdWb7t@...278..."
 type=3D"cite">
  <div><br>
  <div class=3D"gmail_quote">2010/6/26 Gert Doering <span dir=3D"ltr">&lt;<a
 moz-do-not-send=3D"true" href=3D"mailto:gert@...1296...">gert@...1296...</=
a>&gt;</span><br>
  <blockquote class=3D"gmail_quote"
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">Hi,<br>
    <div class=3D"im"><br>
On Wed, Jun 23, 2010 at 10:50:45PM +0300, Henno T=C3=A4ht wrote:<br>
&gt; On Wed, Jun 23, 2010 at 22:48, Gert Doering &lt;<a
 moz-do-not-send=3D"true" href=3D"mailto:gert@...1296...">gert@...1296...</=
a>&gt;
wrote:<br>
    </div>
    <div class=3D"im">&gt; &gt; On Wed, Jun 23, 2010 at 09:10:10AM +0200,
Jan Just Keijser wrote:<br>
&gt; &gt; &gt; assigns a 169.254 address. If this works for you as well
then maybe the<br>
&gt; &gt; &gt; tap-win32 developers can dive deeper into this and find
out why windows<br>
&gt; &gt; &gt; treats the 'always connected' adapter differently from
an 'application<br>
&gt; &gt; &gt; controlled' adapter .<br>
&gt; &gt;<br>
&gt; &gt; I'd assume that windows services are not "bound" to "dynamic"
interfaces...<br>
&gt;<br>
&gt; By dynamic interface you mean an interface which has =C2=A0"Obtain IP
address<br>
&gt; automatically" set?<br>
    <br>
    </div>
No, I was thinking about interfaces that sort of "are not always there".<br>
    <br>
But that was a misconception, the TAP interface *is* always there -
what's<br>
application controlled is whether it's "connected to an ethernet cable"<br>
(virtual, of course) all the time, or only if openvpn tells it so.<br>
    <br>
But in that my idea doesn't really make sense - it's as if windows
wouldn't<br>
start windows sharing if the ethernet cable is not plugged in at boot
time.<br>
    <div>
    <div class=3D"h5"><br>
gert<br>
    <br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //<a
 moz-do-not-send=3D"true" href=3D"http://www.muc.de/%7Egert/"
 target=3D"_blank">www.muc.de/~gert/</a><br>
Gert Doering - Munich, Germany =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a
 moz-do-not-send=3D"true" href=3D"mailto:gert@...1296...">gert@...1296...</=
a><br>
fax: +49-89-35655025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a moz-do-not-send=3D"true"
 href=3D"mailto:gert@...1297...">gert@...1297...</a><br>
    </div>
    </div>
  </blockquote>
  </div>
  <br>
  </div>
</blockquote>
<br>
</body>
</html>

--------------090906020407000305040208--

