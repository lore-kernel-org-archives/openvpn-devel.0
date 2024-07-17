From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 17 Jul 2024 20:01:31 +0000
In-Reply-To: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
References: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1a25a3db95753020fd3938aad373cd12f18a4a56-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q8DqAW7QhZk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow trailing \r
 and \n in control channel message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Q8DqAW7QhZk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Allow trailing \r and \n in control channel message
......................................................................

Allow trailing \r and \n in control channel message

Writing a reason from a script will easily end up adding extra \r\n charact=
ers
at the end of the reason. Our current code pushes this to the peer. So be m=
ore
liberal in accepting these message.

Github: closes OpenVPN/openvpn#568

Change-Id: I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240710140623.172829-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
910.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
M src/openvpn/ssl_pkt.c
M src/openvpn/ssl_pkt.h
M tests/unit_tests/openvpn/test_pkt.c
4 files changed, 92 insertions(+), 30 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/672/5

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 71b7167..40b7cc4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -290,41 +290,14 @@
     struct buffer buf =3D alloc_buf_gc(len, &gc);
     if (tls_rec_payload(c->c2.tls_multi, &buf))
     {
-
         while (BLEN(&buf) > 1)
         {
-            /* commands on the control channel are seperated by 0x00 bytes.
-             * cmdlen does not include the 0 byte of the string */
-            int cmdlen =3D (int)strnlen(BSTR(&buf), BLEN(&buf));
+            struct buffer cmdbuf =3D extract_command_buffer(&buf, &gc);

-            if (cmdlen < BLEN(&buf))
+            if (cmdbuf.len > 0)
             {
-                /* include the NUL byte and ensure NUL termination */
-                int cmdlen =3D (int)strlen(BSTR(&buf)) + 1;
-
-                /* Construct a buffer that only holds the current command =
and
-                 * its closing NUL byte */
-                struct buffer cmdbuf =3D alloc_buf_gc(cmdlen, &gc);
-                buf_write(&cmdbuf, BPTR(&buf), cmdlen);
-
-                /* check we have only printable characters or null byte in=
 the
-                 * command string and no newlines */
-                if (!string_check_buf(&buf, CC_PRINT | CC_NULL, CC_CRLF))
-                {
-                    msg(D_PUSH_ERRORS, "WARNING: Received control with inv=
alid characters: %s",
-                        format_hex(BPTR(&buf), BLEN(&buf), 256, &gc));
-                }
-                else
-                {
-                    parse_incoming_control_channel_command(c, &cmdbuf);
-                }
+                parse_incoming_control_channel_command(c, &cmdbuf);
             }
-            else
-            {
-                msg(D_PUSH_ERRORS, "WARNING: Ignoring control channel "
-                    "message command without NUL termination");
-            }
-            buf_advance(&buf, cmdlen);
         }
     }
     else
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 2ec0b2f..689cd7f 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -557,3 +557,43 @@
     }
     return false;
 }
+
+struct buffer
+extract_command_buffer(struct buffer *buf, struct gc_arena *gc)
+{
+    /* commands on the control channel are seperated by 0x00 bytes.
+     * cmdlen does not include the 0 byte of the string */
+    int cmdlen =3D (int)strnlen(BSTR(buf), BLEN(buf));
+
+    if (cmdlen >=3D BLEN(buf))
+    {
+        buf_advance(buf, cmdlen);
+        /* Return empty buffer */
+        struct buffer empty =3D { 0 };
+        return empty;
+    }
+
+    /* include the NUL byte and ensure NUL termination */
+    cmdlen +=3D  1;
+
+    /* Construct a buffer that only holds the current command and
+     * its closing NUL byte */
+    struct buffer cmdbuf =3D alloc_buf_gc(cmdlen, gc);
+    buf_write(&cmdbuf, BPTR(buf), cmdlen);
+
+    /* Remove \r and \n at the end of the buffer to avoid
+     * problems with scripts and other that add extra \r and \n */
+    buf_chomp(&cmdbuf);
+
+    /* check we have only printable characters or null byte in the
+     * command string and no newlines */
+    if (!string_check_buf(&cmdbuf, CC_PRINT | CC_NULL, CC_CRLF))
+    {
+        msg(D_PUSH_ERRORS, "WARNING: Received control with invalid charact=
ers: %s",
+            format_hex(BPTR(&cmdbuf), BLEN(&cmdbuf), 256, gc));
+        cmdbuf.len =3D 0;
+    }
+
+    buf_advance(buf, cmdlen);
+    return cmdbuf;
+}
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 88b9e8c..c8a27fb 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -230,6 +230,20 @@
                      uint8_t header,
                      bool request_resend_wkc);

+
+/**
+ * Extracts a control channel message from buf and adjusts the size of
+ * buf after the message has been extracted
+ * @param buf   The buffer the message should be extracted from
+ * @param gc    gc_arena to be used for the returned buffer and displaying
+ *              diagnostic messages
+ * @return      A buffer with a control channel message or a buffer with
+ *              with length 0 if there is no message or the message has
+ *              invalid characters.
+ */
+struct buffer
+extract_command_buffer(struct buffer *buf, struct gc_arena *gc);
+
 static inline const char *
 packet_opcode_name(int op)
 {
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index 1084d66..741c982 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -626,6 +626,40 @@
     free_tas(&tas_server);
 }

