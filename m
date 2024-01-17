From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 17 Jan 2024 13:32:18 +0000
In-Reply-To: <gerrit.1705068839000.Iefa4930cb1e8c4135056a17ceb4283fc13cc75c8@...2715...>
References: <gerrit.1705068839000.Iefa4930cb1e8c4135056a17ceb4283fc13cc75c8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ccac54fa9aeb7d3c009d20568daf7a58e48ae528-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8fY9QPFLt8A="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8fY9QPFLt8A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/497?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/497/2

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
Gerrit-MessageType: newpatchset

--8fY9QPFLt8A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/497?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">NTLM: increase size of phase 2 response we can handl=
e<br><br>With NTLMv2 the target information buffer can be rather large<br>e=
ven with normal domain setups.<br><br>In my test setup it was 152 bytes sta=
rting at offset 71.<br>Overall the base64 encode phase 2 response was 300 b=
yte long.<br>The linked documentation has 98 bytes at offset 60. 128 byte<b=
r>is clearly too low.<br><br>While here improve the error messaging, so tha=
t if the buffer<br>is too small at least one can determine that in the log.=
<br><br>Change-Id: Iefa4930cb1e8c4135056a17ceb4283fc13cc75c8<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &l=
t;gert@...1296...&gt;<br>Message-Id: &lt;20240117090840.32621-1-gert@...1826...=
6...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1768...=
ge.net/msg28040.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;=
<br>---<br>M src/openvpn/ntlm.c<br>M src/openvpn/proxy.c<br>2 files changed=
, 10 insertions(+), 11 deletions(-)<br><br></pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/97/497/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/n=
tlm.c b/src/openvpn/ntlm.c</span><br><span>index 99d4ae7..2c6a69d 100644</s=
pan><br><span>--- a/src/openvpn/ntlm.c</span><br><span>+++ b/src/openvpn/nt=
lm.c</span><br><span>@@ -205,7 +205,7 @@</span><br><span>     uint8_t chall=
enge[8];</span><br><span>     int i, ret_val;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t ntlmv2_response[144];=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t ntlmv2_=
response[256];</span><br><span>     char userdomain_u[256];     /* for uppe=
rcase unicode username and domain */</span><br><span>     char userdomain[1=
28];       /* the same as previous but ascii */</span><br><span>     uint8_=
t ntlmv2_hash[MD5_DIGEST_LENGTH];</span><br><span>@@ -255,17 +255,15 @@</sp=
an><br><span>      * the missing bytes will be NULL, as buf2 is known to be=
 zeroed</span><br><span>      * when this decode happens.</span><br><span> =
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t bu=
f2[128]; /* decoded reply from proxy */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    uint8_t buf2[512]; /* decoded reply from proxy */</=
span><br><span>     CLEAR(buf2);</span><br><span>     ret_val =3D openvpn_b=
ase64_decode(phase_2, buf2, -1);</span><br><span>     if (ret_val &lt; 0)</=
span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(M_WARN, &quot;NTLM: base64 decoding of phase 2 response faile=
d&quot;);</span><br><span>         return NULL;</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* w=
e can be sure that phase_2 is less than 128</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-     * therefore buf2 needs to be (3/4 * 128) */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* e=
xtract the challenge from bytes 24-31 */</span><br><span>     for (i =3D 0;=
 i&lt;8; i++)</span><br><span>     {</span><br><span>@@ -284,7 +282,7 @@</s=
pan><br><span>     }</span><br><span>     else</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;W=
arning: Username or domain too long&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;NTLM: Username or domain =
too long&quot;);</span><br><span>     }</span><br><span>     unicodize(user=
domain_u, userdomain);</span><br><span>     gen_hmac_md5((uint8_t *)userdom=
ain_u, 2 * strlen(userdomain), md4_hash,</span><br><span>@@ -319,9 +317,10 =
@@</span><br><span>     if ((flags &amp; 0x00800000) =3D=3D 0x00800000)</sp=
an><br><span>     {</span><br><span>         tib_len =3D buf2[0x28];       =
     /* Get Target Information block size */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (tib_len &gt; 96)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (tib_len + 0x1c + 16 &gt; size=
of(ntlmv2_response))</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            tib_len =3D 96;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;NTLM: targe=
t information buffer too long for response (len=3D%d)&quot;, tib_len);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return NULL;=
</span><br><span>         }</span><br><span> </span><br><span>         {</s=
pan><br><span>@@ -329,6 +328,7 @@</span><br><span>             uint8_t tib_=
pos =3D buf2[0x2c];</span><br><span>             if (tib_pos + tib_len &gt;=
 sizeof(buf2))</span><br><span>             {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                msg(M_ERR, &quot;NTLM: phase 2 re=
sponse from server too long (need %d bytes at offset %u)&quot;, tib_len, ti=
b_pos);</span><br><span>                 return NULL;</span><br><span>     =
        }</span><br><span>             /* Get Target Information block poin=
ter */</span><br><span>diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy=
.c</span><br><span>index 5a1b4e1..e081532 100644</span><br><span>--- a/src/=
openvpn/proxy.c</span><br><span>+++ b/src/openvpn/proxy.c</span><br><span>@=
@ -752,8 +752,7 @@</span><br><span>         {</span><br><span> #if NTLM</sp=
an><br><span>             /* look for the phase 2 response */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            char buf2[129];</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            char buf2[512];</span><br><span>    =
         while (true)</span><br><span>             {</span><br><span>      =
           if (!recv_line(sd, buf, sizeof(buf), get_server_poll_remaining_t=
ime(server_poll_timeout), true, NULL, signal_received))</span><br><span>@@ =
-764,9 +763,9 @@</span><br><span>                 msg(D_PROXY, &quot;HTTP p=
roxy returned: &#39;%s&#39;&quot;, buf);</span><br><span> </span><br><span>=
                 char get[80];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                CLEAR(buf2);</span><br><span>                 op=
envpn_snprintf(get, sizeof(get), &quot;%%*s NTLM %%%zus&quot;, sizeof(buf2)=
 - 1);</span><br><span>                 nparms =3D sscanf(buf, get, buf2);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                buf2[1=
28] =3D 0; /* we only need the beginning - ensure it&#39;s null terminated.=
 */</span><br><span> </span><br><span>                 /* check for &quot;P=
roxy-Authenticate: NTLM TlRM...&quot; */</span><br><span>                 i=
f (nparms =3D=3D 1)</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/497?usp=3Demail">change 497</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/497?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--8fY9QPFLt8A=--

