From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 8 Jul 2024 16:18:06 +0000
In-Reply-To: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
References: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <5264fd13b301501f749e875e1ac991de423cd26e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uJo9IpBeT20="; charset=UTF-8
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

--uJo9IpBeT20=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail

to look at the new patch set (#2).

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
1 file changed, 9 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/672/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 71b7167..943ed11 100644
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
@@ -300,19 +299,23 @@
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
+                buf_chomp(&cmdbuf);

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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--uJo9IpBeT20=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Allow trailing \r and \n in control channel m=
essage<br><br>Writing a reason from a script will easily end up adding extr=
a \r\n characters<br>at the end of the reason. Our current code pushes this=
 to the peer. So be more<br>liberal in accepting these message.<br><br>Clos=
es openvpn/openvpn#568<br><br>Change-Id: I47c992b6b73b1475cbff8a28f720cf50d=
c1fbe3e<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M =
src/openvpn/forward.c<br>1 file changed, 9 insertions(+), 6 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/672=
/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span=
><br><span>index 71b7167..943ed11 100644</span><br><span>--- a/src/openvpn/=
forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -2=
90,7 +290,6 @@</span><br><span>     struct buffer buf =3D alloc_buf_gc(len,=
 &amp;gc);</span><br><span>     if (tls_rec_payload(c-&gt;c2.tls_multi, &am=
p;buf))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span>         while (BLEN(&amp;buf) &gt; 1)</span><br>=
<span>         {</span><br><span>             /* commands on the control ch=
annel are seperated by 0x00 bytes.</span><br><span>@@ -300,19 +299,23 @@</s=
pan><br><span>             if (cmdlen &lt; BLEN(&amp;buf))</span><br><span>=
             {</span><br><span>                 /* include the NUL byte and=
 ensure NUL termination */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                int cmdlen =3D (int)strlen(BSTR(&amp;buf)) + 1;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                int buflen=
 =3D (int)strlen(BSTR(&amp;buf)) + 1;</span><br><span> </span><br><span>   =
              /* Construct a buffer that only holds the current command and=
</span><br><span>                  * its closing NUL byte */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                struct buffer cmdbuf=
 =3D alloc_buf_gc(cmdlen, &amp;gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                buf_write(&amp;cmdbuf, BPTR(&amp;buf), cmdlen=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                s=
truct buffer cmdbuf =3D alloc_buf_gc(buflen, &amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                buf_write(&amp;cmdbuf, B=
PTR(&amp;buf), buflen);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 /* Remove \r and \n at the end of the buffer to avoid</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                 * problems with scripts=
 and other that add extra \r and \n */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                buf_chomp(&amp;cmdbuf);</span><br><span>=
 </span><br><span>                 /* check we have only printable characte=
rs or null byte in the</span><br><span>                  * command string a=
nd no newlines */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            if (!string_check_buf(&amp;buf, CC_PRINT | CC_NULL, CC_CRLF))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (!=
string_check_buf(&amp;cmdbuf, CC_PRINT | CC_NULL, CC_CRLF))</span><br><span=
>                 {</span><br><span>                     msg(D_PUSH_ERRORS,=
 &quot;WARNING: Received control with invalid characters: %s&quot;,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        forma=
t_hex(BPTR(&amp;buf), BLEN(&amp;buf), 256, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        format_hex(BPTR(&=
amp;buf), BLEN(&amp;cmdbuf), 256, &amp;gc));</span><br><span>              =
   }</span><br><span>                 else</span><br><span>                =
 {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/672?usp=3Demail">change 672</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/672?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47c992b6b73b1475cbff8a28f72=
0cf50dc1fbe3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 672 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--uJo9IpBeT20=--

