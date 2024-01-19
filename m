From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 19 Jan 2024 13:12:29 +0000
In-Reply-To: <gerrit.1704798536000.I64f094eeb0ca8c3953a94d742adf468faf27dab3@...2715...>
References: <gerrit.1704798536000.I64f094eeb0ca8c3953a94d742adf468faf27dab3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <08cafca8213c5be6c2b9f87e08d21f0610173179-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/I8JFSZvugk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 buf_string_match_head_str: Fix Coverity issue 'Unsigned compared agai...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/I8JFSZvugk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/491?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: buf_string_match_head_str: Fix Coverity issue 'Unsigned com=
pared against 0'
......................................................................

buf_string_match_head_str: Fix Coverity issue 'Unsigned compared against 0'

As Coverity says:
An unsigned value can never be negative, so this test will always
evaluate the same way.

Was changed from int to size_t in commit
7fc608da4ec388c9209bd009cd5053ac0ff7df38 which triggered warning,
but the check did not make sense before, either.

Change-Id: I64f094eeb0ca8c3953a94d742adf468faf27dab3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240119120341.22933-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
093.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/buffer.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/491/2

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 0b94a52..2ad3461 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -822,7 +822,7 @@
 buf_string_match_head_str(const struct buffer *src, const char *match)
 {
     const size_t size =3D strlen(match);
-    if (size < 0 || size > src->len)
+    if (size > src->len)
     {
         return false;
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/491?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I64f094eeb0ca8c3953a94d742adf468faf27dab3
Gerrit-Change-Number: 491
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--/I8JFSZvugk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/491?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">buf_string_match_head_str: Fix Coverity issue &#=
39;Unsigned compared against 0&#39;<br><br>As Coverity says:<br>An unsigned=
 value can never be negative, so this test will always<br>evaluate the same=
 way.<br><br>Was changed from int to size_t in commit<br>7fc608da4ec388c920=
9bd009cd5053ac0ff7df38 which triggered warning,<br>but the check did not ma=
ke sense before, either.<br><br>Change-Id: I64f094eeb0ca8c3953a94d742adf468=
faf27dab3<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>A=
cked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20=
240119120341.22933-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.c=
om/openvpn-devel@lists.sourceforge.net/msg28093.html<br>Signed-off-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/buffer.c<br>1 file=
 changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/91/491/2</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/buffer.c b/src/openvpn/buffer.c</span><br><span>index 0b94a52..2ad3461 1=
00644</span><br><span>--- a/src/openvpn/buffer.c</span><br><span>+++ b/src/=
openvpn/buffer.c</span><br><span>@@ -822,7 +822,7 @@</span><br><span> buf_s=
tring_match_head_str(const struct buffer *src, const char *match)</span><br=
><span> {</span><br><span>     const size_t size =3D strlen(match);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (size &lt; 0 || size &=
gt; src-&gt;len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (size &gt; src-&gt;len)</span><br><span>     {</span><br><span>        =
 return false;</span><br><span>     }</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/491?usp=3Dem=
ail">change 491</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/491?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I64f094eeb0ca8c3953a94d742ad=
f468faf27dab3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 491 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--/I8JFSZvugk=--

