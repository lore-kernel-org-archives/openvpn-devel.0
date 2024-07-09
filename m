From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 9 Jul 2024 13:55:20 +0000
In-Reply-To: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
References: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <ebe3ff90dd733f24ffb36b3cc9a6abba54edc0ee-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dGmenNcPeqg="; charset=UTF-8
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

--dGmenNcPeqg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by cron2, Code-Review-1 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/672/3

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 71b7167..a9f25a5 100644
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
+            struct buffer cmdbuf =3D extract_command_buffer(buf, &gc);

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
index 2ec0b2f..cc23da2 100644
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
+    int buflen =3D (int)strlen(BSTR(buf)) + 1;
+
+    /* Construct a buffer that only holds the current command and
+     * its closing NUL byte */
+    struct buffer cmdbuf =3D alloc_buf_gc(buflen, gc);
+    buf_write(&cmdbuf, BPTR(buf), buflen);
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
+    buf_advance(buf, buflen);
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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--dGmenNcPeqg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2, Code-Review-1 by flichtenheld</p><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">Allow trailing \r and=
 \n in control channel message<br><br>Writing a reason from a script will e=
asily end up adding extra \r\n characters<br>at the end of the reason. Our =
current code pushes this to the peer. So be more<br>liberal in accepting th=
ese message.<br><br>Closes openvpn/openvpn#568<br><br>Change-Id: I47c992b6b=
73b1475cbff8a28f720cf50dc1fbe3e<br>Signed-off-by: Arne Schwabe &lt;arne@...493...=
1227...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/ssl_pkt.c<br=
>M src/openvpn/ssl_pkt.h<br>M tests/unit_tests/openvpn/test_pkt.c<br>4 file=
s changed, 92 insertions(+), 30 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/72/672/3</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/forward.c b/src/openvpn/forward.c</span><br><span>index 71b7167..a9=
f25a5 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>++=
+ b/src/openvpn/forward.c</span><br><span>@@ -290,41 +290,14 @@</span><br><=
span>     struct buffer buf =3D alloc_buf_gc(len, &amp;gc);</span><br><span=
>     if (tls_rec_payload(c-&gt;c2.tls_multi, &amp;buf))</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
         while (BLEN(&amp;buf) &gt; 1)</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            /* commands on the =
control channel are seperated by 0x00 bytes.</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-             * cmdlen does not include the 0 byte of=
 the string */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     int cmdlen =3D (int)strnlen(BSTR(&amp;buf), BLEN(&amp;buf));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            struct buffer cmd=
