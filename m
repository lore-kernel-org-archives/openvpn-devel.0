From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 22 Jan 2024 13:16:23 +0000
In-Reply-To: <gerrit.1705927509000.I378081f391ad755d0a6fd5613de5c2a8bacc389a@...2715...>
References: <gerrit.1705927509000.I378081f391ad755d0a6fd5613de5c2a8bacc389a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d8685ff47256888bc1987b217f9db8301c54bdd7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q6EsP+mN5TY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Q6EsP+mN5TY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/50=
3?usp=3Demail )

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
Gerrit-MessageType: merged

--Q6EsP+mN5TY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/503?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Fix ssl unit tests on OpenSSL 1.0.2<br><br>Ope=
nSSL 1.1.1 will initialise itself using clever linker magic. For<br>OpenSSL=
 1.0.2 we need to manually initialise the library. For other<br>unit tests =
just doing the OpenSSL_add_all_algorithms is enough but<br>this unit test n=
eeds a more complete initialisation.<br><br>Change-Id: I378081f391ad755d0a6=
fd5613de5c2a8bacc389a<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>Message-Id: &lt;20240122130909.10706-1-gert@...1296...&gt;<br>URL: ht=
tps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28112.htm=
l<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M tests/=
unit_tests/openvpn/test_ssl.c<br>1 file changed, 2 insertions(+), 2 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/open=
vpn/test_ssl.c</span><br><span>index fd2049f..d0c3df7 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_ssl.c</span><br><span>@@ -127,13 +127,13 @@</span><br>=
<span>     };</span><br><span> </span><br><span> #if defined(ENABLE_CRYPTO_=
OPENSSL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenSSL_a=
dd_all_algorithms();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    tls_init_lib();</span><br><span> #endif</span><br><span> </span><br><s=
pan>     int ret =3D cmocka_run_group_tests_name(&quot;crypto tests&quot;, =
tests, NULL, NULL);</span><br><span> </span><br><span> #if defined(ENABLE_C=
RYPTO_OPENSSL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    EVP=
_cleanup();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_=
free_lib();</span><br><span> #endif</span><br><span> </span><br><span>     =
return ret;</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/503?usp=3Demail">change 503</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/503?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Q6EsP+mN5TY=--

