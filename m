From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 10 Jul 2024 13:50:44 +0000
In-Reply-To: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
References: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <4ce80a73ef325b7ee7337d00e4385bcb82842e4c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kFGtHeJ+N5s="; charset=UTF-8
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
To: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kFGtHeJ+N5s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Allow trailing \r and \n in control channel message
......................................................................

Allow trailing \r and \n in control channel message

Writing a reason from a script will easily end up adding extra \r\n charact=
ers
at the end of the reason. Our current code pushes this to the peer. So be m=
ore
liberal in accepting these message.

Closes openvpn/openvpn#568

Change-Id: I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/forward.c
M src/openvpn/ssl_pkt.c
M src/openvpn/ssl_pkt.h
M tests/unit_tests/openvpn/test_pkt.c
4 files changed, 92 insertions(+), 30 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/672/4

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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--kFGtHeJ+N5s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Allow trailing \r and \n in control channel m=
essage<br><br>Writing a reason from a script will easily end up adding extr=
a \r\n characters<br>at the end of the reason. Our current code pushes this=
 to the peer. So be more<br>liberal in accepting these message.<br><br>Clos=
es openvpn/openvpn#568<br><br>Change-Id: I47c992b6b73b1475cbff8a28f720cf50d=
c1fbe3e<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M =
src/openvpn/forward.c<br>M src/openvpn/ssl_pkt.c<br>M src/openvpn/ssl_pkt.h=
<br>M tests/unit_tests/openvpn/test_pkt.c<br>4 files changed, 92 insertions=
(+), 30 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/72/672/4</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/=
openvpn/forward.c</span><br><span>index 71b7167..40b7cc4 100644</span><br><=
span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.=
c</span><br><span>@@ -290,41 +290,14 @@</span><br><span>     struct buffer =
buf =3D alloc_buf_gc(len, &amp;gc);</span><br><span>     if (tls_rec_payloa=
d(c-&gt;c2.tls_multi, &amp;buf))</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         while (BLEN(&am=
p;buf) &gt; 1)</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            /* commands on the control channel are sepe=
rated by 0x00 bytes.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
            * cmdlen does not include the 0 byte of the string */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            int cmdlen =3D (int=
)strnlen(BSTR(&amp;buf), BLEN(&amp;buf));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            struct buffer cmdbuf =3D extract_command_=
buffer(&amp;buf, &amp;gc);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            if (cmdlen &lt; BLEN(&amp;buf))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (cmdbuf.len &=
gt; 0)</span><br><span>             {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                /* include the NUL byte and ensure NUL term=
ination */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     int cmdlen =3D (int)strlen(BSTR(&amp;buf)) + 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                /* Construct a buffer that only holds the curren=
t command and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
         * its closing NUL byte */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                struct buffer cmdbuf =3D alloc_buf_gc(cmdlen, =
&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    buf_write(&amp;cmdbuf, BPTR(&amp;buf), cmdlen);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                /* check we have only printable characters or nu=
ll byte in the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
          * command string and no newlines */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                if (!string_check_buf(&amp;buf, CC_=
PRINT | CC_NULL, CC_CRLF))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    msg(D_PUSH_ERRORS, &quot;WARNING: Received control wit=
h invalid characters: %s&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                        format_hex(BPTR(&amp;buf), BLEN(&amp;buf)=
, 256, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       parse_incoming_control_channel_command(c, &amp;cmdbuf);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                parse_incoming_contr=
ol_channel_command(c, &amp;cmdbuf);</span><br><span>             }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                msg(D_PUSH_ERRORS, &quot;WA=
RNING: Ignoring control channel &quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    &quot;message command without NUL term=
ination&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            bu=
f_advance(&amp;buf, cmdlen);</span><br><span>         }</span><br><span>   =
  }</span><br><span>     else</span><br><span>diff --git a/src/openvpn/ssl_=
pkt.c b/src/openvpn/ssl_pkt.c</span><br><span>index 2ec0b2f..689cd7f 100644=
</span><br><span>--- a/src/openvpn/ssl_pkt.c</span><br><span>+++ b/src/open=
vpn/ssl_pkt.c</span><br><span>@@ -557,3 +557,43 @@</span><br><span>     }</=
span><br><span>     return false;</span><br><span> }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+struct buffer</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+extract_command_buffer(struct buffer *buf, struct gc_arena *gc)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* commands on the control channel a=
re seperated by 0x00 bytes.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * cmdlen does not include the 0 byte of the string */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int cmdlen =3D (int)strn=
len(BSTR(buf), BLEN(buf));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cmdl=
en &gt;=3D BLEN(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_=
advance(buf, cmdlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* Return empty buffer */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct buffer empty =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return empty;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* include the NUL byte and ensure NUL termination */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    cmdlen +=3D  1;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Construct a buffer that only holds the curren=
t command and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 its closing NUL byte */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer cmdbuf =3D alloc_buf_gc(cmdlen, gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;cmdbuf, BPTR(buf=
), cmdlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Remove \r and \n at =
the end of the buffer to avoid</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * problems with scripts and other that add extra \r and \n =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_chomp(&am=
p;cmdbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* check we have only pr=
intable characters or null byte in the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * command string and no newlines */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!string_check_buf(&amp;cmdb=
uf, CC_PRINT | CC_NULL, CC_CRLF))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(D_PUSH_ERRORS, &quot;WARNING: Received control with invalid cha=
racters: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           format_hex(BPTR(&amp;cmdbuf), BLEN(&amp;cmdbuf), 256, gc));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmdbuf.len =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buf_advance(buf, cmdlen);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return cmdbuf;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvp=
n/ssl_pkt.h b/src/openvpn/ssl_pkt.h</span><br><span>index 88b9e8c..c8a27fb =
100644</span><br><span>--- a/src/openvpn/ssl_pkt.h</span><br><span>+++ b/sr=
c/openvpn/ssl_pkt.h</span><br><span>@@ -230,6 +230,20 @@</span><br><span>  =
                    uint8_t header,</span><br><span>                      b=
ool request_resend_wkc);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Extracts =
a control channel message from buf and adjusts the size of</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * buf after the message has been ex=
tracted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param bu=
f   The buffer the message should be extracted from</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param gc    gc_arena to be used for t=
he returned buffer and displaying</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *              diagnostic messages</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return      A buffer with a control chann=
el message or a buffer with</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *              with length 0 if there is no message or the message=
 has</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
 invalid characters.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+extract_command_buffe=
r(struct buffer *buf, struct gc_arena *gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> static inline const char *</span>=
<br><span> packet_opcode_name(int op)</span><br><span> {</span><br><span>di=
ff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/t=
est_pkt.c</span><br><span>index 1084d66..741c982 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/test_pkt.c</span><br><span>+++ b/tests/unit_tes=
ts/openvpn/test_pkt.c</span><br><span>@@ -626,6 +626,40 @@</span><br><span>=
     free_tas(&amp;tas_server);</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_extract_control_message(void =
**ut_state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t buffer input_buf =3D alloc_buf_gc(1024, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* This message will have a \0x00 at the end since it is=
 a C string */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char input[] =3D &quot;valid control message\r\n\0\0Invalid\r\none\0va=
lid one again&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp=
;input_buf, input, sizeof(input));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer cmd1 =3D extract_command_buffer(&amp;input=
_buf, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer cmd2 =3D extract_command_buffer(&amp;input_buf, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer cmd3 =
=3D extract_command_buffer(&amp;input_buf, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer cmd4 =3D extract_comman=
d_buffer(&amp;input_buf, &amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer cmd5 =3D extract_command_buffer(&amp;input=
_buf, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal=
(BSTR(&amp;cmd1), &quot;valid control message&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* empty message with just a \0x00 */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(cmd2.len, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_string_equal(BSTR(&amp;cmd2), &quot;&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(cmd3.len, 0);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(BS=
TR(&amp;cmd4), &quot;valid one again&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(cmd5.len, 0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const uint8_t nonull[6] =3D { &#39;n&#39;, &#39;o&=
#39;, &#39; &#39;, &#39;N&#39;, &#39;U&#39;, &#39;L&#39;};</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer nonull_buf =3D all=
oc_buf_gc(1024, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write=
(&amp;nonull_buf, nonull, sizeof(nonull));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer nonullcmd =3D extract_command_buff=
er(&amp;nonull_buf, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(nonullcmd.len, 0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> int</span><br><span> main(void)</span><br><span> {</span><br><=
span>@@ -640,6 +674,7 @@</span><br><span>         cmocka_unit_test(test_ver=
ify_hmac_tls_auth),</span><br><span>         cmocka_unit_test(test_generate=
_reset_packet_plain),</span><br><span>         cmocka_unit_test(test_genera=
te_reset_packet_tls_auth),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        cmocka_unit_test(test_extract_control_message)</span><br><sp=
an>     };</span><br><span> </span><br><span> #if defined(ENABLE_CRYPTO_OPE=
NSSL)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail">change 672</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/672?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47c992b6b73b1475cbff8a28f72=
0cf50dc1fbe3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 672 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--kFGtHeJ+N5s=--

