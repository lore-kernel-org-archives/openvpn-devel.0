From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 22 Jul 2024 13:20:30 +0000
In-Reply-To: <gerrit.1721648146000.Ic27d84c74c1dd6ff7973ca6966d186f475c67e21@...2715...>
References: <gerrit.1721648146000.Ic27d84c74c1dd6ff7973ca6966d186f475c67e21@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3475d7b418c575460e4562604db71547267ccce0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bcnz526pwjM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix missing spaces
 in various messages
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

--bcnz526pwjM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/67=
9?usp=3Demail )

Change subject: Fix missing spaces in various messages
......................................................................

Fix missing spaces in various messages

These result from broken up literals where it
is easy to miss the missing space.

Change-Id: Ic27d84c74c1dd6ff7973ca6966d186f475c67e21
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240722121034.10816-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
950.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/ssl_verify.c
4 files changed, 10 insertions(+), 10 deletions(-)




diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 78243b1..7f0d53d 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -185,7 +185,7 @@
         }
         else
         {
-            msg(D_DCO_DEBUG, "Swapping primary and secondary keys to"
+            msg(D_DCO_DEBUG, "Swapping primary and secondary keys to "
                 "primary-id=3D%d secondary-id=3D(to be deleted)",
                 primary->key_id);
         }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 162b23e..03177bb 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1804,7 +1804,7 @@
     }
     else if (dco_enabled(o))
     {
-        msg(M_INFO, "Client does not support DATA_V2. Data channel offloai=
ng "
+        msg(M_INFO, "Client does not support DATA_V2. Data channel offload=
ing "
             "requires DATA_V2. Dropping client.");
         auth_set_client_reason(tls_multi, "Data channel negotiation "
                                "failed (missing DATA_V2)");
@@ -1815,7 +1815,7 @@
      * not accept our pushed ciphers */
     if (proto & IV_PROTO_NCP_P2P)
     {
-        msg(M_WARN, "Note: peer reports running in P2P mode (no --pull/--c=
lient"
+        msg(M_WARN, "Note: peer reports running in P2P mode (no --pull/--c=
lient "
             "option). It will not negotiate ciphers with this server. "
             "Expect this connection to fail.");
     }
@@ -2027,7 +2027,7 @@
         /* Not EOF but other error -> fall through to error state */
         default:
             /* We received an unknown/unexpected value.  Assume failure. */
-            msg(M_WARN, "WARNING: Unknown/unexpected value in deferred"
+            msg(M_WARN, "WARNING: Unknown/unexpected value in deferred "
                 "client-connect resultfile");
             ret =3D CC_RET_FAILED;
     }
@@ -2427,7 +2427,7 @@
      */
     if (!mi->context.c2.push_ifconfig_defined)
     {
-        msg(D_MULTI_ERRORS, "MULTI: no dynamic or static remote"
+        msg(D_MULTI_ERRORS, "MULTI: no dynamic or static remote "
             "--ifconfig address is available for %s",
             multi_instance_string(mi, false, &gc));
     }
@@ -2443,7 +2443,7 @@
             print_in_addr_t(mi->context.options.push_ifconfig_constraint_n=
etmask, 0, &gc);

         /* JYFIXME -- this should cause the connection to fail */
-        msg(D_MULTI_ERRORS, "MULTI ERROR: primary virtual IP for %s (%s)"
+        msg(D_MULTI_ERRORS, "MULTI ERROR: primary virtual IP for %s (%s) "
             "violates tunnel network/netmask constraint (%s/%s)",
             multi_instance_string(mi, false, &gc),
             print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc),
@@ -2492,7 +2492,7 @@
     }
     else if (mi->context.options.iroutes)
     {
-        msg(D_MULTI_ERRORS, "MULTI: --iroute options rejected for %s -- ir=
oute"
+        msg(D_MULTI_ERRORS, "MULTI: --iroute options rejected for %s -- ir=
oute "
             "only works with tun-style tunnels",
             multi_instance_string(mi, false, &gc));
     }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 64e67aa..ba9b05e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7033,7 +7033,7 @@
     }
     else if (streq(p[0], "max-routes") && !p[2])
     {
-        msg(M_WARN, "DEPRECATED OPTION: --max-routes option ignored."
+        msg(M_WARN, "DEPRECATED OPTION: --max-routes option ignored. "
             "The number of routes is unlimited as of OpenVPN 2.4. "
             "This option will be removed in a future version, "
             "please remove it from your configuration.");
@@ -9328,7 +9328,7 @@
                         s++;
                     }
                     msg(M_WARN, "DEPRECATED FEATURE: automatically upcased=
 the "
-                        "--x509-username-field parameter to '%s'; please u=
pdate your"
+                        "--x509-username-field parameter to '%s'; please u=
pdate your "
                         "configuration", p[j]);
                 }
             }
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 934ff8d..0b0e2c3 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -717,7 +717,7 @@
         {
             const char *hex_fp =3D format_hex_ex(BPTR(&cert_fp), BLEN(&cer=
t_fp),
                                                0, 1, ":", &gc);
-            msg(D_TLS_ERRORS, "TLS Error: --tls-verify/--peer-fingerprint"
+            msg(D_TLS_ERRORS, "TLS Error: --tls-verify/--peer-fingerprint "
                 "certificate hash verification failed. (got certificate "
                 "fingerprint: %s)", hex_fp);
             goto cleanup;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/679?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic27d84c74c1dd6ff7973ca6966d186f475c67e21
Gerrit-Change-Number: 679
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--bcnz526pwjM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/679?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Fix missing spaces in various messages<br><br>=
These result from broken up literals where it<br>is easy to miss the missin=
g space.<br><br>Change-Id: Ic27d84c74c1dd6ff7973ca6966d186f475c67e21<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20240722121034.10816-1-ger=
t@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg28950.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M src/openvpn/dco.c<br>M src/openvpn/multi.c<br>M src/op=
envpn/options.c<br>M src/openvpn/ssl_verify.c<br>4 files changed, 10 insert=
ions(+), 10 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index=
 78243b1..7f0d53d 100644</span><br><span>--- a/src/openvpn/dco.c</span><br>=
<span>+++ b/src/openvpn/dco.c</span><br><span>@@ -185,7 +185,7 @@</span><br=
><span>         }</span><br><span>         else</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_DCO_=
DEBUG, &quot;Swapping primary and secondary keys to&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(D_DCO_DEBUG, &quot;Sw=
apping primary and secondary keys to &quot;</span><br><span>               =
  &quot;primary-id=3D%d secondary-id=3D(to be deleted)&quot;,</span><br><sp=
an>                 primary-&gt;key_id);</span><br><span>         }</span><=
br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><=
span>index 162b23e..03177bb 100644</span><br><span>--- a/src/openvpn/multi.=
c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -1804,7 +180=
4,7 @@</span><br><span>     }</span><br><span>     else if (dco_enabled(o))=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(M_INFO, &quot;Client does not support DATA_V2. Data channel o=
ffloaing &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_INFO, &quot;Client does not support DATA_V2. Data channel offload=
ing &quot;</span><br><span>             &quot;requires DATA_V2. Dropping cl=
ient.&quot;);</span><br><span>         auth_set_client_reason(tls_multi, &q=
uot;Data channel negotiation &quot;</span><br><span>                       =
         &quot;failed (missing DATA_V2)&quot;);</span><br><span>@@ -1815,7 =
+1815,7 @@</span><br><span>      * not accept our pushed ciphers */</span><=
br><span>     if (proto &amp; IV_PROTO_NCP_P2P)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;=
Note: peer reports running in P2P mode (no --pull/--client&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Note=
: peer reports running in P2P mode (no --pull/--client &quot;</span><br><sp=
an>             &quot;option). It will not negotiate ciphers with this serv=
er. &quot;</span><br><span>             &quot;Expect this connection to fai=
l.&quot;);</span><br><span>     }</span><br><span>@@ -2027,7 +2027,7 @@</sp=
an><br><span>         /* Not EOF but other error -&gt; fall through to erro=
r state */</span><br><span>         default:</span><br><span>             /=
* We received an unknown/unexpected value.  Assume failure. */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WARN=
ING: Unknown/unexpected value in deferred&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;WARNING: Unknown/=
unexpected value in deferred &quot;</span><br><span>                 &quot;=
client-connect resultfile&quot;);</span><br><span>             ret =3D CC_R=
ET_FAILED;</span><br><span>     }</span><br><span>@@ -2427,7 +2427,7 @@</sp=
an><br><span>      */</span><br><span>     if (!mi-&gt;context.c2.push_ifco=
nfig_defined)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        msg(D_MULTI_ERRORS, &quot;MULTI: no dynamic or stati=
c remote&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(D_MULTI_ERRORS, &quot;MULTI: no dynamic or static remote &quot;</spa=
n><br><span>             &quot;--ifconfig address is available for %s&quot;=
,</span><br><span>             multi_instance_string(mi, false, &amp;gc));<=
/span><br><span>     }</span><br><span>@@ -2443,7 +2443,7 @@</span><br><spa=
n>             print_in_addr_t(mi-&gt;context.options.push_ifconfig_constra=
int_netmask, 0, &amp;gc);</span><br><span> </span><br><span>         /* JYF=
IXME -- this should cause the connection to fail */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_ERRORS, &quot;MULTI ERR=
OR: primary virtual IP for %s (%s)&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(D_MULTI_ERRORS, &quot;MULTI ERROR: primary=
 virtual IP for %s (%s) &quot;</span><br><span>             &quot;violates =
tunnel network/netmask constraint (%s/%s)&quot;,</span><br><span>          =
   multi_instance_string(mi, false, &amp;gc),</span><br><span>             =
print_in_addr_t(mi-&gt;context.c2.push_ifconfig_local, 0, &amp;gc),</span><=
br><span>@@ -2492,7 +2492,7 @@</span><br><span>     }</span><br><span>     =
else if (mi-&gt;context.options.iroutes)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_ERRORS, &quot=
;MULTI: --iroute options rejected for %s -- iroute&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_ERRORS, &quot;MULT=
I: --iroute options rejected for %s -- iroute &quot;</span><br><span>      =
       &quot;only works with tun-style tunnels&quot;,</span><br><span>     =
        multi_instance_string(mi, false, &amp;gc));</span><br><span>     }<=