+static void
+test_extract_control_message(void **ut_state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer input_buf =3D alloc_buf_gc(1024, &gc);
+
+    /* This message will have a \0x00 at the end since it is a C string */
+    const char input[] =3D "valid control message\r\n\0\0Invalid\r\none\0v=
alid one again";
+
+    buf_write(&input_buf, input, sizeof(input));
+    struct buffer cmd1 =3D extract_command_buffer(&input_buf, &gc);
+    struct buffer cmd2 =3D extract_command_buffer(&input_buf, &gc);
+    struct buffer cmd3 =3D extract_command_buffer(&input_buf, &gc);
+    struct buffer cmd4 =3D extract_command_buffer(&input_buf, &gc);
+    struct buffer cmd5 =3D extract_command_buffer(&input_buf, &gc);
+
+    assert_string_equal(BSTR(&cmd1), "valid control message");
+    /* empty message with just a \0x00 */
+    assert_int_equal(cmd2.len, 1);
+    assert_string_equal(BSTR(&cmd2), "");
+    assert_int_equal(cmd3.len, 0);
+    assert_string_equal(BSTR(&cmd4), "valid one again");
+    assert_int_equal(cmd5.len, 0);
+
+    const uint8_t nonull[6] =3D { 'n', 'o', ' ', 'N', 'U', 'L'};
+    struct buffer nonull_buf =3D alloc_buf_gc(1024, &gc);
+
+    buf_write(&nonull_buf, nonull, sizeof(nonull));
+    struct buffer nonullcmd =3D extract_command_buffer(&nonull_buf, &gc);
+    assert_int_equal(nonullcmd.len, 0);
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -640,6 +674,7 @@
         cmocka_unit_test(test_verify_hmac_tls_auth),
         cmocka_unit_test(test_generate_reset_packet_plain),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
+        cmocka_unit_test(test_extract_control_message)
     };

 #if defined(ENABLE_CRYPTO_OPENSSL)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e
Gerrit-Change-Number: 672
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--Q8DqAW7QhZk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
672?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Allow trailing \r and \n in control channel m=
essage<br><br>Writing a reason from a script will easily end up adding extr=
a \r\n characters<br>at the end of the reason. Our current code pushes this=
 to the peer. So be more<br>liberal in accepting these message.<br><br>Gith=
