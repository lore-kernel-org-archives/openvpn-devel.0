From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 13 Oct 2025 16:42:58 +0000
In-Reply-To: <gerrit.1760136547000.I30a50826350ac3176443cf3bf16d3972609723a2@...2715...>
References: <gerrit.1760136547000.I30a50826350ac3176443cf3bf16d3972609723a2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0a318dfeacceaa6e68353e8c03f78917b11f6b8c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/tQ580OCtaU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dhcp: Clean up type
 handling of write_dhcp_*
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/tQ580OCtaU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
68?usp=3Demail )

Change subject: dhcp: Clean up type handling of write_dhcp_*
......................................................................

dhcp: Clean up type handling of write_dhcp_*

Use more appropriate types. Add casts where
necessary but ensure that they are safe.

Change-Id: I30a50826350ac3176443cf3bf16d3972609723a2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1268
Message-Id: <20251013161759.1656-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59246219/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dhcp.c
M src/openvpn/options.c
M src/openvpn/tun.h
3 files changed, 21 insertions(+), 32 deletions(-)




diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 0893ec7..a34bfca 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -188,18 +188,13 @@

 #if defined(_WIN32) || defined(DHCP_UNIT_TEST)

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Convert DHCP options from the command line / config file
  * into a raw DHCP-format options string.
  */

 static void
