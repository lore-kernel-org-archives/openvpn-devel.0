From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 19 Oct 2023 16:58:42 +0000
In-Reply-To: <gerrit.1683717398000.Ic996eca227d9e68279a454db93fcbc86a7bd0380@...2715...>
References: <gerrit.1683717398000.Ic996eca227d9e68279a454db93fcbc86a7bd0380@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <55aae1b6c1a669f1a9dc54b0f24e10640bdc4a6e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rj+nzlbHAbg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mss/mtu: make all
 size calculations use size_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, plaisthos <arne-openvpn@...1227...>

--rj+nzlbHAbg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/26=
9?usp=3Demail )

Change subject: mss/mtu: make all size calculations use size_t
......................................................................

mss/mtu: make all size calculations use size_t

Half of them used unsigned int, the other half size_t.
Standardize on one. Could've also standardized on the
other, both are much too big for the expected numbers
anyway.

Add a new utility function clamp_size_to_int for
cases we need to change from size_t to int (there
are a lot of those all over our codebase).

Resolves some -Wconversion warnings.

Change-Id: Ic996eca227d9e68279a454db93fcbc86a7bd0380
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20231008104022.20200-1-frank@...2641...>
URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20231008104022.20200-1=
-frank@...2641...
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/integer.h
M src/openvpn/mss.c
M src/openvpn/mtu.c
3 files changed, 21 insertions(+), 14 deletions(-)




diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 215c159..a012524 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -36,6 +36,13 @@
                    ((uint64_t)ntohl((x) & 0xFFFFFFFF) << 32) | ntohl((x) >=
> 32))
 #endif

+static inline int
+clamp_size_to_int(size_t size)
+{
+    ASSERT(size <=3D INT_MAX);
+    return (int)size;
+}
+
 /*
  * min/max functions
  */
@@ -188,8 +195,8 @@
 /**
  * Rounds down num to the nearest multiple of multiple
  */
-static inline unsigned int
-round_down_uint(unsigned int num, unsigned int multiple)
+static inline size_t
+round_down_size(size_t num, size_t multiple)
 {
     return (num / multiple) * multiple;
 }
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 4227047..1566c64 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -207,8 +207,8 @@
     }
 }
=20
-static inline unsigned int
-adjust_payload_max_cbc(const struct key_type *kt, unsigned int target)
+static inline size_t
+adjust_payload_max_cbc(const struct key_type *kt, size_t target)
 {
     if (!cipher_kt_mode_cbc(kt->cipher))
     {
@@ -221,13 +221,13 @@
         /* With CBC we need at least one extra byte for padding and then n=
eed
          * to ensure that the resulting CBC ciphertext length, which is al=
ways
          * a multiple of the block size, is not larger than the target val=
ue */
-        unsigned int block_size =3D cipher_kt_block_size(kt->cipher);
-        target =3D round_down_uint(target, block_size);
+        size_t block_size =3D cipher_kt_block_size(kt->cipher);
+        target =3D round_down_size(target, block_size);
         return target - 1;
     }
 }

-static unsigned int
+static size_t
 get_ip_encap_overhead(const struct options *options,
                       const struct link_socket_info *lsi)
 {
@@ -258,7 +258,7 @@
                          struct link_socket_info *lsi)
 {
 #if defined(ENABLE_FRAGMENT)
-    unsigned int overhead;
+    size_t overhead;

     overhead =3D frame_calculate_protocol_header_size(kt, options, false);

@@ -267,12 +267,12 @@
         overhead +=3D get_ip_encap_overhead(options, lsi);
     }

-    unsigned int target =3D options->ce.fragment - overhead;
+    size_t target =3D options->ce.fragment - overhead;
     /* The 4 bytes of header that fragment adds itself. The other extra pa=
yload
      * bytes (Ethernet header/compression) are handled by the fragment code
      * just as part of the payload and therefore automatically taken into
      * account if the packet needs to fragmented */
-    frame->max_fragment_size =3D adjust_payload_max_cbc(kt, target) - 4;
+    frame->max_fragment_size =3D clamp_size_to_int(adjust_payload_max_cbc(=
kt, target)) - 4;

     if (cipher_kt_mode_cbc(kt->cipher))
     {
@@ -296,7 +296,7 @@
         return;
     }

