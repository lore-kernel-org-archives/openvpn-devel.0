MIME-Version: 1.0
In-Reply-To: <CAEsd45QPMD57_L-yWHORqumv_-MT6rjC++FVCDRos9F0tTvMvw@...278...>
References: <CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA@...278...>
 <56fd237f-ba3f-c65d-9831-bf75d4dd139d@...1227...>
 <CAKuzo_gAZSaVvfSiaZSHC5ESXJ2Q8mEBPq6oV6Wk+AfDidqoXA@...278...>
 <CAEsd45QPMD57_L-yWHORqumv_-MT6rjC++FVCDRos9F0tTvMvw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 2 Dec 2017 11:27:03 -0500
Message-ID: <CAKuzo_ju2jiJTmOXATPu14cej-+1oPvGwZKAtjc6w=dcVmXezQ@...278...>
Content-Type: multipart/alternative; boundary="94eb2c0e44e0d27043055f5df550"
Subject: Re: [Openvpn-devel] Follow up on sending messages to the GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0e44e0d27043055f5df550
Content-Type: text/plain; charset="UTF-8"

Hi

On Sat, Dec 2, 2017 at 7:08 AM, Jonathan K. Bullard <jkbullard@...277...>
wrote:

> Hi,
>
> On Fri, Dec 1, 2017 at 10:58 AM, Selva Nair <selva.nair@...277...> wrote:
> >
> > Hi,
> >
> > On Fri, Dec 1, 2017 at 8:53 AM, Arne Schwabe <arne@...1227...> wrote:
> >>
>
..

> >>
> >> Could we have some text stating that clients might only display one
> message per connect? At the moment you can have multiple "echo msg-notify
> message-title" pushed by the server. I would like to avoid in my client to
> implement logic to display multiple messages. If one message allowed the
> message can become just an Android notification without special logic
> >
> >
> > Yes, we can and probably should document that some clients may only
> > display one message. Do you also want to say that some clients may
> > interpret msg-window as msg-notify?
> >
> > Even in case of Windows desktop, I think it may be better to display
> > only one message per connection as otherwise it starts to get very
> > noisy. At most one message window and one notification.
> >
> > Jon, do you plan to document the proposed "echo msg" specs in management
> > notes or elsewhere?  The single message per connect limitation
> > could be specified there.
>
> I'll be happy to try to document the protocol between OpenVPN and the
> GUI, including the "msg*" commands and others such as
> "forget-passwords", "setenv", etc., which we've discussed. However,
> I'm thinking it should be a separate "doc/gui-notes.txt" document.
>

Agreed, echo as such is already documented in management-notes,
and this is about standardizing how gui's interpret the echoed text
or directives.

Make sense to have a separate document.

Selva

--94eb2c0e44e0d27043055f5df550
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote">On Sat, Dec 2, 2017 at 7:08 AM, Jonathan K. Bullard <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:jkbullard@...277..." target=3D"_blank">jkbullard@...493...=
277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Fri, Dec 1, 2017 at 10:58 AM, Selva Nair &lt;<a href=3D"mailto:selva.nai=
r@...277...">selva.nair@...277...</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Fri, Dec 1, 2017 at 8:53 AM, Arne Schwabe &lt;<a href=3D"mailto:arn=
e@...1227...">arne@...1227...</a>&gt; wrote:<br>
&gt;&gt;<br></span></blockquote><div>..=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><span class=3D"">
&gt;&gt;<br>
&gt;&gt; Could we have some text stating that clients might only display on=
e message per connect? At the moment you can have multiple &quot;echo msg-n=
otify message-title&quot; pushed by the server. I would like to avoid in my=
 client to implement logic to display multiple messages. If one message all=
owed the message can become just an Android notification without special lo=
gic<br>
&gt;<br>
&gt;<br>
&gt; Yes, we can and probably should document that some clients may only<br>
&gt; display one message. Do you also want to say that some clients may<br>
&gt; interpret msg-window as msg-notify?<br>
&gt;<br>
&gt; Even in case of Windows desktop, I think it may be better to display<b=
r>
&gt; only one message per connection as otherwise it starts to get very<br>
&gt; noisy. At most one message window and one notification.<br>
&gt;<br>
&gt; Jon, do you plan to document the proposed &quot;echo msg&quot; specs i=
n management<br>
&gt; notes or elsewhere?=C2=A0 The single message per connect limitation<br>
&gt; could be specified there.<br>
<br>
</span>I&#39;ll be happy to try to document the protocol between OpenVPN an=
d the<br>
GUI, including the &quot;msg*&quot; commands and others such as<br>
&quot;forget-passwords&quot;, &quot;setenv&quot;, etc., which we&#39;ve dis=
cussed. However,<br>
I&#39;m thinking it should be a separate &quot;doc/gui-notes.txt&quot; docu=
ment.<br></blockquote><div><br></div><div>Agreed, echo as such is already d=
ocumented in management-notes,</div><div>and this is about standardizing ho=
w gui&#39;s interpret the echoed text</div><div>or directives.</div><div><b=
r></div><div>Make sense to have a separate document.</div><div><br></div><d=
iv>Selva</div></div><br></div></div>

--94eb2c0e44e0d27043055f5df550--

