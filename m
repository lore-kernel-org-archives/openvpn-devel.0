MIME-Version: 1.0
In-Reply-To: <CAKuzo_jrPv+=NjoEXtX+5AUjYtgRmVw2Jtens_hvbKOmidAjpQ@...278...>
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <17c77ed3-840e-7624-9e23-6ae8de04bf3e@...515...>
 <CAKuzo_jrPv+=NjoEXtX+5AUjYtgRmVw2Jtens_hvbKOmidAjpQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 9 Feb 2018 10:41:36 +0500
Message-ID: <CAFHpkQHfmrmq16=ra+NAJOSwVoJCx4dzGcCuct9PQAp1A49WHg@...278...>
Content-Type: multipart/alternative; boundary="f403045e93ec59ef230564c0fba6"
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
Cc: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, David Sommerseth <openvpn@...2080...>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

--f403045e93ec59ef230564c0fba6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-02-08 20:40 GMT+05:00 Selva Nair <selva.nair@...277...>:

> Hi,
>
> On Thu, Feb 8, 2018 at 3:15 AM, Samuli Sepp=C3=A4nen <samuli@...515...>
> wrote:
> > Il 07/02/2018 21:58, David Sommerseth ha scritto:
> >> On 07/02/18 20:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
> >>> After auth-token were introduced, when user press "Reconnect", it
> leads to
> >>> auth fail (saved password is forgotten), we run about 1000 users,
> nobody
> >>> complains.
> >>
> >> This is actually expected, I'd say - but smells like a bug on the
> server side
> >> authentication.
> >>
> >> Selva may correct me if I'm wrong, but my understanding of it when
> clicking
> >> "Reconnect", the local OpenVPN process which caches the auth-token is
> stopped
> >> and a new OpenVPN process is started.  The client should in this case
> ask for
> >> username/password again.  So in this case, the server side should treat
> this
> >> connection as a fresh connection with no initial state.
> >>
> >> The step of stopping the local client and starting a new and fresh one
> is
> >> definitely not a bad feature to have on clients.
> >>
> >>> It looks like nobody uses that button.
> >>>
> >>> So, I asked several users, they confirmed they do not use Reconnect.
> >>
> >> This is no good argument for me.  This is one specific setup with 1000
> users.
> >> It would be more valuable with 50 different setups having 20 users
> each.  Your
> >> conclusion is based on a very homogeneous environment.
> >
> > I agree. I also agree that the underlying problem should be fixed.
> >
> > That said, Ilya's message was sent to both openvpn-users and
> > openvpn-devel and nobody has screamed "do not remove the Reconnect
> > button" :). The only additional thing we can do is post a message to the
> > forums. As usual, the only sure way to get feedback (read: complaints)
> > is to release the changes in an official build/installer.
>
> Only recently we added a reconnect item to the menu (earlier it was
> only available as a button in the status window) for ease of doing
> reconnects and based on user requests -- though I can't now find who
> asked for it.
>

it is interesting.


>
> I wouldn't take lack of response on the user's list as an indication
> that no one uses it. In fact its very handy -- how else will you
> restart a connection after editing the config file? Disconnect and
> connect again? That would close the status window and lose all
>

yes. disconnect and connect again.



> messages in it and also takes a number of mouse clicks because of the
> way tray popup menu behaves.
>
> Anyway the purported reason to remove it is totally bogus. Its like
> auth-token cant cope with SIGHUP, so let's remove that signal.
>

no, that is wrong interpretaion.
I actually meant

"it is broken" --> "users do not complain" --> "users do not care" -->
"other buttons will keep their places" --> "let us remove unused button"


>
> Finally, I'm an user too and I use that button all the time, though
> mostly for testing. If that counts as a dissenting voice.
>


yes, I also meant that. it is "designed by developers for themselves" :)
same as "edit config" menu item.
developers need edit config all the time and reconnect. but do users do
same things as well ?


as for "edit config", I'd like to keep it. it's removal will change menu
order, people will click at wrong items.


>
> Selva
>

