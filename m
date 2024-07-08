From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 8 Jul 2024 10:09:26 +0000
References: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ba2a0b29ea6861e15209726459371e7c8fee990e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="62OrIOf3Omo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Allow trailing \r
 and \n in control channel message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--62OrIOf3Omo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail

to review the following change.


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
---
M src/openvpn/forward.c
1 file changed, 14 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/672/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 71b7167..0f89876 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -290,7 +290,6 @@
     struct buffer buf =3D alloc_buf_gc(len, &gc);
     if (tls_rec_payload(c->c2.tls_multi, &buf))
     {
-
         while (BLEN(&buf) > 1)
         {
             /* commands on the control channel are seperated by 0x00 bytes.
@@ -300,19 +299,28 @@
             if (cmdlen < BLEN(&buf))
             {
                 /* include the NUL byte and ensure NUL termination */
-                int cmdlen =3D (int)strlen(BSTR(&buf)) + 1;
+                int buflen =3D (int)strlen(BSTR(&buf)) + 1;

                 /* Construct a buffer that only holds the current command =
and
                  * its closing NUL byte */
-                struct buffer cmdbuf =3D alloc_buf_gc(cmdlen, &gc);
-                buf_write(&cmdbuf, BPTR(&buf), cmdlen);
+                struct buffer cmdbuf =3D alloc_buf_gc(buflen, &gc);
+                buf_write(&cmdbuf, BPTR(&buf), buflen);
+
+                /* Remove \r and \n at the end of the buffer to avoid
+                 * problems with scripts and other that add extra \r and \=
n */
+                while (BLEN(&cmdbuf)
+                       && (*(BEND(&cmdbuf) - 2) =3D=3D '\r' || *(BEND(&cmd=
buf) - 2)=3D=3D '\n'))
+                {
+                    *(BEND(&cmdbuf) - 2) =3D '\0';
+                    buf_inc_len(&cmdbuf, -1);
+                }

                 /* check we have only printable characters or null byte in=
 the
                  * command string and no newlines */
-                if (!string_check_buf(&buf, CC_PRINT | CC_NULL, CC_CRLF))
+                if (!string_check_buf(&cmdbuf, CC_PRINT | CC_NULL, CC_CRLF=
))
                 {
                     msg(D_PUSH_ERRORS, "WARNING: Received control with inv=
alid characters: %s",
-                        format_hex(BPTR(&buf), BLEN(&buf), 256, &gc));
+                        format_hex(BPTR(&buf), BLEN(&cmdbuf), 256, &gc));
                 }
                 else
                 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e
Gerrit-Change-Number: 672
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--62OrIOf3Omo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Allow trailing \r and \n in control channel message<br><br>Wr=
iting a reason from a script will easily end up adding extra \r\n character=
s<br>at the end of the reason. Our current code pushes this to the peer. So=
 be more<br>liberal in accepting these message.<br><br>Closes openvpn/openv=
pn#568<br><br>Change-Id: I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e<br>---<b=
r>M src/openvpn/forward.c<br>1 file changed, 14 insertions(+), 6 deletions(=
-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/7=
2/672/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c<=
/span><br><span>index 71b7167..0f89876 100644</span><br><span>--- a/src/ope=
nvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>=
@@ -290,7 +290,6 @@</span><br><span>     struct buffer buf =3D alloc_buf_gc=
(len, &amp;gc);</span><br><span>     if (tls_rec_payload(c-&gt;c2.tls_multi=
, &amp;buf))</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span>         while (BLEN(&amp;buf) &gt; 1)</span=
><br><span>         {</span><br><span>             /* commands on the contr=
ol channel are seperated by 0x00 bytes.</span><br><span>@@ -300,19 +299,28 =
@@</span><br><span>             if (cmdlen &lt; BLEN(&amp;buf))</span><br><=
span>             {</span><br><span>                 /* include the NUL byt=
e and ensure NUL termination */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                int cmdlen =3D (int)strlen(BSTR(&amp;buf)) + 1;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                int b=
uflen =3D (int)strlen(BSTR(&amp;buf)) + 1;</span><br><span> </span><br><spa=
n>                 /* Construct a buffer that only holds the current comman=
d and</span><br><span>                  * its closing NUL byte */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                struct buffer c=
mdbuf =3D alloc_buf_gc(cmdlen, &amp;gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                buf_write(&amp;cmdbuf, BPTR(&amp;buf), c=
mdlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    struct buffer cmdbuf =3D alloc_buf_gc(buflen, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                buf_write(&amp;cmdb=
uf, BPTR(&amp;buf), buflen);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      /* Remove \r and \n at the end of the buffer to avoid</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                 * problems with sc=
ripts and other that add extra \r and \n */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                while (BLEN(&amp;cmdbuf)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                       &amp;&a=
mp; (*(BEND(&amp;cmdbuf) - 2) =3D=3D &#39;\r&#39; || *(BEND(&amp;cmdbuf) - =
2)=3D=3D &#39;\n&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    *(BEND(&amp;cmdbuf) - 2) =3D &#39;\0&#39;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    buf_inc_le=
n(&amp;cmdbuf, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                }</span><br><span> </span><br><span>                 /* che=
ck we have only printable characters or null byte in the</span><br><span>  =
                * command string and no newlines */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                if (!string_check_buf(&amp;=
buf, CC_PRINT | CC_NULL, CC_CRLF))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                if (!string_check_buf(&amp;cmdbuf, CC_PRINT =
| CC_NULL, CC_CRLF))</span><br><span>                 {</span><br><span>   =
                  msg(D_PUSH_ERRORS, &quot;WARNING: Received control with i=
nvalid characters: %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                        format_hex(BPTR(&amp;buf), BLEN(&amp;buf), 2=
56, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   format_hex(BPTR(&amp;buf), BLEN(&amp;cmdbuf), 256, &amp;=
gc));</span><br><span>                 }</span><br><span>                 e=
lse</span><br><span>                 {</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/672?usp=3De=
mail">change 672</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47c992b6b73b1475cbff8a28f72=
0cf50dc1fbe3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 672 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--62OrIOf3Omo=--

