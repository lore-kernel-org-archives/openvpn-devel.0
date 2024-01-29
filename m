From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 29 Jan 2024 10:45:48 +0000
References: <gerrit.1706525147000.Id7b4bda38adfbb446bdac635ac5d5207ef3f2f40@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <62782a197aefc6227cf97b1549a0807d39f96b42-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y7u2kN7uxhQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: gerrit-send-mail:
 Make output consistent across systems
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

--y7u2kN7uxhQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/508?usp=3Demail

to review the following change.


Change subject: gerrit-send-mail: Make output consistent across systems
......................................................................

gerrit-send-mail: Make output consistent across systems

When writing the file specify encoding and newline, so that
the local settings (like locale) do not change the output.

Change-Id: Id7b4bda38adfbb446bdac635ac5d5207ef3f2f40
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M dev-tools/gerrit-send-mail.py
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/508/1

diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
index 5429aef..67a2cf1 100755
--- a/dev-tools/gerrit-send-mail.py
+++ b/dev-tools/gerrit-send-mail.py
@@ -109,7 +109,7 @@
     )
     filename =3D f"gerrit-{args.changeid}-{details['revision']}.patch"
     patch_text_final =3D patch_text_mod.replace("Subject: [PATCH]", f"Subj=
ect: [PATCH v{details['revision']}]")
-    with open(filename, "w") as patch_file:
+    with open(filename, "w", encoding=3D"utf-8", newline=3D"\n") as patch_=
file:
         patch_file.write(patch_text_final)
     print("send with:")
     print(f"git send-email --in-reply-to {details['msg_id']} {filename}")

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/508?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id7b4bda38adfbb446bdac635ac5d5207ef3f2f40
Gerrit-Change-Number: 508
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--y7u2kN7uxhQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/508?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">gerrit-send-mail: Make output consistent across systems<br><b=
r>When writing the file specify encoding and newline, so that<br>the local =
settings (like locale) do not change the output.<br><br>Change-Id: Id7b4bda=
38adfbb446bdac635ac5d5207ef3f2f40<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>---<br>M dev-tools/gerrit-send-mail.py<br>1 file cha=
nged, 1 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/08/508/1</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/ger=
rit-send-mail.py b/dev-tools/gerrit-send-mail.py</span><br><span>index 5429=
aef..67a2cf1 100755</span><br><span>--- a/dev-tools/gerrit-send-mail.py</sp=
an><br><span>+++ b/dev-tools/gerrit-send-mail.py</span><br><span>@@ -109,7 =
+109,7 @@</span><br><span>     )</span><br><span>     filename =3D f&quot;g=
errit-{args.changeid}-{details[&#39;revision&#39;]}.patch&quot;</span><br><=
span>     patch_text_final =3D patch_text_mod.replace(&quot;Subject: [PATCH=
]&quot;, f&quot;Subject: [PATCH v{details[&#39;revision&#39;]}]&quot;)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    with open(filename, &q=
uot;w&quot;) as patch_file:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    with open(filename, &quot;w&quot;, encoding=3D&quot;utf-8&quot;=
, newline=3D&quot;\n&quot;) as patch_file:</span><br><span>         patch_f=
ile.write(patch_text_final)</span><br><span>     print(&quot;send with:&quo=
t;)</span><br><span>     print(f&quot;git send-email --in-reply-to {details=
[&#39;msg_id&#39;]} {filename}&quot;)</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/508?usp=3Dem=
ail">change 508</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/508?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id7b4bda38adfbb446bdac635ac5=
d5207ef3f2f40 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 508 </div>
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


--y7u2kN7uxhQ=--

