From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 14 Feb 2025 17:45:31 +0000
In-Reply-To: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <59f4e29e841451bd764de3f10b435bcb06cbe0b9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rL3YTsmzmGM="; charset=UTF-8
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

--rL3YTsmzmGM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/764?usp=3Demail )

Change subject: Add support for simultaneous use of UDP and TCP sockets
......................................................................


Patch Set 18:

(15 comments)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/50e5e827_606d6e4d :
PS18, Line 2077:     if (flags & IOW_WAIT_SIGNAL)
> this is duplicating a huge chunk of code from `io_wait_dowork()` - which =
is hard enough to read, wit [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/764/comment/d0b6ff1d_733c10fb :
PS18, Line 2184:     if (c->c2.fast_io && (flags & (IOW_TO_TUN | IOW_TO_LIN=
K | IOW_MBUF)))
> this function is mostly identical to `forward. [=E2=80=A6]
The multi_io has no event_set_status member and since UDP require that I de=
cided to call it udp_flags since it is UDP specific.


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/f536d12b_7a5c51e7 :
PS17, Line 2846:             if (has_udp_in_local_list(&c->options))
> Well, this is introducing new code, to model behaviour that was not inten=
tional in the first place. [=E2=80=A6]
Done


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/29430a8c_d3861afa :
PS18, Line 2685:         if (!proto_is_udp(c->c2.link_sockets[0]->info.prot=
o)
> maybe add a de-confusing comment like `/* client side =3D only one link_s=
ocket */` or so... [=E2=80=A6]
Done


File src/openvpn/multi.h:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/cad1ca81_6565d700 :
PS18, Line 670:
> how can this ever be called without valid `mi`?  Shouldn't this be flagge=
d as a hard error, like kee [=E2=80=A6]
Done


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/6aa7274d_985a29c2 :
PS18, Line 609:     bool is_dgram =3D proto_is_dgram(mi->context.c2.link_so=
ckets[0]->info.proto);
> Is this for a (single-socket) client instance?  Again we have a confused =
reader wondering why we onl [=E2=80=A6]
It is, the 'mi' tells you that this is a client-instance context.


http://gerrit.openvpn.net/c/openvpn/+/764/comment/61d7a697_54c1c90d :
PS18, Line 3841:         if (!mi->halt && proto_is_dgram(mi->context.option=
s.ce.proto))
> why is this using `mi->context.options.ce. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/764/comment/02b15a25_8acde395 :
PS18, Line 3879:     else if (has_udp_in_local_list(&m->top.options))
> why are you splitting this condition into two nested `if()`?  I can see c=
hanging `proto_is_dgram()`  [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/764/comment/0f048603_319d08a4 :
PS18, Line 4164:  * Main event loop for OpenVPN in multi-protocol server mo=
de.
> I'd remove the "multi-protocol" part (protocols, again) - maybe name this=
 `point-to-multipoint serve [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/764/comment/20464f08_18d9e039 :
PS18, Line 4169: void
> static?
Done


http://gerrit.openvpn.net/c/openvpn/+/764/comment/d0311291_8207b195 :
PS18, Line 4265: }
> I don't like this construct - now `tunnel_server_init()` is doing all the=
 work (init, call loop, uni [=E2=80=A6]
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/cef8e785_9aa6185f :
PS18, Line 3351:     if (!le->proto)
> we have a comment for setting "port" and none for "proto". [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/764/comment/c5c0f206_666146e4 :
PS18, Line 3816:         }
> this extra loop looks like it really wants to be part of `options_postpro=
cess_mutate_le()`, no?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/764/comment/611fa1ff_cab4dcb3 :
PS18, Line 3839:
> I'm actually not sure I understand `fast_io` well enough for this, but - =
what I understand, `fast_io [=E2=80=A6]
Acknowledged


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/68eeaf4b_34101cc0 :
PS18, Line 1914:     ASSERT(c->c2.link_sockets[sock_index]);
> we already have an `ASSERT(sock)` at the beginning, which is `sock =3D c-=
>c2. [=E2=80=A6]
Done



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
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Fri, 14 Feb 2025 17:45:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--rL3YTsmzmGM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">View C=
hange</a></p><p>15 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/764/comment/50e5e827_606d6e4d">Patch Set #18, Line 2077:=
</a> <code style=3D"font-family:monospace,monospace">    if (flags &amp; IO=
W_WAIT_SIGNAL)</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">this is duplicating a huge chunk of co=
de from `io_wait_dowork()` - which is hard enough to read, wit [=E2=80=A6]<=
/blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comme=
nt/d0b6ff1d_733c10fb">Patch Set #18, Line 2184:</a> <code style=3D"font-fam=
ily:monospace,monospace">    if (c-&gt;c2.fast_io &amp;&amp; (flags &amp; (=
IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">this function =
is mostly identical to `forward. [=E2=80=A6]</blockquote></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">The multi_io has no event_set_=
status member and since UDP require that I decided to call it udp_flags sin=
ce it is UDP specific.</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File src/openvpn/init.c:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/f536d12=
b_7a5c51e7">Patch Set #17, Line 2846:</a> <code style=3D"font-family:monosp=
ace,monospace">            if (has_udp_in_local_list(&amp;c-&gt;options))</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">Well, this is introducing new code, to model behaviour=
 that was not intentional in the first place. [=E2=80=A6]</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/764/comment/29430a8c_d3861afa">Patch Set #18, Line 268=
5:</a> <code style=3D"font-family:monospace,monospace">        if (!proto_i=
s_udp(c-&gt;c2.link_sockets[0]-&gt;info.proto)</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">maybe =
add a de-confusing comment like `/* client side =3D only one link_socket */=
` or so... [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/multi.h:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/c=
ad1ca81_6565d700">Patch Set #18, Line 670:</a> <code style=3D"font-family:m=
onospace,monospace"></code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">how can this ever be called with=
out valid `mi`?  Shouldn&#39;t this be flagged as a hard error, like kee [=
=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpn/multi.c:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/6aa7274d_985a=
29c2">Patch Set #18, Line 609:</a> <code style=3D"font-family:monospace,mon=
ospace">    bool is_dgram =3D proto_is_dgram(mi-&gt;context.c2.link_sockets=
[0]-&gt;info.proto);</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">Is this for a (single-socket) cl=
ient instance?  Again we have a confused reader wondering why we onl [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">It is, the &#39;mi&#39; tells you that this is a client-instance co=
ntext.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/com=
ment/61d7a697_54c1c90d">Patch Set #18, Line 3841:</a> <code style=3D"font-f=
amily:monospace,monospace">        if (!mi-&gt;halt &amp;&amp; proto_is_dgr=
am(mi-&gt;context.options.ce.proto))</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">why is this usin=
g `mi-&gt;context.options.ce. [=E2=80=A6]</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/764/comment/02b15a25_8acde395">Patch Set #=
18, Line 3879:</a> <code style=3D"font-family:monospace,monospace">    else=
 if (has_udp_in_local_list(&amp;m-&gt;top.options))</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">w=
hy are you splitting this condition into two nested `if()`?  I can see chan=
ging `proto_is_dgram()`  [=E2=80=A6]</blockquote></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/764/comment/0f048603_319d08a4">Patch Set #18, L=
ine 4164:</a> <code style=3D"font-family:monospace,monospace"> * Main event=
 loop for OpenVPN in multi-protocol server mode.</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I&#3=
9;d remove the &quot;multi-protocol&quot; part (protocols, again) - maybe n=
ame this `point-to-multipoint serve [=E2=80=A6]</blockquote></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/764/comment/20464f08_18d9e039">Patch=
 Set #18, Line 4169:</a> <code style=3D"font-family:monospace,monospace">vo=
id</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">static?</blockquote></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/764/comment/d0311291_8207b195">Patch Set #18, Line =
4265:</a> <code style=3D"font-family:monospace,monospace">}</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">I don&#39;t like this construct - now `tunnel_server_init()` is doin=
g all the work (init, call loop, uni [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/764/comment/cef8e785_9aa6185f">Patch Set #18, Line 3351:</=
a> <code style=3D"font-family:monospace,monospace">    if (!le-&gt;proto)</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">we have a comment for setting &quot;port&quot; and non=
e for &quot;proto&quot;. [=E2=80=A6]</blockquote></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/764/comment/c5c0f206_666146e4">Patch Se=
t #18, Line 3816:</a> <code style=3D"font-family:monospace,monospace">     =
   }</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">this extra loop looks like it really wants to be=
 part of `options_postprocess_mutate_le()`, no?</blockquote></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/611fa1ff_cab4dcb=
3">Patch Set #18, Line 3839:</a> <code style=3D"font-family:monospace,monos=
pace"></code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">I&#39;m actually not sure I understand `fast_i=
o` well enough for this, but - what I understand, `fast_io [=E2=80=A6]</blo=
ckquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ackn=
owledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src=
/openvpn/socket.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/68eeaf4b_34101cc0">=
Patch Set #18, Line 1914:</a> <code style=3D"font-family:monospace,monospac=
e">    ASSERT(c-&gt;c2.link_sockets[sock_index]);</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">we =
already have an `ASSERT(sock)` at the beginning, which is `sock =3D c-&gt;c=
2. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">change 764</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/764?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Feb 2025 17:45:31=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--rL3YTsmzmGM=--

