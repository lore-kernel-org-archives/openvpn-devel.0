From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 17 Jan 2024 13:32:22 +0000
In-Reply-To: <gerrit.1705068839000.Iefa4930cb1e8c4135056a17ceb4283fc13cc75c8@...2715...>
References: <gerrit.1705068839000.Iefa4930cb1e8c4135056a17ceb4283fc13cc75c8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ccac54fa9aeb7d3c009d20568daf7a58e48ae528-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EE8d1kG2nxA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: NTLM: increase size
 of phase 2 response we can handle
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

--EE8d1kG2nxA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/49=
7?usp=3Demail )

Change subject: NTLM: increase size of phase 2 response we can handle
......................................................................

NTLM: increase size of phase 2 response we can handle

With NTLMv2 the target information buffer can be rather large
even with normal domain setups.

In my test setup it was 152 bytes starting at offset 71.
Overall the base64 encode phase 2 response was 300 byte long.
The linked documentation has 98 bytes at offset 60. 128 byte
is clearly too low.

While here improve the error messaging, so that if the buffer
is too small at least one can determine that in the log.

Change-Id: Iefa4930cb1e8c4135056a17ceb4283fc13cc75c8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240117090840.32621-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
040.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ntlm.c
M src/openvpn/proxy.c
2 files changed, 10 insertions(+), 11 deletions(-)




diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 99d4ae7..2c6a69d 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -205,7 +205,7 @@
     uint8_t challenge[8];
     int i, ret_val;

-    uint8_t ntlmv2_response[144];
+    uint8_t ntlmv2_response[256];
     char userdomain_u[256];     /* for uppercase unicode username and doma=
in */
     char userdomain[128];       /* the same as previous but ascii */
     uint8_t ntlmv2_hash[MD5_DIGEST_LENGTH];
@@ -255,17 +255,15 @@
      * the missing bytes will be NULL, as buf2 is known to be zeroed
      * when this decode happens.
      */
-    uint8_t buf2[128]; /* decoded reply from proxy */
+    uint8_t buf2[512]; /* decoded reply from proxy */
     CLEAR(buf2);
     ret_val =3D openvpn_base64_decode(phase_2, buf2, -1);
     if (ret_val < 0)
     {
+        msg(M_WARN, "NTLM: base64 decoding of phase 2 response failed");
         return NULL;
     }

