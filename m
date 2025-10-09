From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 9 Oct 2025 14:53:15 +0000
In-Reply-To: <gerrit.1759942426000.Id08524661aa5bcc5cd42f27a1aacc636e2b2b004@...2715...>
References: <gerrit.1759942426000.Id08524661aa5bcc5cd42f27a1aacc636e2b2b004@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5080f068cd8698f364b7c67ceb89e24dc04c7bd7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B1788fh5hqY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options_util: Fix
 conversion warning in atoi_constrained
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

--B1788fh5hqY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
61?usp=3Demail )

Change subject: options_util: Fix conversion warning in atoi_constrained
......................................................................

options_util: Fix conversion warning in atoi_constrained

The whole purpose of the function is to make sure
that cast is safe.

Change-Id: Id08524661aa5bcc5cd42f27a1aacc636e2b2b004
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1261
Message-Id: <20251008170202.10333-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59244107/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options_util.c
1 file changed, 1 insertion(+), 10 deletions(-)




diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 8a1c083..eba7d39 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -162,11 +162,6 @@
     return (int)i;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 atoi_constrained(const char *str, int *value, const char *name, int min, i=
nt max, msglvl_t msglevel)
 {
@@ -194,14 +189,10 @@
         return false;
     }

-    *value =3D i;
+    *value =3D (int)i;
     return true;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static const char *updatable_options[] =3D { "block-ipv6", "block-outside-=
dns",
                                            "dhcp-option", "dns",
                                            "ifconfig", "ifconfig-ipv6",

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1261?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id08524661aa5bcc5cd42f27a1aacc636e2b2b004
Gerrit-Change-Number: 1261
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--B1788fh5hqY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1261?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">options_util: Fix conversion warning in atoi_con=
strained<br><br>The whole purpose of the function is to make sure<br>that c=
ast is safe.<br><br>Change-Id: Id08524661aa5bcc5cd42f27a1aacc636e2b2b004<br=
>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net=
/c/openvpn/+/1261<br>Message-Id: &lt;20251008170202.10333-1-gert@...1296...=
&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/59244107/<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvp=
n/options_util.c<br>1 file changed, 1 insertion(+), 10 deletions(-)<br><br>=
</pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c</sp=
an><br><span>index 8a1c083..eba7d39 100644</span><br><span>--- a/src/openvp=
n/options_util.c</span><br><span>+++ b/src/openvpn/options_util.c</span><br=
><span>@@ -162,11 +162,6 @@</span><br><span>     return (int)i;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconv=
ersion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</=
span><br><span> atoi_constrained(const char *str, int *value, const char *n=
ame, int min, int max, msglvl_t msglevel)</span><br><span> {</span><br><spa=
n>@@ -194,14 +189,10 @@</span><br><span>         return false;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    *value =3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    *value =3D (int)i;</span><br><span>     return true;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> static const char *updatable_options[] =3D =
{ &quot;block-ipv6&quot;, &quot;block-outside-dns&quot;,</span><br><span>  =
                                          &quot;dhcp-option&quot;, &quot;dn=
s&quot;,</span><br><span>                                            &quot;=
ifconfig&quot;, &quot;ifconfig-ipv6&quot;,</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1261?us=
p=3Demail">change 1261</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1261?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id08524661aa5bcc5cd42f27a1aa=
cc636e2b2b004 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1261 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--B1788fh5hqY=--

