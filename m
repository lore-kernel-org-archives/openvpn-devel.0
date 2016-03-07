MIME-Version: 1.0
In-Reply-To: <2BE9E186EE9A49CCA063BEC9E3E38F20@...2089...>
References: <2BE9E186EE9A49CCA063BEC9E3E38F20@...2089...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 7 Mar 2016 10:28:03 -0500
Message-ID: <CAKuzo_iBQUDyT6fqygSOn==xAts1i7UsyiATaZhB6e8auSkP1Q@...278...>
Content-Type: multipart/alternative; boundary=001a113d493c84d4c3052d771df0
Subject: Re: [Openvpn-devel] Samsung Galaxy S6 to android 6.0.1 powersave
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Debbie Tent <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

--001a113d493c84d4c3052d771df0
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Mar 7, 2016 at 9:55 AM, <debbie10t@...277...> wrote:

> An interesting tid-bit about Samsung Galaxy S6 to android 6.0.1
> and OpenVPN Connect
>
> https://forums.openvpn.net/post59478.html#p59478
>

Sounds, suspiciously similar to the sleep-resume issue we had on windows..
The interface probably suspends and openvpn exits?

Brings up an interesting question: should power events be handled by openvpn
or by the UI or in a service that starts it (if relevant)? My view:
although openvpn need not directly handle power events, if an interface
driver notifies that it wants to suspend, it should respond to it
appropriately by restarting after a pause, for example. On windows, our
workaround for a long time was for the GUI to suspend/restart openvpn on
power events, though we changed that a while ago to put the onus of
restarting back on to openvpn.

But one could argue that its the job of the process starting openvpn to
respawn it if needed, instead of making it handle all kinds of failure
scenarios... Any thoughts on which is a better approach?

Selva

--001a113d493c84d4c3052d771df0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_quote">On Mon=
, Mar 7, 2016 at 9:55 AM,  <span dir=3D"ltr">&lt;<a href=3D"mailto:debbie10=
t@...277..." target=3D"_blank">debbie10t@...277...</a>&gt;</span> wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><div style=3D"overflow:hidden">An interesti=
ng tid-bit about Samsung Galaxy S6 to android 6.0.1<br>
and OpenVPN Connect<br>
<br>
<a href=3D"https://forums.openvpn.net/post59478.html#p59478" rel=3D"norefer=
rer" target=3D"_blank">https://forums.openvpn.net/post59478.html#p59478</a>=
</div></blockquote></div><br>Sounds, suspiciously similar to the sleep-resu=
me issue we had on windows.. The interface probably suspends and <span><spa=
n class=3D"" id=3D":5yy.1" tabindex=3D"-1">openvpn</span></span> exits?</di=
v><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Brings up=
 an interesting question: should power events be handled by=C2=A0<span><spa=
n class=3D"" id=3D":5yy.2" tabindex=3D"-1">openvpn</span></span> or by the =
<span><span class=3D"" id=3D":5yy.3" tabindex=3D"-1">UI</span></span> or in=
 a service that starts it (if relevant)? My view: although <span><span clas=
s=3D"" id=3D":5yy.4" tabindex=3D"-1">openvpn</span></span> need not directl=
y handle power events, if an interface driver notifies that it wants to sus=
pend, it should respond to it appropriately by restarting after a pause, fo=
r example. On windows, our workaround for a long time was for the GUI to su=
spend/restart=C2=A0<span><span class=3D"" id=3D":5yy.5" tabindex=3D"-1">ope=
nvpn</span></span> on power events, though we changed that a while ago to p=
ut the onus of restarting back on to <span><span class=3D"" id=3D":5yy.6" t=
abindex=3D"-1">openvpn</span></span>.</div><div class=3D"gmail_extra"><br><=
/div><div class=3D"gmail_extra">But one could argue that its the job of the=
 process starting <span><span class=3D"" id=3D":5yy.7" tabindex=3D"-1">open=
vpn</span></span> to <span class=3D"" id=3D":5yy.8" tabindex=3D"-1">respawn=
</span> it if needed, instead of making it handle all kinds of failure scen=
arios... Any thoughts on which is a better approach?</div><div class=3D"gma=
il_extra"><br></div><div class=3D"gmail_extra"><span><span class=3D"" id=3D=
":5yy.9" tabindex=3D"-1">Selva</span></span></div></div>

--001a113d493c84d4c3052d771df0--

