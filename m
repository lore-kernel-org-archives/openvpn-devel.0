MIME-Version: 1.0
References: <20201220105430.GP976@...1296...>
 <093511bd-43c0-a37c-1d8f-335d9df451d6@...1227...>
 <20201220185402.GQ976@...1296...>
 <CAKuzo_ja=a9XxHkQX5Vv2_UTT1vWNfO8S-XLvvKZ_CQ6f-U1uQ@...278...>
 <20201225200335.GA976@...1296...>
In-Reply-To: <20201225200335.GA976@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 25 Dec 2020 15:32:26 -0500
Message-ID: <CAKuzo_jc1idAtGLLteWs0L6MfHYF76AD2h+rE5LASNTPj5XsOA@...278...>
Content-Type: multipart/alternative; boundary="000000000000860fec05b74fd385"
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000860fec05b74fd385
Content-Type: text/plain; charset="UTF-8"

Hi

Thanks for the comments.

On Fri, Dec 25, 2020 at 3:03 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Sun, Dec 20, 2020 at 07:31:42PM -0500, Selva Nair wrote:
> > Here is the link again.
> > https://github.com/selvanair/openvpn-gui/releases/tag/v11-echo-msg
> > I got no feedback then nor now.
>
> I have stared at the code a bit, and it seems to make sense.  The part
> "store a digest + timestamp, and avoid repeating the same message for
> <n> hours" is a good idea.
>
> I can see that "echo_msg_clear()" has a bool parameter to clear the
> message history but I can not see a call with "true" - what did you
> have in mind?  A button to clear the messages history?  Or "if changing
> to a different profile"?
>

It has been a while...

The history needs to be cleared to free up memory when the thread is
terminated on disconnect. Looks like a bug if it's not done during cleanup.
That said, I see that I have newer versions of this echo-msg branch (upto
v4) in my local repo and the latest includes persisting the history in
registry and clearing before disconnect.


> I have not tested the binary.
>

Don't. While we are in this blessed "One True Echo" state, let me rebase
the latest version, do some quick tests and post it as a PR for review &
comments.

Have to do that before I again get stuck in procrastination and the desire
to add more glitter like urls in message text etc..

Selva

--000000000000860fec05b74fd385
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><div><br></div>Thanks for the comments.<div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri,=
 Dec 25, 2020 at 3:03 PM Gert Doering &lt;<a href=3D"mailto:gert@...1296...=
">gert@...1296...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Hi,<br>
<br>
On Sun, Dec 20, 2020 at 07:31:42PM -0500, Selva Nair wrote:<br>
&gt; Here is the link again.<br>
&gt; <a href=3D"https://github.com/selvanair/openvpn-gui/releases/tag/v11-e=
cho-msg" rel=3D"noreferrer" target=3D"_blank">https://github.com/selvanair/=
openvpn-gui/releases/tag/v11-echo-msg</a><br>
&gt; I got no feedback then nor now.<br>
<br>
I have stared at the code a bit, and it seems to make sense.=C2=A0 The part=
<br>
&quot;store a digest + timestamp, and avoid repeating the same message for<=
br>
&lt;n&gt; hours&quot; is a good idea.<br>
<br>
I can see that &quot;echo_msg_clear()&quot; has a bool parameter to clear t=
he<br>
message history but I can not see a call with &quot;true&quot; - what did y=
ou <br>
have in mind?=C2=A0 A button to clear the messages history?=C2=A0 Or &quot;=
if changing<br>
to a different profile&quot;?<br></blockquote><div><br></div><div>It has be=
en a while...</div><div><br></div><div>The history needs to be cleared to f=
ree up memory when the thread is terminated on disconnect. Looks like a bug=
 if it&#39;s not done during cleanup. That said, I see that I have newer ve=
rsions of this echo-msg branch (upto v4) in my local repo and the=C2=A0late=
st includes persisting the history in registry and clearing before disconne=
ct.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I have not tested the binary.<br></blockquote><div><br></div><div>Don&#39;t=
. While we are in this blessed &quot;One True Echo&quot; state, let me reba=
se the latest version, do some quick tests and post it as a PR for=C2=A0rev=
iew &amp; comments.=C2=A0</div><div><br></div><div>Have to do that before I=
 again get stuck in procrastination and the desire to add more glitter like=
 urls in message text etc..</div><div><br></div><div>Selva</div></div></div=
></div>

--000000000000860fec05b74fd385--

