From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 18 Feb 2025 17:35:06 +0000
In-Reply-To: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <ec62200f6da3753b9422a515f35c79bbab0ea946-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KaJ8P/sU0Lk="; charset=UTF-8
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

--KaJ8P/sU0Lk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/764?usp=3Demail )

Change subject: Add support for simultaneous use of UDP and TCP sockets
......................................................................


Patch Set 19: Code-Review-2

(10 comments)

Patchset:

PS19:
more comments, but these are mostly minor and/or nothing new.  The main thi=
ng that must be fixed remains the gremlin crash...


File src/openvpn/multi.h:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/acd4850a_3fd5d5d9 :
PS19, Line 256:  * on the transport protocols:
The wording is a bit odd... since we do no longer need to point out that th=
is calls "tcp and udp!!" I'd just make this

```
 * Main event loop for OpenVPN in server mode
```

(yes it will call `tunnel_server_loop()` but that's not really relevant her=
e, is it?)


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/002a17a2_4cb6329f :
PS18, Line 609:     bool is_dgram =3D proto_is_dgram(mi->context.c2.link_so=
ckets[0]->info.proto);
> It is, the 'mi' tells you that this is a client-instance context.
Done


File src/openvpn/multi_io.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/4c1453d0_3cacda0f :
PS19, Line 145:                    !proto_is_dgram(mi->context.c2.link_sock=
ets[0]->info.proto) ? &mi->tcp_rwflags : NULL);
I like that this is being moved to a dedicated function :-) - I would style=
 it differently, though, not "one fat function call with two conditionals i=
n it".

Maybe start with `if (!mi) { return; }` (early return, save indent space) a=
nd then have a surrounding `if(proto_is_dgram) { ...}` with one `socket_set=
()` call in each branch?

... also, why are we not storing `ev_arg` in the `&mi` for both cases?


http://gerrit.openvpn.net/c/openvpn/+/764/comment/5d6f18e7_d50503ba :
PS19, Line 491:                         }
since this is the same `if (mi)` now, it could go outside one level, avoid =
code duplication...  and make the comment "protocol invariant" (`/* monitor=
 and/or handle events that are triggered...` without mentioning `TCP`)


File src/openvpn/openvpn.h:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/ce61719a_f2258f18 :
PS19, Line 219:  * tunnel_point_to_point(), \c tunnel_server() \c
an `and` is missing before `tunnel_server()`  (since it's only these 2 func=
tions now)


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/3dbf2e3f_8940878c :
PS18, Line 3351:     if (!le->proto)
> Acknowledged
it says `acknowledged` but we still have no comment for `proto`? ;-)


http://gerrit.openvpn.net/c/openvpn/+/764/comment/ad01e4f2_8599b78a :
PS18, Line 3839:
> Acknowledged
so what does "Acknowledged" mean, here?  "Will be handled in a future patch=
"?


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/873691f9_0977c2fe :
PS19, Line 1747:             o->local_list->array[i]->port);
I think this should show `proto` now as well, otherwise the log is a bit ha=
rd to read if trying to understand why a `bind()` fails.


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/e7e767ef_7f49bef8 :
PS18, Line 1914:     ASSERT(c->c2.link_sockets[sock_index]);
> Done
maybe gerrit is playing tricks on me, but the `ASSERT()` seems to be still =
here



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
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Tue, 18 Feb 2025 17:35:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: its_Giaan <gianmarco@...2726...>
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--KaJ8P/sU0Lk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, ordex, plaisthos. </p>
<p>Patch set 19:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">V=
iew Change</a></p><p>10 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/764?tab=3Dcomments">Patch Set #19:</a> </p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">more comments, but these are mostly minor =
and/or nothing new.  The main thing that must be fixed remains the gremlin =
crash...</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src=
/openvpn/multi.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/acd4850a_3fd5d5d9">=
Patch Set #19, Line 256:</a> <code style=3D"font-family:monospace,monospace=
"> * on the transport protocols:</code></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">The wording is a bit odd... since we do no longe=
r need to point out that this calls &quot;tcp and udp!!&quot; I&#39;d just =
make this</p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">```<br> * Main event loop for OpenVPN in server mode<br>```</pre>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">(yes it will cal=
l `tunnel_server_loop()` but that&#39;s not really relevant here, is it?)</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/m=
ulti.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/764/comment/002a17a2_4cb6329f">Patch Set #=
18, Line 609:</a> <code style=3D"font-family:monospace,monospace">    bool =
is_dgram =3D proto_is_dgram(mi-&gt;context.c2.link_sockets[0]-&gt;info.prot=
o);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">It is, the &#39;mi&#39; tells you that this is a =
client-instance context.</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/multi_io.c:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comm=
ent/4c1453d0_3cacda0f">Patch Set #19, Line 145:</a> <code style=3D"font-fam=
ily:monospace,monospace">                   !proto_is_dgram(mi-&gt;context.=
c2.link_sockets[0]-&gt;info.proto) ? &amp;mi-&gt;tcp_rwflags : NULL);</code=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I like that=
 this is being moved to a dedicated function :-) - I would style it differe=
