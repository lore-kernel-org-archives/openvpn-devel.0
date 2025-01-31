From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 31 Jan 2025 13:32:25 +0000
In-Reply-To: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <fd3035ab4855a78752beb862edce266cf7304ef1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="na21HB5eLHU="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--na21HB5eLHU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/764?usp=3Demail )

Change subject: Add support for simultaneous use of UDP and TCP sockets
......................................................................


Patch Set 18: Code-Review-1

(23 comments)

Patchset:

PS18:
some minor bits, and something I consider major - massive code duplication =
that is not helping to make the code flow easier to understand


File doc/man-sections/link-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/37a21a77_b85f0053 :
PS18, Line 122:
I think we also should mention the default values, something like

```
If ``port`` is omitted, it defaults to the setting of ``--lport``.
If ``proto`` is omitted, it defaults to the setting of ``--proto``.
```

... which brings up an interesting corner case, what if a config has

```
local * 1000 tcp
remote 1.2.3.4 1194 udp
```
?  Shall we just disallow `proto` bindings on the client-side?


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/6695b917_b3e1ecda :
PS18, Line 2077:     if (flags & IOW_WAIT_SIGNAL)
this is duplicating a huge chunk of code from `io_wait_dowork()` - which is=
 hard enough to read, without appearing twice.

Can you remove the common parts from `io_wait_dowork()` and have it call he=
re?


http://gerrit.openvpn.net/c/openvpn/+/764/comment/f3a3f9ad_e4a8f66f :
PS18, Line 2184:     if (c->c2.fast_io && (flags & (IOW_TO_TUN | IOW_TO_LIN=
K | IOW_MBUF)))
this function is mostly identical to `forward.h::io_wait()`, except for the=
 call to `get_io_flags_dowork_udp()` in the end, vs. `io_wait_dowork()`, an=
d setting `multi_io->udp_flags` vs. `c->c2.event_set_status`.

There has to be a better way to tackle this than to walk all sockets twice,=
 in two nearly identical functions.  Why's there a separate `udp_flags` and=
 `event_set_status` anyway?


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/bf3f0236_95dbba2c :
PS17, Line 2846:             if (has_udp_in_local_list(&c->options))
> maybe something to create a ticket about and we fix it separately from th=
is patchset? [=E2=80=A6]
Well, this is introducing new code, to model behaviour that was not intenti=
onal in the first place.  So I'd go for simple code - on a server, no matte=
r of UDP or TCP, delay 1 second, on a client, do exponential backoff.

Also, arguably, the code proposed isn't doing the right thing anyway - it's=
 doing "if there is *one* UDP socket, among many, do backoff (on UDP and TC=
P sockets), and if there are *only* TCP sockets, not".


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/286fdebf_e60bf789 :
PS18, Line 2685:         if (!proto_is_udp(c->c2.link_sockets[0]->info.prot=
o)
maybe add a de-confusing comment like `/* client side =3D only one link_soc=
ket */` or so... I was wondering, again, why there is no loop here...


File src/openvpn/mtcp.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/ed3a23f0_5a81d266 :
PS17, Line 57:     if (mi && !proto_is_dgram(ls->info.proto))
> that's a leftover from early development when still trying to untangle ud=
p and tcp clients.
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/764/comment/7810367d_c39b0d92 :
PS17, Line 156:         if (proto_is_dgram(mi->context.c2.link_sockets[0]->=
info.proto))
> see answer above
Acknowledged


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/e0aa2662_4a802ef8 :
PS18, Line 335:     const unsigned int status =3D m->multi_io->udp_flags;
I do wonder why a separate `udp_flags` field for UDP has been introduced.  =
Isn't this basically mimicking everything we do in `event_set_status` for T=
CP?  Where is the practical difference (except we have two mostly-identical=
 functions that set udp_flags or event_set_status)?


File src/openvpn/multi.h:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/b5407429_3ff1a65d :
PS18, Line 670:
how can this ever be called without valid `mi`?  Shouldn't this be flagged =
as a hard error, like keeping the `ASSERT(mi)`?


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/c2b835ed_a70ba824 :
PS18, Line 609:     bool is_dgram =3D proto_is_dgram(mi->context.c2.link_so=
ckets[0]->info.proto);
Is this for a (single-socket) client instance?  Again we have a confused re=
ader wondering why we only look at `link_sockets[0]`... ;-)


http://gerrit.openvpn.net/c/openvpn/+/764/comment/35e37e61_90cb74af :
PS18, Line 3841:         if (!mi->halt && proto_is_dgram(mi->context.option=
s.ce.proto))
why is this using `mi->context.options.ce.proto`?  The rest of the code see=
ms to have moved all the checks toward something `ls->proto` - is this not =
available here?


