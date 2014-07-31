MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <CAGyAFMWg5j+ki56=fwOOZwcpAdixE8eDyJXFgktrNsOqrYZRcA@...278...>
References: <CAGyAFMWg5j+ki56=fwOOZwcpAdixE8eDyJXFgktrNsOqrYZRcA@...278...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Thu, 31 Jul 2014 23:21:56 +0200
Message-ID: <CAP+U6tKkiU3FmaPN66s62iZiEoqbmgLjn4J-kJTM9P=0H5qSMg@...278...>
Content-Type: multipart/alternative; boundary=001a11c2394cf7f06304ff83dd5c
Subject: Re: [Openvpn-devel] Async OPENVPN_PLUGIN_CLIENT_CONNECT plugin
	support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11c2394cf7f06304ff83dd5c
Content-Type: text/plain; charset=UTF-8

Hi Lev,

2014-07-29 12:56 GMT+02:00 Lev Stipakov <lstipakov@...277...>:

> I am pondering about asynchronous OPENVPN_PLUGIN_CLIENT_CONNECT
> callback. Basically, I want _not_ to establish connection until
> response is received and ofcI  don't want to block rest of traffic.
>

[ Details of approach snipped. ]

What do you think about that? Does that approach sound reasonable?
>

Some time ago I implemented something quite similar, but never quite
managed to officially submit it. You can find my old git branch here [0].
Unfortunately, to be of any use it would need to be ported to a current
OpenVPN release / master first.

The code has been in use for several years now [1], so the approach and the
code basically work quite well. (I think my use case involved calling a
Python script, but I might have implemented the plugin part too.)

If the OpenVPN commiters see a certain chance, that such a change could be
included upstream, I might even try to rebase the branch to master myself...

Cheers
Fabian

0:
http://opensource.fsmi.uni-karlsruhe.de/gitweb/?p=openvpn.git;a=shortlog;h=refs/heads/feat_deferred_client-connect
1: ... in a production environment with several hundred users (together
with the equally unofficial VLAN-tagging feature [2]). The feature is
needed by a daemon that does asynchronous IP-configuration via a central
DHCP server [3].
2:
http://opensource.fsmi.uni-karlsruhe.de/gitweb/?p=openvpn.git;a=shortlog;h=refs/heads/feat_vlan
3: https://gitorious.org/odr

--001a11c2394cf7f06304ff83dd5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Lev,<div><br></div><div>2014-07-29 12:56 GMT+02:00 Lev =
Stipakov=C2=A0<span dir=3D"ltr">&lt;<a href=3D"mailto:lstipakov@...277..." =
target=3D"_blank" onclick=3D"window.open(&#39;https://mail.google.com/mail/=
?view=3Dcm&amp;tf=3D1&amp;to=3Dlstipakov@...277...&amp;cc=3D&amp;bcc=3D&amp=
;su=3D&amp;body=3D&#39;,&#39;_blank&#39;);return false;">lstipakov@...1663...=
.</a>&gt;</span>:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">I am pondering about asynchronous OPENVPN_PLUGIN_CLIENT_CO=
NNECT<br>

callback. Basically, I want _not_ to establish connection until<br>response=
 is received and ofcI =C2=A0don&#39;t want to block rest of traffic.<br></b=
lockquote><div><br></div><div>[ Details of approach snipped. ]=C2=A0</div><=
/div>
<div>
<br></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:=
1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left=
:1ex">

What do you think about that? Does that approach sound reasonable?<br></blo=
ckquote><div><br></div><div>Some time ago I implemented something quite sim=
ilar, but never quite managed to officially submit it. You can find my old =
git branch here [0]. Unfortunately, to be of any use it would need to be po=
rted to a current OpenVPN release / master first.</div>

<div><br></div><div>The code has been in use for several years now [1], so =
the approach and the code basically work quite well. (I think my use case i=
nvolved calling a Python script, but I might have implemented the plugin pa=
rt too.)</div>

<div><br></div><div>If the OpenVPN commiters see a certain chance, that suc=
h a change could be included upstream, I might even try to rebase the branc=
h to master myself...</div><div><br></div><div>Cheers</div><div>Fabian</div>

<div><br></div><div>0: <a href=3D"http://opensource.fsmi.uni-karlsruhe.de/g=
itweb/?p=3Dopenvpn.git;a=3Dshortlog;h=3Drefs/heads/feat_deferred_client-con=
nect">http://opensource.fsmi.uni-karlsruhe.de/gitweb/?p=3Dopenvpn.git;a=3Ds=
hortlog;h=3Drefs/heads/feat_deferred_client-connect</a></div>

<div>1: ... in a production environment with several hundred users (togethe=
r with the equally unofficial VLAN-tagging feature [2]). The feature is nee=
ded by a daemon that does asynchronous IP-configuration via a central DHCP =
server [3].</div>

<div>2:=C2=A0<a href=3D"http://opensource.fsmi.uni-karlsruhe.de/gitweb/?p=
=3Dopenvpn.git;a=3Dshortlog;h=3Drefs/heads/feat_vlan">http://opensource.fsm=
i.uni-karlsruhe.de/gitweb/?p=3Dopenvpn.git;a=3Dshortlog;h=3Drefs/heads/feat=
_vlan</a></div><div>

3:=C2=A0<a href=3D"https://gitorious.org/odr">https://gitorious.org/odr</a>=
</div></div></div></div>

--001a11c2394cf7f06304ff83dd5c--

