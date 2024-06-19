From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 19 Jun 2024 11:02:59 +0000
References: <gerrit.1718794976000.I6e08920e4cf4762b9f14a7461a29fa77df15255c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9f344a39d07987d5f25eba2383a618db5ba56509-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ll9lW2zdfaw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Add
 -Wstrict-prototypes and -Wold-style-definition
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

--Ll9lW2zdfaw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/667?usp=3Demail

to review the following change.


Change subject: configure: Add -Wstrict-prototypes and -Wold-style-definiti=
on
......................................................................

configure: Add -Wstrict-prototypes and -Wold-style-definition

These are not covered by -Wall (nor -Wextra) but we want
to enforce them.

Change-Id: I6e08920e4cf4762b9f14a7461a29fa77df15255c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M configure.ac
M src/openvpn/dco.h
M src/openvpn/dco_linux.c
M src/openvpn/sig.c
M src/openvpn/ssl.c
M src/openvpn/ssl.h
M src/openvpn/xkey_helper.c
M src/openvpn/xkey_provider.c
8 files changed, 9 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/667/1

diff --git a/configure.ac b/configure.ac
index 2e5ab6a..c01ad09 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1408,6 +1408,8 @@
 )

 ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])

 if test "${enable_pedantic}" =3D "yes"; then
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 50ebb35..cb0adcd 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -247,7 +247,7 @@
  *
  * @return                   list of colon-separated ciphers
  */
-const char *dco_get_supported_ciphers();
+const char *dco_get_supported_ciphers(void);

 #else /* if defined(ENABLE_DCO) */

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b2584b9..277cd64 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -1053,7 +1053,7 @@
 }

 const char *
-dco_get_supported_ciphers()
+dco_get_supported_ciphers(void)
 {
     return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
 }
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index cfbd942..8323f0d 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -448,7 +448,7 @@
 }

 void
