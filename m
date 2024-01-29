From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 29 Jan 2024 15:05:29 +0000
In-Reply-To: <gerrit.1706525147000.Id7b4bda38adfbb446bdac635ac5d5207ef3f2f40@...2715...>
References: <gerrit.1706525147000.Id7b4bda38adfbb446bdac635ac5d5207ef3f2f40@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f2ad21c671c9e326cca3ebf3c3d3557b89edbd64-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0yvB3wbiZqQ="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0yvB3wbiZqQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/50=
8?usp=3Demail )

Change subject: gerrit-send-mail: Make output consistent across systems
......................................................................

gerrit-send-mail: Make output consistent across systems

When writing the file specify encoding and newline, so that
the local settings (like locale) do not change the output.

Change-Id: Id7b4bda38adfbb446bdac635ac5d5207ef3f2f40
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240129145756.769-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
153.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M dev-tools/gerrit-send-mail.py
1 file changed, 1 insertion(+), 1 deletion(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--0yvB3wbiZqQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/508?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">gerrit-send-mail: Make output consistent acros=
s systems<br><br>When writing the file specify encoding and newline, so tha=
t<br>the local settings (like locale) do not change the output.<br><br>Chan=
ge-Id: Id7b4bda38adfbb446bdac635ac5d5207ef3f2f40<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openv=
pn@...1227...&gt;<br>Message-Id: &lt;20240129145756.769-1-gert@...1296...&g=
t;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net=
/msg28153.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>--=
-<br>M dev-tools/gerrit-send-mail.py<br>1 file changed, 1 insertion(+), 1 d=
eletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.=
py</span><br><span>index 5429aef..67a2cf1 100755</span><br><span>--- a/dev-=
tools/gerrit-send-mail.py</span><br><span>+++ b/dev-tools/gerrit-send-mail.=
py</span><br><span>@@ -109,7 +109,7 @@</span><br><span>     )</span><br><sp=
an>     filename =3D f&quot;gerrit-{args.changeid}-{details[&#39;revision&#=
39;]}.patch&quot;</span><br><span>     patch_text_final =3D patch_text_mod.=
replace(&quot;Subject: [PATCH]&quot;, f&quot;Subject: [PATCH v{details[&#39=
;revision&#39;]}]&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    with open(filename, &quot;w&quot;) as patch_file:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    with open(filename, &quot;w&quot;,=
 encoding=3D&quot;utf-8&quot;, newline=3D&quot;\n&quot;) as patch_file:</sp=
an><br><span>         patch_file.write(patch_text_final)</span><br><span>  =
   print(&quot;send with:&quot;)</span><br><span>     print(f&quot;git send=
-email --in-reply-to {details[&#39;msg_id&#39;]} {filename}&quot;)</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/508?usp=3Demail">change 508</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
508?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id7b4bda38adfbb446bdac635ac5=
d5207ef3f2f40 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 508 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--0yvB3wbiZqQ=--

