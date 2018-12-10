MIME-Version: 1.0
References: <6cc03a83-47e6-cedb-254b-f445972788f5@...515...>
 <b9c984d6-bcde-0d0e-349d-3a586600b668@...515...>
 <6ebf219f-6a8e-6e39-893c-5610129abaef@...1147...>
 <CAGyAFMU1iS3FJjVbmBqYq6BeSt+UyxUrAUg=xd=cmiH3nVac6g@...278...>
 <1c6fca9e-342d-b863-303b-9dc4a78a9e0d@...1147...>
In-Reply-To: <1c6fca9e-342d-b863-303b-9dc4a78a9e0d@...1147...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 10 Dec 2018 18:29:32 +0200
Message-ID: <CAGyAFMUiKs5OkMOyOF6LgScrDyy-ukTV6Sb0e0wL+4H1ru7_Kg@...278...>
Content-Type: multipart/alternative; boundary="000000000000c7c7b4057cad7812"
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 28th Nov 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000c7c7b4057cad7812
Content-Type: text/plain; charset="UTF-8"

Hi,

I'd thoroughly test this with protocols like Google's QUIC, which uses UDP
> underneath. How does it respond to such ICMP messages? what does it do to
> throughput?
>

I tested sending ICMP "destination unreachable/fragmentation needed" with
Chrome as QUIC client and
turns out that it fallbacks to TCP if MTU is less than 1378 (IP header +
UDP header + QUIC packet 1350)

In Wireshark I observed:

quic client hello -> icmp dest unreachable -> quic connection close

1350 seems to be a maximum (as well as minimum) packet size, it doesn't get
bigger than that,
see
https://groups.google.com/a/chromium.org/forum/#!topic/proto-quic/uKWLRh9JPCo

you seem to be talking about the mssfix size, wheras I am talking about the
> tun-mtu size. When you add
>   link-mtu 1500
>   ncp-disable
> (and no fragment or mssfix)
> to a server config file, an OpenVPN 2.4 server starts up using
>   openvpn 2.4.6 -> mtu = 1379
> whereas an OpenVPN 2.3 server starts with
>     openvpn 2.3.18 -> mtu = 1431
> To me, this difference is inexplicable and annoying.
>
> (see the mail thread titled "Overhead TUN vs TAP mode" on Openvpn-users).
>

I think this is caused by "Add server-side support for cipher negotiation"
patch

https://github.com/OpenVPN/openvpn/commit/a17aa98180319f34c3240aea617bf8114d0bcaf7#diff-ecafa727f56e9ae02ef3b19924c46f24R2334

    /* Compute MTU parameters (postpone if we push/pull options) */
    if (c->options.pull || c->options.mode == MODE_SERVER)
    {
        /* Account for worst-case crypto overhead before allocating buffers
*/
        frame_add_to_extra_frame(&c->c2.frame, crypto_max_overhead());
    }
    else
    {
        crypto_adjust_frame_parameters(&c->c2.frame, &c->c1.ks.key_type,
                                       options->replay,
packet_id_long_form);
    }

In 2.3 we always adjusted frame parameters according to actual cipher (else
branch).

We probably should not account for maximum overhead if ncp-disable is set,
so
following patch seems to make things better (I got 1443 on a server and
1440 on a client).

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d24634cc..c1c951b3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2715,7 +2715,7 @@ do_init_crypto_tls(struct context *c, const unsigned
int flags)
     packet_id_long_form = cipher_kt_mode_ofb_cfb(c->c1.ks.key_type.cipher);

     /* Compute MTU parameters (postpone if we push/pull options) */