/span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c<=
/span><br><span>index 64e67aa..ba9b05e 100644</span><br><span>--- a/src/ope=
nvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>=
@@ -7033,7 +7033,7 @@</span><br><span>     }</span><br><span>     else if (=
streq(p[0], &quot;max-routes&quot;) &amp;&amp; !p[2])</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, =
&quot;DEPRECATED OPTION: --max-routes option ignored.&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DEPRECATE=
D OPTION: --max-routes option ignored. &quot;</span><br><span>             =
&quot;The number of routes is unlimited as of OpenVPN 2.4. &quot;</span><br=
><span>             &quot;This option will be removed in a future version, =
&quot;</span><br><span>             &quot;please remove it from your config=
uration.&quot;);</span><br><span>@@ -9328,7 +9328,7 @@</span><br><span>    =
                     s++;</span><br><span>                     }</span><br>=
<span>                     msg(M_WARN, &quot;DEPRECATED FEATURE: automatica=
lly upcased the &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                        &quot;--x509-username-field parameter to &#39;%s&#=
39;; please update your&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        &quot;--x509-username-field parameter to =
&#39;%s&#39;; please update your &quot;</span><br><span>                   =
      &quot;configuration&quot;, p[j]);</span><br><span>                 }<=
/span><br><span>             }</span><br><span>diff --git a/src/openvpn/ssl=
_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index 934ff8d..0b0e2c3=
 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ =
b/src/openvpn/ssl_verify.c</span><br><span>@@ -717,7 +717,7 @@</span><br><s=
pan>         {</span><br><span>             const char *hex_fp =3D format_h=
ex_ex(BPTR(&amp;cert_fp), BLEN(&amp;cert_fp),</span><br><span>             =
                                   0, 1, &quot;:&quot;, &amp;gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS, &=
quot;TLS Error: --tls-verify/--peer-fingerprint&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS, &quot;TLS E=
rror: --tls-verify/--peer-fingerprint &quot;</span><br><span>              =
   &quot;certificate hash verification failed. (got certificate &quot;</spa=
n><br><span>                 &quot;fingerprint: %s)&quot;, hex_fp);</span><=
br><span>             goto cleanup;</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/679?usp=3Demai=
l">change 679</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/679?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic27d84c74c1dd6ff7973ca6966d=
186f475c67e21 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 679 </div>
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


--bcnz526pwjM=--

