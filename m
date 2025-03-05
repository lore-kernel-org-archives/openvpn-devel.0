From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 5 Mar 2025 16:59:21 +0000
In-Reply-To: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <020299e7dcfa6627b70ae6c7114f5e0e17959bfd-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R64mgdF3vvs="; charset=UTF-8
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

--R64mgdF3vvs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/764?usp=3Demail )

Change subject: Add support for simultaneous use of UDP and TCP sockets
......................................................................


Patch Set 19:

(10 comments)

File doc/man-sections/link-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/bb017af8_98251213 :
PS18, Line 122:
> I think we also should mention the default values, something like [=E2=80=
=A6]
Done, see options_postprocess_mutate_le(), now in a case like:

local * 1000 tcp
remote 1.2.3.4 1194 udp

Only the remote proto will be used


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/a19e31fc_278f6bab :
PS18, Line 335:     const unsigned int status =3D m->multi_io->udp_flags;
> I do wonder why a separate `udp_flags` field for UDP has been introduced.=
 [=E2=80=A6]
As said in a comment above, the multi_io has no event_set_status member and=
 since UDP require that I decided to call it udp_flags since it is UDP spec=
ific.


File src/openvpn/multi.h:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/9b01bf4b_df045866 :
PS19, Line 256:  * on the transport protocols:
> The wording is a bit odd... [=E2=80=A6]
Done


File src/openvpn/multi_io.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/8d2cfb2d_b69e0502 :
PS19, Line 145:                    !proto_is_dgram(mi->context.c2.link_sock=
ets[0]->info.proto) ? &mi->tcp_rwflags : NULL);
> I like that this is being moved to a dedicated function :-) - I would sty=
le it differently, though,  [=E2=80=A6]
TCP ev_arg are usually of type 'mi' while UDP are of type 'link_sockets'.


http://gerrit.openvpn.net/c/openvpn/+/764/comment/37cd169e_1703017b :
PS19, Line 491:                         }
> since this is the same `if (mi)` now, it could go outside one level, avoi=
d code duplication... [=E2=80=A6]
Done


File src/openvpn/openvpn.h:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/1ddc2f85_7dceb3e5 :
PS19, Line 219:  * tunnel_point_to_point(), \c tunnel_server() \c
> an `and` is missing before `tunnel_server()`  (since it's only these 2 fu=
nctions now)
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/1e2cfd64_b9b578a8 :
PS18, Line 3351:     if (!le->proto)
> it says `acknowledged` but we still have no comment for `proto`? ;-)
I've also added a check to avoid proto bindings on client side


http://gerrit.openvpn.net/c/openvpn/+/764/comment/8fe0a241_34255d82 :
PS18, Line 3839:
> so what does "Acknowledged" mean, here?  "Will be handled in a future pat=
ch"?
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/bc60012a_289c4f91 :
PS19, Line 1747:             o->local_list->array[i]->port);
> I think this should show `proto` now as well, otherwise the log is a bit =
hard to read if trying to u [=E2=80=A6]
Done


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/80bb9647_fc94b5d2 :
PS18, Line 1914:     ASSERT(c->c2.link_sockets[sock_index]);
> maybe gerrit is playing tricks on me, but the `ASSERT()` seems to be stil=
l here
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363
Gerrit-Change-Number: 764
Gerrit-PatchSet: 19
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Wed, 05 Mar 2025 16:59:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: its_Giaan <gianmarco@...2726...>
Gerrit-MessageType: comment

--R64mgdF3vvs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">View C=
hange</a></p><p>10 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/link-options=
.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/764/comment/bb017af8_98251213">Patch Set #18=
, Line 122:</a> <code style=3D"font-family:monospace,monospace"></code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">I think we also should mention the default values, something li=
ke [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done, see options_postprocess_mutate_le(), now in a case lik=
e:</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">local * 10=
00 tcp<br>remote 1.2.3.4 1194 udp</p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Only the remote proto will be used</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/764/comment/a19e31fc_278f6bab">Patch Set #18, Line 335:</a> <=
code style=3D"font-family:monospace,monospace">    const unsigned int statu=
s =3D m-&gt;multi_io-&gt;udp_flags;</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I do wonder why a=
 separate `udp_flags` field for UDP has been introduced. [=E2=80=A6]</block=
quote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">As sai=
d in a comment above, the multi_io has no event_set_status member and since=
 UDP require that I decided to call it udp_flags since it is UDP specific.<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/=
multi.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/764/comment/9b01bf4b_df045866">Patch Set =
#19, Line 256:</a> <code style=3D"font-family:monospace,monospace"> * on th=
e transport protocols:</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">The wording is a bit odd... [=
=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpn/multi_io.c:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/8d2cfb2d_b=
69e0502">Patch Set #19, Line 145:</a> <code style=3D"font-family:monospace,=
monospace">                   !proto_is_dgram(mi-&gt;context.c2.link_socket=
s[0]-&gt;info.proto) ? &amp;mi-&gt;tcp_rwflags : NULL);</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">I like that this is being moved to a dedicated function :-) - I would st=
yle it differently, though,  [=E2=80=A6]</blockquote></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">TCP ev_arg are usually of type &#3=
9;mi&#39; while UDP are of type &#39;link_sockets&#39;.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/37cd169e_1703017b">=
Patch Set #19, Line 491:</a> <code style=3D"font-family:monospace,monospace=
">                        }</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">since this is the same `i=
f (mi)` now, it could go outside one level, avoid code duplication... [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/openvpn.h:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/1ddc2f85_7dceb=
3e5">Patch Set #19, Line 219:</a> <code style=3D"font-family:monospace,mono=
space"> * tunnel_point_to_point(), \c tunnel_server() \c</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">an `and` is missing before `tunnel_server()`  (since it&#39;s only thes=
e 2 functions now)</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/1e2=
cfd64_b9b578a8">Patch Set #18, Line 3351:</a> <code style=3D"font-family:mo=
nospace,monospace">    if (!le-&gt;proto)</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">it says `ac=
knowledged` but we still have no comment for `proto`? ;-)</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">I&#39;ve also add=
ed a check to avoid proto bindings on client side</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/764/comment/8fe0a241_34255d82">Patch Se=
t #18, Line 3839:</a> <code style=3D"font-family:monospace,monospace"></cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">so what does &quot;Acknowledged&quot; mean, here?  &quot;=
Will be handled in a future patch&quot;?</blockquote></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/764/comment/bc60012a_289c4f91">Patch Set #19, Line 1747:</a> <code=
 style=3D"font-family:monospace,monospace">            o-&gt;local_list-&gt=
;array[i]-&gt;port);</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">I think this should show `proto`=
 now as well, otherwise the log is a bit hard to read if trying to u [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/socket.c:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/80bb9647_fc94b5=
d2">Patch Set #18, Line 1914:</a> <code style=3D"font-family:monospace,mono=
space">    ASSERT(c-&gt;c2.link_sockets[sock_index]);</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>maybe gerrit is playing tricks on me, but the `ASSERT()` seems to be still=
 here</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/764?usp=3Demail">change 764</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/764?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31bbf87e4e568021445c7512ece=
fadfd4a69b363 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 764 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 19 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 05 Mar 2025 16:59:21=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: its_Giaan &lt;gianmarco@...220...=
..2726...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--R64mgdF3vvs=--