-halt_low_priority_signals()
+halt_low_priority_signals(void)
 {
 #ifndef _WIN32
     struct sigaction sa;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 2054eb4..17078c9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -277,7 +277,7 @@
 #endif

 void
-enable_auth_user_pass()
+enable_auth_user_pass(void)
 {
     auth_user_pass_enabled =3D true;
 }
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 98e59e8..0e2a43f 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -381,7 +381,7 @@
 void pem_password_setup(const char *auth_file);

 /* Enables the use of user/password authentication */
-void enable_auth_user_pass();
+void enable_auth_user_pass(void);

 /*
  * Setup authentication username and password. If auth_file is given, use =
the
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 283c95d..b68fb43 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -49,7 +49,7 @@
 XKEY_EXTERNAL_SIGN_fn xkey_management_sign;

 static void
-print_openssl_errors()
+print_openssl_errors(void)
 {
     unsigned long e;
     while ((e =3D ERR_get_error()))
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index f5fc956..964d2eb 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -155,7 +155,7 @@
 keymgmt_import_helper(XKEY_KEYDATA *key, const OSSL_PARAM params[]);

 static XKEY_KEYDATA *
-keydata_new()
+keydata_new(void)
 {
     xkey_dmsg(D_XKEY, "entry");


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/667?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6e08920e4cf4762b9f14a7461a29fa77df15255c
Gerrit-Change-Number: 667
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--Ll9lW2zdfaw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/667?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">configure: Add -Wstrict-prototypes and -Wold-style-definition=
<br><br>These are not covered by -Wall (nor -Wextra) but we want<br>to enfo=
rce them.<br><br>Change-Id: I6e08920e4cf4762b9f14a7461a29fa77df15255c<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M configu=
re.ac<br>M src/openvpn/dco.h<br>M src/openvpn/dco_linux.c<br>M src/openvpn/=
sig.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl.h<br>M src/openvpn/xkey_h=
elper.c<br>M src/openvpn/xkey_provider.c<br>8 files changed, 9 insertions(+=
), 7 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/67/667/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac</sp=
an><br><span>index 2e5ab6a..c01ad09 100644</span><br><span>--- a/configure.=
ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -1408,6 +1408,8 @@=
</span><br><span> )</span><br><span> </span><br><span> ACL_CHECK_ADD_COMPIL=
E_FLAGS([-Wno-stringop-truncation])</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ACL_CHECK_ADD_COMPILE_FLAGS(=
[-Wold-style-definition])</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wa=
ll])</span><br><span> </span><br><span> if test &quot;${enable_pedantic}&qu=
ot; =3D &quot;yes&quot;; then</span><br><span>diff --git a/src/openvpn/dco.=
h b/src/openvpn/dco.h</span><br><span>index 50ebb35..cb0adcd 100644</span><=
br><span>--- a/src/openvpn/dco.h</span><br><span>+++ b/src/openvpn/dco.h</s=
pan><br><span>@@ -247,7 +247,7 @@</span><br><span>  *</span><br><span>  * @=
return                   list of colon-separated ciphers</span><br><span>  =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *dco_get=
_supported_ciphers();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+const char *dco_get_supported_ciphers(void);</span><br><span> </span><br>=
<span> #else /* if defined(ENABLE_DCO) */</span><br><span> </span><br><span=
>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><=
span>index b2584b9..277cd64 100644</span><br><span>--- a/src/openvpn/dco_li=
nux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -105=
3,7 +1053,7 @@</span><br><span> }</span><br><span> </span><br><span> const =
char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_get_support=
ed_ciphers()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get=
_supported_ciphers(void)</span><br><span> {</span><br><span>     return &qu=
ot;AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305&quot;;</span><br><=
span> }</span><br><span>diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c<=
/span><br><span>index cfbd942..8323f0d 100644</span><br><span>--- a/src/ope=
nvpn/sig.c</span><br><span>+++ b/src/openvpn/sig.c</span><br><span>@@ -448,=
7 +448,7 @@</span><br><span> }</span><br><span> </span><br><span> void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-halt_low_priority_signals(=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+halt_low_priority_=
signals(void)</span><br><span> {</span><br><span> #ifndef _WIN32</span><br>=
<span>     struct sigaction sa;</span><br><span>diff --git a/src/openvpn/ss=
l.c b/src/openvpn/ssl.c</span><br><span>index 2054eb4..17078c9 100644</span=
><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c<=
/span><br><span>@@ -277,7 +277,7 @@</span><br><span> #endif</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-enable_auth_user_pass()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+enable_auth_user_pass(void)</span><br><span> {</span><br><span>     =
auth_user_pass_enabled =3D true;</span><br><span> }</span><br><span>diff --=
git a/src/openvpn/ssl.h b/src/openvpn/ssl.h</span><br><span>index 98e59e8..=
0e2a43f 100644</span><br><span>--- a/src/openvpn/ssl.h</span><br><span>+++ =
b/src/openvpn/ssl.h</span><br><span>@@ -381,7 +381,7 @@</span><br><span> vo=
id pem_password_setup(const char *auth_file);</span><br><span> </span><br><=
span> /* Enables the use of user/password authentication */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void enable_auth_user_pass();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void enable_auth_user_pass(=
void);</span><br><span> </span><br><span> /*</span><br><span>  * Setup auth=
entication username and password. If auth_file is given, use the</span><br>=
<span>diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c</s=
pan><br><span>index 283c95d..b68fb43 100644</span><br><span>--- a/src/openv=
pn/xkey_helper.c</span><br><span>+++ b/src/openvpn/xkey_helper.c</span><br>=
<span>@@ -49,7 +49,7 @@</span><br><span> XKEY_EXTERNAL_SIGN_fn xkey_managem=
ent_sign;</span><br><span> </span><br><span> static void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-print_openssl_errors()</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+print_openssl_errors(void)</span><br>=
<span> {</span><br><span>     unsigned long e;</span><br><span>     while (=
(e =3D ERR_get_error()))</span><br><span>diff --git a/src/openvpn/xkey_prov=
ider.c b/src/openvpn/xkey_provider.c</span><br><span>index f5fc956..964d2eb=
 100644</span><br><span>--- a/src/openvpn/xkey_provider.c</span><br><span>+=
++ b/src/openvpn/xkey_provider.c</span><br><span>@@ -155,7 +155,7 @@</span>=
<br><span> keymgmt_import_helper(XKEY_KEYDATA *key, const OSSL_PARAM params=
[]);</span><br><span> </span><br><span> static XKEY_KEYDATA *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-keydata_new()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+keydata_new(void)</span><br><span> {</spa=
n><br><span>     xkey_dmsg(D_XKEY, &quot;entry&quot;);</span><br><span> </s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/667?usp=3Demail">change 667</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/667?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6e08920e4cf4762b9f14a7461a2=
9fa77df15255c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 667 </div>
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


--Ll9lW2zdfaw=--

