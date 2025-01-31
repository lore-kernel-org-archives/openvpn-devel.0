From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 31 Jan 2025 10:42:34 +0000
In-Reply-To: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <f0e1cb8531edcfd793140e23f7606f25190a7ef0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BWMQsC4RyYc="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for
 simultaneous use of UDP and TCP sockets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BWMQsC4RyYc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/764?usp=3Demail )

Change subject: Add support for simultaneous use of UDP and TCP sockets
......................................................................


Patch Set 17:

(13 comments)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/d2d2bf21_d4657dec :
PS17, Line 2471:
> spurious new line
Done


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/557e83eb_4b361d4d :
PS17, Line 3834:
> this (and the next) blank line are arguably good, and should be kept, no?
Done


http://gerrit.openvpn.net/c/openvpn/+/764/comment/e3883fac_7a141a70 :
PS17, Line 228:             if (ce->proto !=3D PROTO_TCP && c->mode !=3D CM=
_CHILD_TCP)
> what's the reason for this change?  the conditions should be the same?
Done


http://gerrit.openvpn.net/c/openvpn/+/764/comment/098aad10_d6ea2c6c :
PS17, Line 616:         c->options.ce.proto =3D proto;
> this does not look right.  So we advance to the next ce, but keep the pro=
to?  Wouldn't that break [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/764/comment/d2412021_82123c38 :
PS17, Line 2687:         if (!proto_is_udp(c->c2.link_sockets[0]->info.prot=
o) && c->options.ce.explicit_exit_notification)
> this like is getting a bit long, so I think wrapping might be a good thing
Done


http://gerrit.openvpn.net/c/openvpn/+/764/comment/d9a8ec74_c1f662c7 :
PS17, Line 3369:     }
> given that `link_socket_proto_connection_oriented()` (nowadays) is a very=
 long form of `if (!proto_i [=E2=80=A6]
Done


File src/openvpn/mroute.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/8b5bd492_5d35e8a3 :
PS17, Line 424:                 buf_printf(&out, ":%d", maddr.proto);
> we should not unconditionally add this `:%d`. [=E2=80=A6]
Done


File src/openvpn/mtcp.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/e4035612_308aec8e :
PS17, Line 57:     if (mi && !proto_is_dgram(ls->info.proto))
> why would this be called for an UDP packet in the first place, that is, w=
hy is that check necessary?
that's a leftover from early development when still trying to untangle udp =
and tcp clients.


http://gerrit.openvpn.net/c/openvpn/+/764/comment/74a66627_6f73d597 :
PS17, Line 156:         if (proto_is_dgram(mi->context.c2.link_sockets[0]->=
info.proto))
> same here: why is this check necessary?  Who calls a `_tcp_` function for=
 UDP packets, and why?
see answer above


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/f9770527_5f1c061a :
PS17, Line 1052:             setenv_local_entry(es, o->ce.local_list->array=
[i], i+1);
> you have an i+1 here, and another i+1 inside `setenv_local_entry()`... [=
=E2=80=A6]
i'm not sure either


http://gerrit.openvpn.net/c/openvpn/+/764/comment/bb8e11ad_17fcd75d :
PS17, Line 3192:             o->ce.proto =3D ce->proto;
> what is `o->ce. [=E2=80=A6]
o->ce differs from let's say o->connection_list->array[0] but this is not a=
 big deal on server side while it can be dangerous on client side so a copy=
 won't hurt.


http://gerrit.openvpn.net/c/openvpn/+/764/comment/efef2d42_e743e796 :
PS17, Line 3198:                 if (ce->local_list->array[i]->proto =3D=3D=
 PROTO_TCP)
