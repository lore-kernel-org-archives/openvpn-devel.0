MIME-Version: 1.0
References: <20200813072923.24385-1-eric@...1918...>
 <1fb10dd1-8ddf-c467-21a5-a93e21e6a8ac@...1227...>
 <0a634481-cf3b-de2f-5e34-8f5c5ef16fdc@...1918...>
In-Reply-To: <0a634481-cf3b-de2f-5e34-8f5c5ef16fdc@...1918...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 22 Aug 2020 22:13:43 -0400
Message-ID: <CAKuzo_h_xWf-Jbkow=H3sL_CQw5CC23pw3DxH0Nsydj2f57usg@...278...>
Content-Type: multipart/alternative; boundary="000000000000e3bdc205ad820595"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Send auth-fail messages to clients
 on renegotiation failures via auth-token or user-pass expiry
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000e3bdc205ad820595
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Aug 13, 2020 at 4:37 AM Eric Thorpe <eric@...1918...> wrote:

> Hi Arne,
>
> The issue is your state is not accessible from where that boolean needs
> to be used unless I am missing something? Please advise if I'm mistaken
> or of another route.
>

I agree with Arne that duplicating a state machine variable is
not a good approach. But we have to somehow get the REAUTH (reneg)
info in here.

This has stalled for too long, so my suggestion would be to make
this conditional on MANAGEMNET_DEF_AUTH so that we can
then get it from  session->opt->mda_context just as we do it when
auth is done via the management. In practice, that would cover
most builds where this is really useful.

In fact, I think we should always enable MANAGEMENT_DEF_AUTH
when management is enabled. That also gets rid of a lot of IFDEFs and
allow the use of useful bits like CID more widely in the code. I see
no compelling reason for such fine-grained build options.

A marginal increase in code size is of little consequence all but
embedded devices which can continue to cope without this
as they do now.

Selva

--000000000000e3bdc205ad820595
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div></div><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 13, 2020 at 4:3=
7 AM Eric Thorpe &lt;<a href=3D"mailto:eric@...1918...">eric@...1918...</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi A=
rne,<br>
<br>
The issue is your state is not accessible from where that boolean needs <br>
to be used unless I am missing something? Please advise if I&#39;m mistaken=
 <br>
or of another route.<br></blockquote><div><br></div><div>I agree with Arne =
that duplicating a state machine variable is=C2=A0</div><div>not a good app=
roach. But we have to somehow get the REAUTH (reneg)=C2=A0</div><div>info i=
n here.</div><div><br></div><div>This has stalled for too long, so my=C2=A0=
suggestion would be to make</div><div>this conditional on MANAGEMNET_DEF_AU=
TH so that we can</div><div>then get it from=C2=A0 session-&gt;opt-&gt;mda_=
context just as we do it when=C2=A0</div><div>auth is=C2=A0done via the man=
agement. In practice, that would cover</div><div>most builds where this is =
really useful.</div><div><br></div><div>In fact, I think we should always e=
nable MANAGEMENT_DEF_AUTH</div><div>when management is enabled. That also g=
ets rid of a lot of IFDEFs and</div><div>allow the use of useful bits like =
CID more widely in the code. I see</div><div>no compelling reason for such =
fine-grained build options.</div><div><br></div><div>A marginal increase in=
 code size is of little consequence all but</div><div>embedded devices whic=
h can continue to cope without this</div><div>as they do now.</div><div><br=
></div><div>Selva</div></div></div>

--000000000000e3bdc205ad820595--

