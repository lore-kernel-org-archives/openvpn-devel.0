MIME-Version: 1.0
References: <20200813072923.24385-1-eric@...1918...>
 <1fb10dd1-8ddf-c467-21a5-a93e21e6a8ac@...1227...>
 <0a634481-cf3b-de2f-5e34-8f5c5ef16fdc@...1918...>
 <CAKuzo_h_xWf-Jbkow=H3sL_CQw5CC23pw3DxH0Nsydj2f57usg@...278...>
 <dc800745-efe3-0f10-d08f-046fc041c96a@...1918...>
In-Reply-To: <dc800745-efe3-0f10-d08f-046fc041c96a@...1918...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 24 Aug 2020 10:25:00 -0400
Message-ID: <CAKuzo_heHMcpRd31Lc=ZHDjPAb3GsQoBQB4iQvXCd7EPTnGEug@...278...>
Content-Type: multipart/alternative; boundary="0000000000000ece0705ada05bed"
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

--0000000000000ece0705ada05bed
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 24, 2020 at 3:49 AM Eric Thorpe <eric@...1918...> wrote:

> Hi Selva,
>
> my suggestion would be to make
> this conditional on MANAGEMNET_DEF_AUTH so that we can
> then get it from  session->opt->mda_context just as we do it when
> auth is done via the management. In practice, that would cover
> most builds where this is really useful.
>
> Unfortunately this doesn't help. The mda_context flags are only set when
> --management-client-auth is in use, meaning this patch would not cover
> plugin or script authentication, which are the more commonly used, and this
> patch set specifically addresses plugin authentication.
>

Are you sure of that?

In multi_connection_estableished, we have

#ifdef MANAGEMENT_DEF_AUTH
    if (management)
    {
        management_connection_established(management,
                                          &mi->context.c2.mda_context, mi->
context.c2.es);
    }
#endif

management_connection_established will set DAF_CONENCTION_ESATBLISHED in
mdac->flags and that's what's used to determine REAUTH.

I do not see why this requires --management-client-auth or any management
related options to be in use. Sure, management support and deferred auth
support have to be enabled but restricting the usefulness of your patch to
those cases is not really a limitation.

What am I missing?

Selva

---
> Eric Thorpe
> SparkLabs Developerhttps://www.sparklabs.comhttps://twitter.com/sparklabssupport@...1918...
>
> On 23/08/2020 12:13 pm, Selva Nair wrote:
>
> Hi,
>
> On Thu, Aug 13, 2020 at 4:37 AM Eric Thorpe <eric@...1918...> wrote:
>
>> Hi Arne,
>>
>> The issue is your state is not accessible from where that boolean needs
>> to be used unless I am missing something? Please advise if I'm mistaken
>> or of another route.
>>
>
> I agree with Arne that duplicating a state machine variable is
> not a good approach. But we have to somehow get the REAUTH (reneg)
> info in here.
>
> This has stalled for too long, so my suggestion would be to make
> this conditional on MANAGEMNET_DEF_AUTH so that we can
> then get it from  session->opt->mda_context just as we do it when
> auth is done via the management. In practice, that would cover
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
>
>

--0000000000000ece0705ada05bed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 24, 2020 at 3:49 AM Eric =
Thorpe &lt;<a href=3D"mailto:eric@...1918...">eric@...1918...</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=20=20
=20=20=20=20
=20=20
  <div>
    <p>Hi Selva,</p>
    <p>
      </p><blockquote type=3D"cite">my=C2=A0suggestion would be to make
        <div>this conditional on MANAGEMNET_DEF_AUTH so that we can</div>
        <div>then get it from=C2=A0 session-&gt;opt-&gt;mda_context just as
          we do it when=C2=A0</div>
        <div>auth is=C2=A0done via the management. In practice, that would
          cover</div>
        <div>most builds where this is really useful.</div>
      </blockquote>
      Unfortunately this doesn&#39;t help. The mda_context flags are only
      set when --management-client-auth is in use, meaning this patch
      would not cover plugin or script authentication, which are the
      more commonly used, and this patch set specifically addresses
      plugin authentication.<br></div></blockquote><div><br></div><div>Are =
you sure of that?=C2=A0</div><div><br></div><div>In multi_connection_establ=
eished, we have</div><div><br></div><div>#ifdef MANAGEMENT_DEF_AUTH<br>=C2=
=A0 =C2=A0 if (management)<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 management_connection_established(management,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;mi-&gt;context.c2=
.mda_context, mi-&gt;<a href=3D"http://context.c2.es">context.c2.es</a>);<b=
r>=C2=A0 =C2=A0 }<br>#endif<br></div><div><br></div><div>management_connect=
ion_established will set DAF_CONENCTION_ESATBLISHED in mdac-&gt;flags and t=
hat&#39;s what&#39;s used to determine REAUTH.=C2=A0</div><div><br></div><d=
iv>I do not see why this requires --management-client-auth or any managemen=
t related options to be in use. Sure, management support and deferred auth =
support have to be enabled but restricting the usefulness of your patch to =
those cases is not really a limitation.</div><div><br></div><div>What am I =
missing?</div><div><br></div><div>Selva</div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div>
    <pre cols=3D"72">---
Eric Thorpe
SparkLabs Developer
<a href=3D"https://www.sparklabs.com" target=3D"_blank">https://www.sparkla=
bs.com</a>
<a href=3D"https://twitter.com/sparklabs" target=3D"_blank">https://twitter=
.com/sparklabs</a>
<a href=3D"mailto:support@...1918..." target=3D"_blank">support@...1918...<=
/a></pre>
    <div>On 23/08/2020 12:13 pm, Selva Nair
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
=20=20=20=20=20=20
      <div dir=3D"ltr">
        <div dir=3D"ltr">Hi,
          <div><br>
          </div>
        </div>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 13, 2020 at 4:37
            AM Eric Thorpe &lt;<a href=3D"mailto:eric@...1918..." target=3D=
"_blank">eric@...1918...</a>&gt; wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Arne,<br>
            <br>
            The issue is your state is not accessible from where that
            boolean needs <br>
            to be used unless I am missing something? Please advise if
            I&#39;m mistaken <br>
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
  </div>

</blockquote></div></div>

--0000000000000ece0705ada05bed--

