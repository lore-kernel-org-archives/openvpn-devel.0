From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 21:01:19 +0000
In-Reply-To: <gerrit.1761745430000.I648ee99b1152b1248d1b3e64af7679ab99f1388f@...2715...>
References: <gerrit.1761745430000.I648ee99b1152b1248d1b3e64af7679ab99f1388f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d60379bfa760044707c1aeabb1c52b353066bcef-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zDoZvM1ei8E="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix warnings about
 conversion from int to unsigned char/uint8_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zDoZvM1ei8E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1328?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Fix warnings about conversion from int to unsigned char/uin=
t8_t
......................................................................

Fix warnings about conversion from int to unsigned char/uint8_t

When compiling with cmake -DCMAKE_BUILD_TYPE=3DASAN under Ubuntu 25.10
(gcc 15.2.0).

Explicitly cast these instances to uint8_t/unssigned char to silence this
warning.

Change-Id: I648ee99b1152b1248d1b3e64af7679ab99f1388f
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1328
Message-Id: <20251030193834.1186-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
065.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/httpdigest.c
M src/openvpn/mroute.c
2 files changed, 3 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/1328/2

diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index be20638..3e6520a 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -46,7 +46,7 @@
         }
         else
         {
-            Hex[i * 2] =3D (j + 'a' - 10);
+            Hex[i * 2] =3D (unsigned char)(j + 'a' - 10);
         }
         j =3D Bin[i] & 0xf;
         if (j <=3D 9)
@@ -55,7 +55,7 @@
         }
         else
         {
-            Hex[i * 2 + 1] =3D (j + 'a' - 10);
+            Hex[i * 2 + 1] =3D (unsigned char)(j + 'a' - 10);
         }
     }
     Hex[HASHHEXLEN] =3D '\0';
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index b50d48f..d17902f 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -337,7 +337,7 @@
             }
             else
             {
-                ma->v6.addr.s6_addr[byte--] &=3D (0xFF << bits_to_clear);
+                ma->v6.addr.s6_addr[byte--] &=3D (uint8_t)(0xFF << bits_to=
_clear);
                 bits_to_clear =3D 0;
             }
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1328?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I648ee99b1152b1248d1b3e64af7679ab99f1388f
Gerrit-Change-Number: 1328
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zDoZvM1ei8E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1328?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Fix warnings about conversion from =
int to unsigned char/uint8_t<br><br>When compiling with cmake -DCMAKE_BUILD=
_TYPE=3DASAN under Ubuntu 25.10<br>(gcc 15.2.0).<br><br>Explicitly cast the=
se instances to uint8_t/unssigned char to silence this<br>warning.<br><br>C=
hange-Id: I648ee99b1152b1248d1b3e64af7679ab99f1388f<br>Signed-off-by: Arne =
Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1328<br>Messag=
e-Id: &lt;20251030193834.1186-1-gert@...1296...&gt;<br>URL: https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg34065.html<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/httpdig=
est.c<br>M src/openvpn/mroute.c<br>2 files changed, 3 insertions(+), 3 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/28/1328/2</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/httpdigest=
.c b/src/openvpn/httpdigest.c</span><br><span>index be20638..3e6520a 100644=
</span><br><span>--- a/src/openvpn/httpdigest.c</span><br><span>+++ b/src/o=
penvpn/httpdigest.c</span><br><span>@@ -46,7 +46,7 @@</span><br><span>     =
    }</span><br><span>         else</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            Hex[i * 2] =3D (j + &#=
39;a&#39; - 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         Hex[i * 2] =3D (unsigned char)(j + &#39;a&#39; - 10);</span><br><s=
pan>         }</span><br><span>         j =3D Bin[i] &amp; 0xf;</span><br><=
span>         if (j &lt;=3D 9)</span><br><span>@@ -55,7 +55,7 @@</span><br>=
<span>         }</span><br><span>         else</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            Hex[i * 2 +=
 1] =3D (j + &#39;a&#39; - 10);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            Hex[i * 2 + 1] =3D (unsigned char)(j + &#39;a&#39; =
- 10);</span><br><span>         }</span><br><span>     }</span><br><span>  =
   Hex[HASHHEXLEN] =3D &#39;\0&#39;;</span><br><span>diff --git a/src/openv=
pn/mroute.c b/src/openvpn/mroute.c</span><br><span>index b50d48f..d17902f 1=
00644</span><br><span>--- a/src/openvpn/mroute.c</span><br><span>+++ b/src/=
openvpn/mroute.c</span><br><span>@@ -337,7 +337,7 @@</span><br><span>      =
       }</span><br><span>             else</span><br><span>             {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ma-&gt;=
v6.addr.s6_addr[byte--] &amp;=3D (0xFF &lt;&lt; bits_to_clear);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                ma-&gt;v6.addr.=
s6_addr[byte--] &amp;=3D (uint8_t)(0xFF &lt;&lt; bits_to_clear);</span><br>=
<span>                 bits_to_clear =3D 0;</span><br><span>             }<=
/span><br><span>         }</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1328?usp=3Demail">chang=
e 1328</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1328?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I648ee99b1152b1248d1b3e64af7=
679ab99f1388f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1328 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--zDoZvM1ei8E=--

