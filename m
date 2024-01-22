From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 22 Jan 2024 12:45:12 +0000
References: <gerrit.1705927509000.I378081f391ad755d0a6fd5613de5c2a8bacc389a@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7ff1e5f7717b7ef3102ae50d125f9728c1424ce0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qAo/KWW2dWI="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qAo/KWW2dWI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/503?usp=3Demail

to review the following change.


Change subject: Fix ssl unit tests on OpenSSL 1.0.2
......................................................................

Fix ssl unit tests on OpenSSL 1.0.2

OpenSSL 1.1.1 will initialise itself using clever linker magic. For
OpenSSL 1.0.2 we need to manually initialise the library. For other
unit tests just doing the OpenSSL_add_all_algorithms is enough but
this unit test needs a more complete initialisation.

Change-Id: I378081f391ad755d0a6fd5613de5c2a8bacc389a
---
M tests/unit_tests/openvpn/test_ssl.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/503/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--qAo/KWW2dWI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/503?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix ssl unit tests on OpenSSL 1.0.2<br><br>OpenSSL 1.1.1 will=
 initialise itself using clever linker magic. For<br>OpenSSL 1.0.2 we need =
to manually initialise the library. For other<br>unit tests just doing the =
OpenSSL_add_all_algorithms is enough but<br>this unit test needs a more com=
plete initialisation.<br><br>Change-Id: I378081f391ad755d0a6fd5613de5c2a8ba=
cc389a<br>---<br>M tests/unit_tests/openvpn/test_ssl.c<br>1 file changed, 2=
 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/03/503/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/o=
penvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>ind=
ex fd2049f..d0c3df7 100644</span><br><span>--- a/tests/unit_tests/openvpn/t=
est_ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><=
br><span>@@ -127,13 +127,13 @@</span><br><span>     };</span><br><span> </s=
pan><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    OpenSSL_add_all_algorithms();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    tls_init_lib();</span><br><sp=
an> #endif</span><br><span> </span><br><span>     int ret =3D cmocka_run_gr=
oup_tests_name(&quot;crypto tests&quot;, tests, NULL, NULL);</span><br><spa=
n> </span><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    EVP_cleanup();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tls_free_lib();</span><br><span> #end=
if</span><br><span> </span><br><span>     return ret;</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/503?usp=3Demail">change 503</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/503?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I378081f391ad755d0a6fd5613de=
5c2a8bacc389a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 503 </div>
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


--qAo/KWW2dWI=--