-    /* we can be sure that phase_2 is less than 128
-     * therefore buf2 needs to be (3/4 * 128) */
-
     /* extract the challenge from bytes 24-31 */
     for (i =3D 0; i<8; i++)
     {
@@ -284,7 +282,7 @@
     }
     else
     {
-        msg(M_INFO, "Warning: Username or domain too long");
+        msg(M_INFO, "NTLM: Username or domain too long");
     }
     unicodize(userdomain_u, userdomain);
     gen_hmac_md5((uint8_t *)userdomain_u, 2 * strlen(userdomain), md4_hash,
@@ -319,9 +317,10 @@
     if ((flags & 0x00800000) =3D=3D 0x00800000)
     {
         tib_len =3D buf2[0x28];            /* Get Target Information block=
 size */
-        if (tib_len > 96)
+        if (tib_len + 0x1c + 16 > sizeof(ntlmv2_response))
         {
-            tib_len =3D 96;
+            msg(M_WARN, "NTLM: target information buffer too long for resp=
onse (len=3D%d)", tib_len);
+            return NULL;
         }

         {
@@ -329,6 +328,7 @@
             uint8_t tib_pos =3D buf2[0x2c];
             if (tib_pos + tib_len > sizeof(buf2))
             {
+                msg(M_ERR, "NTLM: phase 2 response from server too long (n=
eed %d bytes at offset %u)", tib_len, tib_pos);
                 return NULL;
             }
             /* Get Target Information block pointer */
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 5a1b4e1..e081532 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -752,8 +752,7 @@
         {
 #if NTLM
             /* look for the phase 2 response */
-            char buf2[129];
-
+            char buf2[512];
             while (true)
             {
                 if (!recv_line(sd, buf, sizeof(buf), get_server_poll_remai=
ning_time(server_poll_timeout), true, NULL, signal_received))
@@ -764,9 +763,9 @@
                 msg(D_PROXY, "HTTP proxy returned: '%s'", buf);

                 char get[80];
+                CLEAR(buf2);
                 openvpn_snprintf(get, sizeof(get), "%%*s NTLM %%%zus", siz=
eof(buf2) - 1);
                 nparms =3D sscanf(buf, get, buf2);
-                buf2[128] =3D 0; /* we only need the beginning - ensure it=
's null terminated. */

                 /* check for "Proxy-Authenticate: NTLM TlRM..." */
                 if (nparms =3D=3D 1)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/497?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iefa4930cb1e8c4135056a17ceb4283fc13cc75c8
Gerrit-Change-Number: 497
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--EE8d1kG2nxA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/497?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">NTLM: increase size of phase 2 response we can=
 handle<br><br>With NTLMv2 the target information buffer can be rather larg=
e<br>even with normal domain setups.<br><br>In my test setup it was 152 byt=
es starting at offset 71.<br>Overall the base64 encode phase 2 response was=
 300 byte long.<br>The linked documentation has 98 bytes at offset 60. 128 =
byte<br>is clearly too low.<br><br>While here improve the error messaging, =
so that if the buffer<br>is too small at least one can determine that in th=
e log.<br><br>Change-Id: Iefa4930cb1e8c4135056a17ceb4283fc13cc75c8<br>Signe=
d-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>Message-Id: &lt;20240117090840.32621-1-gert@=
...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1885...=
rceforge.net/msg28040.html<br>Signed-off-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>---<br>M src/openvpn/ntlm.c<br>M src/openvpn/proxy.c<br>2 files c=
hanged, 10 insertions(+), 11 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c</span><br><span>ind=
ex 99d4ae7..2c6a69d 100644</span><br><span>--- a/src/openvpn/ntlm.c</span><=
br><span>+++ b/src/openvpn/ntlm.c</span><br><span>@@ -205,7 +205,7 @@</span=
><br><span>     uint8_t challenge[8];</span><br><span>     int i, ret_val;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
uint8_t ntlmv2_response[144];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint8_t ntlmv2_response[256];</span><br><span>     char userd=
omain_u[256];     /* for uppercase unicode username and domain */</span><br=
><span>     char userdomain[128];       /* the same as previous but ascii *=
/</span><br><span>     uint8_t ntlmv2_hash[MD5_DIGEST_LENGTH];</span><br><s=
pan>@@ -255,17 +255,15 @@</span><br><span>      * the missing bytes will be=
 NULL, as buf2 is known to be zeroed</span><br><span>      * when this deco=
de happens.</span><br><span>      */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    uint8_t buf2[128]; /* decoded reply from proxy */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t buf2[512]; /* =
decoded reply from proxy */</span><br><span>     CLEAR(buf2);</span><br><sp=
an>     ret_val =3D openvpn_base64_decode(phase_2, buf2, -1);</span><br><sp=
an>     if (ret_val &lt; 0)</span><br><span>     {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;NTLM: base64 decod=
ing of phase 2 response failed&quot;);</span><br><span>         return NULL=
;</span><br><span>     }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* we can be sure that phase_2 is less than 128</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * therefore buf2 ne=
eds to be (3/4 * 128) */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span>     /* extract the challenge from bytes 24-31 */</span=
><br><span>     for (i =3D 0; i&lt;8; i++)</span><br><span>     {</span><br=
><span>@@ -284,7 +282,7 @@</span><br><span>     }</span><br><span>     else=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(M_INFO, &quot;Warning: Username or domain too long&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &q=
uot;NTLM: Username or domain too long&quot;);</span><br><span>     }</span>=
<br><span>     unicodize(userdomain_u, userdomain);</span><br><span>     ge=
n_hmac_md5((uint8_t *)userdomain_u, 2 * strlen(userdomain), md4_hash,</span=
><br><span>@@ -319,9 +317,10 @@</span><br><span>     if ((flags &amp; 0x008=
00000) =3D=3D 0x00800000)</span><br><span>     {</span><br><span>         t=
ib_len =3D buf2[0x28];            /* Get Target Information block size */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (tib_len &gt=
; 96)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ti=
b_len + 0x1c + 16 &gt; sizeof(ntlmv2_response))</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            tib_len =
=3D 96;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(M_WARN, &quot;NTLM: target information buffer too long for response (le=
n=3D%d)&quot;, tib_len);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return NULL;</span><br><span>         }</span><br><span> <=
/span><br><span>         {</span><br><span>@@ -329,6 +328,7 @@</span><br><s=
pan>             uint8_t tib_pos =3D buf2[0x2c];</span><br><span>          =
   if (tib_pos + tib_len &gt; sizeof(buf2))</span><br><span>             {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(=
M_ERR, &quot;NTLM: phase 2 response from server too long (need %d bytes at =
offset %u)&quot;, tib_len, tib_pos);</span><br><span>                 retur=
n NULL;</span><br><span>             }</span><br><span>             /* Get =
Target Information block pointer */</span><br><span>diff --git a/src/openvp=
n/proxy.c b/src/openvpn/proxy.c</span><br><span>index 5a1b4e1..e081532 1006=
44</span><br><span>--- a/src/openvpn/proxy.c</span><br><span>+++ b/src/open=
vpn/proxy.c</span><br><span>@@ -752,8 +752,7 @@</span><br><span>         {<=
/span><br><span> #if NTLM</span><br><span>             /* look for the phas=
e 2 response */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      char buf2[129];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            char bu=
f2[512];</span><br><span>             while (true)</span><br><span>        =
     {</span><br><span>                 if (!recv_line(sd, buf, sizeof(buf)=
, get_server_poll_remaining_time(server_poll_timeout), true, NULL, signal_r=
eceived))</span><br><span>@@ -764,9 +763,9 @@</span><br><span>             =
    msg(D_PROXY, &quot;HTTP proxy returned: &#39;%s&#39;&quot;, buf);</span=
><br><span> </span><br><span>                 char get[80];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                CLEAR(buf2);</span>=
<br><span>                 openvpn_snprintf(get, sizeof(get), &quot;%%*s NT=
LM %%%zus&quot;, sizeof(buf2) - 1);</span><br><span>                 nparms=
 =3D sscanf(buf, get, buf2);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                buf2[128] =3D 0; /* we only need the beginning - ens=
ure it&#39;s null terminated. */</span><br><span> </span><br><span>        =
         /* check for &quot;Proxy-Authenticate: NTLM TlRM...&quot; */</span=
><br><span>                 if (nparms =3D=3D 1)</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
97?usp=3Demail">change 497</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/497?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefa4930cb1e8c4135056a17ceb4=
283fc13cc75c8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 497 </div>
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


--EE8d1kG2nxA=--

