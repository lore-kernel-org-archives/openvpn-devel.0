From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 24 Jan 2025 21:50:41 +0000
In-Reply-To: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <bf0012b2a98623731c5540113a1099b67b180c78-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c5PjzBmBtbI="; charset=UTF-8
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

--c5PjzBmBtbI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/764?usp=3Demail )

Change subject: Add support for simultaneous use of UDP and TCP sockets
......................................................................


Patch Set 17:

(12 comments)

Patchset:

PS17:
more comments


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/e1ebc360_490d6327 :
PS17, Line 3834:
this (and the next) blank line are arguably good, and should be kept, no?


http://gerrit.openvpn.net/c/openvpn/+/764/comment/8b76c90d_17966fbf :
PS17, Line 228:             if (ce->proto !=3D PROTO_TCP && c->mode !=3D CM=
_CHILD_TCP)
what's the reason for this change?  the conditions should be the same?


http://gerrit.openvpn.net/c/openvpn/+/764/comment/9a35e34d_80fa4240 :
PS17, Line 616:         c->options.ce.proto =3D proto;
this does not look right.  So we advance to the next ce, but keep the proto=
?  Wouldn't that break

```
<connection>
  remote ... udp
<connection>
  remote ... tcp
```

setups?


http://gerrit.openvpn.net/c/openvpn/+/764/comment/d8380160_cf33bdd0 :
PS17, Line 2687:         if (!proto_is_udp(c->c2.link_sockets[0]->info.prot=
o) && c->options.ce.explicit_exit_notification)
this like is getting a bit long, so I think wrapping might be a good thing


http://gerrit.openvpn.net/c/openvpn/+/764/comment/e84b95dc_73633f8a :
PS17, Line 2846:             if (has_udp_in_local_list(&c->options))
this might be modelling the existing behaviour, but it's arguable whether t=
he old behaviour was actually correct - a *server* should not do exponentia=
l backoff after a connection failure, no matter whether TCP or UDP.


http://gerrit.openvpn.net/c/openvpn/+/764/comment/ff1ffcf7_a5d0582f :
PS17, Line 3369:     }
given that `link_socket_proto_connection_oriented()` (nowadays) is a very l=
ong form of `if (!proto_is_dgram())` I don't think it makes sense to have t=
he code this way - get rid of the `if()`, loop always.

That said, grepping through the code, `to.tcp_mode` seems to be dead anyway=
 - I see no user of it.  Get rid of it completely, then ;-)


File src/openvpn/mroute.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/e768a558_8ea1565c :
PS17, Line 424:                 buf_printf(&out, ":%d", maddr.proto);
we should not unconditionally add this `:%d`.  It might be useful, but when=
 MR_WITH_PORT is not set, it very much looks like `:6` or `:17` being the r=
emote port.

If we really want this, we should ascii-ize the proto and prepend (`tcp:1.2=
.3.4:1194`), no?


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/cf0b5a07_5892252f :
PS17, Line 1052:             setenv_local_entry(es, o->ce.local_list->array=
[i], i+1);
you have an i+1 here, and another i+1 inside `setenv_local_entry()`... what=
 is it that you want to achieve here?


http://gerrit.openvpn.net/c/openvpn/+/764/comment/2b3f667b_e3b3e51c :
PS17, Line 3192:             o->ce.proto =3D ce->proto;
what is `o->ce.proto`?


http://gerrit.openvpn.net/c/openvpn/+/764/comment/1bf199d4_7737bca5 :
PS17, Line 3198:                 if (ce->local_list->array[i]->proto =3D=3D=
 PROTO_TCP)
So we walk the list here, for the `--server` case, and then walk it again i=
n `option_postprocess_mutate()` for all cases, correct?  So we could just s=
tore the desired proto (TCP_SERVER etc) in `o->ce.proto` here and leave the=
 walking the list to `option_postprocess_mutate()`?


