From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 10 Jan 2024 14:57:05 +0000
References: <gerrit.1704898621000.Icea931d29e3e504e23e045539b21013b42172664@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <24b0de3b3035d04c48fef070956d4e3bf7d03131-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X+/xiouS7Gs="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: NTLM: add
 length check to add_security_buffer
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

--X+/xiouS7Gs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/493?usp=3Demail

to review the following change.


Change subject: NTLM: add length check to add_security_buffer
......................................................................

NTLM: add length check to add_security_buffer

Especially ntlmv2_response can be very big, so make sure
we not do exceed the size of the phase3 buffer.

Change-Id: Icea931d29e3e504e23e045539b21013b42172664
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ntlm.c
1 file changed, 10 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/493/1

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 2e77214..2b735ec 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -167,8 +167,13 @@

 static void
 add_security_buffer(int sb_offset, void *data, int length,
-                    unsigned char *msg_buf, int *msg_bufpos)
+                    unsigned char *msg_buf, int *msg_bufpos, size_t msg_bu=
fsize)
 {
+    if (*msg_bufpos + length > msg_bufsize)
+    {
+        msg(M_WARN, "NTLM: security buffer too big for message buffer");
+        return;
+    }
     /* Adds security buffer data to a message and sets security buffer's
      * offset and length */
     msg_buf[sb_offset] =3D (unsigned char)length;
@@ -396,20 +401,20 @@
     if (ntlmv2_enabled)      /* NTLMv2 response */
     {
         add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16,
-                            phase3, &phase3_bufpos);
+                            phase3, &phase3_bufpos, sizeof(phase3));
     }
     else       /* NTLM response */
     {
-        add_security_buffer(0x14, ntlm_response, 24, phase3, &phase3_bufpo=
s);
+        add_security_buffer(0x14, ntlm_response, 24, phase3, &phase3_bufpo=
s, sizeof(phase3));
     }

     /* username in ascii */
     add_security_buffer(0x24, username, strlen(username), phase3,
-                        &phase3_bufpos);
+                        &phase3_bufpos, sizeof(phase3));

     /* Set domain. If <domain> is empty, default domain will be used
      * (i.e. proxy's domain) */
-    add_security_buffer(0x1c, domain, strlen(domain), phase3, &phase3_bufp=
os);
+    add_security_buffer(0x1c, domain, strlen(domain), phase3, &phase3_bufp=
os, sizeof(phase3));

     /* other security buffers will be empty */
     phase3[0x10] =3D phase3_bufpos;     /* lm not used */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/493?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Icea931d29e3e504e23e045539b21013b42172664
Gerrit-Change-Number: 493
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--X+/xiouS7Gs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/493?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">NTLM: add length check to add_security_buffer<br><br>Especial=
ly ntlmv2_response can be very big, so make sure<br>we not do exceed the si=
ze of the phase3 buffer.<br><br>Change-Id: Icea931d29e3e504e23e045539b21013=
b42172664<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>-=
--<br>M src/openvpn/ntlm.c<br>1 file changed, 10 insertions(+), 5 deletions=
(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
93/493/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c</span=
><br><span>index 2e77214..2b735ec 100644</span><br><span>--- a/src/openvpn/=
ntlm.c</span><br><span>+++ b/src/openvpn/ntlm.c</span><br><span>@@ -167,8 +=
167,13 @@</span><br><span> </span><br><span> static void</span><br><span> a=
dd_security_buffer(int sb_offset, void *data, int length,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    unsigned char *msg_=
buf, int *msg_bufpos)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    unsigned char *msg_buf, int *msg_bufpos, size_t msg_b=
ufsize)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (*msg_bufpos + length &gt; msg_bufsize)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_WARN, &quot;NTLM: security buffer too big=
 for message buffer&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span>     /* Adds security buffer data to a message an=
d sets security buffer&#39;s</span><br><span>      * offset and length */</=
span><br><span>     msg_buf[sb_offset] =3D (unsigned char)length;</span><br=
><span>@@ -396,20 +401,20 @@</span><br><span>     if (ntlmv2_enabled)      =
/* NTLMv2 response */</span><br><span>     {</span><br><span>         add_s=
ecurity_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                            phase3, =
&amp;phase3_bufpos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                            phase3, &amp;phase3_bufpos, sizeof(phase3));</=
span><br><span>     }</span><br><span>     else       /* NTLM response */</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        add_security_buffer(0x14, ntlm_response, 24, phase3, &amp;phase3_bu=
fpos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_s=
ecurity_buffer(0x14, ntlm_response, 24, phase3, &amp;phase3_bufpos, sizeof(=
phase3));</span><br><span>     }</span><br><span> </span><br><span>     /* =
username in ascii */</span><br><span>     add_security_buffer(0x24, usernam=
e, strlen(username), phase3,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                        &amp;phase3_bufpos);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        &amp;phase3_bufpo=
s, sizeof(phase3));</span><br><span> </span><br><span>     /* Set domain. I=
f &lt;domain&gt; is empty, default domain will be used</span><br><span>    =
  * (i.e. proxy&#39;s domain) */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    add_security_buffer(0x1c, domain, strlen(domain), phase3, &a=
mp;phase3_bufpos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   add_security_buffer(0x1c, domain, strlen(domain), phase3, &amp;phase3_bu=
fpos, sizeof(phase3));</span><br><span> </span><br><span>     /* other secu=
rity buffers will be empty */</span><br><span>     phase3[0x10] =3D phase3_=
bufpos;     /* lm not used */</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/493?usp=3Demail">cha=
nge 493</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/493?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icea931d29e3e504e23e045539b2=
1013b42172664 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 493 </div>
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


--X+/xiouS7Gs=--