> So we walk the list here, for the `--server` case, and then walk it again=
 in `option_postprocess_mut [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/764/comment/809120a8_8e4a8ed5 :
PS17, Line 3838:         msg(M_INFO, "NOTE: --fast-io is disabled while usi=
ng multi-socket");
> that comment needs to be something like `--fast-ip is disabled if there i=
s a TCP socket active` or s [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363
Gerrit-Change-Number: 764
Gerrit-PatchSet: 17
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Fri, 31 Jan 2025 10:42:34 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--BWMQsC4RyYc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">View C=
hange</a></p><p>13 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/764/comment/d2d2bf21_d4657dec">Patch Set #17, Line 2471:=
</a> <code style=3D"font-family:monospace,monospace"></code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>spurious new line</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/init.c:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/557e83=
eb_4b361d4d">Patch Set #17, Line 3834:</a> <code style=3D"font-family:monos=
pace,monospace"></code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">this (and the next) blank line are a=
rguably good, and should be kept, no?</blockquote></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/764/comment/e3883fac_7a141a70">Patch Set #17, =
Line 228:</a> <code style=3D"font-family:monospace,monospace">            i=
f (ce-&gt;proto !=3D PROTO_TCP &amp;&amp; c-&gt;mode !=3D CM_CHILD_TCP)</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">what&#39;s the reason for this change?  the conditions s=
hould be the same?</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/764/comment/098aad10_d6ea2c6c">Patch Set #17, Line 616:</a> <code=
 style=3D"font-family:monospace,monospace">        c-&gt;options.ce.proto =
=3D proto;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">this does not look right.  So we advance t=
o the next ce, but keep the proto?  Wouldn&#39;t that break [=E2=80=A6]</bl=
ockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/=
d2412021_82123c38">Patch Set #17, Line 2687:</a> <code style=3D"font-family=
:monospace,monospace">        if (!proto_is_udp(c-&gt;c2.link_sockets[0]-&g=
t;info.proto) &amp;&amp; c-&gt;options.ce.explicit_exit_notification)</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">this like is getting a bit long, so I think wrapping might=
 be a good thing</blockquote></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/764/comment/d9a8ec74_c1f662c7">Patch Set #17, Line 3369:</a> <code =
style=3D"font-family:monospace,monospace">    }</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">given=
 that `link_socket_proto_connection_oriented()` (nowadays) is a very long f=
orm of `if (!proto_i [=E2=80=A6]</blockquote></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/mroute.c:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
64/comment/8b5bd492_5d35e8a3">Patch Set #17, Line 424:</a> <code style=3D"f=
ont-family:monospace,monospace">                buf_printf(&amp;out, &quot;=
:%d&quot;, maddr.proto);</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">we should not unconditionall=
y add this `:%d`. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/mtcp.c:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/com=
ment/e4035612_308aec8e">Patch Set #17, Line 57:</a> <code style=3D"font-fam=
ily:monospace,monospace">    if (mi &amp;&amp; !proto_is_dgram(ls-&gt;info.=
proto))</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">why would this be called for an UDP packet in=
 the first place, that is, why is that check necessary?</blockquote></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">that&#39;s a leftov=
er from early development when still trying to untangle udp and tcp clients=
.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/=
74a66627_6f73d597">Patch Set #17, Line 156:</a> <code style=3D"font-family:=
monospace,monospace">        if (proto_is_dgram(mi-&gt;context.c2.link_sock=
ets[0]-&gt;info.proto))</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">same here: why is this check =
necessary?  Who calls a `_tcp_` function for UDP packets, and why?</blockqu=
ote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">see answ=
er above</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src=
/openvpn/options.c:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/f9770527_5f1c061a"=
>Patch Set #17, Line 1052:</a> <code style=3D"font-family:monospace,monospa=
ce">            setenv_local_entry(es, o-&gt;ce.local_list-&gt;array[i], i+=
1);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">you have an i+1 here, and another i+1 inside `set=
env_local_entry()`... [=E2=80=A6]</blockquote></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">i&#39;m not sure either</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/bb8e11ad_17fcd75d">=
Patch Set #17, Line 3192:</a> <code style=3D"font-family:monospace,monospac=
e">            o-&gt;ce.proto =3D ce-&gt;proto;</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">what =
is `o-&gt;ce. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">o-&gt;ce differs from let&#39;s say o-&gt;connect=
ion_list-&gt;array[0] but this is not a big deal on server side while it ca=
n be dangerous on client side so a copy won&#39;t hurt.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/efef2d42_e743e796">=
Patch Set #17, Line 3198:</a> <code style=3D"font-family:monospace,monospac=
e">                if (ce-&gt;local_list-&gt;array[i]-&gt;proto =3D=3D PROT=
O_TCP)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">So we walk the list here, for the `--server` c=
ase, and then walk it again in `option_postprocess_mut [=E2=80=A6]</blockqu=
ote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/80912=
0a8_8e4a8ed5">Patch Set #17, Line 3838:</a> <code style=3D"font-family:mono=
space,monospace">        msg(M_INFO, &quot;NOTE: --fast-io is disabled whil=
e using multi-socket&quot;);</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">that comment needs to be=
 something like `--fast-ip is disabled if there is a TCP socket active` or =
s [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">change 764</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/764?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31bbf87e4e568021445c7512ece=
fadfd4a69b363 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 764 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 31 Jan 2025 10:42:34=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--BWMQsC4RyYc=--

