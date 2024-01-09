From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 9 Jan 2024 11:09:02 +0000
References: <gerrit.1704798536000.I64f094eeb0ca8c3953a94d742adf468faf27dab3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <77b603bc7e5a745a4e88f37c194cb081860c9c61-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tXmJurzQCuE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 buf_string_match_head_str: Fix Coverity issue "Unsigned compared agai...
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

--tXmJurzQCuE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/491?usp=3Demail

to review the following change.


Change subject: buf_string_match_head_str: Fix Coverity issue "Unsigned com=
pared against 0"
......................................................................

buf_string_match_head_str: Fix Coverity issue "Unsigned compared against 0"

As Coverity says:
An unsigned value can never be negative, so this test will always
evaluate the same way.

Was changed from int to size_t in commit
7fc608da4ec388c9209bd009cd5053ac0ff7df38 which triggered warning,
but the check did not make sense before, either.

Change-Id: I64f094eeb0ca8c3953a94d742adf468faf27dab3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/491/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--tXmJurzQCuE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/491?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">buf_string_match_head_str: Fix Coverity issue &quot;Unsigned =
compared against 0&quot;<br><br>As Coverity says:<br>An unsigned value can =
never be negative, so this test will always<br>evaluate the same way.<br><b=
r>Was changed from int to size_t in commit<br>7fc608da4ec388c9209bd009cd505=
3ac0ff7df38 which triggered warning,<br>but the check did not make sense be=
fore, either.<br><br>Change-Id: I64f094eeb0ca8c3953a94d742adf468faf27dab3<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src=
/openvpn/buffer.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/491/1</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><sp=
an>index 0b94a52..2ad3461 100644</span><br><span>--- a/src/openvpn/buffer.c=
</span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -822,7 +822,=
7 @@</span><br><span> buf_string_match_head_str(const struct buffer *src, c=
onst char *match)</span><br><span> {</span><br><span>     const size_t size=
 =3D strlen(match);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (size &lt; 0 || size &gt; src-&gt;len)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (size &gt; src-&gt;len)</span><br><span>    =
 {</span><br><span>         return false;</span><br><span>     }</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/491?usp=3Demail">change 491</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/49=
1?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I64f094eeb0ca8c3953a94d742ad=
f468faf27dab3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 491 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--tXmJurzQCuE=--

