MIME-Version: 1.0
In-Reply-To: <56fd237f-ba3f-c65d-9831-bf75d4dd139d@...1227...>
References: <CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA@...278...>
 <56fd237f-ba3f-c65d-9831-bf75d4dd139d@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 1 Dec 2017 10:58:04 -0500
Message-ID: <CAKuzo_gAZSaVvfSiaZSHC5ESXJ2Q8mEBPq6oV6Wk+AfDidqoXA@...278...>
Content-Type: multipart/alternative; boundary="001a113ad3b4546d5f055f497059"
Subject: Re: [Openvpn-devel] Follow up on sending messages to the GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113ad3b4546d5f055f497059
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Dec 1, 2017 at 8:53 AM, Arne Schwabe <arne@...1227...> wrote:

> Am 30.11.2017 um 03:03 schrieb Selva Nair:
>
> Cross-posting to users and devel as this may be of interest to both.
>
> Hi,
>
> I have made a draft implementation of this feature that was discussed in a
> previous thread. A test executable (GUI only) is in this pre-release:
>
> https://github.com/selvanair/openvpn-gui/releases/tag/v11-echo-msg
>
> It would be great if anyone can test this out[*].
>
> Thanks,
>
> Selva
>
> [*] Although virtually any text can be sent, some familiarity with openvpn
> config/ccd parsing/quoting and push processing is necessary to get it
> right for non-trivial messages that contain comment characters, commas, new
> lines etc... Short and simple messages must be easy, though.
>
>
> Could we have some text stating that clients might only display one
> message per connect? At the moment you can have multiple "echo msg-notify
> message-title" pushed by the server. I would like to avoid in my client to
> implement logic to display multiple messages. If one message allowed the
> message can become just an Android notification without special logic
>

Yes, we can and probably should document that some clients may only
display one message. Do you also want to say that some clients may
interpret msg-window as msg-notify?

Even in case of Windows desktop, I think it may be better to display
only one message per connection as otherwise it starts to get very
noisy. At most one message window and one notification.

Jon, do you plan to document the proposed "echo msg" specs in management
notes or elsewhere?  The single message per connect limitation
could be specified there.


> > msg-window : displayed only when starting from a disconnected state
> > not when reconnecting by SIGUSR1 or SIGHUP
>
> We need to clarify this a bit. You probably mean "reconnecting after a
> successful" connection. If there are multiple remote in the config and only
> the 3rd works you already have had two internal SIGUSR1.
>

Ah, I didn't think of that. In my current implementation, it'll miss the
message if a second remote succeeds after a failure with first remote.
I'll fix this.

If a successful connection moves to a new remote, we
may get a new message worth showing to the user but will be ignored
(unless its a notification). This may not be ideal but I want to avoid
displaying popups when the user may not be even at the desktop.
Any thoughts on this?

Thanks,

Selva

--001a113ad3b4546d5f055f497059
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Fri, Dec 1, 2017 at 8:53 AM, Arne Schwabe <span dir=3D"ltr">&lt;<=
a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
=20=20
=20=20=20=20
=20=20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF"><span class=3D"">
    <div class=3D"m_-3369676424823065534moz-cite-prefix">Am 30.11.2017 um 0=
3:03 schrieb Selva
      Nair:<br>
    </div>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>Cross-posting to users and <span id=3D"m_-3369676424823065534:=
64w.1">devel</span> as this may be of interest to
          both.</div>
        <div><br>
        </div>
        Hi,
        <div><br>
        </div>
        <div>I have made a draft implementation of this feature that was
          discussed in a previous thread. A test executable (GUI only)
          is in this <span id=3D"m_-3369676424823065534:64w.2">pre</span>-r=
elease:</div>
        <div><br>
        </div>
        <div><a href=3D"https://github.com/selvanair/openvpn-gui/releases/t=
ag/v11-echo-msg" target=3D"_blank">https://<span id=3D"m_-33696764248230655=
34:64w.3">github</span>.com/<span id=3D"m_-3369676424823065534:64w.4">selva=
nair</span>/<span id=3D"m_-3369676424823065534:64w.5">o<wbr>penvpn</span>-<=
span id=3D"m_-3369676424823065534:64w.6">gui</span>/releases/tag/v11-ec<wbr=
>ho-<span id=3D"m_-3369676424823065534:64w.7">msg</span></a><br>
        </div>
        <div><br>
        </div>
        <div>It would be great if anyone can test this out[*].</div>
        <div><br>
        </div>
        <div>Thanks,</div>
        <div><br>
        </div>
        <div><span id=3D"m_-3369676424823065534:64w.8">Selva</span></div>
        <div><br>
        </div>
        <div>[*] Although virtually any text can be sent, some
          familiarity with <span id=3D"m_-3369676424823065534:64w.9">openvp=
n</span>
          <span id=3D"m_-3369676424823065534:64w.10">config</span>/<span id=
=3D"m_-3369676424823065534:64w.11">ccd</span>
          parsing/quoting and push processing is necessary to get it
          right for non-trivial messages that contain comment
          characters, commas, new lines etc... Short and simple messages
          must be easy, though.</div>
      </div>
    </blockquote>
    <br></span>
    Could we have some text stating that clients might only display one
    message per connect? At the moment you can have multiple &quot;echo
    msg-notify message-title&quot; pushed by the server. I would like to
    avoid in my client to implement logic to display multiple messages.
    If one message allowed the message can become just an Android
    notification without special logic<br></div></blockquote><div><br></div=
><div>Yes, we can and probably should document that some clients may only</=
div><div>display one message. Do you also want to say that some clients may=
</div><div>interpret msg-window as msg-notify?</div><div><br></div><div>Eve=
n in case of Windows desktop, I think it may be better to display</div><div=
>only one message per connection as otherwise it starts to get very</div><d=
iv>noisy. At most one message window and one notification.</div><div>=C2=A0=
</div><div>Jon, do you plan to document the proposed &quot;echo msg&quot; s=
pecs in management</div><div>notes or elsewhere?=C2=A0 The single message p=
er connect limitation</div><div>could be specified there.</div><div><br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <span><br>
      &gt; msg-window : displayed only when starting from a disconnected
      state</span><br>
    <span>
      &gt; not when reconnecting by SIGUSR1 or SIGHUP</span><span><br>
      <br>
      We need to clarify this a bit. You probably mean &quot;reconnecting
      after a successful&quot; connection. If there are multiple remote in
      the config and only the 3rd works you already have had two
      internal SIGUSR1.</span></div></blockquote><div><br></div><div>Ah, I =
didn&#39;t think of that. In my current implementation, it&#39;ll miss the<=
/div><div>message if a second remote succeeds after a failure with first re=
mote.</div><div>I&#39;ll fix this.</div><div><br></div><div>If a successful=
 connection moves to a new remote, we</div><div>may get a new message worth=
 showing to the user but will be ignored</div><div>(unless its a notificati=
on). This may not be ideal but I want to avoid</div><div>displaying popups =
when the user may not be even at the desktop.</div><div>Any thoughts on thi=
s?</div><div>=C2=A0<br></div><div>Thanks,</div><div><br></div><div>Selva</d=
iv></div></div></div>

--001a113ad3b4546d5f055f497059--

