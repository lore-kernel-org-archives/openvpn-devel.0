MIME-Version: 1.0
References: <gerrit.1733989644000.I3fb01ab76cf3df0874ba92e08f371d17607a8369@...2715...>
 <a7e11016a114631f281dc7c769e55533a80728ac-EmailReplacePatchSet-HTML@...2715...>
 <CAEsd45SvAi2eqYYqfajzVnwxK9TuN6cO9PskoQk2oNAC8pu_Qg@...278...>
 <5948319.31r3eYUQgx@...2664...>
In-Reply-To: <5948319.31r3eYUQgx@...2664...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 20 Jan 2025 18:06:19 -0500
Message-ID: <CAEsd45THxw2U9g=dWvx0_Mutw5KHq3+tvtpyO_xYe3MTOoM+Qw@...278...>
Content-Type: multipart/alternative; boundary="00000000000013ae1c062c2b51ad"
Subject: Re: [Openvpn-devel] [L] Change in openvpn[master]: dns: don't
 publish env vars to non-dns scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko@...515...>
Cc: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net, frank@...2641...

--00000000000013ae1c062c2b51ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi.

On Mon, Jan 20, 2025 at 2:38=E2=80=AFPM Heiko Hund <heiko@...515...> wrote:

> Hi Jon
>
> On Montag, 20. Januar 2025 00:02:46 CET Jonathan K. Bullard wrote:
> > On Mon, Jan 13, 2025 at 8:13=E2=80=AFAM d12fk (Code Review) <gerrit@...493...=
515...>
>
> wrote:
> > > With --dns-script in place we no longer need DNS related vars in the
> > > environment for other script hooks. Code for doing that is removed and
> > > the function to set --dns stuff made static, for internal use only.
> > >
> > > Another thing: since --dns setting overrule DNS related --dhcp-option=
s,
> > > remove the latter when we got some via --dns.
> >
> > Does this mean that if there are --dns options which override
> > --dns-options options, then (for macOS) the foreign_options_N
> > environment variables related to DNS will not be passed to the up/down
> > scripts? That would be a a *major* breaking change.
>
> Yes, that is the intended behavior. However, I'll port the macos DNS
> setting
> code from openvpn3 to a macos --dns-script for openvpn 2, which will run
> automatically. DNS will not break this way, but depending on how the --up
> script is written, that one might. I've not come up with an idea on how to
> prevent this potential breakage, besides a warning in the release notes
> unfortunately.
>

Thanks. That will impact Tunnelbllick because we set DNS in our own up/down
scripts. But I understand the reasons for the change.

Am I correct that the plan for this to go into 2.7 or later, and not into
2.6?

Best regards,

Jon

--00000000000013ae1c062c2b51ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi.</div><br><div class=3D"gmail_quote gmail_quote_co=
ntainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 20, 2025 at 2:38=
=E2=80=AFPM Heiko Hund &lt;<a href=3D"mailto:heiko@...515...">heiko@...2092...=
..</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-le=
ft-color:rgb(204,204,204);padding-left:1ex">Hi Jon<br>
<br>
On Montag, 20. Januar 2025 00:02:46 CET Jonathan K. Bullard wrote:<br>
&gt; On Mon, Jan 13, 2025 at 8:13=E2=80=AFAM d12fk (Code Review) &lt;<a hre=
f=3D"mailto:gerrit@...515..." target=3D"_blank">gerrit@...515...</a>&gt; <b=
r>
wrote:<br>
&gt; &gt; With --dns-script in place we no longer need DNS related vars in =
the<br>
&gt; &gt; environment for other script hooks. Code for doing that is remove=
d and<br>
&gt; &gt; the function to set --dns stuff made static, for internal use onl=
y.<br>
&gt; &gt; <br>
&gt; &gt; Another thing: since --dns setting overrule DNS related --dhcp-op=
tions,<br>
&gt; &gt; remove the latter when we got some via --dns.<br>
&gt; <br>
&gt; Does this mean that if there are --dns options which override<br>
&gt; --dns-options options, then (for macOS) the foreign_options_N<br>
&gt; environment variables related to DNS will not be passed to the up/down=
<br>
&gt; scripts? That would be a a *major* breaking change.<br>
<br>
Yes, that is the intended behavior. However, I&#39;ll port the macos DNS se=
tting <br>
code from openvpn3 to a macos --dns-script for openvpn 2, which will run <b=
r>
automatically. DNS will not break this way, but depending on how the --up <=
br>
script is written, that one might. I&#39;ve not come up with an idea on how=
 to <br>
prevent this potential breakage, besides a warning in the release notes <br>
unfortunately.<br></blockquote><div><br></div><div>Thanks. That will impact=
 Tunnelbllick because we set DNS in our own up/down scripts. But I understa=
nd the reasons for the change.</div><div><br></div><div>Am I correct that t=
he=C2=A0plan for=C2=A0this to go into 2.7 or later, and not into 2.6?</div>=
<div><br></div><div>Best regards,</div><div><br></div><div>Jon</div></div><=
/div>

--00000000000013ae1c062c2b51ad--

