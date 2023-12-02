From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 2 Dec 2023 15:26:36 +0000
In-Reply-To: <gerrit.1701361470000.Ie511a586cf022afcab9d67891ff80676ac7d47b9@...2715...>
References: <gerrit.1701361470000.Ie511a586cf022afcab9d67891ff80676ac7d47b9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4dc366da95d38beae2fdbc75f2a80b98620fe1cc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xzokwAbg5qM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove dead remains
 of extract_x509_field_test
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xzokwAbg5qM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/46=
2?usp=3Demail )

Change subject: Remove dead remains of extract_x509_field_test
......................................................................

Remove dead remains of extract_x509_field_test

This removes some leftover references to extract_x509_field_test that
was removed 15 years ago in commit 564cbab5f.

Change-Id: Ie511a586cf022afcab9d67891ff80676ac7d47b9
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231201111846.15097-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
625.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
M src/openvpn/ssl.h
2 files changed, 0 insertions(+), 8 deletions(-)




diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 8c707a4..abba748 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -880,11 +880,6 @@
     return false;
 #endif

-#ifdef EXTRACT_X509_FIELD_TEST
-    extract_x509_field_test();
-    return false;
-#endif
-
 #ifdef TIME_TEST
     time_test();
     return false;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index e842746..6ba6ff8 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -540,9 +540,6 @@

 #endif

-/*#define EXTRACT_X509_FIELD_TEST*/
-void extract_x509_field_test(void);
-
 /**
  * Given a key_method, return true if opcode represents the one of the
  * hard_reset op codes for key-method 2

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/462?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie511a586cf022afcab9d67891ff80676ac7d47b9
Gerrit-Change-Number: 462
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--xzokwAbg5qM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/462?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove dead remains of extract_x509_field_test=
<br><br>This removes some leftover references to extract_x509_field_test th=
at<br>was removed 15 years ago in commit 564cbab5f.<br><br>Change-Id: Ie511=
a586cf022afcab9d67891ff80676ac7d47b9<br>Signed-off-by: Arne Schwabe &lt;arn=
e@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>Message-Id: &lt;20231201111846.15097-1-frank@...2641...&gt;<br>URL: https:=
//www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27625.html<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvp=
n/init.c<br>M src/openvpn/ssl.h<br>2 files changed, 0 insertions(+), 8 dele=
tions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>ind=
ex 8c707a4..abba748 100644</span><br><span>--- a/src/openvpn/init.c</span><=
br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -880,11 +880,6 @@</spa=
n><br><span>     return false;</span><br><span> #endif</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef EXTRACT_X509_FIEL=
D_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    extract_x50=
9_field_test();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef =
TIME_TEST</span><br><span>     time_test();</span><br><span>     return fal=
se;</span><br><span>diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h</spa=
n><br><span>index e842746..6ba6ff8 100644</span><br><span>--- a/src/openvpn=
/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -540,9 +5=
40,6 @@</span><br><span> </span><br><span> #endif</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/*#define EXTRACT_X509_FIELD_=
TEST*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void extract_x5=
09_field_test(void);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> /**</span><br><span>  * Given a key_method, return true if=
 opcode represents the one of the</span><br><span>  * hard_reset op codes f=
or key-method 2</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/462?usp=3Demail">change 462</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/462?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie511a586cf022afcab9d67891ff=
80676ac7d47b9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 462 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--xzokwAbg5qM=--

