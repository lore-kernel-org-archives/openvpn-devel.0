From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 23 Jun 2025 11:53:11 +0000
In-Reply-To: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
References: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 rein.vanbaaren@...1435..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <f1f623cb3fdc97b66347e0c959a19a3019d38f4a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7bbN1PeWrqM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Added PQE to WolfSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: comododragon <rein.vanbaaren@...1435...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7bbN1PeWrqM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: comododragon, flichtenheld.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1046?usp=3Demail )

Change subject: Added PQE to WolfSSL
......................................................................


Patch Set 3: Code-Review-1

(3 comments)

Patchset:

PS3:
getting closer ;-)


File README.wolfssl:

http://gerrit.openvpn.net/c/openvpn/+/1046/comment/7ec159a7_61317087 :
PS3, Line 40: option in a config.
the textual logic is weird here - "to build with these PQE...", while "thes=
e PQE" are only defined in the next paragraph...?


File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1046/comment/e1a1e35c_b06c65eb :
PS3, Line 564:     if (!SSL_CTX_set1_groups_list(ctx->ctx, groups))
please do not do that - that is, move code blocks around, just to have an e=
asier time in the #ifdef

As far as I can see all the patch really does is "change the #ifdef", but w=
ith a larger diff due to swapping the if/else parts this is harder to see, =
and will also mess up "git blame"



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef53090a6edbd35
Gerrit-Change-Number: 1046
Gerrit-PatchSet: 3
Gerrit-Owner: comododragon <rein.vanbaaren@...1435...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: comododragon <rein.vanbaaren@...1435...>
Gerrit-Comment-Date: Mon, 23 Jun 2025 11:53:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--7bbN1PeWrqM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: comododragon, flichtenheld. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1046?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">getting closer ;-)</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File README.wolfssl:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1046/comment/7ec159a7_61317087">Patch Set #3, Line 40:</a> <code style=
=3D"font-family:monospace,monospace">option in a config.</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">the textual logic is wei=
rd here - &quot;to build with these PQE...&quot;, while &quot;these PQE&quo=
t; are only defined in the next paragraph...?</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_openssl.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1046/comment/e1a1e35c_b06c65eb">Patch Set #3, Line 564:</a> <c=
ode style=3D"font-family:monospace,monospace">    if (!SSL_CTX_set1_groups_=
list(ctx-&gt;ctx, groups))</code></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">please do not do that - that is, move code blocks arou=
nd, just to have an easier time in the #ifdef</p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">As far as I can see all the patch really d=
oes is &quot;change the #ifdef&quot;, but with a larger diff due to swappin=
g the if/else parts this is harder to see, and will also mess up &quot;git =
blame&quot;</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1046?usp=3Demail">change 1046</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1046?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef=
53090a6edbd35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1046 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: comododragon &lt;rein.vanbaaren@=
...1435...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: comododragon &lt;rein.vanbaa=
ren@...1435...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 23 Jun 2025 11:53:11=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--7bbN1PeWrqM=--

