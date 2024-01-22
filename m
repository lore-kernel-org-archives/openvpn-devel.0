From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 22 Jan 2024 13:16:22 +0000
In-Reply-To: <gerrit.1705927509000.I378081f391ad755d0a6fd5613de5c2a8bacc389a@...2715...>
References: <gerrit.1705927509000.I378081f391ad755d0a6fd5613de5c2a8bacc389a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d8685ff47256888bc1987b217f9db8301c54bdd7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8x9UDnsmfqk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix ssl unit tests
 on OpenSSL 1.0.2
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

--8x9UDnsmfqk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/503?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Fix ssl unit tests on OpenSSL 1.0.2
......................................................................

Fix ssl unit tests on OpenSSL 1.0.2

OpenSSL 1.1.1 will initialise itself using clever linker magic. For
OpenSSL 1.0.2 we need to manually initialise the library. For other
unit tests just doing the OpenSSL_add_all_algorithms is enough but
this unit test needs a more complete initialisation.

Change-Id: I378081f391ad755d0a6fd5613de5c2a8bacc389a
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240122130909.10706-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
112.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_ssl.c
1 file changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/503/2

diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index fd2049f..d0c3df7 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -127,13 +127,13 @@
     };

 #if defined(ENABLE_CRYPTO_OPENSSL)
-    OpenSSL_add_all_algorithms();
+    tls_init_lib();
 #endif

     int ret =3D cmocka_run_group_tests_name("crypto tests", tests, NULL, N=
ULL);

 #if defined(ENABLE_CRYPTO_OPENSSL)
-    EVP_cleanup();
+    tls_free_lib();
 #endif

     return ret;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/503?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I378081f391ad755d0a6fd5613de5c2a8bacc389a
Gerrit-Change-Number: 503
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--8x9UDnsmfqk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
503?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Fix ssl unit tests on OpenSSL 1.0.2<br><br>Op=
enSSL 1.1.1 will initialise itself using clever linker magic. For<br>OpenSS=
L 1.0.2 we need to manually initialise the library. For other<br>unit tests=
 just doing the OpenSSL_add_all_algorithms is enough but<br>this unit test =
needs a more complete initialisation.<br><br>Change-Id: I378081f391ad755d0a=
6fd5613de5c2a8bacc389a<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&=
gt;<br>Message-Id: &lt;20240122130909.10706-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28112.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M tests=
/unit_tests/openvpn/test_ssl.c<br>1 file changed, 2 insertions(+), 2 deleti=
ons(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/03/503/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/test=
s/unit_tests/openvpn/test_ssl.c</span><br><span>index fd2049f..d0c3df7 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><spa=
n>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -127,13 +127=
,13 @@</span><br><span>     };</span><br><span> </span><br><span> #if defin=
ed(ENABLE_CRYPTO_OPENSSL)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    OpenSSL_add_all_algorithms();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    tls_init_lib();</span><br><span> #endif</span><br><sp=
an> </span><br><span>     int ret =3D cmocka_run_group_tests_name(&quot;cry=
pto tests&quot;, tests, NULL, NULL);</span><br><span> </span><br><span> #if=
 defined(ENABLE_CRYPTO_OPENSSL)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    EVP_cleanup();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    tls_free_lib();</span><br><span> #endif</span><br><span> </spa=
n><br><span>     return ret;</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/503?usp=3Demail">chan=
ge 503</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/503?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I378081f391ad755d0a6fd5613de=
5c2a8bacc389a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 503 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--8x9UDnsmfqk=--

