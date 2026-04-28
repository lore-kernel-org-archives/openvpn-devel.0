From: "selvanair (Code Review)" <gerrit@...515...>
Date: Tue, 28 Apr 2026 15:49:05 +0000
References: <gerrit.1777391343000.Id514b06223cb55295c92b1fa6727f03d6e06befe@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5f63efc8a1e7e6558a89018dde4bccf5f4e5f97f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jkyu3Y/OP70="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dns: correctly
 handle dnssec settings
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

--Jkyu3Y/OP70=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1643?usp=3Demail

to review the following change.


Change subject: dns: correctly handle dnssec settings
......................................................................

dns: correctly handle dnssec settings

Change-Id: Id514b06223cb55295c92b1fa6727f03d6e06befe
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M doc/man-sections/client-options.rst
M include/openvpn-msg.h
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpnserv/interactive.c
5 files changed, 29 insertions(+), 14 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/1643/1

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index 1664eed..abd5ec7 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -231,7 +231,7 @@
   The ``dnssec`` option is used to configure validation of DNSSEC records.
   While the exact semantics may differ for resolvers on different systems,
   ``yes`` likely makes validation mandatory, ``no`` disables it, and ``opt=
ional``
-  uses it opportunistically.
+  uses it opportunistically. The default is ``optional``.

   The ``transport`` option enables DNS-over-HTTPS (``DoH``) or DNS-over-TL=
S (``DoT``)
   for a DNS server. The ``sni`` option can be used with them to specify the
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index ca3267e..3e1f99d 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -110,7 +110,8 @@

 typedef enum
 {
-    nrpt_dnssec =3D 1 << 0,
+    nrpt_dnssec_enabled =3D 1 << 0,
+    nrpt_dnssec_required =3D 1 << 1,
 } nrpt_flags_t;

 #define NRPT_ADDR_NUM  8  /* Max. number of addresses */
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index ce23f1f..256aac9 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -442,8 +442,25 @@
         .header =3D { (add ? msg_add_nrpt_cfg : msg_del_nrpt_cfg), sizeof(=
nrpt_dns_cfg_message_t),
                     0 },
         .iface =3D { .index =3D tt->adapter_index, .name =3D "" },
-        .flags =3D server->dnssec =3D=3D DNS_SECURITY_NO ? 0 : nrpt_dnssec,
+        .flags =3D 0,
     };
+
+    switch (server->dnssec)
+    {
+        case DNS_SECURITY_YES:
+            nrpt.flags |=3D nrpt_dnssec_required;
+            /* fall through */
+        case DNS_SECURITY_OPTIONAL:
+            nrpt.flags |=3D nrpt_dnssec_enabled;
+            break;
+        case DNS_SECURITY_NO:
+            nrpt.flags =3D 0;
+            break;
+        default:
+            ASSERT(0);
+            break;
+    }
+
     strncpynt(nrpt.iface.name, tt->actual_name, sizeof(nrpt.iface.name));

     for (size_t i =3D 0; i < NRPT_ADDR_NUM; ++i)
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 51bc2de..7786452 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -29,10 +29,9 @@

 enum dns_security
 {
-    DNS_SECURITY_UNSET,
+    DNS_SECURITY_OPTIONAL,
     DNS_SECURITY_NO,
     DNS_SECURITY_YES,
-    DNS_SECURITY_OPTIONAL
 };

 enum dns_server_transport
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 473a8d3..f1dd794 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2463,13 +2463,13 @@
  * @param  address    name server address string
  * @param  domains    domains to resolve by this server as MULTI_SZ
  * @param  dom_size   size of domains in bytes including the terminators