buf =3D extract_command_buffer(buf, &amp;gc);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            if (cmdlen &lt; BLEN(=
&amp;buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (cmdbuf.len &gt; 0)</span><br><span>             {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                /* include the NUL byte =
and ensure NUL termination */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                int cmdlen =3D (int)strlen(BSTR(&amp;buf)) + 1;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                /* Construct a buffer that onl=
y holds the current command and</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                 * its closing NUL byte */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                struct buffer cmdbuf =3D al=
loc_buf_gc(cmdlen, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                buf_write(&amp;cmdbuf, BPTR(&amp;buf), cmdlen);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                /* check we have only printable=
 characters or null byte in the</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                 * command string and no newlines */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                if (!string_check_=
buf(&amp;buf, CC_PRINT | CC_NULL, CC_CRLF))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    msg(D_PUSH_ERRORS, &quot;WARNING: Rec=
eived control with invalid characters: %s&quot;,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        format_hex(BPTR(&amp;buf=
), BLEN(&amp;buf), 256, &amp;gc));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                else</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    parse_incoming_control_channel_command(c, &amp;cmdb=
uf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                par=
se_incoming_control_channel_command(c, &amp;cmdbuf);</span><br><span>      =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            e=
lse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(D_PUSH=
_ERRORS, &quot;WARNING: Ignoring control channel &quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    &quot;message command=
 without NUL termination&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            buf_advance(&amp;buf, cmdlen);</span><br><span>         }</s=
pan><br><span>     }</span><br><span>     else</span><br><span>diff --git a=
/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c</span><br><span>index 2ec0b2=
f..cc23da2 100644</span><br><span>--- a/src/openvpn/ssl_pkt.c</span><br><sp=
an>+++ b/src/openvpn/ssl_pkt.c</span><br><span>@@ -557,3 +557,43 @@</span><=
br><span>     }</span><br><span>     return false;</span><br><span> }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+struct buffer</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+extract_command_buffer(struct buffer *buf, struct =
gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* commands on the c=
ontrol channel are seperated by 0x00 bytes.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * cmdlen does not include the 0 byte of the st=
ring */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int cmdl=
en =3D (int)strnlen(BSTR(buf), BLEN(buf));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (cmdlen &gt;=3D BLEN(buf))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        buf_advance(buf, cmdlen);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /* Return empty buffer */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct buffer empty =3D { 0 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return empty;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* include the NUL byte and ensure NUL terminatio=
n */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int buflen =
=3D (int)strlen(BSTR(buf)) + 1;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Construct a buffer that only holds the current command and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * its closing NUL byte */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer cmdbuf =
=3D alloc_buf_gc(buflen, gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buf_write(&amp;cmdbuf, BPTR(buf), buflen);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Remove \r and \n at the end of the buffer to avoid=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * problems wit=
h scripts and other that add extra \r and \n */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    buf_chomp(&amp;cmdbuf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* check we have only printable characters or null byt=
e in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * comm=
and string and no newlines */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!string_check_buf(&amp;cmdbuf, CC_PRINT | CC_NULL, CC_CRL=
F))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &qu=
ot;WARNING: Received control with invalid characters: %s&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            format_hex(BPTR(&am=
p;cmdbuf), BLEN(&amp;cmdbuf), 256, gc));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmdbuf.len =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_advance(buf, buflen);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return cmdbuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span>diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_p=
kt.h</span><br><span>index 88b9e8c..c8a27fb 100644</span><br><span>--- a/sr=
c/openvpn/ssl_pkt.h</span><br><span>+++ b/src/openvpn/ssl_pkt.h</span><br><=
span>@@ -230,6 +230,20 @@</span><br><span>                      uint8_t hea=
der,</span><br><span>                      bool request_resend_wkc);</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Extracts a control channel message fro=
m buf and adjusts the size of</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * buf after the message has been extracted</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer the message sh=
ould be extracted from</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param gc    gc_arena to be used for the returned buffer and displayi=
ng</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *              d=
iagnostic messages</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return      A buffer with a control channel message or a buffer with</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *              with le=
ngth 0 if there is no message or the message has</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *              invalid characters.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+struct buffer</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+extract_command_buffer(struct buffer *buf, struct gc=
_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> static inline const char *</span><br><span> packet_opcode_name(i=
nt op)</span><br><span> {</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>index=
 1084d66..741c982 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_pkt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt.c</span><br=
><span>@@ -626,6 +626,40 @@</span><br><span>     free_tas(&amp;tas_server);=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_extract_control_message(void **ut_state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer input_buf =3D alloc_bu=
f_gc(1024, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* This messag=
e will have a \0x00 at the end since it is a C string */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char input[] =3D &quot;valid=
 control message\r\n\0\0Invalid\r\none\0valid one again&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buf_write(&amp;input_buf, input, sizeof(input))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
cmd1 =3D extract_command_buffer(&amp;input_buf, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct buffer cmd2 =3D extract_co=
mmand_buffer(&amp;input_buf, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer cmd3 =3D extract_command_buffer(&amp;i=
nput_buf, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer cmd4 =3D extract_command_buffer(&amp;input_buf, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer c=
md5 =3D extract_command_buffer(&amp;input_buf, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_string_equal(BSTR(&amp;cmd1), &quot;valid cont=
rol message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* empty message with just a \0x00 */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(cmd2.len, 1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(BSTR(&amp;cmd2=
), &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(cmd3.len, 0);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_string_equal(BSTR(&amp;cmd4), &quot;valid one again=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(cmd5.len, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8=
_t nonull[6] =3D { &#39;n&#39;, &#39;o&#39;, &#39; &#39;, &#39;N&#39;, &#39=
;U&#39;, &#39;L&#39;};</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer nonull_buf =3D alloc_buf_gc(1024, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    buf_write(&amp;nonull_buf, nonull, sizeof(non=
ull));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer nonullcmd =3D extract_command_buffer(&amp;nonull_buf, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(nonul=
lcmd.len, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
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
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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


--dGmenNcPeqg=--

