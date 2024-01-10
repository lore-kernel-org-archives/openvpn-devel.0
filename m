From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 10 Jan 2024 14:57:04 +0000
References: <gerrit.1704898621000.Iefa4930cb1e8c4135056a17ceb4283fc13cc75c8@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f6636d3c6a2bb00b190a222e14dd8c924d56c0f1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ORrhGfdoyKI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: NTLM: increase
 size of phase 2 response we can handle
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

--ORrhGfdoyKI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/494?usp=3Demail

to review the following change.


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
---
M src/openvpn/ntlm.c
M src/openvpn/proxy.c
2 files changed, 11 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/494/1

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 2b735ec..698abfb 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -218,7 +218,7 @@
     uint8_t challenge[8], ntlm_response[24];
     int i, ret_val;

-    uint8_t ntlmv2_response[144];
+    uint8_t ntlmv2_response[256];
     char userdomain_u[256];     /* for uppercase unicode username and doma=
in */
     char userdomain[128];       /* the same as previous but ascii */
     uint8_t ntlmv2_hash[MD5_DIGEST_LENGTH];
@@ -270,17 +270,15 @@
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
@@ -300,7 +298,7 @@
         }
         else
         {
-            msg(M_INFO, "Warning: Username or domain too long");
+            msg(M_WARN, "NTLM: Username or domain too long");
         }
         unicodize(userdomain_u, userdomain);
         gen_hmac_md5((uint8_t *)userdomain_u, 2 * strlen(userdomain), md4_=
hash,
@@ -335,9 +333,10 @@
         if ((flags & 0x00800000) =3D=3D 0x00800000)
         {
             tib_len =3D buf2[0x28];            /* Get Target Information b=
lock size */
-            if (tib_len > 96)
+            if (tib_len + 0x1c + 16 > sizeof(ntlmv2_response))
             {
-                tib_len =3D 96;
+                msg(M_WARN, "NTLM: target information buffer too long for =
response (len=3D%d)", tib_len);
+                return NULL;
             }

             {
@@ -345,6 +344,7 @@
                 uint8_t tib_pos =3D buf2[0x2c];
                 if (tib_pos + tib_len > sizeof(buf2))
                 {
+                    msg(M_ERR, "NTLM: phase 2 response from server too lon=
g (need %d bytes at offset %u)", tib_len, tib_pos);
                     return NULL;
                 }
                 /* Get Target Information block pointer */
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 76e27cb..b2e8b3d 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -638,7 +638,6 @@
 {
     struct gc_arena gc =3D gc_new();
     char buf[512];
-    char buf2[129];
     char get[80];
     int status;
     int nparms;
@@ -758,7 +757,7 @@
         {
 #if NTLM
             /* look for the phase 2 response */
-
+            char buf2[512];
             while (true)
             {
                 if (!recv_line(sd, buf, sizeof(buf), get_server_poll_remai=
ning_time(server_poll_timeout), true, NULL, signal_received))
@@ -768,9 +767,9 @@
                 chomp(buf);
                 msg(D_PROXY, "HTTP proxy returned: '%s'", buf);

-                openvpn_snprintf(get, sizeof get, "%%*s NTLM %%%ds", (int)=
 sizeof(buf2) - 1);
+                CLEAR(buf2);
+                openvpn_snprintf(get, sizeof(get), "%%*s NTLM %%%zus", siz=
eof(buf2) - 1);
                 nparms =3D sscanf(buf, get, buf2);
-                buf2[128] =3D 0; /* we only need the beginning - ensure it=
's null terminated. */

                 /* check for "Proxy-Authenticate: NTLM TlRM..." */
                 if (nparms =3D=3D 1)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/494?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Iefa4930cb1e8c4135056a17ceb4283fc13cc75c8
Gerrit-Change-Number: 494
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--ORrhGfdoyKI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/494?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">NTLM: increase size of phase 2 response we can handle<br><br>=
With NTLMv2 the target information buffer can be rather large<br>even with =
normal domain setups.<br><br>In my test setup it was 152 bytes starting at =
offset 71.<br>Overall the base64 encode phase 2 response was 300 byte long.=
<br>The linked documentation has 98 bytes at offset 60. 128 byte<br>is clea=
rly too low.<br><br>While here improve the error messaging, so that if the =
buffer<br>is too small at least one can determine that in the log.<br><br>C=
hange-Id: Iefa4930cb1e8c4135056a17ceb4283fc13cc75c8<br>Signed-off-by: Frank=
 Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ntlm.c<br>M s=
rc/openvpn/proxy.c<br>2 files changed, 11 insertions(+), 12 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/494=
/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c</span><br><=
span>index 2b735ec..698abfb 100644</span><br><span>--- a/src/openvpn/ntlm.c=
</span><br><span>+++ b/src/openvpn/ntlm.c</span><br><span>@@ -218,7 +218,7 =
@@</span><br><span>     uint8_t challenge[8], ntlm_response[24];</span><br>=
<span>     int i, ret_val;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    uint8_t ntlmv2_response[144];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    uint8_t ntlmv2_response[256];</spa=
n><br><span>     char userdomain_u[256];     /* for uppercase unicode usern=
ame and domain */</span><br><span>     char userdomain[128];       /* the s=
ame as previous but ascii */</span><br><span>     uint8_t ntlmv2_hash[MD5_D=
IGEST_LENGTH];</span><br><span>@@ -270,17 +270,15 @@</span><br><span>      =
* the missing bytes will be NULL, as buf2 is known to be zeroed</span><br><=
span>      * when this decode happens.</span><br><span>      */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t buf2[128]; /* decoded=
 reply from proxy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint8_t buf2[512]; /* decoded reply from proxy */</span><br><span>    =
 CLEAR(buf2);</span><br><span>     ret_val =3D openvpn_base64_decode(phase_=
2, buf2, -1);</span><br><span>     if (ret_val &lt; 0)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WAR=
N, &quot;NTLM: base64 decoding of phase 2 response failed&quot;);</span><br=
><span>         return NULL;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* we can be sure that =
phase_2 is less than 128</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     * therefore buf2 needs to be (3/4 * 128) */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* extract the challe=
nge from bytes 24-31 */</span><br><span>     for (i =3D 0; i&lt;8; i++)</sp=
an><br><span>     {</span><br><span>@@ -300,7 +298,7 @@</span><br><span>   =
      }</span><br><span>         else</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO, &quot;Wa=
rning: Username or domain too long&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;NTLM: Username or doma=
in too long&quot;);</span><br><span>         }</span><br><span>         uni=
codize(userdomain_u, userdomain);</span><br><span>         gen_hmac_md5((ui=
nt8_t *)userdomain_u, 2 * strlen(userdomain), md4_hash,</span><br><span>@@ =
-335,9 +333,10 @@</span><br><span>         if ((flags &amp; 0x00800000) =3D=
=3D 0x00800000)</span><br><span>         {</span><br><span>             tib=
_len =3D buf2[0x28];            /* Get Target Information block size */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (tib_len &=
gt; 96)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (tib_len + 0x1c + 16 &gt; sizeof(ntlmv2_response))</span><br><span>     =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    tib_len =3D 96;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                msg(M_WARN, &quot;NTLM: target information buffer too long =
for response (len=3D%d)&quot;, tib_len);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                return NULL;</span><br><span>         =
    }</span><br><span> </span><br><span>             {</span><br><span>@@ -=
345,6 +344,7 @@</span><br><span>                 uint8_t tib_pos =3D buf2[0=
x2c];</span><br><span>                 if (tib_pos + tib_len &gt; sizeof(bu=
f2))</span><br><span>                 {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    msg(M_ERR, &quot;NTLM: phase 2 resp=
onse from server too long (need %d bytes at offset %u)&quot;, tib_len, tib_=
pos);</span><br><span>                     return NULL;</span><br><span>   =
              }</span><br><span>                 /* Get Target Information =
block pointer */</span><br><span>diff --git a/src/openvpn/proxy.c b/src/ope=
nvpn/proxy.c</span><br><span>index 76e27cb..b2e8b3d 100644</span><br><span>=
--- a/src/openvpn/proxy.c</span><br><span>+++ b/src/openvpn/proxy.c</span><=
br><span>@@ -638,7 +638,6 @@</span><br><span> {</span><br><span>     struct=
 gc_arena gc =3D gc_new();</span><br><span>     char buf[512];</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    char buf2[129];</span><br><spa=
n>     char get[80];</span><br><span>     int status;</span><br><span>     =
int nparms;</span><br><span>@@ -758,7 +757,7 @@</span><br><span>         {<=
/span><br><span> #if NTLM</span><br><span>             /* look for the phas=
e 2 response */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            char buf2[512=
];</span><br><span>             while (true)</span><br><span>             {=
</span><br><span>                 if (!recv_line(sd, buf, sizeof(buf), get_=
server_poll_remaining_time(server_poll_timeout), true, NULL, signal_receive=
d))</span><br><span>@@ -768,9 +767,9 @@</span><br><span>                 ch=
omp(buf);</span><br><span>                 msg(D_PROXY, &quot;HTTP proxy re=
turned: &#39;%s&#39;&quot;, buf);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                openvpn_snprintf(get, sizeo=
f get, &quot;%%*s NTLM %%%ds&quot;, (int) sizeof(buf2) - 1);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                CLEAR(buf2);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                openvpn_s=
nprintf(get, sizeof(get), &quot;%%*s NTLM %%%zus&quot;, sizeof(buf2) - 1);<=
/span><br><span>                 nparms =3D sscanf(buf, get, buf2);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                buf2[128] =3D=
 0; /* we only need the beginning - ensure it&#39;s null terminated. */</sp=
an><br><span> </span><br><span>                 /* check for &quot;Proxy-Au=
thenticate: NTLM TlRM...&quot; */</span><br><span>                 if (npar=
ms =3D=3D 1)</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/494?usp=3Demail">change 494</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/494?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefa4930cb1e8c4135056a17ceb4=
283fc13cc75c8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 494 </div>
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


--ORrhGfdoyKI=--

