From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 31 Mar 2026 17:32:26 +0000
In-Reply-To: <gerrit.1771008284000.I701452496bb47c58b9728b08104dd5cb7823a94f@...2715...>
References: <gerrit.1771008284000.I701452496bb47c58b9728b08104dd5cb7823a94f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <26f57b03905241a0d412f07965fa7f61969010df-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3nkt1nq9oyo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Avoid
 sign-compare warning in should_trigger_renegotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3nkt1nq9oyo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change by flichtenheld. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1526?usp=3Demail )

Change subject: ssl: Avoid sign-compare warning in should_trigger_renegotia=
tion
......................................................................


Patch Set 7: Code-Review-1

Copied votes on follow-up patch sets have been updated:
* Code-Review-1 has been copied to patch set 8 (copy condition: "changekind=
:NO_CHANGE OR changekind:TRIVIAL_REBASE OR is:MIN").

(1 comment)

File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1526/comment/6043bf12_8e71cece?usp=3D=
email :
PS7, Line 2927:     if (session->opt->renegotiate_bytes > 0 && ks->n_bytes =
>=3D (counter_type)session->opt->renegotiate_bytes)
I think we should look into making `session->opt->renegotiate_bytes` and `.=
..packets` an `uint64_t` and initialize as `0` (not -1).   Saves on the cas=
t, adds 3 more lines to the patch...  not sure if the end result is really =
nicer, but it might worth looking at it.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1526?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I701452496bb47c58b9728b08104dd5cb7823a94f
Gerrit-Change-Number: 1526
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 31 Mar 2026 17:32:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--3nkt1nq9oyo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>Patch set 7:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1526?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1526/comment/6043bf12_8e71cece?usp=3Demail">Patch Set #7,=
 Line 2927:</a> <code style=3D"font-family:monospace,monospace">    if (ses=
sion-&gt;opt-&gt;renegotiate_bytes &gt; 0 &amp;&amp; ks-&gt;n_bytes &gt;=3D=
 (counter_type)session-&gt;opt-&gt;renegotiate_bytes)</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I think we=
 should look into making `session-&gt;opt-&gt;renegotiate_bytes` and `...pa=
ckets` an `uint64_t` and initialize as `0` (not -1).   Saves on the cast, a=
dds 3 more lines to the patch...  not sure if the end result is really nice=
r, but it might worth looking at it.</p></li></ul></li></ul><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1526?usp=3Demail">chang=
e 1526</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1526?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I701452496bb47c58b9728b08104=
dd5cb7823a94f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1526 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 31 Mar 2026 17:32:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--3nkt1nq9oyo=--

