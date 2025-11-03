From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 3 Nov 2025 11:53:37 +0000
References: <gerrit.1762170801000.I19373408a82332d7b2e5c634e5509c8be3727b5a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <07433e7201e0b863db315067233cff56cc8d973a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ohcXx0WgRJs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: Correctly
 handle port 65535 in man_kill
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ohcXx0WgRJs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1341?usp=3Demail

to review the following change.


Change subject: manage: Correctly handle port 65535 in man_kill
......................................................................

manage: Correctly handle port 65535 in man_kill

Commit c66d433111c958c42cc98f4ba12d3cfc1bd5b3b4 introduced
an off-by-one when changing a literal to a constant.

Fixes: #887
Change-Id: I19373408a82332d7b2e5c634e5509c8be3727b5a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/manage.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/1341/1

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index e46b5f2..6efa100 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -612,7 +612,7 @@
                                       : (streq(p1, "udp")) ? PROTO_UDP
                                                            : PROTO_NONE;

-                if ((port > 0 && port < UINT16_MAX) && (proto !=3D PROTO_N=
ONE))
+                if ((port > 0 && port <=3D UINT16_MAX) && (proto !=3D PROT=
O_NONE))
                 {
                     n_killed =3D (*man->persist.callback.kill_by_addr)(man=
->persist.callback.arg,
                                                                      addr,=
 (uint16_t)port, proto);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1341?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I19373408a82332d7b2e5c634e5509c8be3727b5a
Gerrit-Change-Number: 1341
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--ohcXx0WgRJs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1341?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">manage: Correctly handle port 65535 in man_=
kill<br><br>Commit c66d433111c958c42cc98f4ba12d3cfc1bd5b3b4 introduced<br>a=
n off-by-one when changing a literal to a constant.<br><br>Fixes: #887<br>C=
hange-Id: I19373408a82332d7b2e5c634e5509c8be3727b5a<br>Signed-off-by: Frank=
 Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/manage.c<br>1=
 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/1341/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>i=
ndex e46b5f2..6efa100 100644</span><br><span>--- a/src/openvpn/manage.c</sp=
an><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -612,7 +612,7 @@=
</span><br><span>                                       : (streq(p1, &quot;=
udp&quot;)) ? PROTO_UDP</span><br><span>                                   =
                         : PROTO_NONE;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                if ((port &gt; 0 &amp;&a=
mp; port &lt; UINT16_MAX) &amp;&amp; (proto !=3D PROTO_NONE))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                if ((port &gt; 0 =
&amp;&amp; port &lt;=3D UINT16_MAX) &amp;&amp; (proto !=3D PROTO_NONE))</sp=
an><br><span>                 {</span><br><span>                     n_kill=
ed =3D (*man-&gt;persist.callback.kill_by_addr)(man-&gt;persist.callback.ar=
g,</span><br><span>                                                        =
              addr, (uint16_t)port, proto);</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1341?u=
sp=3Demail">change 1341</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1341?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I19373408a82332d7b2e5c634e55=
09c8be3727b5a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1341 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--ohcXx0WgRJs=--

