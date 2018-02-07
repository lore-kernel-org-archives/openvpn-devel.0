MIME-Version: 1.0
In-Reply-To: <CAKuzo_hYfnm3G_zNJ4iX_ONAJkR_=0L4GWhSMqi9NV17+u7n1Q@...278...>
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
 <CAFHpkQF7qhc+4coTN5Tf=Ez5nioUyQG1N8GW6mzQPy4gWoY_XQ@...278...>
 <CAKuzo_hYfnm3G_zNJ4iX_ONAJkR_=0L4GWhSMqi9NV17+u7n1Q@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 8 Feb 2018 02:45:00 +0500
Message-ID: <CAFHpkQGeEW5OL5cGu0tHBuasreNx2mYHfSt+tc2AE+YQXwk-ng@...278...>
Content-Type: multipart/alternative; boundary="001a114cbd740f5b6e0564a635ac"
Subject: Re: [Openvpn-devel] [Openvpn-users] "Reconnect" button in
 openvpn-gui
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

--001a114cbd740f5b6e0564a635ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-02-08 1:43 GMT+05:00 Selva Nair <selva.nair@...277...>:

> Hi,
>
> On Wed, Feb 7, 2018 at 3:30 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
> >
> >
> > 2018-02-08 1:21 GMT+05:00 Selva Nair <selva.nair@...277...>:
> >>
> >> Hi,
> >>
> >> On Wed, Feb 7, 2018 at 2:58 PM, David Sommerseth
> >> <openvpn@...2080...> wrote:
> >> > On 07/02/18 20:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
> >> >> After auth-token were introduced, when user press "Reconnect", it
> leads
> >> >> to
> >> >> auth fail (saved password is forgotten), we run about 1000 users,
> >> >> nobody
> >> >> complains.
> >> >
> >> > This is actually expected, I'd say - but smells like a bug on the
> server
> >> > side
> >> > authentication.
> >> >
> >> > Selva may correct me if I'm wrong, but my understanding of it when
> >> > clicking
> >> > "Reconnect", the local OpenVPN process which caches the auth-token is
> >> > stopped
> >> > and a new OpenVPN process is started.  The client should in this case
> >> > ask for
> >> > username/password again.  So in this case, the server side should
> treat
> >> > this
> >> > connection as a fresh connection with no initial state.
> >>
> >> GUI's reconnect button is wired to send a SIGHUP to the client openvpn
> >> process. The problem is that if auth-token is in use, the client
> >> openvpn.exe does not forget it it when restarting the connection by
> >> SIGHUP or SIGUSR1 -- I think it should but it doesn't. That leads to
> >> an AUTH_FAILED from server. The GUI has hard time distinguishing
> >> between reasons for AUTH_FAILED, so it just assumes that password
> >> verification failed and clears the saved password and prompts for a
> >> new one. Obviously users are not happy.
> >
> >
> > users don't care :)
> >
> > if they we ever unhappy, we should fix it.
> >
> > currently, I'm open to ideas how to perform a (proper) investigation in
> > order to actually remove "Reconnect" button
>
> I do not understand why you keep harping about removing the reconnect
> button.
>
> If you are angry with auth-token do not take it out on the wrong
> victim. Its not reconnect button's fault. In fact if your users do not
> use it, why bother?
>


those victims are not mutually exclusive.

I noticed that nobody cares of broken behaviour of "REconnect" button. So,
I suggest to remove it (as a user, I cannot imagine when
I would press it ... probably something like "change IP address on
reconnect", like I do with Tor)

Also, I think that auth-token should be handled in better way.


>
> Selva
>

--001a114cbd740f5b6e0564a635ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2018-02-08 1:43 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;<=
/span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<div><div class=3D"h5"><br>
On Wed, Feb 7, 2018 at 3:30 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277...">chipit=
sine@...277...</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; 2018-02-08 1:21 GMT+05:00 Selva Nair &lt;<a href=3D"mailto:selva.nair@=
...277...">selva.nair@...277...</a>&gt;:<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Feb 7, 2018 at 2:58 PM, David Sommerseth<br>
&gt;&gt; &lt;<a href=3D"mailto:openvpn@...2080...">openvpn@...2142...<wbr>t=
opphemmelig.net</a>&gt; wrote:<br>
&gt;&gt; &gt; On 07/02/18 20:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
&gt;&gt; &gt;&gt; After auth-token were introduced, when user press &quot;R=
econnect&quot;, it leads<br>
&gt;&gt; &gt;&gt; to<br>
&gt;&gt; &gt;&gt; auth fail (saved password is forgotten), we run about 100=
0 users,<br>
&gt;&gt; &gt;&gt; nobody<br>
&gt;&gt; &gt;&gt; complains.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This is actually expected, I&#39;d say - but smells like a bu=
g on the server<br>
&gt;&gt; &gt; side<br>
&gt;&gt; &gt; authentication.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Selva may correct me if I&#39;m wrong, but my understanding o=
f it when<br>
&gt;&gt; &gt; clicking<br>
&gt;&gt; &gt; &quot;Reconnect&quot;, the local OpenVPN process which caches=
 the auth-token is<br>
&gt;&gt; &gt; stopped<br>
&gt;&gt; &gt; and a new OpenVPN process is started.=C2=A0 The client should=
 in this case<br>
&gt;&gt; &gt; ask for<br>
&gt;&gt; &gt; username/password again.=C2=A0 So in this case, the server si=
de should treat<br>
&gt;&gt; &gt; this<br>
&gt;&gt; &gt; connection as a fresh connection with no initial state.<br>
&gt;&gt;<br>
&gt;&gt; GUI&#39;s reconnect button is wired to send a SIGHUP to the client=
 openvpn<br>
&gt;&gt; process. The problem is that if auth-token is in use, the client<b=
r>
&gt;&gt; openvpn.exe does not forget it it when restarting the connection b=
y<br>
&gt;&gt; SIGHUP or SIGUSR1 -- I think it should but it doesn&#39;t. That le=
ads to<br>
&gt;&gt; an AUTH_FAILED from server. The GUI has hard time distinguishing<b=
r>
&gt;&gt; between reasons for AUTH_FAILED, so it just assumes that password<=
br>
&gt;&gt; verification failed and clears the saved password and prompts for =
a<br>
&gt;&gt; new one. Obviously users are not happy.<br>
&gt;<br>
&gt;<br>
&gt; users don&#39;t care :)<br>
&gt;<br>
&gt; if they we ever unhappy, we should fix it.<br>
&gt;<br>
&gt; currently, I&#39;m open to ideas how to perform a (proper) investigati=
on in<br>
&gt; order to actually remove &quot;Reconnect&quot; button<br>
<br>
</div></div>I do not understand why you keep harping about removing the rec=
onnect button.<br>
<br>
If you are angry with auth-token do not take it out on the wrong<br>
victim. Its not reconnect button&#39;s fault. In fact if your users do not<=
br>
use it, why bother?<br></blockquote><div><br></div><div><br></div><div>thos=
e victims are not mutually exclusive.</div><div><br></div><div>I noticed th=
at nobody cares of broken behaviour of &quot;REconnect&quot; button. So, I =
suggest to remove it (as a user, I cannot imagine when <br></div><div>I wou=
ld press it ... probably something like &quot;change IP address on reconnec=
t&quot;, like I do with Tor)</div><div><br></div><div>Also, I think that au=
th-token should be handled in better way.<br></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Selva<br>
</font></span></blockquote></div><br></div></div>

--001a114cbd740f5b6e0564a635ac--

