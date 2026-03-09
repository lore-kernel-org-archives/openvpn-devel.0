From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 9 Mar 2026 16:29:14 +0000
References: <gerrit.1773073753000.Ie0b94b596637d660392bc4eda48d16cfecfeb971@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6b9018bd610dfa2705c0d984a32a0e739aaead46-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WIG941kFxTw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: Avoid
 sign-compare warnings
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

--WIG941kFxTw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1562?usp=3Demail

to review the following change.


Change subject: init: Avoid sign-compare warnings
......................................................................

init: Avoid sign-compare warnings

- Use BLENZ instead of buf_len where applicable
- Fix some comparisons with ce list length

Change-Id: Ie0b94b596637d660392bc4eda48d16cfecfeb971
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/init.c
1 file changed, 6 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/1562/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 34ed4eb..66a5836 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -325,11 +325,6 @@
     return l->len;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static bool
 management_callback_remote_entry_get(void *arg, unsigned int index, char *=
*remote)
 {
@@ -340,7 +335,7 @@
     struct connection_list *l =3D c->options.connection_list;
     bool ret =3D true;

-    if (index < l->len)
+    if (l->len > 0 && index < (unsigned int)l->len)
     {
         struct connection_entry *ce =3D l->array[index];
         const char *proto =3D proto2ascii(ce->proto, ce->af, false);
@@ -364,10 +359,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static bool
 management_callback_remote_cmd(void *arg, const char **p)
 {
@@ -466,7 +457,6 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
-#pragma GCC diagnostic ignored "-Wsign-compare"
 #endif

 /*
@@ -638,8 +628,8 @@
     } while (!ce_defined);

     /* Check if this connection attempt would bring us over the limit */
-    if (c->options.connect_retry_max > 0
-        && c->options.unsuccessful_attempts > (l->len * c->options.connect=
_retry_max))
+    int max_attempts =3D l->len * c->options.connect_retry_max;
+    if (max_attempts > 0 && c->options.unsuccessful_attempts > (unsigned i=
nt)max_attempts)
     {
         msg(M_FATAL, "All connections have been connect-retry-max (%d) tim=
es unsuccessful, exiting",
             c->options.connect_retry_max);
@@ -2176,7 +2166,7 @@
 static void
 add_delim_if_non_empty(struct buffer *buf, const char *header)
 {
-    if (buf_len(buf) > strlen(header))
+    if (BLENZ(buf) > strlen(header))
     {
         buf_printf(buf, ", ");
     }
@@ -2264,7 +2254,7 @@
         buf_printf(&out, "session-timeout %d", o->session_timeout);
     }

-    if (buf_len(&out) > strlen(header))
+    if (BLENZ(&out) > strlen(header))
     {
         msg(D_HANDSHAKE, "%s", BSTR(&out));
     }
@@ -2301,7 +2291,7 @@
         }
     }

-    if (buf_len(&out) > strlen(header))
+    if (BLENZ(&out) > strlen(header))
     {
         msg(D_HANDSHAKE, "%s", BSTR(&out));
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1562?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0b94b596637d660392bc4eda48d16cfecfeb971
Gerrit-Change-Number: 1562
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--WIG941kFxTw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1562?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">init: Avoid sign-compare warnings<br><br>- =
Use BLENZ instead of buf_len where applicable<br>- Fix some comparisons wit=
h ce list length<br><br>Change-Id: Ie0b94b596637d660392bc4eda48d16cfecfeb97=
1<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M =
src/openvpn/init.c<br>1 file changed, 6 insertions(+), 16 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/62/1562/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/in=
it.c</span><br><span>index 34ed4eb..66a5836 100644</span><br><span>--- a/sr=
c/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@=
@ -325,11 +325,6 @@</span><br><span>     return l-&gt;len;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-comp=
are&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bo=
ol</span><br><span> management_callback_remote_entry_get(void *arg, unsigne=
d int index, char **remote)</span><br><span> {</span><br><span>@@ -340,7 +3=
35,7 @@</span><br><span>     struct connection_list *l =3D c-&gt;options.co=
nnection_list;</span><br><span>     bool ret =3D true;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (index &lt; l-&gt=
;len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (l-&gt;=
len &gt; 0 &amp;&amp; index &lt; (unsigned int)l-&gt;len)</span><br><span> =
    {</span><br><span>         struct connection_entry *ce =3D l-&gt;array[=
index];</span><br><span>         const char *proto =3D proto2ascii(ce-&gt;p=
roto, ce-&gt;af, false);</span><br><span>@@ -364,10 +359,6 @@</span><br><sp=
an>     return ret;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static boo=
l</span><br><span> management_callback_remote_cmd(void *arg, const char **p=
)</span><br><span> {</span><br><span>@@ -466,7 +457,6 @@</span><br><span> #=
if defined(__GNUC__) || defined(__clang__)</span><br><span> #pragma GCC dia=
gnostic push</span><br><span> #pragma GCC diagnostic ignored &quot;-Wconver=
sion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span> #endif</spa=
n><br><span> </span><br><span> /*</span><br><span>@@ -638,8 +628,8 @@</span=
><br><span>     } while (!ce_defined);</span><br><span> </span><br><span>  =
   /* Check if this connection attempt would bring us over the limit */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;options.con=
nect_retry_max &gt; 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        &amp;&amp; c-&gt;options.unsuccessful_attempts &gt; (l-&gt;len * c-=
&gt;options.connect_retry_max))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int max_attempts =3D l-&gt;len * c-&gt;options.connect_retr=
y_max;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (max_a=
ttempts &gt; 0 &amp;&amp; c-&gt;options.unsuccessful_attempts &gt; (unsigne=
d int)max_attempts)</span><br><span>     {</span><br><span>         msg(M_F=
ATAL, &quot;All connections have been connect-retry-max (%d) times unsucces=
sful, exiting&quot;,</span><br><span>             c-&gt;options.connect_ret=
ry_max);</span><br><span>@@ -2176,7 +2166,7 @@</span><br><span> static void=
</span><br><span> add_delim_if_non_empty(struct buffer *buf, const char *he=
ader)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (buf_len(buf) &gt; strlen(header))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (BLENZ(buf) &gt; strlen(header))</span><br>=
<span>     {</span><br><span>         buf_printf(buf, &quot;, &quot;);</spa=
n><br><span>     }</span><br><span>@@ -2264,7 +2254,7 @@</span><br><span>  =
       buf_printf(&amp;out, &quot;session-timeout %d&quot;, o-&gt;session_t=
imeout);</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (buf_len(&amp;out) &gt; strlen(header))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(&amp;o=
ut) &gt; strlen(header))</span><br><span>     {</span><br><span>         ms=
g(D_HANDSHAKE, &quot;%s&quot;, BSTR(&amp;out));</span><br><span>     }</spa=
n><br><span>@@ -2301,7 +2291,7 @@</span><br><span>         }</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (buf_len(&amp;out) &gt; strlen(header))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(&amp;out) &gt; strlen(heade=
r))</span><br><span>     {</span><br><span>         msg(D_HANDSHAKE, &quot;=
%s&quot;, BSTR(&amp;out));</span><br><span>     }</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1562?usp=3Demail">change 1562</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/156=
2?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0b94b596637d660392bc4eda48=
d16cfecfeb971 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1562 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--WIG941kFxTw=--