- * @param  dnssec     boolean to determine if DNSSEC is to be enabled
+ * @param  dnssec     flag to determine DNSSEC setting
  *
  * @return NO_ERROR on success, or Windows error code
  */
 static DWORD
 SetNrptRule(HKEY nrpt_key, PCWSTR subkey, PCSTR address, PCWSTR domains, D=
WORD dom_size,
-            BOOL dnssec)
+            nrpt_flags_t dnssec)
 {
     /* Create rule subkey */
     DWORD err =3D NO_ERROR;
@@ -2497,7 +2497,7 @@

     DWORD reg_val;
     /* Set DNSSEC if required */
-    if (dnssec)
+    if (dnssec & nrpt_dnssec_required)
     {
         reg_val =3D 1;
         err =3D RegSetValueExA(rule_key, "DNSSECValidationRequired", 0, RE=
G_DWORD, (PBYTE)&reg_val,
@@ -2506,7 +2506,6 @@
         {
             goto out;
         }
-
         reg_val =3D 0;
         err =3D RegSetValueExA(rule_key, "DNSSECQueryIPSECRequired", 0, RE=
G_DWORD, (PBYTE)&reg_val,
                              sizeof(reg_val));
@@ -2525,7 +2524,7 @@
     }

     /* Set NRPT config options */
-    reg_val =3D dnssec ? 0x0000000A : 0x00000008;
+    reg_val =3D (dnssec & nrpt_dnssec_enabled) ? 0x0000000A : 0x00000008;
     err =3D RegSetValueExA(rule_key, "ConfigOptions", 0, REG_DWORD, (const=
 PBYTE)&reg_val,
                          sizeof(reg_val));
     if (err)
@@ -2593,14 +2592,14 @@
  * @param  addresses         name server addresses
  * @param  domains           optional list of split routing domains
  * @param  search_domains    optional list of search domains
- * @param  dnssec            boolean whether DNSSEC is to be used
+ * @param  dnssec            flag to determine DNSSEC setting
  * @param  ovpn_pid          the PID of the openvpn process
  *
  * @return NO_ERROR on success, or a Windows error code
  */
 static DWORD
 SetNrptRules(HKEY nrpt_key, const nrpt_address_t *addresses, const char *d=
omains,
-             const char *search_domains, BOOL dnssec, DWORD ovpn_pid)
+             const char *search_domains, nrpt_flags_t dnssec, DWORD ovpn_p=
id)
 {
     DWORD err =3D NO_ERROR;
     PWSTR wide_domains =3D L".\0"; /* DNS route everything by default */
@@ -2896,8 +2895,7 @@
     }

     /* Set NRPT rules */
-    BOOL dnssec =3D (msg->flags & nrpt_dnssec) !=3D 0;
-    err =3D SetNrptRules(key, msg->addresses, msg->resolve_domains, msg->s=
earch_domains, dnssec,
+    err =3D SetNrptRules(key, msg->addresses, msg->resolve_domains, msg->s=
earch_domains, msg->flags,
                        ovpn_pid);
     if (err)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1643?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id514b06223cb55295c92b1fa6727f03d6e06befe
Gerrit-Change-Number: 1643
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--Jkyu3Y/OP70=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1643?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dns: correctly handle dnssec settings<br><b=
r>Change-Id: Id514b06223cb55295c92b1fa6727f03d6e06befe<br>Signed-off-by: Se=
lva Nair &lt;selva.nair@...277...&gt;<br>---<br>M doc/man-sections/client-o=
ptions.rst<br>M include/openvpn-msg.h<br>M src/openvpn/dns.c<br>M src/openv=
pn/dns.h<br>M src/openvpnserv/interactive.c<br>5 files changed, 29 insertio=
ns(+), 14 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/43/1643/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-=
sections/client-options.rst b/doc/man-sections/client-options.rst</span><br=
><span>index 1664eed..abd5ec7 100644</span><br><span>--- a/doc/man-sections=
/client-options.rst</span><br><span>+++ b/doc/man-sections/client-options.r=
st</span><br><span>@@ -231,7 +231,7 @@</span><br><span>   The ``dnssec`` op=
tion is used to configure validation of DNSSEC records.</span><br><span>   =
While the exact semantics may differ for resolvers on different systems,</s=
pan><br><span>   ``yes`` likely makes validation mandatory, ``no`` disables=
 it, and ``optional``</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  uses it opportunistically.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  uses it opportunistically. The default is ``optional``.</span><b=
r><span> </span><br><span>   The ``transport`` option enables DNS-over-HTTP=
S (``DoH``) or DNS-over-TLS (``DoT``)</span><br><span>   for a DNS server. =
The ``sni`` option can be used with them to specify the</span><br><span>dif=
f --git a/include/openvpn-msg.h b/include/openvpn-msg.h</span><br><span>ind=
ex ca3267e..3e1f99d 100644</span><br><span>--- a/include/openvpn-msg.h</spa=
n><br><span>+++ b/include/openvpn-msg.h</span><br><span>@@ -110,7 +110,8 @@=
</span><br><span> </span><br><span> typedef enum</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    nrpt_dnssec =3D 1 &lt;&lt=
; 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nrpt_dnssec=
_enabled =3D 1 &lt;&lt; 0,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    nrpt_dnssec_required =3D 1 &lt;&lt; 1,</span><br><span> } nrpt_f=
lags_t;</span><br><span> </span><br><span> #define NRPT_ADDR_NUM  8  /* Max=
. number of addresses */</span><br><span>diff --git a/src/openvpn/dns.c b/s=
rc/openvpn/dns.c</span><br><span>index ce23f1f..256aac9 100644</span><br><s=
pan>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><=
br><span>@@ -442,8 +442,25 @@</span><br><span>         .header =3D { (add ?=
 msg_add_nrpt_cfg : msg_del_nrpt_cfg), sizeof(nrpt_dns_cfg_message_t),</spa=
n><br><span>                     0 },</span><br><span>         .iface =3D {=
 .index =3D tt-&gt;adapter_index, .name =3D &quot;&quot; },</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        .flags =3D server-&gt;dnssec =
=3D=3D DNS_SECURITY_NO ? 0 : nrpt_dnssec,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        .flags =3D 0,</span><br><span>     };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    switch (server-&gt;dnssec)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        case DNS_SECURITY_YES:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            nrpt.flags |=3D nrpt_dnsse=
c_required;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    /* fall through */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        case DNS_SECURITY_OPTIONAL:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            nrpt.flags |=3D nrpt_dnssec_enabled;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        case DNS_SECURITY_NO=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            nrpt.f=
lags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d=
efault:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
ASSERT(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     st=
rncpynt(nrpt.iface.name, tt-&gt;actual_name, sizeof(nrpt.iface.name));</spa=
n><br><span> </span><br><span>     for (size_t i =3D 0; i &lt; NRPT_ADDR_NU=
M; ++i)</span><br><span>diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h<=
/span><br><span>index 51bc2de..7786452 100644</span><br><span>--- a/src/ope=
nvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h</span><br><span>@@ -29,1=
0 +29,9 @@</span><br><span> </span><br><span> enum dns_security</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DNS_SECURI=
TY_UNSET,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DNS_SE=
CURITY_OPTIONAL,</span><br><span>     DNS_SECURITY_NO,</span><br><span>    =
 DNS_SECURITY_YES,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 DNS_SECURITY_OPTIONAL</span><br><span> };</span><br><span> </span><br><spa=