http://gerrit.openvpn.net/c/openvpn/+/764/comment/4ee90666_8e61c48d :
PS17, Line 3838:         msg(M_INFO, "NOTE: --fast-io is disabled while usi=
ng multi-socket");
that comment needs to be something like `--fast-ip is disabled if there is =
a TCP socket active` or so ("using multi-socket" with multiple UDP sockets =
won't be a problem)



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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Fri, 24 Jan 2025 21:50:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--c5PjzBmBtbI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">View C=
hange</a></p><p>12 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/764?tab=3Dcomments">Patch Set #17:</a> </p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">more comments</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
764/comment/e1ebc360_490d6327">Patch Set #17, Line 3834:</a> <code style=3D=
"font-family:monospace,monospace"></code></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">this (and the next) blank line are arguably go=
od, and should be kept, no?</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/764/comment/8b76c90d_17966fbf">Patch Set #17, Line 228:</a> <=
code style=3D"font-family:monospace,monospace">            if (ce-&gt;proto=
 !=3D PROTO_TCP &amp;&amp; c-&gt;mode !=3D CM_CHILD_TCP)</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">what&#39;s the reason fo=
r this change?  the conditions should be the same?</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/764/comment/9a35e34d_80fa4240">Patch S=
et #17, Line 616:</a> <code style=3D"font-family:monospace,monospace">     =
   c-&gt;options.ce.proto =3D proto;</code></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">this does not look right.  So we advance to =
the next ce, but keep the proto?  Wouldn&#39;t that break</p><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">```<br>&lt;connec=
tion&gt;<br>  remote ... udp<br>&lt;connection&gt;<br>  remote ... tcp<br>`=
``</pre><p style=3D"white-space: pre-wrap; word-wrap: break-word;">setups?<=
/p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/d8=
380160_cf33bdd0">Patch Set #17, Line 2687:</a> <code style=3D"font-family:m=
onospace,monospace">        if (!proto_is_udp(c-&gt;c2.link_sockets[0]-&gt;=
info.proto) &amp;&amp; c-&gt;options.ce.explicit_exit_notification)</code><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">this like is =
getting a bit long, so I think wrapping might be a good thing</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/e84b95dc_73633f=
8a">Patch Set #17, Line 2846:</a> <code style=3D"font-family:monospace,mono=
space">            if (has_udp_in_local_list(&amp;c-&gt;options))</code></p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">this might be m=
odelling the existing behaviour, but it&#39;s arguable whether the old beha=
viour was actually correct - a *server* should not do exponential backoff a=
fter a connection failure, no matter whether TCP or UDP.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/ff1ffcf7_a5d0582f">=
Patch Set #17, Line 3369:</a> <code style=3D"font-family:monospace,monospac=
e">    }</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">given that `link_socket_proto_connection_oriented()` (nowadays) is a ver=
y long form of `if (!proto_is_dgram())` I don&#39;t think it makes sense to=
 have the code this way - get rid of the `if()`, loop always.</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">That said, grepping thro=
ugh the code, `to.tcp_mode` seems to be dead anyway - I see no user of it. =
 Get rid of it completely, then ;-)</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/mroute.c:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/=
comment/e768a558_8ea1565c">Patch Set #17, Line 424:</a> <code style=3D"font=
-family:monospace,monospace">                buf_printf(&amp;out, &quot;:%d=
&quot;, maddr.proto);</code></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">we should not unconditionally add this `:%d`.  It might be =
useful, but when MR_WITH_PORT is not set, it very much looks like `:6` or `=
:17` being the remote port.</p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">If we really want this, we should ascii-ize the proto and pr=
epend (`tcp:1.2.3.4:1194`), no?</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/com=
ment/cf0b5a07_5892252f">Patch Set #17, Line 1052:</a> <code style=3D"font-f=
amily:monospace,monospace">            setenv_local_entry(es, o-&gt;ce.loca=
l_list-&gt;array[i], i+1);</code></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">you have an i+1 here, and another i+1 inside `setenv_l=
ocal_entry()`... what is it that you want to achieve here?</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/2b3f667b_e3b3e51c"=
>Patch Set #17, Line 3192:</a> <code style=3D"font-family:monospace,monospa=
ce">            o-&gt;ce.proto =3D ce-&gt;proto;</code></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">what is `o-&gt;ce.proto`?</p></l=
i><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/1bf199d4=
_7737bca5">Patch Set #17, Line 3198:</a> <code style=3D"font-family:monospa=
ce,monospace">                if (ce-&gt;local_list-&gt;array[i]-&gt;proto =
=3D=3D PROTO_TCP)</code></p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">So we walk the list here, for the `--server` case, and then wal=
k it again in `option_postprocess_mutate()` for all cases, correct?  So we =
could just store the desired proto (TCP_SERVER etc) in `o-&gt;ce.proto` her=
e and leave the walking the list to `option_postprocess_mutate()`?</p></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/4ee90666_8=
e61c48d">Patch Set #17, Line 3838:</a> <code style=3D"font-family:monospace=
,monospace">        msg(M_INFO, &quot;NOTE: --fast-io is disabled while usi=
ng multi-socket&quot;);</code></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">that comment needs to be something like `--fast-ip is dis=
abled if there is a TCP socket active` or so (&quot;using multi-socket&quot=
; with multiple UDP sockets won&#39;t be a problem)</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=
=3Demail">change 764</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 24 Jan 2025 21:50:41=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--c5PjzBmBtbI=--

