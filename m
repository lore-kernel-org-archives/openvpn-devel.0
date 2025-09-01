From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 1 Sep 2025 15:09:33 +0000
In-Reply-To: <gerrit.1754490554000.I5ef21e425786a49c90d4b7305c3fb174ab6ddf92@...2715...>
References: <gerrit.1754490554000.I5ef21e425786a49c90d4b7305c3fb174ab6ddf92@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <af4bd545747a29573921825c91d4bb9244d6382f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GNBBiGen+yw="; charset=UTF-8
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

--GNBBiGen+yw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1131?usp=3Demail

to look at the new patch set (#6).


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
M src/openvpn/socket_util.h
3 files changed, 18 insertions(+), 18 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/1131/6

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 306170c..e362e5e 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -245,10 +245,10 @@
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
@@ -268,7 +268,7 @@

 static int
 do_preresolve_host(struct context *c, const char *hostname, const char *se=
rvname, const int af,
-                   const int flags)
+                   const unsigned int flags)
 {
     struct addrinfo *ai;
     int status;
@@ -322,7 +322,7 @@
     {
         int status;
         const char *remote;
-        int flags =3D preresolve_flags;
+        unsigned int flags =3D preresolve_flags;

         struct connection_entry *ce =3D l->array[i];

@@ -1185,7 +1185,7 @@
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
index cce9183..e45981f 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -67,7 +67,7 @@
     const char *hostname;
     const char *servname;
     int ai_family;
-    int flags;
+    unsigned int flags;
     struct addrinfo *ai;
     struct cached_dns_entry *next;
 };
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index 5ea37dd..801fbfa 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -114,18 +114,18 @@
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
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--GNBBiGen+yw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #6</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1131?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">socket: Change resolve flags to unsigned int<br><br>And use them =
consistently so to avoid conversion<br>warnings.<br><br>Change-Id: I5ef21e4=
25786a49c90d4b7305c3fb174ab6ddf92<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>---<br>M src/openvpn/socket.c<br>M src/openvpn/socke=
t.h<br>M src/openvpn/socket_util.h<br>3 files changed, 18 insertions(+), 18=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/31/1131/6</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/openvpn=
/socket.c</span><br><span>index 306170c..e362e5e 100644</span><br><span>---=
 a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><b=
r><span>@@ -245,10 +245,10 @@</span><br><span>  */</span><br><span> static =
int</span><br><span> get_cached_dns_entry(struct cached_dns_entry *dns_cach=
e, const char *hostname, const char *servname,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                     int ai_family, int resolve_fl=
ags, struct addrinfo **ai)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                     int ai_family, unsigned int resolve_flags, stru=
ct addrinfo **ai)</span><br><span> {</span><br><span>     struct cached_dns=
_entry *ph;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int fl=
ags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned in=
t flags;</span><br><span> </span><br><span>     /* Only use flags that are =
relevant for the structure */</span><br><span>     flags =3D resolve_flags =
&amp; GETADDR_CACHE_MASK;</span><br><span>@@ -268,7 +268,7 @@</span><br><sp=
an> </span><br><span> static int</span><br><span> do_preresolve_host(struct=
 context *c, const char *hostname, const char *servname, const int af,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                   const i=
nt flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
         const unsigned int flags)</span><br><span> {</span><br><span>     =
struct addrinfo *ai;</span><br><span>     int status;</span><br><span>@@ -3=
22,7 +322,7 @@</span><br><span>     {</span><br><span>         int status;<=
/span><br><span>         const char *remote;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        int flags =3D preresolve_flags;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        unsigned int flags =3D p=
reresolve_flags;</span><br><span> </span><br><span>         struct connecti=
on_entry *ce =3D l-&gt;array[i];</span><br><span> </span><br><span>@@ -1185=
,7 +1185,7 @@</span><br><span>     /* resolve local address if undefined */=
</span><br><span>     if (!sock-&gt;info.lsa-&gt;bind_local)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int f=
lags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL | GETADDR=
_PASSIVE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        un=
signed int flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FAT=
AL | GETADDR_PASSIVE;</span><br><span>         int status;</span><br><span>=
 </span><br><span>         if (proto_is_dgram(sock-&gt;info.proto))</span><=
br><span>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br=
><span>index cce9183..e45981f 100644</span><br><span>--- a/src/openvpn/sock=
et.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -67,7 +6=
7,7 @@</span><br><span>     const char *hostname;</span><br><span>     cons=
t char *servname;</span><br><span>     int ai_family;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int flags;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    unsigned int flags;</span><br><span>     str=
uct addrinfo *ai;</span><br><span>     struct cached_dns_entry *next;</span=
><br><span> };</span><br><span>diff --git a/src/openvpn/socket_util.h b/src=
/openvpn/socket_util.h</span><br><span>index 5ea37dd..801fbfa 100644</span>=
<br><span>--- a/src/openvpn/socket_util.h</span><br><span>+++ b/src/openvpn=
/socket_util.h</span><br><span>@@ -114,18 +114,18 @@</span><br><span>  * DN=
S resolution</span><br><span>  */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_RESOLVE                 (1 =
&lt;&lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GE=
TADDR_FATAL                   (1 &lt;&lt; 1)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define GETADDR_HOST_ORDER              (1 &lt;&lt; =
2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_MEN=
TION_RESOLVE_RETRY   (1 &lt;&lt; 3)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define GETADDR_FATAL_ON_SIGNAL         (1 &lt;&lt; 4)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_WARN_ON_SIGN=
AL          (1 &lt;&lt; 5)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define GETADDR_MSG_VIRT_OUT            (1 &lt;&lt; 6)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_TRY_ONCE             =
   (1 &lt;&lt; 7)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine GETADDR_UPDATE_MANAGEMENT_STATE (1 &lt;&lt; 8)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define GETADDR_RANDOMIZE               (1 &lt=
;&lt; 9)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETAD=
DR_PASSIVE                 (1 &lt;&lt; 10)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define GETADDR_DATAGRAM                (1 &lt;&lt; 11=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_RE=
SOLVE                 (1u &lt;&lt; 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define GETADDR_FATAL                   (1u &lt;&lt; 1)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_HOST_=
ORDER              (1u &lt;&lt; 2)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define GETADDR_MENTION_RESOLVE_RETRY   (1u &lt;&lt; 3)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_FATAL_ON=
_SIGNAL         (1u &lt;&lt; 4)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define GETADDR_WARN_ON_SIGNAL          (1u &lt;&lt; 5)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_MSG_VIRT_OU=
T            (1u &lt;&lt; 6)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define GETADDR_TRY_ONCE                (1u &lt;&lt; 7)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_UPDATE_MANAGEM=
ENT_STATE (1u &lt;&lt; 8)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define GETADDR_RANDOMIZE               (1u &lt;&lt; 9)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_PASSIVE          =
       (1u &lt;&lt; 10)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define GETADDR_DATAGRAM                (1u &lt;&lt; 11)</span><br><spa=
n> </span><br><span> #define GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR=
_PASSIVE)</span><br><span> </span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1131?usp=3Demail">chan=
ge 1131</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1131?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ef21e425786a49c90d4b7305c3=
fb174ab6ddf92 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1131 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--GNBBiGen+yw=--