n> enum dns_server_transport</span><br><span>diff --git a/src/openvpnserv/i=
nteractive.c b/src/openvpnserv/interactive.c</span><br><span>index 473a8d3.=
.f1dd794 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><=
br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -2463,13 +2=
463,13 @@</span><br><span>  * @param  address    name server address string=
</span><br><span>  * @param  domains    domains to resolve by this server a=
s MULTI_SZ</span><br><span>  * @param  dom_size   size of domains in bytes =
including the terminators</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @param  dnssec     boolean to determine if DNSSEC is to be enabled</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  dnssec    =
 flag to determine DNSSEC setting</span><br><span>  *</span><br><span>  * @=
return NO_ERROR on success, or Windows error code</span><br><span>  */</spa=
n><br><span> static DWORD</span><br><span> SetNrptRule(HKEY nrpt_key, PCWST=
R subkey, PCSTR address, PCWSTR domains, DWORD dom_size,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            BOOL dnssec)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            nrpt_flags_t dnssec)</s=
pan><br><span> {</span><br><span>     /* Create rule subkey */</span><br><s=
pan>     DWORD err =3D NO_ERROR;</span><br><span>@@ -2497,7 +2497,7 @@</spa=
n><br><span> </span><br><span>     DWORD reg_val;</span><br><span>     /* S=
et DNSSEC if required */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (dnssec)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (dnssec &amp; nrpt_dnssec_required)</span><br><span>     {</span><br>=
<span>         reg_val =3D 1;</span><br><span>         err =3D RegSetValueE=
xA(rule_key, &quot;DNSSECValidationRequired&quot;, 0, REG_DWORD, (PBYTE)&am=
p;reg_val,</span><br><span>@@ -2506,7 +2506,6 @@</span><br><span>         {=
</span><br><span>             goto out;</span><br><span>         }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         reg_=
val =3D 0;</span><br><span>         err =3D RegSetValueExA(rule_key, &quot;=
DNSSECQueryIPSECRequired&quot;, 0, REG_DWORD, (PBYTE)&amp;reg_val,</span><b=
r><span>                              sizeof(reg_val));</span><br><span>@@ =
-2525,7 +2524,7 @@</span><br><span>     }</span><br><span> </span><br><span=
>     /* Set NRPT config options */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    reg_val =3D dnssec ? 0x0000000A : 0x00000008;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    reg_val =3D (dnssec &amp; n=
rpt_dnssec_enabled) ? 0x0000000A : 0x00000008;</span><br><span>     err =3D=
 RegSetValueExA(rule_key, &quot;ConfigOptions&quot;, 0, REG_DWORD, (const P=
BYTE)&amp;reg_val,</span><br><span>                          sizeof(reg_val=
));</span><br><span>     if (err)</span><br><span>@@ -2593,14 +2592,14 @@</=
span><br><span>  * @param  addresses         name server addresses</span><b=
r><span>  * @param  domains           optional list of split routing domain=
s</span><br><span>  * @param  search_domains    optional list of search dom=
ains</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  dnssec=
            boolean whether DNSSEC is to be used</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param  dnssec            flag to determine=
 DNSSEC setting</span><br><span>  * @param  ovpn_pid          the PID of th=
e openvpn process</span><br><span>  *</span><br><span>  * @return NO_ERROR =
on success, or a Windows error code</span><br><span>  */</span><br><span> s=
tatic DWORD</span><br><span> SetNrptRules(HKEY nrpt_key, const nrpt_address=
_t *addresses, const char *domains,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-             const char *search_domains, BOOL dnssec, DWORD o=
vpn_pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
  const char *search_domains, nrpt_flags_t dnssec, DWORD ovpn_pid)</span><b=
r><span> {</span><br><span>     DWORD err =3D NO_ERROR;</span><br><span>   =
  PWSTR wide_domains =3D L&quot;.\0&quot;; /* DNS route everything by defau=
lt */</span><br><span>@@ -2896,8 +2895,7 @@</span><br><span>     }</span><b=
r><span> </span><br><span>     /* Set NRPT rules */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    BOOL dnssec =3D (msg-&gt;flags &amp; nr=
pt_dnssec) !=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 err =3D SetNrptRules(key, msg-&gt;addresses, msg-&gt;resolve_domains, msg-=
&gt;search_domains, dnssec,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    err =3D SetNrptRules(key, msg-&gt;addresses, msg-&gt;resolve_do=
mains, msg-&gt;search_domains, msg-&gt;flags,</span><br><span>             =
           ovpn_pid);</span><br><span>     if (err)</span><br><span>     {<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1643?usp=3Demail">change 1643</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1643?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id514b06223cb55295c92b1fa672=
7f03d6e06befe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1643 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--Jkyu3Y/OP70=--