ntly, though, not &quot;one fat function call with two conditionals in it&q=
uot;.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe s=
tart with `if (!mi) { return; }` (early return, save indent space) and then=
 have a surrounding `if(proto_is_dgram) { ...}` with one `socket_set()` cal=
l in each branch?</p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">... also, why are we not storing `ev_arg` in the `&amp;mi` for both ca=
ses?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comme=
nt/5d6f18e7_d50503ba">Patch Set #19, Line 491:</a> <code style=3D"font-fami=
ly:monospace,monospace">                        }</code></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">since this is the same `if (mi)=
` now, it could go outside one level, avoid code duplication...  and make t=
he comment &quot;protocol invariant&quot; (`/* monitor and/or handle events=
 that are triggered...` without mentioning `TCP`)</p></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File src/openvpn/openvpn.h:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/764/comment/ce61719a_f2258f18">Patch Set #19, Line 219:</a> <c=
ode style=3D"font-family:monospace,monospace"> * tunnel_point_to_point(), \=
c tunnel_server() \c</code></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">an `and` is missing before `tunnel_server()`  (since it&#39;=
s only these 2 functions now)</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comme=
nt/3dbf2e3f_8940878c">Patch Set #18, Line 3351:</a> <code style=3D"font-fam=
ily:monospace,monospace">    if (!le-&gt;proto)</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Ackno=
wledged</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">it says `acknowledged` but we still have no comment for `proto`? ;-=
)</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/=
ad01e4f2_8599b78a">Patch Set #18, Line 3839:</a> <code style=3D"font-family=
:monospace,monospace"></code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">Acknowledged</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">so what does &quo=
t;Acknowledged&quot; mean, here?  &quot;Will be handled in a future patch&q=
uot;?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/op=
envpn/options.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/873691f9_0977c2fe">=
Patch Set #19, Line 1747:</a> <code style=3D"font-family:monospace,monospac=
e">            o-&gt;local_list-&gt;array[i]-&gt;port);</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I think this should show=
 `proto` now as well, otherwise the log is a bit hard to read if trying to =
understand why a `bind()` fails.</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File src/openvpn/socket.c:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/com=
ment/e7e767ef_7f49bef8">Patch Set #18, Line 1914:</a> <code style=3D"font-f=
amily:monospace,monospace">    ASSERT(c-&gt;c2.link_sockets[sock_index]);</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">Done</blockquote></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">maybe gerrit is playing tricks on me, but the `AS=
SERT()` seems to be still here</p></li></ul></li></ul><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">change 764</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/764?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 18 Feb 2025 17:35:06=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: its_Giaan &lt;gianmarco@...220...=
..2726...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--KaJ8P/sU0Lk=--

