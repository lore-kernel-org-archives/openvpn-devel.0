From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 Aug 2025 14:29:35 +0000
References: <gerrit.1754490554000.I5ef21e425786a49c90d4b7305c3fb174ab6ddf92@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7e61ba594965ffa54587ccfccca26c9d788bd23b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="m8pWtAgjy8w="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: Change
 resolve flags to unsigned int
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

--m8pWtAgjy8w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1131?usp=3Demail

to review the following change.


Change subject: socket: Change resolve flags to unsigned int
......................................................................

socket: Change resolve flags to unsigned int

And use them consistently so to avoid conversion
warnings.

Change-Id: I5ef21e425786a49c90d4b7305c3fb174ab6ddf92
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/socket.c
M src/openvpn/socket.h
2 files changed, 18 insertions(+), 18 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/1131/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index b0a158b..4019c1e 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -246,10 +246,10 @@
  */
 static int
 get_cached_dns_entry(struct cached_dns_entry *dns_cache, const char *hostn=
ame, const char *servname,
-                     int ai_family, int resolve_flags, struct addrinfo **a=
i)
+                     int ai_family, unsigned int resolve_flags, struct add=
rinfo **ai)
 {
     struct cached_dns_entry *ph;
-    int flags;
+    unsigned int flags;

     /* Only use flags that are relevant for the structure */
     flags =3D resolve_flags & GETADDR_CACHE_MASK;
@@ -269,7 +269,7 @@
=20
 static int
 do_preresolve_host(struct context *c, const char *hostname, const char *se=
rvname, const int af,
-                   const int flags)
+                   const unsigned int flags)
 {
     struct addrinfo *ai;
     int status;
@@ -323,7 +323,7 @@
     {
         int status;
         const char *remote;
-        int flags =3D preresolve_flags;
+        unsigned int flags =3D preresolve_flags;

         struct connection_entry *ce =3D l->array[i];

@@ -1608,7 +1608,7 @@
     /* resolve local address if undefined */
     if (!sock->info.lsa->bind_local)
     {
-        int flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_F=
ATAL | GETADDR_PASSIVE;
+        unsigned int flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | =
GETADDR_FATAL | GETADDR_PASSIVE;
         int status;

         if (proto_is_dgram(sock->info.proto))
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index c34c65a..3b82dac 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -78,7 +78,7 @@
     const char *hostname;
     const char *servname;
     int ai_family;
-    int flags;
+    unsigned int flags;
     struct addrinfo *ai;
     struct cached_dns_entry *next;
 };
@@ -476,18 +476,18 @@
  * DNS resolution
  */

-#define GETADDR_RESOLVE                 (1 << 0)
-#define GETADDR_FATAL                   (1 << 1)
-#define GETADDR_HOST_ORDER              (1 << 2)
-#define GETADDR_MENTION_RESOLVE_RETRY   (1 << 3)
-#define GETADDR_FATAL_ON_SIGNAL         (1 << 4)
-#define GETADDR_WARN_ON_SIGNAL          (1 << 5)
-#define GETADDR_MSG_VIRT_OUT            (1 << 6)
-#define GETADDR_TRY_ONCE                (1 << 7)
-#define GETADDR_UPDATE_MANAGEMENT_STATE (1 << 8)
-#define GETADDR_RANDOMIZE               (1 << 9)
-#define GETADDR_PASSIVE                 (1 << 10)
-#define GETADDR_DATAGRAM                (1 << 11)
+#define GETADDR_RESOLVE                 (1u << 0)
+#define GETADDR_FATAL                   (1u << 1)
+#define GETADDR_HOST_ORDER              (1u << 2)
+#define GETADDR_MENTION_RESOLVE_RETRY   (1u << 3)
+#define GETADDR_FATAL_ON_SIGNAL         (1u << 4)
+#define GETADDR_WARN_ON_SIGNAL          (1u << 5)
+#define GETADDR_MSG_VIRT_OUT            (1u << 6)
+#define GETADDR_TRY_ONCE                (1u << 7)
+#define GETADDR_UPDATE_MANAGEMENT_STATE (1u << 8)
+#define GETADDR_RANDOMIZE               (1u << 9)
+#define GETADDR_PASSIVE                 (1u << 10)
+#define GETADDR_DATAGRAM                (1u << 11)

 #define GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1131?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ef21e425786a49c90d4b7305c3fb174ab6ddf92
Gerrit-Change-Number: 1131
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--m8pWtAgjy8w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1131?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">socket: Change resolve flags to unsigned int<br><br>And use =
them consistently so to avoid conversion<br>warnings.<br><br>Change-Id: I5e=
f21e425786a49c90d4b7305c3fb174ab6ddf92<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>---<br>M src/openvpn/socket.c<br>M src/openvpn/=
socket.h<br>2 files changed, 18 insertions(+), 18 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/1131/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>=
index b0a158b..4019c1e 100644</span><br><span>--- a/src/openvpn/socket.c</s=
pan><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -246,10 +246,10=
 @@</span><br><span>  */</span><br><span> static int</span><br><span> get_c=
ached_dns_entry(struct cached_dns_entry *dns_cache, const char *hostname, c=
onst char *servname,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                    int ai_family, int resolve_flags, struct addrinfo **ai)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
  int ai_family, unsigned int resolve_flags, struct addrinfo **ai)</span><b=
r><span> {</span><br><span>     struct cached_dns_entry *ph;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    int flags;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags;</span><br><span> =
</span><br><span>     /* Only use flags that are relevant for the structure=
 */</span><br><span>     flags =3D resolve_flags &amp; GETADDR_CACHE_MASK;<=
/span><br><span>@@ -269,7 +269,7 @@</span><br><span> </span><br><span> stat=
ic int</span><br><span> do_preresolve_host(struct context *c, const char *h=
ostname, const char *servname, const int af,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                   const int flags)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                   const unsigned in=
t flags)</span><br><span> {</span><br><span>     struct addrinfo *ai;</span=
><br><span>     int status;</span><br><span>@@ -323,7 +323,7 @@</span><br><=
span>     {</span><br><span>         int status;</span><br><span>         c=
onst char *remote;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     int flags =3D preresolve_flags;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        unsigned int flags =3D preresolve_flags;</span><br=
><span> </span><br><span>         struct connection_entry *ce =3D l-&gt;arr=
ay[i];</span><br><span> </span><br><span>@@ -1608,7 +1608,7 @@</span><br><s=
pan>     /* resolve local address if undefined */</span><br><span>     if (=
!sock-&gt;info.lsa-&gt;bind_local)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        int flags =3D GETADDR_RESOLVE |=
 GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL | GETADDR_PASSIVE;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        unsigned int flags =3D GETAD=
DR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL | GETADDR_PASSIVE;</spa=
n><br><span>         int status;</span><br><span> </span><br><span>        =
 if (proto_is_dgram(sock-&gt;info.proto))</span><br><span>diff --git a/src/=
openvpn/socket.h b/src/openvpn/socket.h</span><br><span>index c34c65a..3b82=
dac 100644</span><br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b=
/src/openvpn/socket.h</span><br><span>@@ -78,7 +78,7 @@</span><br><span>   =
  const char *hostname;</span><br><span>     const char *servname;</span><b=
r><span>     int ai_family;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    int flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    unsigned int flags;</span><br><span>     struct addrinfo *ai;</span><b=
r><span>     struct cached_dns_entry *next;</span><br><span> };</span><br><=
span>@@ -476,18 +476,18 @@</span><br><span>  * DNS resolution</span><br><sp=
an>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define GETADDR_RESOLVE                 (1 &lt;&lt; 0)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_FATAL                 =
  (1 &lt;&lt; 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne GETADDR_HOST_ORDER              (1 &lt;&lt; 2)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define GETADDR_MENTION_RESOLVE_RETRY   (1 &lt;=
&lt; 3)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADD=
R_FATAL_ON_SIGNAL         (1 &lt;&lt; 4)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define GETADDR_WARN_ON_SIGNAL          (1 &lt;&lt; 5)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_MSG_VIR=
T_OUT            (1 &lt;&lt; 6)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define GETADDR_TRY_ONCE                (1 &lt;&lt; 7)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_UPDATE_MANAGEMEN=
T_STATE (1 &lt;&lt; 8)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define GETADDR_RANDOMIZE               (1 &lt;&lt; 9)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_PASSIVE                 (=
1 &lt;&lt; 10)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 GETADDR_DATAGRAM                (1 &lt;&lt; 11)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define GETADDR_RESOLVE                 (1u &l=
t;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GE=
TADDR_FATAL                   (1u &lt;&lt; 1)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define GETADDR_HOST_ORDER              (1u &lt;&=
lt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETAD=
DR_MENTION_RESOLVE_RETRY   (1u &lt;&lt; 3)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define GETADDR_FATAL_ON_SIGNAL         (1u &lt;&lt;=
 4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_=
WARN_ON_SIGNAL          (1u &lt;&lt; 5)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define GETADDR_MSG_VIRT_OUT            (1u &lt;&lt; 6)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_TRY=
_ONCE                (1u &lt;&lt; 7)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define GETADDR_UPDATE_MANAGEMENT_STATE (1u &lt;&lt; 8)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_RANDOM=
IZE               (1u &lt;&lt; 9)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define GETADDR_PASSIVE                 (1u &lt;&lt; 10)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_DATAGRAM=
                (1u &lt;&lt; 11)</span><br><span> </span><br><span> #define=
 GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)</span><br><span> <=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1131?usp=3Demail">change 1131</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1131?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ef21e425786a49c90d4b7305c3=
fb174ab6ddf92 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1131 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--m8pWtAgjy8w=--