-    unsigned int overhead, payload_overhead;
+    size_t overhead, payload_overhead;

     overhead =3D frame_calculate_protocol_header_size(kt, options, false);

@@ -325,7 +325,7 @@
      * by ce.mssfix */

     /* This is the target value our payload needs to be smaller */
-    unsigned int target =3D options->ce.mssfix - overhead;
+    size_t target =3D options->ce.mssfix - overhead;
     frame->mss_fix =3D (uint16_t)(adjust_payload_max_cbc(kt, target) - pay=
load_overhead);


diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 81851d3..e1e8e02 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -167,7 +167,7 @@
      */
     const char *ciphername =3D o->ciphername;

-    unsigned int overhead =3D 0;
+    size_t overhead =3D 0;

     if (strcmp(o->ciphername, "BF-CBC") =3D=3D 0)
     {
@@ -185,7 +185,7 @@
      * the ciphers are actually valid for non tls in occ calucation */
     init_key_type(&occ_kt, ciphername, o->authname, true, false);

-    unsigned int payload =3D frame_calculate_payload_size(frame, o, &occ_k=
t);
+    size_t payload =3D frame_calculate_payload_size(frame, o, &occ_kt);
     overhead +=3D frame_calculate_protocol_header_size(&occ_kt, o, true);

     return payload + overhead;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/269?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic996eca227d9e68279a454db93fcbc86a7bd0380
Gerrit-Change-Number: 269
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--rj+nzlbHAbg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/269?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">mss/mtu: make all size calculations use size_t=
<br><br>Half of them used unsigned int, the other half size_t.<br>Standardi=
ze on one. Could&#39;ve also standardized on the<br>other, both are much to=
o big for the expected numbers<br>anyway.<br><br>Add a new utility function=
 clamp_size_to_int for<br>cases we need to change from size_t to int (there=
<br>are a lot of those all over our codebase).<br><br>Resolves some -Wconve=
rsion warnings.<br><br>Change-Id: Ic996eca227d9e68279a454db93fcbc86a7bd0380=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: =
Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20231008104=
022.20200-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/searc=
h?l=3Dmid&amp;q=3D20231008104022.20200-1-frank@...2641...<br>Signed-off-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/integer.h<br>=
M src/openvpn/mss.c<br>M src/openvpn/mtu.c<br>3 files changed, 21 insertion=
s(+), 14 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h</span><br><sp=
an>index 215c159..a012524 100644</span><br><span>--- a/src/openvpn/integer.=
h</span><br><span>+++ b/src/openvpn/integer.h</span><br><span>@@ -36,6 +36,=
13 @@</span><br><span>                    ((uint64_t)ntohl((x) &amp; 0xFFFF=
FFFF) &lt;&lt; 32) | ntohl((x) &gt;&gt; 32))</span><br><span> #endif</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static i=
nline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+clamp_size=
_to_int(size_t size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(size &=
lt;=3D INT_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return (int)size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /=
*</span><br><span>  * min/max functions</span><br><span>  */</span><br><spa=
n>@@ -188,8 +195,8 @@</span><br><span> /**</span><br><span>  * Rounds down =
num to the nearest multiple of multiple</span><br><span>  */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static inline unsigned int</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-round_down_uint(unsigned int nu=
m, unsigned int multiple)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static inline size_t</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+round_down_size(size_t num, size_t multiple)</span><br><span> {</spa=
n><br><span>     return (num / multiple) * multiple;</span><br><span> }</sp=
an><br><span>diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c</span><br><=
span>index 4227047..1566c64 100644</span><br><span>--- a/src/openvpn/mss.c<=
/span><br><span>+++ b/src/openvpn/mss.c</span><br><span>@@ -207,8 +207,8 @@=
</span><br><span>     }</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static inline unsigned int</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-adjust_payload_max_cbc(const st=
ruct key_type *kt, unsigned int target)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static inline size_t</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+adjust_payload_max_cbc(const struct key_type *kt, size=
_t target)</span><br><span> {</span><br><span>     if (!cipher_kt_mode_cbc(=
kt-&gt;cipher))</span><br><span>     {</span><br><span>@@ -221,13 +221,13 @=
@</span><br><span>         /* With CBC we need at least one extra byte for =
padding and then need</span><br><span>          * to ensure that the result=
ing CBC ciphertext length, which is always</span><br><span>          * a mu=
ltiple of the block size, is not larger than the target value */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        unsigned int block_size =
=3D cipher_kt_block_size(kt-&gt;cipher);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        target =3D round_down_uint(target, block_size);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t block=
_size =3D cipher_kt_block_size(kt-&gt;cipher);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        target =3D round_down_size(target, block=
_size);</span><br><span>         return target - 1;</span><br><span>     }<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static unsigned int</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static size_t</span><br><span> get_ip_encap_overhead(const s=
truct options *options,</span><br><span>                       const struct=
 link_socket_info *lsi)</span><br><span> {</span><br><span>@@ -258,7 +258,7=
 @@</span><br><span>                          struct link_socket_info *lsi)=
</span><br><span> {</span><br><span> #if defined(ENABLE_FRAGMENT)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int overhead;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t overhead;</sp=
an><br><span> </span><br><span>     overhead =3D frame_calculate_protocol_h=
eader_size(kt, options, false);</span><br><span> </span><br><span>@@ -267,1=
2 +267,12 @@</span><br><span>         overhead +=3D get_ip_encap_overhead(o=
ptions, lsi);</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    unsigned int target =3D options-&gt;ce=
.fragment - overhead;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    size_t target =3D options-&gt;ce.fragment - overhead;</span><br><span=
>     /* The 4 bytes of header that fragment adds itself. The other extra p=
ayload</span><br><span>      * bytes (Ethernet header/compression) are hand=
led by the fragment code</span><br><span>      * just as part of the payloa=
d and therefore automatically taken into</span><br><span>      * account if=
 the packet needs to fragmented */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    frame-&gt;max_fragment_size =3D adjust_payload_max_cbc(kt,=
 target) - 4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fr=
ame-&gt;max_fragment_size =3D clamp_size_to_int(adjust_payload_max_cbc(kt, =
target)) - 4;</span><br><span> </span><br><span>     if (cipher_kt_mode_cbc=
(kt-&gt;cipher))</span><br><span>     {</span><br><span>@@ -296,7 +296,7 @@=
</span><br><span>         return;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int overh=
ead, payload_overhead;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    size_t overhead, payload_overhead;</span><br><span> </span><br><span=
>     overhead =3D frame_calculate_protocol_header_size(kt, options, false)=
;</span><br><span> </span><br><span>@@ -325,7 +325,7 @@</span><br><span>   =
   * by ce.mssfix */</span><br><span> </span><br><span>     /* This is the =
target value our payload needs to be smaller */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    unsigned int target =3D options-&gt;ce.mssfix=
 - overhead;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siz=
e_t target =3D options-&gt;ce.mssfix - overhead;</span><br><span>     frame=
-&gt;mss_fix =3D (uint16_t)(adjust_payload_max_cbc(kt, target) - payload_ov=
erhead);</span><br><span> </span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/mtu.c b/src/openvpn/mtu.c</span><br><span>index 81851d3..e1e8e02=
 100644</span><br><span>--- a/src/openvpn/mtu.c</span><br><span>+++ b/src/o=
penvpn/mtu.c</span><br><span>@@ -167,7 +167,7 @@</span><br><span>      */</=
span><br><span>     const char *ciphername =3D o-&gt;ciphername;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned i=
nt overhead =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   size_t overhead =3D 0;</span><br><span> </span><br><span>     if (strcmp=
(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D 0)</span><br><span>     {</sp=
an><br><span>@@ -185,7 +185,7 @@</span><br><span>      * the ciphers are ac=
tually valid for non tls in occ calucation */</span><br><span>     init_key=
_type(&amp;occ_kt, ciphername, o-&gt;authname, true, false);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int p=
ayload =3D frame_calculate_payload_size(frame, o, &amp;occ_kt);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    size_t payload =3D frame_ca=
lculate_payload_size(frame, o, &amp;occ_kt);</span><br><span>     overhead =
+=3D frame_calculate_protocol_header_size(&amp;occ_kt, o, true);</span><br>=
<span> </span><br><span>     return payload + overhead;</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/269?usp=3Demail">change 269</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/269?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic996eca227d9e68279a454db93f=
cbc86a7bd0380 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 269 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--rj+nzlbHAbg=--

