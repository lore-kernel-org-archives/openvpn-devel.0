From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 17 Jan 2024 09:38:53 +0000
In-Reply-To: <gerrit.1705068839000.Icea931d29e3e504e23e045539b21013b42172664@...2715...>
References: <gerrit.1705068839000.Icea931d29e3e504e23e045539b21013b42172664@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <af58c2f3f4cec4c01ff8a2e00de5d985054e772d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KO7nwEhUF8k="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: NTLM: add length
 check to add_security_buffer
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

--KO7nwEhUF8k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/496?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: NTLM: add length check to add_security_buffer
......................................................................

NTLM: add length check to add_security_buffer

Especially ntlmv2_response can be very big, so make sure
we not do exceed the size of the phase3 buffer.

Change-Id: Icea931d29e3e504e23e045539b21013b42172664
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240117085951.27414-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
037.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ntlm.c
1 file changed, 9 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/496/2

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index bc33f41..99d4ae7 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -154,8 +154,13 @@

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
@@ -362,15 +367,15 @@

     /* NTLMv2 response */
     add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16,
-                        phase3, &phase3_bufpos);
+                        phase3, &phase3_bufpos, sizeof(phase3));

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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/496?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icea931d29e3e504e23e045539b21013b42172664
Gerrit-Change-Number: 496
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--KO7nwEhUF8k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/496?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">NTLM: add length check to add_security_buffer<br><br=
>Especially ntlmv2_response can be very big, so make sure<br>we not do exce=
ed the size of the phase3 buffer.<br><br>Change-Id: Icea931d29e3e504e23e045=
539b21013b42172664<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...=
&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;2=
0240117085951.27414-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg28037.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ntlm.c<br>1 file =
changed, 9 insertions(+), 4 deletions(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/96/496/2</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/ntlm.c b/src/openvpn/ntlm.c</span><br><span>index bc33f41..99d4ae7 1006=
44</span><br><span>--- a/src/openvpn/ntlm.c</span><br><span>+++ b/src/openv=
pn/ntlm.c</span><br><span>@@ -154,8 +154,13 @@</span><br><span> </span><br>=
<span> static void</span><br><span> add_security_buffer(int sb_offset, void=
 *data, int length,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  unsigned char *msg_buf, int *msg_bufpos)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    unsigned char *m=
sg_buf, int *msg_bufpos, size_t msg_bufsize)</span><br><span> {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (*msg_bufpos + length &g=
t; msg_bufsize)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN=
, &quot;NTLM: security buffer too big for message buffer&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     /* Adds=
 security buffer data to a message and sets security buffer&#39;s</span><br=
><span>      * offset and length */</span><br><span>     msg_buf[sb_offset]=
 =3D (unsigned char)length;</span><br><span>@@ -362,15 +367,15 @@</span><br=
><span> </span><br><span>     /* NTLMv2 response */</span><br><span>     ad=
d_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                        phase3, &=
amp;phase3_bufpos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        phase3, &amp;phase3_bufpos, sizeof(phase3));</span>=
<br><span> </span><br><span>     /* username in ascii */</span><br><span>  =
   add_security_buffer(0x24, username, strlen(username), phase3,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                        &amp;pha=
se3_bufpos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 &amp;phase3_bufpos, sizeof(phase3));</span><br><span> </sp=
an><br><span>     /* Set domain. If &lt;domain&gt; is empty, default domain=
 will be used</span><br><span>      * (i.e. proxy&#39;s domain) */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    add_security_buffer(0x1c, =
domain, strlen(domain), phase3, &amp;phase3_bufpos);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    add_security_buffer(0x1c, domain, str=
len(domain), phase3, &amp;phase3_bufpos, sizeof(phase3));</span><br><span> =
</span><br><span>     /* other security buffers will be empty */</span><br>=
<span>     phase3[0x10] =3D phase3_bufpos;     /* lm not used */</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/496?usp=3Demail">change 496</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/49=
6?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icea931d29e3e504e23e045539b2=
1013b42172664 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 496 </div>
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


--KO7nwEhUF8k=--