-    if (c->options.pull || c->options.mode == MODE_SERVER)
+    if (c->options.pull || (c->options.mode == MODE_SERVER &&
c->options.ncp_enabled))
     {
         /* Account for worst-case crypto overhead before allocating
buffers */
         frame_add_to_extra_frame(&c->c2.frame, crypto_max_overhead());

-- 
-Lev

--000000000000c7c7b4057cad7812
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<div bgcolor=3D"#FFFFFF">
    I&#39;d thoroughly test this with protocols like Google&#39;s QUIC, whi=
ch
    uses UDP underneath. How does it respond to such ICMP messages? what
    does it do to throughput?<br></div></blockquote><div><br></div><div>I t=
ested sending ICMP &quot;destination unreachable/fragmentation needed&quot;=
 with Chrome as QUIC client and</div><div>turns out that it fallbacks to TC=
P if MTU is less than 1378 (IP header + UDP header + QUIC packet 1350)</div=
><div><br></div><div>In Wireshark I observed:</div><div><br></div><div>quic=
 client hello -&gt; icmp dest unreachable -&gt; quic connection close</div>=
<div><br></div><div>1350 seems to be a maximum (as well as minimum) packet =
size, it doesn&#39;t get bigger than that,</div><div>see=C2=A0<a href=3D"ht=
tps://groups.google.com/a/chromium.org/forum/#!topic/proto-quic/uKWLRh9JPCo=
">https://groups.google.com/a/chromium.org/forum/#!topic/proto-quic/uKWLRh9=
JPCo</a></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div bgcolor=3D"#FFFFFF">you seem to be talking about the mssfix size, =
wheras I am talking
    about the tun-mtu size. When you add<br>
    =C2=A0 link-mtu 1500<br>
    =C2=A0 ncp-disable<br>
    (and no fragment or mssfix)<br>
    to a server config file, an OpenVPN 2.4 server starts up using<br>
    =C2=A0 openvpn 2.4.6 -&gt; mtu =3D 1379
    <br>
    whereas an OpenVPN 2.3 server starts with<br>
    =C2=A0 =C2=A0 openvpn 2.3.18 -&gt; mtu =3D 1431
    <br>
    To me, this difference is inexplicable and annoying.<br>
    <br>
    (see the mail thread titled &quot;Overhead TUN vs TAP mode&quot; on
    Openvpn-users).<br></div></blockquote><div><br></div><div>I think this =
is caused by &quot;Add server-side support for cipher negotiation&quot; pat=
ch</div><div><br></div><div><a href=3D"https://github.com/OpenVPN/openvpn/c=
ommit/a17aa98180319f34c3240aea617bf8114d0bcaf7#diff-ecafa727f56e9ae02ef3b19=
924c46f24R2334">https://github.com/OpenVPN/openvpn/commit/a17aa98180319f34c=
3240aea617bf8114d0bcaf7#diff-ecafa727f56e9ae02ef3b19924c46f24R2334</a><br><=
/div><div><br></div><div><div>=C2=A0 =C2=A0 /* Compute MTU parameters (post=
pone if we push/pull options) */</div><div>=C2=A0 =C2=A0 if (c-&gt;options.=
pull || c-&gt;options.mode =3D=3D MODE_SERVER)</div><div>=C2=A0 =C2=A0 {</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Account for worst-case crypto overhe=
ad before allocating buffers */</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 frame=
_add_to_extra_frame(&amp;c-&gt;c2.frame, crypto_max_overhead());</div><div>=
=C2=A0 =C2=A0 }</div><div>=C2=A0 =C2=A0 else</div><div>=C2=A0 =C2=A0 {</div=
><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto_adjust_frame_parameters(&amp;c-&gt=
;c2.frame, &amp;c-&gt;c1.ks.key_type,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;replay, packet_id_long_fo=
rm);</div><div>=C2=A0 =C2=A0 }</div></div><div><br></div><div>In 2.3 we alw=
ays adjusted frame parameters according to actual cipher (else branch).<br>=
</div><div><br></div><div>We probably should not account for maximum overhe=
ad if ncp-disable is set, so=C2=A0</div><div>following patch seems to make =
things better (I got 1443 on a server and 1440 on a client).</div><div><br>=
</div><div><div>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</div><=
div>index d24634cc..c1c951b3 100644</div><div>--- a/src/openvpn/init.c</div=
><div>+++ b/src/openvpn/init.c</div><div>@@ -2715,7 +2715,7 @@ do_init_cryp=
to_tls(struct context *c, const unsigned int flags)</div><div>=C2=A0 =C2=A0=
 =C2=A0packet_id_long_form =3D cipher_kt_mode_ofb_cfb(c-&gt;c1.ks.key_type.=
cipher);</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0/* Compute MTU parame=
ters (postpone if we push/pull options) */</div><div>-=C2=A0 =C2=A0 if (c-&=
gt;options.pull || c-&gt;options.mode =3D=3D MODE_SERVER)</div><div>+=C2=A0=
 =C2=A0 if (c-&gt;options.pull || (c-&gt;options.mode =3D=3D MODE_SERVER &a=
mp;&amp; c-&gt;options.ncp_enabled))</div><div>=C2=A0 =C2=A0 =C2=A0{</div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Account for worst-case crypto over=
head before allocating buffers */</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0frame_add_to_extra_frame(&amp;c-&gt;c2.frame, crypto_max_overhead());</d=
iv></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signat=
ure">-Lev</div></div></div></div></div></div></div></div></div></div>

--000000000000c7c7b4057cad7812--

