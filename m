From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 20 Nov 2025 14:52:16 +0000
References: <gerrit.1763650333000.Ie7308d549182a95b86cd113e4a8cc65ff45ba3d7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9edf72f5a2e5955433adf63af396bc2f1a66b986-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1AhGs/gMCgE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_crypt: Fix
 Coverity complaint in tls_crypt_v2_check_client_key_age
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

--1AhGs/gMCgE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1385?usp=3Demail

to review the following change.


Change subject: tls_crypt: Fix Coverity complaint in tls_crypt_v2_check_cli=
ent_key_age
......................................................................

tls_crypt: Fix Coverity complaint in tls_crypt_v2_check_client_key_age

Coverity complained about "overflow_before_widen" because
there is a theoretical overflow that can happen even though
the target value is wide enough. For useful values of max_days
this is irrelevant but Coverity is not wrong, so change the
code accordingly.

Change-Id: Ie7308d549182a95b86cd113e4a8cc65ff45ba3d7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/tls_crypt.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/1385/1

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 318c939..9026cff 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -539,7 +539,7 @@
     int64_t timestamp;
     memcpy(&timestamp, metadata + 1, sizeof(int64_t));
     timestamp =3D (int64_t)ntohll((uint64_t)timestamp);
-    int64_t max_age_in_seconds =3D max_days * 24 * 60 * 60;
+    int64_t max_age_in_seconds =3D (int64_t)max_days * 24 * 60 * 60;
     if (now - timestamp > max_age_in_seconds)
     {
         msg(M_WARN, "ERROR: Client key is too old.");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1385?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie7308d549182a95b86cd113e4a8cc65ff45ba3d7
Gerrit-Change-Number: 1385
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--1AhGs/gMCgE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1385?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tls_crypt: Fix Coverity complaint in tls_cr=
ypt_v2_check_client_key_age<br><br>Coverity complained about &quot;overflow=
_before_widen&quot; because<br>there is a theoretical overflow that can hap=
pen even though<br>the target value is wide enough. For useful values of ma=
x_days<br>this is irrelevant but Coverity is not wrong, so change the<br>co=
de accordingly.<br><br>Change-Id: Ie7308d549182a95b86cd113e4a8cc65ff45ba3d7=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M s=
rc/openvpn/tls_crypt.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/85/1385/1</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/tls_crypt.c b/src/open=
vpn/tls_crypt.c</span><br><span>index 318c939..9026cff 100644</span><br><sp=
an>--- a/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls_cryp=
t.c</span><br><span>@@ -539,7 +539,7 @@</span><br><span>     int64_t timest=
amp;</span><br><span>     memcpy(&amp;timestamp, metadata + 1, sizeof(int64=
_t));</span><br><span>     timestamp =3D (int64_t)ntohll((uint64_t)timestam=
p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int64_t max_ag=
e_in_seconds =3D max_days * 24 * 60 * 60;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int64_t max_age_in_seconds =3D (int64_t)max_days =
* 24 * 60 * 60;</span><br><span>     if (now - timestamp &gt; max_age_in_se=
conds)</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;ER=
ROR: Client key is too old.&quot;);</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1385?usp=3Dema=
il">change 1385</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1385?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie7308d549182a95b86cd113e4a8=
cc65ff45ba3d7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1385 </div>
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

--1AhGs/gMCgE=--

