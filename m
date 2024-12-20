From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 20 Dec 2024 21:56:39 +0000
In-Reply-To: <gerrit.1734714757000.I806757a8c6f9a589665624f176391b5f7b87f581@...2715...>
References: <gerrit.1734714757000.I806757a8c6f9a589665624f176391b5f7b87f581@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <26ae51594b7447d382477fac1ca2de0f0eec31c8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fMyRQfDlbtg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix float support in
 P2P topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fMyRQfDlbtg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/844?usp=3Demail )

Change subject: Fix float support in P2P topology
......................................................................


Patch Set 1:

(4 comments)

Patchset:

PS1:
This looks like it should work (I do have a few nags)


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/844/comment/54eabdc3_8b8edf10 :
PS1, Line 1238:     if (remote && (family =3D=3D AF_INET || family =3D=3D A=
F_INET6))
I'm not sure what *that* does?  When can we ever have a `remote` and an fam=
ily that is neither `AF_INET` nor `AF_INET6`?  (If we're waiting for incomi=
ng data it can be `AF_UNSPEC`, but then we have no `remote`, no?)


http://gerrit.openvpn.net/c/openvpn/+/844/comment/c48925bd_4bc7c300 :
PS1, Line 1245:         if (floated && c->c2.buf.len > 0)
the GC seems only used inside here, and since this is a performance relevan=
t function ("hot path", executed for each packet) we should not doing unnec=
cessary work -> `gc_new(), gc_free()` can be inside the `if (floated)`.


http://gerrit.openvpn.net/c/openvpn/+/844/comment/21341812_f18c537c :
PS1, Line 1253:         process_incoming_link_part2(c, lsi, orig_buf);
should this be *inside* the `if()`?  In the old code `_part2()` is uncondit=
ionally called always



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/844?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I806757a8c6f9a589665624f176391b5f7b87f581
Gerrit-Change-Number: 844
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Fri, 20 Dec 2024 21:56:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--fMyRQfDlbtg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, ralf_lic=
i. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/844?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
844?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">This looks like it should work (I do have a few n=
ags)</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/ope=
nvpn/forward.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/844/comment/54eabdc3_8b8edf10">Pa=
tch Set #1, Line 1238:</a> <code style=3D"font-family:monospace,monospace">=
    if (remote &amp;&amp; (family =3D=3D AF_INET || family =3D=3D AF_INET6)=
)</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I&#3=
9;m not sure what *that* does?  When can we ever have a `remote` and an fam=
ily that is neither `AF_INET` nor `AF_INET6`?  (If we&#39;re waiting for in=
coming data it can be `AF_UNSPEC`, but then we have no `remote`, no?)</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/844/comment/c48925b=
d_4bc7c300">Patch Set #1, Line 1245:</a> <code style=3D"font-family:monospa=
ce,monospace">        if (floated &amp;&amp; c-&gt;c2.buf.len &gt; 0)</code=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">the GC seem=
s only used inside here, and since this is a performance relevant function =
(&quot;hot path&quot;, executed for each packet) we should not doing unnecc=
essary work -&gt; `gc_new(), gc_free()` can be inside the `if (floated)`.</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/844/comment/213=
41812_f18c537c">Patch Set #1, Line 1253:</a> <code style=3D"font-family:mon=
ospace,monospace">        process_incoming_link_part2(c, lsi, orig_buf);</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">should t=
his be *inside* the `if()`?  In the old code `_part2()` is unconditionally =
called always</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/844?usp=3Demail">change 844</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/844?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I806757a8c6f9a589665624f1763=
91b5f7b87f581 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 844 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 20 Dec 2024 21:56:39=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--fMyRQfDlbtg=--