-write_dhcp_u8(struct buffer *buf, const int type, const int data, bool *er=
ror)
+write_dhcp_u8(struct buffer *buf, const uint8_t type, const uint8_t data, =
bool *error)
 {
     if (!buf_safe(buf, 3))
     {
@@ -213,13 +208,12 @@
 }

 static void
-write_dhcp_u32_array(struct buffer *buf, const int type, const uint32_t *d=
ata,
+write_dhcp_u32_array(struct buffer *buf, const uint8_t type, const uint32_=
t *data,
                      const unsigned int len, bool *error)
 {
     if (len > 0)
     {
-        int i;
-        const int size =3D len * sizeof(uint32_t);
+        const size_t size =3D len * sizeof(uint32_t);

         if (!buf_safe(buf, 2 + size))
         {
@@ -230,12 +224,12 @@
         if (size < 1 || size > 255)
         {
             *error =3D true;
-            msg(M_WARN, "write_dhcp_u32_array: size (%d) must be > 0 and <=
=3D 255", size);
+            msg(M_WARN, "write_dhcp_u32_array: size (%zu) must be > 0 and =
<=3D 255", size);
             return;
         }
         buf_write_u8(buf, type);
-        buf_write_u8(buf, size);
-        for (i =3D 0; i < len; ++i)
+        buf_write_u8(buf, (uint8_t)size);
+        for (unsigned int i =3D 0; i < len; ++i)
         {
             buf_write_u32(buf, data[i]);
         }
@@ -243,9 +237,9 @@
 }

 static void
-write_dhcp_str(struct buffer *buf, const int type, const char *str, bool *=
error)
+write_dhcp_str(struct buffer *buf, const uint8_t type, const char *str, bo=
ol *error)
 {
-    const int len =3D strlen(str);
+    const size_t len =3D strlen(str);
     if (!buf_safe(buf, 2 + len))
     {
         *error =3D true;
@@ -259,7 +253,7 @@
         return;
     }
     buf_write_u8(buf, type);
-    buf_write_u8(buf, len);
+    buf_write_u8(buf, (uint8_t)len);
     buf_write(buf, str, len);
 }

@@ -272,15 +266,14 @@
  *  0x1D  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00
  */
 static void
-write_dhcp_search_str(struct buffer *buf, const int type, const char *cons=
t *str_array,
+write_dhcp_search_str(struct buffer *buf, const uint8_t type, const char *=
const *str_array,
                       int array_len, bool *error)
 {
     char tmp_buf[256];
-    int i;
-    int len =3D 0;
-    int label_length_pos;
+    size_t len =3D 0;
+    size_t label_length_pos;

-    for (i =3D 0; i < array_len; i++)
+    for (int i =3D 0; i < array_len; i++)
     {
         const char *ptr =3D str_array[i];

@@ -301,7 +294,8 @@
         {
             if (*ptr =3D=3D '.' || *ptr =3D=3D '\0')
             {
-                tmp_buf[label_length_pos] =3D (len - label_length_pos) - 1;
+                /* cast is protected by sizeof(tmp_buf) */
+                tmp_buf[label_length_pos] =3D (char)(len - label_length_po=
s - 1);
                 label_length_pos =3D len;
                 if (*ptr =3D=3D '\0')
                 {
@@ -328,14 +322,10 @@
     }

     buf_write_u8(buf, type);
-    buf_write_u8(buf, len);
+    buf_write_u8(buf, (uint8_t)len);
     buf_write(buf, tmp_buf, len);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 build_dhcp_options_string(struct buffer *buf, const struct tuntap_options =
*o)
 {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9daba7d..44f68c7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1322,7 +1322,7 @@
     SHOW_BOOL(dhcp_pre_release);
     SHOW_STR(domain);
     SHOW_STR(netbios_scope);
-    SHOW_INT(netbios_node_type);
+    SHOW_UNSIGNED(netbios_node_type);
     SHOW_BOOL(disable_nbt);

     show_dhcp_option_addrs("DNS", o->dns, o->dns_len);
@@ -8001,7 +8001,7 @@
                 msg(msglevel, "--dhcp-option NBT: parameter (%d) must be 1=
, 2, 4, or 8", t);
                 goto err;
             }
-            o->netbios_node_type =3D t;
+            o->netbios_node_type =3D (uint8_t)t;
             o->dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;
         }
         else if (streq(p[1], "WINS") && p[2] && !p[3])
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 741798d..e13f99f 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -104,11 +104,10 @@

     const char *netbios_scope; /* NBS (47) */

-    int netbios_node_type;     /* NBT 1,2,4,8 (46) */
+    uint8_t netbios_node_type; /* NBT 1,2,4,8 (46) */

-#define N_DHCP_ADDR                     \
-    4 /* Max # of addresses allowed for \
-       * DNS, WINS, etc. */
+/* Max # of addresses allowed for  DNS, WINS, etc. */
+#define N_DHCP_ADDR 4

     /* DNS (6) */
     in_addr_t dns[N_DHCP_ADDR];

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1268?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I30a50826350ac3176443cf3bf16d3972609723a2
Gerrit-Change-Number: 1268
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/tQ580OCtaU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1268?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">dhcp: Clean up type handling of write_dhcp_*<br>=
<br>Use more appropriate types. Add casts where<br>necessary but ensure tha=
t they are safe.<br><br>Change-Id: I30a50826350ac3176443cf3bf16d3972609723a=
2<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn=
.net/c/openvpn/+/1268<br>Message-Id: &lt;20251013161759.1656-1-gert@...1726...=
...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/59246219/=
<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/ope=
nvpn/dhcp.c<br>M src/openvpn/options.c<br>M src/openvpn/tun.h<br>3 files ch=
anged, 21 insertions(+), 32 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c</span><br><span>ind=
ex 0893ec7..a34bfca 100644</span><br><span>--- a/src/openvpn/dhcp.c</span><=
br><span>+++ b/src/openvpn/dhcp.c</span><br><span>@@ -188,18 +188,13 @@</sp=
an><br><span> </span><br><span> #if defined(_WIN32) || defined(DHCP_UNIT_TE=
ST)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversi=
on&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><=
br><span>  * Convert DHCP options from the command line / config file</span=
><br><span>  * into a raw DHCP-format options string.</span><br><span>  */<=
/span><br><span> </span><br><span> static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-write_dhcp_u8(struct buffer *buf, const int type, =
const int data, bool *error)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+write_dhcp_u8(struct buffer *buf, const uint8_t type, const uint8_=
t data, bool *error)</span><br><span> {</span><br><span>     if (!buf_safe(=
buf, 3))</span><br><span>     {</span><br><span>@@ -213,13 +208,12 @@</span=
><br><span> }</span><br><span> </span><br><span> static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-write_dhcp_u32_array(struct buffer *=
buf, const int type, const uint32_t *data,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+write_dhcp_u32_array(struct buffer *buf, const uint8=
_t type, const uint32_t *data,</span><br><span>                      const =
unsigned int len, bool *error)</span><br><span> {</span><br><span>     if (=
len &gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        int i;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        const int size =3D len * sizeof(uint32_t);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        const size_t size =3D len * si=
zeof(uint32_t);</span><br><span> </span><br><span>         if (!buf_safe(bu=
f, 2 + size))</span><br><span>         {</span><br><span>@@ -230,12 +224,12=
 @@</span><br><span>         if (size &lt; 1 || size &gt; 255)</span><br><s=
pan>         {</span><br><span>             *error =3D true;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;write_=
dhcp_u32_array: size (%d) must be &gt; 0 and &lt;=3D 255&quot;, size);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, =
&quot;write_dhcp_u32_array: size (%zu) must be &gt; 0 and &lt;=3D 255&quot;=
, size);</span><br><span>             return;</span><br><span>         }</s=
pan><br><span>         buf_write_u8(buf, type);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        buf_write_u8(buf, size);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; len; ++i)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_write_u=
8(buf, (uint8_t)size);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        for (unsigned int i =3D 0; i &lt; len; ++i)</span><br><span>    =
     {</span><br><span>             buf_write_u32(buf, data[i]);</span><br>=
<span>         }</span><br><span>@@ -243,9 +237,9 @@</span><br><span> }</sp=
an><br><span> </span><br><span> static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-write_dhcp_str(struct buffer *buf, const int type, co=
nst char *str, bool *error)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+write_dhcp_str(struct buffer *buf, const uint8_t type, const char *=
str, bool *error)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    const int len =3D strlen(str);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const size_t len =3D strlen(str);</span><=
br><span>     if (!buf_safe(buf, 2 + len))</span><br><span>     {</span><br=
><span>         *error =3D true;</span><br><span>@@ -259,7 +253,7 @@</span>=
<br><span>         return;</span><br><span>     }</span><br><span>     buf_=
write_u8(buf, type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   buf_write_u8(buf, len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    buf_write_u8(buf, (uint8_t)len);</span><br><span>     buf_write(=
buf, str, len);</span><br><span> }</span><br><span> </span><br><span>@@ -27=
2,15 +266,14 @@</span><br><span>  *  0x1D  0x7 openvpn 0x3 net 0x00 0x0A du=
ckduckgo 0x3 com 0x00</span><br><span>  */</span><br><span> static void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-write_dhcp_search_str(str=
uct buffer *buf, const int type, const char *const *str_array,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+write_dhcp_search_str(struct buf=
fer *buf, const uint8_t type, const char *const *str_array,</span><br><span=
>                       int array_len, bool *error)</span><br><span> {</spa=
n><br><span>     char tmp_buf[256];</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int label_length_pos;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    size_t len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    size_t label_length_pos;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; array_len; i++)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0;=
 i &lt; array_len; i++)</span><br><span>     {</span><br><span>         con=
st char *ptr =3D str_array[i];</span><br><span> </span><br><span>@@ -301,7 =
+294,8 @@</span><br><span>         {</span><br><span>             if (*ptr =
=3D=3D &#39;.&#39; || *ptr =3D=3D &#39;\0&#39;)</span><br><span>           =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                tm=
p_buf[label_length_pos] =3D (len - label_length_pos) - 1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                /* cast is protected =
by sizeof(tmp_buf) */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                tmp_buf[label_length_pos] =3D (char)(len - label_length_p=
os - 1);</span><br><span>                 label_length_pos =3D len;</span><=
br><span>                 if (*ptr =3D=3D &#39;\0&#39;)</span><br><span>   =
              {</span><br><span>@@ -328,14 +322,10 @@</span><br><span>     =
}</span><br><span> </span><br><span>     buf_write_u8(buf, type);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    buf_write_u8(buf, len);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8(buf, (=
uint8_t)len);</span><br><span>     buf_write(buf, tmp_buf, len);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> bool</span><br><span> build_dhcp_options=
_string(struct buffer *buf, const struct tuntap_options *o)</span><br><span=
> {</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/option=
s.c</span><br><span>index 9daba7d..44f68c7 100644</span><br><span>--- a/src=
/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><s=
pan>@@ -1322,7 +1322,7 @@</span><br><span>     SHOW_BOOL(dhcp_pre_release);=
</span><br><span>     SHOW_STR(domain);</span><br><span>     SHOW_STR(netbi=
os_scope);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_IN=
T(netbios_node_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    SHOW_UNSIGNED(netbios_node_type);</span><br><span>     SHOW_BOOL(disa=
ble_nbt);</span><br><span> </span><br><span>     show_dhcp_option_addrs(&qu=
ot;DNS&quot;, o-&gt;dns, o-&gt;dns_len);</span><br><span>@@ -8001,7 +8001,7=
 @@</span><br><span>                 msg(msglevel, &quot;--dhcp-option NBT:=
 parameter (%d) must be 1, 2, 4, or 8&quot;, t);</span><br><span>          =
       goto err;</span><br><span>             }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            o-&gt;netbios_node_type =3D t;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;netbios_=
node_type =3D (uint8_t)t;</span><br><span>             o-&gt;dhcp_options |=
=3D DHCP_OPTIONS_DHCP_REQUIRED;</span><br><span>         }</span><br><span>=
         else if (streq(p[1], &quot;WINS&quot;) &amp;&amp; p[2] &amp;&amp; =
!p[3])</span><br><span>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</=
span><br><span>index 741798d..e13f99f 100644</span><br><span>--- a/src/open=
vpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</span><br><span>@@ -104,1=
1 +104,10 @@</span><br><span> </span><br><span>     const char *netbios_sco=
pe; /* NBS (47) */</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int netbios_node_type;     /* NBT 1,2,4,8 (46) */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t netbios_node_t=
ype; /* NBT 1,2,4,8 (46) */</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define N_DHCP_ADDR                     \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    4 /* Max # of addresses all=
owed for \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       * DN=
S, WINS, etc. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Max # of addresses allowed for  DNS, WINS, etc. */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define N_DHCP_ADDR 4</span><br><span> </spa=
n><br><span>     /* DNS (6) */</span><br><span>     in_addr_t dns[N_DHCP_AD=
DR];</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1268?usp=3Demail">change 1268</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1268?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I30a50826350ac3176443cf3bf16=
d3972609723a2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1268 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--/tQ580OCtaU=--

