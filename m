MIME-Version: 1.0
In-Reply-To: <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 8 Feb 2018 01:30:30 +0500
Message-ID: <CAFHpkQF7qhc+4coTN5Tf=Ez5nioUyQG1N8GW6mzQPy4gWoY_XQ@...278...>
Content-Type: multipart/alternative; boundary="94eb2c1a65cc9d52e90564a52a2d"
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

--94eb2c1a65cc9d52e90564a52a2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-02-08 1:21 GMT+05:00 Selva Nair <selva.nair@...277...>:

> Hi,
>
> On Wed, Feb 7, 2018 at 2:58 PM, David Sommerseth
> <openvpn@...2080...> wrote:
> > On 07/02/18 20:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> >> After auth-token were introduced, when user press "Reconnect", it leads
> to
> >> auth fail (saved password is forgotten), we run about 1000 users, nobo=
dy
> >> complains.
> >
> > This is actually expected, I'd say - but smells like a bug on the server
> side
> > authentication.
> >
> > Selva may correct me if I'm wrong, but my understanding of it when
> clicking
> > "Reconnect", the local OpenVPN process which caches the auth-token is
> stopped
> > and a new OpenVPN process is started.  The client should in this case
> ask for
> > username/password again.  So in this case, the server side should treat
> this
> > connection as a fresh connection with no initial state.
>
> GUI's reconnect button is wired to send a SIGHUP to the client openvpn
> process. The problem is that if auth-token is in use, the client
> openvpn.exe does not forget it it when restarting the connection by
> SIGHUP or SIGUSR1 -- I think it should but it doesn't. That leads to
> an AUTH_FAILED from server. The GUI has hard time distinguishing
> between reasons for AUTH_FAILED, so it just assumes that password
> verification failed and clears the saved password and prompts for a
> new one. Obviously users are not happy.
>

users don't care :)

if they we ever unhappy, we should fix it.

currently, I'm open to ideas how to perform a (proper) investigation in
order to actually remove "Reconnect" button


>
> In my view auth-token handling in openvpn.exe is broken at multiple level=
s:
>
> Client process:
> (i) it should not remember the token after a reconnect is issued
> (ii) it should not remember the auth-token when auth-nocache is in
> effect --- without that there is no way for the GUI to take over
> handling auth-token. In my view auth-nocache is the only way
> openvpn.exe can stand aside and let the GUI take over all password
> handling. Unless we introduce a --management-auth-token flag. Else
> what's the use of sending the token to the management interface?
> In other words if a user wants auth-token and no GUI, they should not
> use auth-nocache, GUI users should use it if they want the GUI to
> control all password requests. No need to bend over backwards to
> support auth-nocache with auth-token as we now do.
>
> Server process
> (iii) --gen-auth-token with an expiry just doesn't work -- we need to
> have a mechanism for the server to tell the client that the token has
> expired.
>
> >> It looks like nobody uses that button.
> >>
> >> So, I asked several users, they confirmed they do not use Reconnect.
> >This is no good argument for me.  This is one specific setup with 1000
> users.
> >It would be more valuable with 50 different setups having 20 users each.
> Your
> >conclusion is based on a very homogeneous environment.
>
> Indeed. Actually I use that button frequently.
>
> >> After auth-token were introduced, when user press "Reconnect", it leads
> to
> >> auth fail (saved password is forgotten),
>
> That reads as if introduction of auth-token broke reconnect. It did
> not. Only those users who have 2-factor turned on and use
> --gen-auth-token on the server are affected.
>
> Selva
>

--94eb2c1a65cc9d52e90564a52a2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2018-02-08 1:21 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;<=
/span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Wed, Feb 7, 2018 at 2:58 PM, David Sommerseth<br>
&lt;<a href=3D"mailto:openvpn@...2080...">openvpn@...2142...<wbr>topphemmel=
ig.net</a>&gt; wrote:<br>
&gt; On 07/02/18 20:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:<br>
&gt;&gt; After auth-token were introduced, when user press &quot;Reconnect&=
quot;, it leads to<br>
&gt;&gt; auth fail (saved password is forgotten), we run about 1000 users, =
nobody<br>
&gt;&gt; complains.<br>
&gt;<br>
&gt; This is actually expected, I&#39;d say - but smells like a bug on the =
server side<br>
&gt; authentication.<br>
&gt;<br>
&gt; Selva may correct me if I&#39;m wrong, but my understanding of it when=
 clicking<br>
&gt; &quot;Reconnect&quot;, the local OpenVPN process which caches the auth=
-token is stopped<br>
&gt; and a new OpenVPN process is started.=C2=A0 The client should in this =
case ask for<br>
&gt; username/password again.=C2=A0 So in this case, the server side should=
 treat this<br>
&gt; connection as a fresh connection with no initial state.<br>
<br>
</span>GUI&#39;s reconnect button is wired to send a SIGHUP to the client o=
penvpn<br>
process. The problem is that if auth-token is in use, the client<br>
openvpn.exe does not forget it it when restarting the connection by<br>
SIGHUP or SIGUSR1 -- I think it should but it doesn&#39;t. That leads to<br>
an AUTH_FAILED from server. The GUI has hard time distinguishing<br>
between reasons for AUTH_FAILED, so it just assumes that password<br>
verification failed and clears the saved password and prompts for a<br>
new one. Obviously users are not happy.<br></blockquote><div><br></div><div=
>users don&#39;t care :)</div><div><br></div><div>if they we ever unhappy, =
we should fix it.</div><div><br></div><div>currently, I&#39;m open to ideas=
 how to perform a (proper) investigation in order to actually remove &quot;=
Reconnect&quot; button<br></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
<br>
In my view auth-token handling in openvpn.exe is broken at multiple levels:=
<br>
<br>
Client process:<br>
(i) it should not remember the token after a reconnect is issued<br>
(ii) it should not remember the auth-token when auth-nocache is in<br>
effect --- without that there is no way for the GUI to take over<br>
handling auth-token. In my view auth-nocache is the only way<br>
openvpn.exe can stand aside and let the GUI take over all password<br>
handling. Unless we introduce a --management-auth-token flag. Else<br>
what&#39;s the use of sending the token to the management interface?<br>
In other words if a user wants auth-token and no GUI, they should not<br>
use auth-nocache, GUI users should use it if they want the GUI to<br>
control all password requests. No need to bend over backwards to<br>
support auth-nocache with auth-token as we now do.<br>
<br>
Server process<br>
(iii) --gen-auth-token with an expiry just doesn&#39;t work -- we need to<b=
r>
have a mechanism for the server to tell the client that the token has<br>
expired.<br>
<span class=3D""><br>
&gt;&gt; It looks like nobody uses that button.<br>
&gt;&gt;<br>
&gt;&gt; So, I asked several users, they confirmed they do not use Reconnec=
t.<br>
&gt;This is no good argument for me.=C2=A0 This is one specific setup with =
1000 users.<br>
&gt;It would be more valuable with 50 different setups having 20 users each=
.=C2=A0 Your<br>
&gt;conclusion is based on a very homogeneous environment.<br>
<br>
</span>Indeed. Actually I use that button frequently.<br>
<span class=3D""><br>
&gt;&gt; After auth-token were introduced, when user press &quot;Reconnect&=
quot;, it leads to<br>
&gt;&gt; auth fail (saved password is forgotten),<br>
<br>
</span>That reads as if introduction of auth-token broke reconnect. It did<=
br>
not. Only those users who have 2-factor turned on and use<br>
--gen-auth-token on the server are affected.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Selva<br>
</font></span></blockquote></div><br></div></div>

--94eb2c1a65cc9d52e90564a52a2d--