ub: closes OpenVPN/openvpn#568<br><br>Change-Id: I47c992b6b73b1475cbff8a28f=
720cf50dc1fbe3e<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>A=
cked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;2024=
0710140623.172829-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.c=
om/openvpn-devel@lists.sourceforge.net/msg28910.html<br>Signed-off-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/forward.c<br>M src=
/openvpn/ssl_pkt.c<br>M src/openvpn/ssl_pkt.h<br>M tests/unit_tests/openvpn=
/test_pkt.c<br>4 files changed, 92 insertions(+), 30 deletions(-)<br><br></=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/672/5</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><s=
pan>index 71b7167..40b7cc4 100644</span><br><span>--- a/src/openvpn/forward=
.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -290,41 +=
290,14 @@</span><br><span>     struct buffer buf =3D alloc_buf_gc(len, &amp=
;gc);</span><br><span>     if (tls_rec_payload(c-&gt;c2.tls_multi, &amp;buf=
))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span>         while (BLEN(&amp;buf) &gt; 1)</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  /* commands on the control channel are seperated by 0x00 bytes.</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-             * cmdlen does not =
include the 0 byte of the string */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            int cmdlen =3D (int)strnlen(BSTR(&amp;buf), BLEN(=
&amp;buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    struct buffer cmdbuf =3D extract_command_buffer(&amp;buf, &amp;gc);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     if (cmdlen &lt; BLEN(&amp;buf))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (cmdbuf.len &gt; 0)</span><br><span>       =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  /* include the NUL byte and ensure NUL termination */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                int cmdlen =3D (int)strle=
n(BSTR(&amp;buf)) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* C=
onstruct a buffer that only holds the current command and</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                 * its closing NUL byte=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                st=
ruct buffer cmdbuf =3D alloc_buf_gc(cmdlen, &amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                buf_write(&amp;cmdbuf, BPTR=
(&amp;buf), cmdlen);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* che=
ck we have only printable characters or null byte in the</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                 * command string and no=
 newlines */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       if (!string_check_buf(&amp;buf, CC_PRINT | CC_NULL, CC_CRLF))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    msg(D_PUSH_E=
RRORS, &quot;WARNING: Received control with invalid characters: %s&quot;,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 format_hex(BPTR(&amp;buf), BLEN(&amp;buf), 256, &amp;gc));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    parse_incoming_control_cha=
nnel_command(c, &amp;cmdbuf);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                parse_incoming_control_channel_command(c, &amp;cmdbuf=
);</span><br><span>             }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            else</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               msg(D_PUSH_ERRORS, &quot;WARNING: Ignoring control channel &=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    &quot;message command without NUL termination&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            buf_advance(&amp;buf, cmdlen);</spa=
n><br><span>         }</span><br><span>     }</span><br><span>     else</sp=
an><br><span>diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c</sp=
an><br><span>index 2ec0b2f..689cd7f 100644</span><br><span>--- a/src/openvp=
n/ssl_pkt.c</span><br><span>+++ b/src/openvpn/ssl_pkt.c</span><br><span>@@ =
-557,3 +557,43 @@</span><br><span>     }</span><br><span>     return false;=
</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+extract_command_buffer(st=
ruct buffer *buf, struct gc_arena *gc)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* commands on the control channel are seperated by 0x00 bytes.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * cmdlen does not inc=
lude the 0 byte of the string */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int cmdlen =3D (int)strnlen(BSTR(buf), BLEN(buf));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (cmdlen &gt;=3D BLEN(buf))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        buf_advance(buf, cmdlen);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* Return empty buffer *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buf=
fer empty =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return empty;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* include the NUL byte an=
d ensure NUL termination */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    cmdlen +=3D  1;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Cons=
truct a buffer that only holds the current command and</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * its closing NUL byte */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer cmdbuf =3D =
alloc_buf_gc(cmdlen, gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    buf_write(&amp;cmdbuf, BPTR(buf), cmdlen);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Remove \r and \n at the end of the buffer to avoid</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * problems with s=
cripts and other that add extra \r and \n */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    buf_chomp(&amp;cmdbuf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* check we have only printable characters or null byte =
in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * comman=
d string and no newlines */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!string_check_buf(&amp;cmdbuf, CC_PRINT | CC_NULL, CC_CRLF)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot=
;WARNING: Received control with invalid characters: %s&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            format_hex(BPTR(&amp;=
cmdbuf), BLEN(&amp;cmdbuf), 256, gc));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmdbuf.len =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_=
advance(buf, cmdlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return cmdbuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span>diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt=
.h</span><br><span>index 88b9e8c..c8a27fb 100644</span><br><span>--- a/src/=
openvpn/ssl_pkt.h</span><br><span>+++ b/src/openvpn/ssl_pkt.h</span><br><sp=
an>@@ -230,6 +230,20 @@</span><br><span>                      uint8_t heade=
r,</span><br><span>                      bool request_resend_wkc);</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Extracts a control channel message from bu=
f and adjusts the size of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * buf after the message has been extracted</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param buf   The buffer the message should=
 be extracted from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param gc    gc_arena to be used for the returned buffer and displaying</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *              diagn=
ostic messages</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn      A buffer with a control channel message or a buffer with</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *              with length=
 0 if there is no message or the message has</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *              invalid characters.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+struct buffer</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+extract_command_buffer(struct buffer *buf, struct gc_are=
na *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> static inline const char *</span><br><span> packet_opcode_name(int o=
p)</span><br><span> {</span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>index 108=
4d66..741c982 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pk=
t.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt.c</span><br><sp=
an>@@ -626,6 +626,40 @@</span><br><span>     free_tas(&amp;tas_server);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_extract_control_message(void **ut_state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer input_buf =3D alloc_buf=
_gc(1024, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* This message=
 will have a \0x00 at the end since it is a C string */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char input[] =3D &quot;valid =
control message\r\n\0\0Invalid\r\none\0valid one again&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf_write(&amp;input_buf, input, sizeof(input));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer c=
md1 =3D extract_command_buffer(&amp;input_buf, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer cmd2 =3D extract_com=
mand_buffer(&amp;input_buf, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct buffer cmd3 =3D extract_command_buffer(&amp;in=
put_buf, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer cmd4 =3D extract_command_buffer(&amp;input_buf, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer cm=
d5 =3D extract_command_buffer(&amp;input_buf, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(BSTR(&amp;cmd1), &quot;valid contr=
ol message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* empty message with just a \0x00 */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(cmd2.len, 1);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(BSTR(&amp;cmd2)=
, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(cmd3.len, 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_string_equal(BSTR(&amp;cmd4), &quot;valid one again&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(cmd5.len, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_=
t nonull[6] =3D { &#39;n&#39;, &#39;o&#39;, &#39; &#39;, &#39;N&#39;, &#39;=
U&#39;, &#39;L&#39;};</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct buffer nonull_buf =3D alloc_buf_gc(1024, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    buf_write(&amp;nonull_buf, nonull, sizeof(nonu=
ll));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buf=
fer nonullcmd =3D extract_command_buffer(&amp;nonull_buf, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(nonull=
cmd.len, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> ma=
in(void)</span><br><span> {</span><br><span>@@ -640,6 +674,7 @@</span><br><=
span>         cmocka_unit_test(test_verify_hmac_tls_auth),</span><br><span>=
         cmocka_unit_test(test_generate_reset_packet_plain),</span><br><spa=
n>         cmocka_unit_test(test_generate_reset_packet_tls_auth),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_extract_control_message)</span><br><span>     };</span><br><span> </span><=
br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/672?u=
sp=3Demail">change 672</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47c992b6b73b1475cbff8a28f72=
0cf50dc1fbe3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 672 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Q8DqAW7QhZk=--

