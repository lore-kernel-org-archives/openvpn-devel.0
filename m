References: <20200813072923.24385-1-eric@...1918...>
 <1fb10dd1-8ddf-c467-21a5-a93e21e6a8ac@...1227...>
 <0a634481-cf3b-de2f-5e34-8f5c5ef16fdc@...1918...>
 <CAKuzo_h_xWf-Jbkow=H3sL_CQw5CC23pw3DxH0Nsydj2f57usg@...278...>
From: Eric Thorpe <eric@...1918...>
Message-ID: <dc800745-efe3-0f10-d08f-046fc041c96a@...1918...>
Date: Mon, 24 Aug 2020 17:49:50 +1000
MIME-Version: 1.0
In-Reply-To: <CAKuzo_h_xWf-Jbkow=H3sL_CQw5CC23pw3DxH0Nsydj2f57usg@...278...>
Content-Type: multipart/alternative;
 boundary="------------277FF2AD10472E5598DC164D"
Content-Language: en-US
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
To: Selva Nair <selva.nair@...277...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------277FF2AD10472E5598DC164D
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Selva,

> my=C2=A0suggestion would be to make
> this conditional on MANAGEMNET_DEF_AUTH so that we can
> then get it from=C2=A0 session->opt->mda_context just as we do it when
> auth is=C2=A0done via the management. In practice, that would cover
> most builds where this is really useful.
Unfortunately this doesn't help. The mda_context flags are only set when=20
--management-client-auth is in use, meaning this patch would not cover=20
plugin or script authentication, which are the more commonly used, and=20
this patch set specifically addresses plugin authentication.

Regards,
Eric

---
Eric Thorpe
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...

On 23/08/2020 12:13 pm, Selva Nair wrote:
> Hi,
>
> On Thu, Aug 13, 2020 at 4:37 AM Eric Thorpe <eric@...1918...=20
> <mailto:eric@...1918...>> wrote:
>
>     Hi Arne,
>
>     The issue is your state is not accessible from where that boolean
>     needs
>     to be used unless I am missing something? Please advise if I'm
>     mistaken
>     or of another route.
>
>
> I agree with Arne that duplicating a state machine variable is
> not a good approach. But we have to somehow get the REAUTH (reneg)
> info in here.
>
> This has stalled for too long, so my=C2=A0suggestion would be to make
> this conditional on MANAGEMNET_DEF_AUTH so that we can
> then get it from=C2=A0 session->opt->mda_context just as we do it when
> auth is=C2=A0done via the management. In practice, that would cover
> most builds where this is really useful.
>
> In fact, I think we should always enable MANAGEMENT_DEF_AUTH
> when management is enabled. That also gets rid of a lot of IFDEFs and
> allow the use of useful bits like CID more widely in the code. I see
> no compelling reason for such fine-grained build options.
>
> A marginal increase in code size is of little consequence all but
> embedded devices which can continue to cope without this
> as they do now.
>
> Selva

--------------277FF2AD10472E5598DC164D
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p>Hi Selva,</p>
    <p>
      <blockquote type=3D"cite">my=C2=A0suggestion would be to make
        <div>this conditional on MANAGEMNET_DEF_AUTH so that we can</div>
        <div>then get it from=C2=A0 session-&gt;opt-&gt;mda_context just as
          we do it when=C2=A0</div>
        <div>auth is=C2=A0done via the management. In practice, that would
          cover</div>
        <div>most builds where this is really useful.</div>
      </blockquote>
      Unfortunately this doesn't help. The mda_context flags are only
      set when --management-client-auth is in use, meaning this patch
      would not cover plugin or script authentication, which are the
      more commonly used, and this patch set specifically addresses
      plugin authentication.<br>
    </p>
    <p>Regards,<br>
      Eric<br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">---
Eric Thorpe
SparkLabs Developer
<a class=3D"moz-txt-link-freetext" href=3D"https://www.sparklabs.com">https=
://www.sparklabs.com</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://twitter.com/sparklabs">h=
ttps://twitter.com/sparklabs</a>
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:support@...1918...">su=
pport@...1918...</a></pre>
    <div class=3D"moz-cite-prefix">On 23/08/2020 12:13 pm, Selva Nair
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CAKuzo_h_xWf-Jbkow=3DH3sL_CQw5CC23pw3DxH0Nsydj2f57usg@...278...=
">
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
      <div dir=3D"ltr">
        <div dir=3D"ltr">Hi,
          <div><br>
          </div>
        </div>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 13, 2020 at 4:37
            AM Eric Thorpe &lt;<a href=3D"mailto:eric@...1918..."
              moz-do-not-send=3D"true">eric@...1918...</a>&gt; wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">Hi Arne,<br>
            <br>
            The issue is your state is not accessible from where that
            boolean needs <br>
            to be used unless I am missing something? Please advise if
            I'm mistaken <br>
            or of another route.<br>
          </blockquote>
          <div><br>
          </div>
          <div>I agree with Arne that duplicating a state machine
            variable is=C2=A0</div>
          <div>not a good approach. But we have to somehow get the
            REAUTH (reneg)=C2=A0</div>
          <div>info in here.</div>
          <div><br>
          </div>
          <div>This has stalled for too long, so my=C2=A0suggestion would be
            to make</div>
          <div>this conditional on MANAGEMNET_DEF_AUTH so that we can</div>
          <div>then get it from=C2=A0 session-&gt;opt-&gt;mda_context just =
as
            we do it when=C2=A0</div>
          <div>auth is=C2=A0done via the management. In practice, that would
            cover</div>
          <div>most builds where this is really useful.</div>
          <div><br>
          </div>
          <div>In fact, I think we should always enable
            MANAGEMENT_DEF_AUTH</div>
          <div>when management is enabled. That also gets rid of a lot
            of IFDEFs and</div>
          <div>allow the use of useful bits like CID more widely in the
            code. I see</div>
          <div>no compelling reason for such fine-grained build options.</d=
iv>
          <div><br>
          </div>
          <div>A marginal increase in code size is of little consequence
            all but</div>
          <div>embedded devices which can continue to cope without this</di=
v>
          <div>as they do now.</div>
          <div><br>
          </div>
          <div>Selva</div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------277FF2AD10472E5598DC164D--