http://gerrit.openvpn.net/c/openvpn/+/764/comment/9539d5ff_a442fabf :
PS18, Line 3879:     else if (has_udp_in_local_list(&m->top.options))
why are you splitting this condition into two nested `if()`?  I can see cha=
nging `proto_is_dgram()` to `has_udp_...()` but it could just be part of th=
e same `if (...&...&...)` block.  no?


http://gerrit.openvpn.net/c/openvpn/+/764/comment/82416e50_ccc42bb0 :
PS18, Line 4164:  * Main event loop for OpenVPN in multi-protocol server mo=
de.
I'd remove the "multi-protocol" part (protocols, again) - maybe name this `=
point-to-multipoint server mode` instead, so it's clear "this is the --serv=
er functionality".


http://gerrit.openvpn.net/c/openvpn/+/764/comment/0808d8b9_ee6cdc19 :
PS18, Line 4169: void
static?


http://gerrit.openvpn.net/c/openvpn/+/764/comment/9c492ef1_466fc2d6 :
PS18, Line 4265: }
I don't like this construct - now `tunnel_server_init()` is doing all the w=
ork (init, call loop, uninit).

I suggest to remove `tunnel_server_init()` and have all its functionality i=
n `tunnel_server()`.

Having the inner loop in `tunnel_server_loop()` is fine for me.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/3fed854f_635a4c70 :
PS10, Line 1000:     for (int j =3D 0; j < e->local_list->len; j++)
> made another function to do this specifically for every local_entry, let =
me know if this is legal.
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/764/comment/bed3e7ba_f462f4f9 :
PS10, Line 3833:     if (!has_udp_in_local_list(o))
> made another function has_tcp_in_local_list(), might be useful in some ca=
ses, also I moved this chec [=E2=80=A6]
Acknowledged


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/b093c46d_db331cc3 :
PS17, Line 1052:             setenv_local_entry(es, o->ce.local_list->array=
[i], i+1);
> i'm not sure either
so only one "i+1" left - that means local_list entries are numbered 0...(n-=
1) and the env variables are numbered 1...n - which makes sense.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/231e4ca1_8cdb4f3f :
PS18, Line 3351:     if (!le->proto)
we have a comment for setting "port" and none for "proto".  Do we want one?


http://gerrit.openvpn.net/c/openvpn/+/764/comment/ffe64598_39b97862 :
PS18, Line 3816:         }
this extra loop looks like it really wants to be part of `options_postproce=
ss_mutate_le()`, no?


http://gerrit.openvpn.net/c/openvpn/+/764/comment/da8501e5_f0ca4bac :
PS18, Line 3839:
I'm actually not sure I understand `fast_io` well enough for this, but - wh=
at I understand, `fast_io` is only working on UDP sockets (and not if `--sh=
aper` is active) - but why can't we not have `fast_io` on "all the UDP sock=
ets" just because there is one extra TCP socket?


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/2d46cfa3_40e4c922 :
PS18, Line 1914:     ASSERT(c->c2.link_sockets[sock_index]);
we already have an `ASSERT(sock)` at the beginning, which is `sock =3D c->c=
2.link_sockets[sock_index];` - so I think this can go?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363
Gerrit-Change-Number: 764
Gerrit-PatchSet: 18
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Fri, 31 Jan 2025 13:32:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: its_Giaan <gianmarco@...2726...>
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--na21HB5eLHU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, ordex, plaisthos. </p>
<p>Patch set 18:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">V=
iew Change</a></p><p>23 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/764?tab=3Dcomments">Patch Set #18:</a> </p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">some minor bits, and something I consider =
major - massive code duplication that is not helping to make the code flow =
easier to understand</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File doc/man-sections/link-options.rst:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/co=
mment/37a21a77_b85f0053">Patch Set #18, Line 122:</a> <code style=3D"font-f=
amily:monospace,monospace"></code></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">I think we also should mention the default values, so=
mething like</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
```<br>If ``port`` is omitted, it defaults to the setting of ``--lport``.<b=
r>If ``proto`` is omitted, it defaults to the setting of ``--proto``.<br>``=
`</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">... which b=
rings up an interesting corner case, what if a config has</p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">```<br>local * 1000 tcp<br>rem=
ote 1.2.3.4 1194 udp<br>```<br>?  Shall we just disallow `proto` bindings o=
n the client-side?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File src/openvpn/forward.c:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/6695b917=
_b3e1ecda">Patch Set #18, Line 2077:</a> <code style=3D"font-family:monospa=
ce,monospace">    if (flags &amp; IOW_WAIT_SIGNAL)</code></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">this is duplicating a huge chu=
nk of code from `io_wait_dowork()` - which is hard enough to read, without =
appearing twice.</p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Can you remove the common parts from `io_wait_dowork()` and have it cal=
l here?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/co=
mment/f3a3f9ad_e4a8f66f">Patch Set #18, Line 2184:</a> <code style=3D"font-=
family:monospace,monospace">    if (c-&gt;c2.fast_io &amp;&amp; (flags &amp=
; (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))</code></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">this function is mostly identical to `f=
orward.h::io_wait()`, except for the call to `get_io_flags_dowork_udp()` in=
 the end, vs. `io_wait_dowork()`, and setting `multi_io-&gt;udp_flags` vs. =
`c-&gt;c2.event_set_status`.</p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">There has to be a better way to tackle this than to walk al=
l sockets twice, in two nearly identical functions.  Why&#39;s there a sepa=
rate `udp_flags` and `event_set_status` anyway?</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/764/comment/bf3f0236_95dbba2c">Patch Set #17, Line 2846:</a> <code st=
yle=3D"font-family:monospace,monospace">            if (has_udp_in_local_li=
st(&amp;c-&gt;options))</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">maybe something to create a t=
icket about and we fix it separately from this patchset? [=E2=80=A6]</block=
quote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Well, =
this is introducing new code, to model behaviour that was not intentional i=
n the first place.  So I&#39;d go for simple code - on a server, no matter =
of UDP or TCP, delay 1 second, on a client, do exponential backoff.</p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Also, arguably, the =
code proposed isn&#39;t doing the right thing anyway - it&#39;s doing &quot=
;if there is *one* UDP socket, among many, do backoff (on UDP and TCP socke=
ts), and if there are *only* TCP sockets, not&quot;.</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/764/comment/286fdebf_e60bf789">Patch Set #18, Line 2685:</a> <=
code style=3D"font-family:monospace,monospace">        if (!proto_is_udp(c-=
&gt;c2.link_sockets[0]-&gt;info.proto)</code></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">maybe add a de-confusing comment like `/* =
client side =3D only one link_socket */` or so... I was wondering, again, w=
hy there is no loop here...</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/mtcp.c:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/ed=
3a23f0_5a81d266">Patch Set #17, Line 57:</a> <code style=3D"font-family:mon=
ospace,monospace">    if (mi &amp;&amp; !proto_is_dgram(ls-&gt;info.proto))=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">that&#39;s a leftover from early development when st=
ill trying to untangle udp and tcp clients.</blockquote></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/7810367d_c39b0d92">=
Patch Set #17, Line 156:</a> <code style=3D"font-family:monospace,monospace=
">        if (proto_is_dgram(mi-&gt;context.c2.link_sockets[0]-&gt;info.pro=
to))</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">see answer above</blockquote></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/764/comment/e0aa2662_4a802ef8">Patch Set #18, Line 335:</a> =
<code style=3D"font-family:monospace,monospace">    const unsigned int stat=
us =3D m-&gt;multi_io-&gt;udp_flags;</code></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">I do wonder why a separate `udp_flags` field=
 for UDP has been introduced.  Isn&#39;t this basically mimicking everythin=
g we do in `event_set_status` for TCP?  Where is the practical difference (=
except we have two mostly-identical functions that set udp_flags or event_s=
et_status)?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
src/openvpn/multi.h:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/b5407429_3ff1a65d=
">Patch Set #18, Line 670:</a> <code style=3D"font-family:monospace,monospa=
ce"></code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">h=
ow can this ever be called without valid `mi`?  Shouldn&#39;t this be flagg=
ed as a hard error, like keeping the `ASSERT(mi)`?</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/764/comment/c2b835ed_a70ba824">Patch Set #18, Line 609:</a> <code=
 style=3D"font-family:monospace,monospace">    bool is_dgram =3D proto_is_d=
gram(mi-&gt;context.c2.link_sockets[0]-&gt;info.proto);</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Is this for a (single-so=
cket) client instance?  Again we have a confused reader wondering why we on=
ly look at `link_sockets[0]`... ;-)</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/764/comment/35e37e61_90cb74af">Patch Set #18, Line 38=
41:</a> <code style=3D"font-family:monospace,monospace">        if (!mi-&gt=
;halt &amp;&amp; proto_is_dgram(mi-&gt;context.options.ce.proto))</code></p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">why is this usi=
ng `mi-&gt;context.options.ce.proto`?  The rest of the code seems to have m=
oved all the checks toward something `ls-&gt;proto` - is this not available=
 here?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/com=
ment/9539d5ff_a442fabf">Patch Set #18, Line 3879:</a> <code style=3D"font-f=
amily:monospace,monospace">    else if (has_udp_in_local_list(&amp;m-&gt;to=
p.options))</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">why are you splitting this condition into two nested `if()`?  I can s=
ee changing `proto_is_dgram()` to `has_udp_...()` but it could just be part=
 of the same `if (...&amp;...&amp;...)` block.  no?</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/764/comment/82416e50_ccc42bb0">Patch =
Set #18, Line 4164:</a> <code style=3D"font-family:monospace,monospace"> * =
Main event loop for OpenVPN in multi-protocol server mode.</code></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">I&#39;d remove the &qu=
ot;multi-protocol&quot; part (protocols, again) - maybe name this `point-to=
-multipoint server mode` instead, so it&#39;s clear &quot;this is the --ser=
ver functionality&quot;.</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/764/comment/0808d8b9_ee6cdc19">Patch Set #18, Line 4169:</a> <co=
de style=3D"font-family:monospace,monospace">void</code></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">static?</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/764/comment/9c492ef1_466fc2d6">Patch =
Set #18, Line 4265:</a> <code style=3D"font-family:monospace,monospace">}</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I don&#=
39;t like this construct - now `tunnel_server_init()` is doing all the work=
 (init, call loop, uninit).</p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">I suggest to remove `tunnel_server_init()` and have all its =
functionality in `tunnel_server()`.</p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Having the inner loop in `tunnel_server_loop()` is f=
ine for me.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
src/openvpn/options.c:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/3fed854f_635a4c=
70">Patch Set #10, Line 1000:</a> <code style=3D"font-family:monospace,mono=
space">    for (int j =3D 0; j &lt; e-&gt;local_list-&gt;len; j++)</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">made another function to do this specifically for every local=
_entry, let me know if this is legal.</blockquote></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/764/comment/bed3e7ba_f462f4f9">Patch S=
et #10, Line 3833:</a> <code style=3D"font-family:monospace,monospace">    =
if (!has_udp_in_local_list(o))</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">made another function =
has_tcp_in_local_list(), might be useful in some cases, also I moved this c=
hec [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/commen=
t/b093c46d_db331cc3">Patch Set #17, Line 1052:</a> <code style=3D"font-fami=
ly:monospace,monospace">            setenv_local_entry(es, o-&gt;ce.local_l=
ist-&gt;array[i], i+1);</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">i&#39;m not sure either</bloc=
kquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">so on=
ly one &quot;i+1&quot; left - that means local_list entries are numbered 0.=
..(n-1) and the env variables are numbered 1...n - which makes sense.</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/optio=
ns.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/764/comment/231e4ca1_8cdb4f3f">Patch Set #18=
, Line 3351:</a> <code style=3D"font-family:monospace,monospace">    if (!l=
e-&gt;proto)</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">we have a comment for setting &quot;port&quot; and none for &quot;pr=
oto&quot;.  Do we want one?</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/764/comment/ffe64598_39b97862">Patch Set #18, Line 3816:</a> =
<code style=3D"font-family:monospace,monospace">        }</code></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">this extra loop looks l=
ike it really wants to be part of `options_postprocess_mutate_le()`, no?</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/da85=
01e5_f0ca4bac">Patch Set #18, Line 3839:</a> <code style=3D"font-family:mon=
ospace,monospace"></code></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">I&#39;m actually not sure I understand `fast_io` well enough f=
or this, but - what I understand, `fast_io` is only working on UDP sockets =
(and not if `--shaper` is active) - but why can&#39;t we not have `fast_io`=
 on &quot;all the UDP sockets&quot; just because there is one extra TCP soc=
ket?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/ope=
nvpn/socket.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/2d46cfa3_40e4c922">Pa=
tch Set #18, Line 1914:</a> <code style=3D"font-family:monospace,monospace"=
>    ASSERT(c-&gt;c2.link_sockets[sock_index]);</code></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">we already have an `ASSERT(sock)`=
 at the beginning, which is `sock =3D c-&gt;c2.link_sockets[sock_index];` -=
 so I think this can go?</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">change 764</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/764?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31bbf87e4e568021445c7512ece=
fadfd4a69b363 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 764 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 18 </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 31 Jan 2025 13:32:25=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: its_Giaan &lt;gianmarco@...220...=
..2726...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--na21HB5eLHU=--

