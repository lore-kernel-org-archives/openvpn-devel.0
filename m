From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 30 Nov 2023 16:24:36 +0000
References: <gerrit.1701361470000.Ie511a586cf022afcab9d67891ff80676ac7d47b9@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <837d4b88d4ef5f44f6b4d385bc2a44501ed72318-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uWr07xYDNvY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uWr07xYDNvY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/462?usp=3Demail

to review the following change.


Change subject: Remove dead remains of extract_x509_field_test
......................................................................

Remove dead remains of extract_x509_field_test

This removes some leftover references to extract_x509_field_test that
was removed 15 years in commit 564cbab5f.

Change-Id: Ie511a586cf022afcab9d67891ff80676ac7d47b9
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/init.c
M src/openvpn/ssl.h
2 files changed, 0 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/462/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--uWr07xYDNvY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/462?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove dead remains of extract_x509_field_test<br><br>This re=
moves some leftover references to extract_x509_field_test that<br>was remov=
ed 15 years in commit 564cbab5f.<br><br>Change-Id: Ie511a586cf022afcab9d678=
91ff80676ac7d47b9<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br=
>---<br>M src/openvpn/init.c<br>M src/openvpn/ssl.h<br>2 files changed, 0 i=
nsertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/62/462/1</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init.c b=
/src/openvpn/init.c</span><br><span>index 8c707a4..abba748 100644</span><br=
><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</s=
pan><br><span>@@ -880,11 +880,6 @@</span><br><span>     return false;</span=
><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#ifdef EXTRACT_X509_FIELD_TEST</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    extract_x509_field_test();</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return false;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> #ifdef TIME_TEST</span><br><span>     time_=
test();</span><br><span>     return false;</span><br><span>diff --git a/src=
/openvpn/ssl.h b/src/openvpn/ssl.h</span><br><span>index e842746..6ba6ff8 1=
00644</span><br><span>--- a/src/openvpn/ssl.h</span><br><span>+++ b/src/ope=
nvpn/ssl.h</span><br><span>@@ -540,9 +540,6 @@</span><br><span> </span><br>=
<span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-/*#define EXTRACT_X509_FIELD_TEST*/</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-void extract_x509_field_test(void);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span=
>  * Given a key_method, return true if opcode represents the one of the</s=
pan><br><span>  * hard_reset op codes for key-method 2</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/462?usp=3Demail">change 462</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/462?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie511a586cf022afcab9d67891ff=
80676ac7d47b9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 462 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--uWr07xYDNvY=--

