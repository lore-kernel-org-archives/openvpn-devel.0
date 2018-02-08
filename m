MIME-Version: 1.0
In-Reply-To: <17c77ed3-840e-7624-9e23-6ae8de04bf3e@...515...>
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <17c77ed3-840e-7624-9e23-6ae8de04bf3e@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 8 Feb 2018 13:26:27 +0500
Message-ID: <CAFHpkQH4O2MueU__O8KiDp5WobAf-nPRW3dU0cCm4Tm9xh11ng@...278...>
Content-Type: multipart/alternative; boundary="089e082e1ec008736a0564af2bab"
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, David Sommerseth <openvpn@...2080...>, Selva Nair <selva.nair@...277...>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

--089e082e1ec008736a0564af2bab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-02-08 13:15 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Il 07/02/2018 21:58, David Sommerseth ha scritto:
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
> >
> > The step of stopping the local client and starting a new and fresh one =
is
> > definitely not a bad feature to have on clients.
> >
> >> It looks like nobody uses that button.
> >>
> >> So, I asked several users, they confirmed they do not use Reconnect.
> >
> > This is no good argument for me.  This is one specific setup with 1000
> users.
> > It would be more valuable with 50 different setups having 20 users
> each.  Your
> > conclusion is based on a very homogeneous environment.
>
> I agree. I also agree that the underlying problem should be fixed.
>
> That said, Ilya's message was sent to both openvpn-users and
> openvpn-devel and nobody has screamed "do not remove the Reconnect
> button" :). The only additional thing we can do is post a message to the
> forums. As usual, the only sure way to get feedback (read: complaints)
> is to release the changes in an official build/installer.
>
>
I suggest to do that after 2.4.5 installer.
I'll write post on the forum. I think, even a good idea to place snapshot
installer with new feature (i.e. button removed) to forum as well.

after feedback is received we can take it into account and act.

I also noticed nobody screaming "stop!!! do not remove that button!!!"

Samuli ?


> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>

--089e082e1ec008736a0564af2bab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2018-02-08 13:15 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">Il 07/02/2018=
 21:58, David Sommerseth ha scritto:<br>
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
&gt;<br>
&gt; The step of stopping the local client and starting a new and fresh one=
 is<br>
&gt; definitely not a bad feature to have on clients.<br>
&gt;<br>
&gt;&gt; It looks like nobody uses that button.<br>
&gt;&gt;<br>
&gt;&gt; So, I asked several users, they confirmed they do not use Reconnec=
t.<br>
&gt;<br>
&gt; This is no good argument for me.=C2=A0 This is one specific setup with=
 1000 users.<br>
&gt; It would be more valuable with 50 different setups having 20 users eac=
h.=C2=A0 Your<br>
&gt; conclusion is based on a very homogeneous environment.<br>
<br>
</span>I agree. I also agree that the underlying problem should be fixed.<b=
r>
<br>
That said, Ilya&#39;s message was sent to both openvpn-users and<br>
openvpn-devel and nobody has screamed &quot;do not remove the Reconnect<br>
button&quot; :). The only additional thing we can do is post a message to t=
he<br>
forums. As usual, the only sure way to get feedback (read: complaints)<br>
is to release the changes in an official build/installer.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div><br></div><div>I suggest to do that after 2.4.5 installer.</div><di=
v>I&#39;ll write post on the forum. I think, even a good idea to place snap=
shot installer with new feature (i.e. button removed) to forum as well.</di=
v><div><br></div><div>after feedback is received we can take it into accoun=
t and act.</div><div><br></div><div>I also noticed nobody screaming &quot;s=
top!!! do not remove that button!!!&quot;<br></div><div><br></div><div>Samu=
li ?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"HOEnZb"><font color=3D"#888888">
--<br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
<br>
</font></span></blockquote></div><br></div></div>

--089e082e1ec008736a0564af2bab--

