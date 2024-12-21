From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Sat, 21 Dec 2024 15:23:08 +0000
In-Reply-To: <gerrit.1734714757000.I806757a8c6f9a589665624f176391b5f7b87f581@...2715...>
References: <gerrit.1734714757000.I806757a8c6f9a589665624f176391b5f7b87f581@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <85d1cbd99244998c8632fb89a095d70d03466b48-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EVmA6ECMwZY="; charset=UTF-8
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
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EVmA6ECMwZY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

ralf_lici has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/844?usp=3Demail )

Change subject: Fix float support in P2P topology
......................................................................


Patch Set 1:

(4 comments)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/844/comment/a2f4224f_180af603 :
PS1, Line 1238:     if (remote && (family =3D=3D AF_INET || family =3D=3D A=
F_INET6))
> I'm not sure what *that* does?  When can we ever have a `remote` and an f=
amily that is neither `AF_I [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/844/comment/ed3d6af5_b5a33468 :
PS1, Line 1245:         if (floated && c->c2.buf.len > 0)
> the GC seems only used inside here, and since this is a performance relev=
ant function ("hot path", e [=E2=80=A6]
Definitely, I think I forgot to reorder this when I removed the other debug=
ging prints I used for testing purposes. Acknowledged.


http://gerrit.openvpn.net/c/openvpn/+/844/comment/34c401d6_00f96d38 :
PS1, Line 1251: tls_update_remote_addr
Tested the non-tls p2p configuration (`--secret`) and realized that this li=
ne obviously segfaults. Sorry for this, I will fix it on the next patch.


http://gerrit.openvpn.net/c/openvpn/+/844/comment/ee561cd1_89c6d5cc :
PS1, Line 1253:         process_incoming_link_part2(c, lsi, orig_buf);
> should this be *inside* the `if()`?  In the old code `_part2()` is uncond=
itionally called always
AFAICT the output of `_part1()` is correlated with `c->c2.buf.len` such tha=
t `buf.len` is always <=3D 0 if `_part1()` returns false (though the revers=
e isn't always true). Since `_part2()` processes a packet only if `buf.len =
> 0`, it seems safe to call `_part2()` only if `_part1()` returns true. How=
ever, as the current implementation works and I=E2=80=99m not entirely cert=
ain, I suggest leaving it as is unless there=E2=80=99s a strong reason to s=
witch to conditional execution. What do you think?



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
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sat, 21 Dec 2024 15:23:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--EVmA6ECMwZY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/844?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/844/comment/a2f4224f_180af603">Patch Set #1, Line 1238:</=
a> <code style=3D"font-family:monospace,monospace">    if (remote &amp;&amp=
; (family =3D=3D AF_INET || family =3D=3D AF_INET6))</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
I&#39;m not sure what *that* does?  When can we ever have a `remote` and an=
 family that is neither `AF_I [=E2=80=A6]</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/844/comment/ed3d6af5_b5a33468">Pa=
tch Set #1, Line 1245:</a> <code style=3D"font-family:monospace,monospace">=
        if (floated &amp;&amp; c-&gt;c2.buf.len &gt; 0)</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">the GC seems only used inside here, and since this is a performance rele=
vant function (&quot;hot path&quot;, e [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Definitely, I think I fo=
rgot to reorder this when I removed the other debugging prints I used for t=
esting purposes. Acknowledged.</p></li><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/844/comment/34c401d6_00f96d38">Patch Set #1, Line 1251:</a=
> <code style=3D"font-family:monospace,monospace">tls_update_remote_addr</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Tested t=
he non-tls p2p configuration (`--secret`) and realized that this line obvio=
usly segfaults. Sorry for this, I will fix it on the next patch.</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/844/comment/ee561cd1_89c=
6d5cc">Patch Set #1, Line 1253:</a> <code style=3D"font-family:monospace,mo=
nospace">        process_incoming_link_part2(c, lsi, orig_buf);</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">should this be *inside* the `if()`?  In the old code `_part2()` =
is unconditionally called always</blockquote></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">AFAICT the output of `_part1()` is correla=
ted with `c-&gt;c2.buf.len` such that `buf.len` is always &lt;=3D 0 if `_pa=
rt1()` returns false (though the reverse isn&#39;t always true). Since `_pa=
rt2()` processes a packet only if `buf.len &gt; 0`, it seems safe to call `=
_part2()` only if `_part1()` returns true. However, as the current implemen=
tation works and I=E2=80=99m not entirely certain, I suggest leaving it as =
is unless there=E2=80=99s a strong reason to switch to conditional executio=
n. What do you think?</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/844?usp=3Demail">change 844</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/844?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 21 Dec 2024 15:23:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--EVmA6ECMwZY=--

