From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 17 Nov 2025 07:44:25 +0000
In-Reply-To: <gerrit.1761324750000.Id7bacec23edc6dcd94465c308ea2144c7329a0c1@...2715...>
References: <gerrit.1761324750000.Id7bacec23edc6dcd94465c308ea2144c7329a0c1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a00072577f9bbc8573076ef62fd1c6118629b941-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HpN7nj+sFBU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Clean up type
 handling in export_user_keying_material()
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

--HpN7nj+sFBU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1301?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: ssl: Clean up type handling in export_user_keying_material()
......................................................................

ssl: Clean up type handling in export_user_keying_material()

For this we actually change the API of the
format_hex{,_ex} functions by changing int
to size_t for length parameters. While we
call this function with int paramters in
a lot of places (usually BLEN), this will
not produce warnings under
-Wno-sign-conversion. And we're sure those
values are positive since format_hex already
uses size_t internally.

Change-Id: Id7bacec23edc6dcd94465c308ea2144c7329a0c1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1301
Message-Id: <20251030145231.2792-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
036.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/ssl.c
3 files changed, 12 insertions(+), 13 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/1301/7

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 28de00f..293622f 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -480,18 +480,17 @@
  */

 char *
-format_hex_ex(const uint8_t *data, int size, int maxoutput, unsigned int s=
pace_break_flags,
+format_hex_ex(const uint8_t *data, size_t size, size_t maxoutput, unsigned=
 int space_break_flags,
               const char *separator, struct gc_arena *gc)
 {
     const size_t bytes_per_hexblock =3D space_break_flags & FHE_SPACE_BREA=
K_MASK;
     const size_t separator_len =3D separator ? strlen(separator) : 0;
-    static_assert(INT_MAX <=3D SIZE_MAX, "Code assumes INT_MAX <=3D SIZE_M=
AX");
     const size_t out_len =3D maxoutput > 0
                                ? maxoutput
                                : ((size * 2) + ((size / bytes_per_hexblock=
) * separator_len) + 2);

     struct buffer out =3D alloc_buf_gc(out_len, gc);
-    for (int i =3D 0; i < size; ++i)
+    for (size_t i =3D 0; i < size; ++i)
     {
         if (separator && i && !(i % bytes_per_hexblock))
         {
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 148cee0..ab2a29d 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -496,11 +496,11 @@
  */
 #define FHE_SPACE_BREAK_MASK 0xFF  /* space_break parameter in lower 8 bit=
s */
 #define FHE_CAPS             0x100 /* output hex in caps */
-char *format_hex_ex(const uint8_t *data, int size, int maxoutput, unsigned=
 int space_break_flags,
+char *format_hex_ex(const uint8_t *data, size_t size, size_t maxoutput, un=
signed int space_break_flags,
                     const char *separator, struct gc_arena *gc);

 static inline char *
-format_hex(const uint8_t *data, int size, int maxoutput, struct gc_arena *=
gc)
+format_hex(const uint8_t *data, size_t size, size_t maxoutput, struct gc_a=
rena *gc)
 {
     return format_hex_ex(data, size, maxoutput, 4, " ", gc);
 }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 22a1f52..4841837 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1829,11 +1829,6 @@
     return len;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static char *
 read_string_alloc(struct buffer *buf)
 {
@@ -2174,15 +2169,15 @@
 {
     if (session->opt->ekm_size > 0)
     {
-        unsigned int size =3D session->opt->ekm_size;
+        const size_t size =3D session->opt->ekm_size;
         struct gc_arena gc =3D gc_new();

-        unsigned char *ekm =3D gc_malloc(session->opt->ekm_size, true, &gc=
);
+        unsigned char *ekm =3D gc_malloc(size, true, &gc);
         if (key_state_export_keying_material(session, session->opt->ekm_la=
bel,
                                              session->opt->ekm_label_size,=
 ekm,
                                              session->opt->ekm_size))
         {
-            unsigned int len =3D (size * 2) + 2;
+            const size_t len =3D (size * 2) + 2;

             const char *key =3D format_hex_ex(ekm, size, len, 0, NULL, &gc=
);
             setenv_str(session->opt->es, "exported_keying_material", key);
@@ -2199,6 +2194,11 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /**
  * Handle reading key data, peer-info, username/password, OCC
  * from the TLS control channel (cleartext).

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1301?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id7bacec23edc6dcd94465c308ea2144c7329a0c1
Gerrit-Change-Number: 1301
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HpN7nj+sFBU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #7</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1301?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">ssl: Clean up type handling in expo=
rt_user_keying_material()<br><br>For this we actually change the API of the=
<br>format_hex{,_ex} functions by changing int<br>to size_t for length para=
meters. While we<br>call this function with int paramters in<br>a lot of pl=
aces (usually BLEN), this will<br>not produce warnings under<br>-Wno-sign-c=
onversion. And we&#39;re sure those<br>values are positive since format_hex=
 already<br>uses size_t internally.<br><br>Change-Id: Id7bacec23edc6dcd9446=
5c308ea2144c7329a0c1<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2724...=
..&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: htt=
ps://gerrit.openvpn.net/c/openvpn/+/1301<br>Message-Id: &lt;20251030145231.=
2792-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-dev=
el@lists.sourceforge.net/msg34036.html<br>Signed-off-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>---<br>M src/openvpn/buffer.c<br>M src/openvpn/buffer=
.h<br>M src/openvpn/ssl.c<br>3 files changed, 12 insertions(+), 13 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/01/1301/7</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer.c b/src=
/openvpn/buffer.c</span><br><span>index 28de00f..293622f 100644</span><br><=
span>--- a/src/openvpn/buffer.c</span><br><span>+++ b/src/openvpn/buffer.c<=
/span><br><span>@@ -480,18 +480,17 @@</span><br><span>  */</span><br><span>=
 </span><br><span> char *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-format_hex_ex(const uint8_t *data, int size, int maxoutput, unsigned in=
t space_break_flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+format_hex_ex(const uint8_t *data, size_t size, size_t maxoutput, unsigned=
 int space_break_flags,</span><br><span>               const char *separato=
r, struct gc_arena *gc)</span><br><span> {</span><br><span>     const size_=
t bytes_per_hexblock =3D space_break_flags &amp; FHE_SPACE_BREAK_MASK;</spa=
n><br><span>     const size_t separator_len =3D separator ? strlen(separato=
r) : 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static_ass=
ert(INT_MAX &lt;=3D SIZE_MAX, &quot;Code assumes INT_MAX &lt;=3D SIZE_MAX&q=
uot;);</span><br><span>     const size_t out_len =3D maxoutput &gt; 0</span=
><br><span>                                ? maxoutput</span><br><span>    =
                            : ((size * 2) + ((size / bytes_per_hexblock) * =
separator_len) + 2);</span><br><span> </span><br><span>     struct buffer o=
ut =3D alloc_buf_gc(out_len, gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    for (int i =3D 0; i &lt; size; ++i)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; size; ++i=
)</span><br><span>     {</span><br><span>         if (separator &amp;&amp; =
i &amp;&amp; !(i % bytes_per_hexblock))</span><br><span>         {</span><b=
r><span>diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h</span><br>=
<span>index 148cee0..ab2a29d 100644</span><br><span>--- a/src/openvpn/buffe=
r.h</span><br><span>+++ b/src/openvpn/buffer.h</span><br><span>@@ -496,11 +=
496,11 @@</span><br><span>  */</span><br><span> #define FHE_SPACE_BREAK_MAS=
K 0xFF  /* space_break parameter in lower 8 bits */</span><br><span> #defin=
e FHE_CAPS             0x100 /* output hex in caps */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-char *format_hex_ex(const uint8_t *data, in=
t size, int maxoutput, unsigned int space_break_flags,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+char *format_hex_ex(const uint8_t *data,=
 size_t size, size_t maxoutput, unsigned int space_break_flags,</span><br><=
span>                     const char *separator, struct gc_arena *gc);</spa=
n><br><span> </span><br><span> static inline char *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-format_hex(const uint8_t *data, int size, i=
nt maxoutput, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+format_hex(const uint8_t *data, size_t size, size_t maxoutpu=
t, struct gc_arena *gc)</span><br><span> {</span><br><span>     return form=
at_hex_ex(data, size, maxoutput, 4, &quot; &quot;, gc);</span><br><span> }<=
/span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><b=
r><span>index 22a1f52..4841837 100644</span><br><span>--- a/src/openvpn/ssl=
.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -1829,11 +182=
9,6 @@</span><br><span>     return len;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> static char *</span><br><span>=
 read_string_alloc(struct buffer *buf)</span><br><span> {</span><br><span>@=
@ -2174,15 +2169,15 @@</span><br><span> {</span><br><span>     if (session-=
&gt;opt-&gt;ekm_size &gt; 0)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        unsigned int size =3D session-&gt;o=
pt-&gt;ekm_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     const size_t size =3D session-&gt;opt-&gt;ekm_size;</span><br><span>  =
       struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        unsigned char *ekm =3D gc_mallo=
c(session-&gt;opt-&gt;ekm_size, true, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        unsigned char *ekm =3D gc_malloc(size, =
true, &amp;gc);</span><br><span>         if (key_state_export_keying_materi=
al(session, session-&gt;opt-&gt;ekm_label,</span><br><span>                =
                              session-&gt;opt-&gt;ekm_label_size, ekm,</spa=
n><br><span>                                              session-&gt;opt-&=
gt;ekm_size))</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            unsigned int len =3D (size * 2) + 2;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            const size_t le=
n =3D (size * 2) + 2;</span><br><span> </span><br><span>             const =
char *key =3D format_hex_ex(ekm, size, len, 0, NULL, &amp;gc);</span><br><s=
pan>             setenv_str(session-&gt;opt-&gt;es, &quot;exported_keying_m=
aterial&quot;, key);</span><br><span>@@ -2199,6 +2194,11 @@</span><br><span=
>     }</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pus=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagno=
stic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /**</span><br><span>  * Handle reading key data, pee=
r-info, username/password, OCC</span><br><span>  * from the TLS control cha=
nnel (cleartext).</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1301?usp=3Demail">change 1301</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1301?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id7bacec23edc6dcd94465c308ea=
2144c7329a0c1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1301 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--HpN7nj+sFBU=--