--f403045e93ec59ef230564c0fba6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2018-02-08 20:40 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"=
mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Thu, Feb 8, 2018 at 3:15 AM, Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:=
samuli@...515..." target=3D"_blank">samuli@...515...</a>&gt; wrote:<br>
&gt; Il 07/02/2018 21:58, David Sommerseth ha scritto:<br>
&gt;&gt; On 07/02/18 20:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD wrote:<br>
&gt;&gt;&gt; After auth-token were introduced, when user press &quot;Reconn=
ect&quot;, it leads to<br>
&gt;&gt;&gt; auth fail (saved password is forgotten), we run about 1000 use=
rs, nobody<br>
&gt;&gt;&gt; complains.<br>
&gt;&gt;<br>
&gt;&gt; This is actually expected, I&#39;d say - but smells like a bug on =
the server side<br>
&gt;&gt; authentication.<br>
&gt;&gt;<br>
&gt;&gt; Selva may correct me if I&#39;m wrong, but my understanding of it =
when clicking<br>
&gt;&gt; &quot;Reconnect&quot;, the local OpenVPN process which caches the =
auth-token is stopped<br>
&gt;&gt; and a new OpenVPN process is started.=C2=A0 The client should in t=
his case ask for<br>
&gt;&gt; username/password again.=C2=A0 So in this case, the server side sh=
ould treat this<br>
&gt;&gt; connection as a fresh connection with no initial state.<br>
&gt;&gt;<br>
&gt;&gt; The step of stopping the local client and starting a new and fresh=
 one is<br>
&gt;&gt; definitely not a bad feature to have on clients.<br>
&gt;&gt;<br>
&gt;&gt;&gt; It looks like nobody uses that button.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; So, I asked several users, they confirmed they do not use Reco=
nnect.<br>
&gt;&gt;<br>
&gt;&gt; This is no good argument for me.=C2=A0 This is one specific setup =
with 1000 users.<br>
&gt;&gt; It would be more valuable with 50 different setups having 20 users=
 each.=C2=A0 Your<br>
&gt;&gt; conclusion is based on a very homogeneous environment.<br>
&gt;<br>
&gt; I agree. I also agree that the underlying problem should be fixed.<br>
&gt;<br>
&gt; That said, Ilya&#39;s message was sent to both openvpn-users and<br>
&gt; openvpn-devel and nobody has screamed &quot;do not remove the Reconnec=
t<br>
&gt; button&quot; :). The only additional thing we can do is post a message=
 to the<br>
&gt; forums. As usual, the only sure way to get feedback (read: complaints)=
<br>
&gt; is to release the changes in an official build/installer.<br>
<br>
Only recently we added a reconnect item to the menu (earlier it was<br>
only available as a button in the status window) for ease of doing<br>
reconnects and based on user requests -- though I can&#39;t now find who<br>
asked for it.<br></blockquote><div><br></div><div>it is interesting.<br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
I wouldn&#39;t take lack of response on the user&#39;s list as an indicatio=
n<br>
that no one uses it. In fact its very handy -- how else will you<br>
restart a connection after editing the config file? Disconnect and<br>
connect again? That would close the status window and lose all<br></blockqu=
ote><div><br></div><div>yes. disconnect and connect again.<br></div><div><b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
messages in it and also takes a number of mouse clicks because of the<br>
way tray popup menu behaves.<br>
<br>
Anyway the purported reason to remove it is totally bogus. Its like<br>
auth-token cant cope with SIGHUP, so let&#39;s remove that signal.<br></blo=
ckquote><div><br></div><div>no, that is wrong interpretaion.</div><div>I ac=
tually meant</div><div><br></div><div>&quot;it is broken&quot; --&gt; &quot=
;users do not complain&quot; --&gt; &quot;users do not care&quot; --&gt; &q=
uot;other buttons will keep their places&quot; --&gt; &quot;let us remove u=
nused button&quot;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Finally, I&#39;m an user too and I use that button all the time, though<br>
mostly for testing. If that counts as a dissenting voice.<br></blockquote><=
div><br></div><div><br></div><div>yes, I also meant that. it is &quot;desig=
ned by developers for themselves&quot; :) same as &quot;edit config&quot; m=
enu item.</div><div>developers need edit config all the time and reconnect.=
 but do users do same things as well ?</div><div><br></div><div><br></div><=
div>as for &quot;edit config&quot;, I&#39;d like to keep it. it&#39;s remov=
al will change menu order, people will click at wrong items.<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
<span class=3D"m_5344220610536062285HOEnZb"><font color=3D"#888888"><br>
Selva<br>
</font></span></blockquote></div><br></div></div>

--f403045e93ec59ef230564c0fba6--

