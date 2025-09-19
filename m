From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 19 Sep 2025 16:42:56 +0000
In-Reply-To: <gerrit.1754490554000.I5ef21e425786a49c90d4b7305c3fb174ab6ddf92@...2715...>
References: <gerrit.1754490554000.I5ef21e425786a49c90d4b7305c3fb174ab6ddf92@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <eedba23e8fc774c78b9d0816bb680d044db13acd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/0KcPyNQApA="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/0KcPyNQApA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
31?usp=3Demail )

Change subject: socket: Change resolve flags to unsigned int
......................................................................

socket: Change resolve flags to unsigned int

And use them consistently so to avoid conversion
warnings.

Change-Id: I5ef21e425786a49c90d4b7305c3fb174ab6ddf92
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1131
Message-Id: <20250919154040.17684-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
098.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
M src/openvpn/socket.h
M src/openvpn/socket_util.h
3 files changed, 18 insertions(+), 18 deletions(-)




diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index eeb42d1..afedf5d 100644
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

@@ -1186,7 +1186,7 @@
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
index ada52a4..f3dfd22 100644
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
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--/0KcPyNQApA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1131?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">socket: Change resolve flags to unsigned int<=
br><br>And use them consistently so to avoid conversion<br>warnings.<br><br=
>Change-Id: I5ef21e425786a49c90d4b7305c3fb174ab6ddf92<br>Signed-off-by: Fra=
nk Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@=
...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1131<b=
r>Message-Id: &lt;20250919154040.17684-1-gert@...1296...&gt;<br>URL: https:=
//www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33098.html<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvp=
n/socket.c<br>M src/openvpn/socket.h<br>M src/openvpn/socket_util.h<br>3 fi=
les changed, 18 insertions(+), 18 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span=
>index eeb42d1..afedf5d 100644</span><br><span>--- a/src/openvpn/socket.c</=
span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -246,10 +246,1=
0 @@</span><br><span>  */</span><br><span> static int</span><br><span> get_=
cached_dns_entry(struct cached_dns_entry *dns_cache, const char *hostname, =
const char *servname,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                     int ai_family, int resolve_flags, struct addrinfo **ai=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
   int ai_family, unsigned int resolve_flags, struct addrinfo **ai)</span><=
br><span> {</span><br><span>     struct cached_dns_entry *ph;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int flags;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags;</span><br><span>=
 </span><br><span>     /* Only use flags that are relevant for the structur=
e */</span><br><span>     flags =3D resolve_flags &amp; GETADDR_CACHE_MASK;=
</span><br><span>@@ -269,7 +269,7 @@</span><br><span> </span><br><span> sta=
tic int</span><br><span> do_preresolve_host(struct context *c, const char *=
hostname, const char *servname, const int af,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                   const int flags)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                   const unsigned i=
nt flags)</span><br><span> {</span><br><span>     struct addrinfo *ai;</spa=
n><br><span>     int status;</span><br><span>@@ -323,7 +323,7 @@</span><br>=
<span>     {</span><br><span>         int status;</span><br><span>         =
const char *remote;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      int flags =3D preresolve_flags;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        unsigned int flags =3D preresolve_flags;</span><b=
r><span> </span><br><span>         struct connection_entry *ce =3D l-&gt;ar=
ray[i];</span><br><span> </span><br><span>@@ -1186,7 +1186,7 @@</span><br><=
span>     /* resolve local address if undefined */</span><br><span>     if =
(!sock-&gt;info.lsa-&gt;bind_local)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        int flags =3D GETADDR_RESOLVE =
| GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL | GETADDR_PASSIVE;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        unsigned int flags =3D GETA=
DDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL | GETADDR_PASSIVE;</sp=
an><br><span>         int status;</span><br><span> </span><br><span>       =
  if (proto_is_dgram(sock-&gt;info.proto))</span><br><span>diff --git a/src=
/openvpn/socket.h b/src/openvpn/socket.h</span><br><span>index cce9183..e45=
981f 100644</span><br><span>--- a/src/openvpn/socket.h</span><br><span>+++ =
b/src/openvpn/socket.h</span><br><span>@@ -67,7 +67,7 @@</span><br><span>  =
   const char *hostname;</span><br><span>     const char *servname;</span><=
br><span>     int ai_family;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    unsigned int flags;</span><br><span>     struct addrinfo *ai;</span><=
br><span>     struct cached_dns_entry *next;</span><br><span> };</span><br>=
<span>diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h</s=
pan><br><span>index ada52a4..f3dfd22 100644</span><br><span>--- a/src/openv=
pn/socket_util.h</span><br><span>+++ b/src/openvpn/socket_util.h</span><br>=
<span>@@ -114,18 +114,18 @@</span><br><span>  * DNS resolution</span><br><s=
pan>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define GETADDR_RESOLVE                 (1 &lt;&lt; 0)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_FATAL                =
   (1 &lt;&lt; 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine GETADDR_HOST_ORDER              (1 &lt;&lt; 2)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define GETADDR_MENTION_RESOLVE_RETRY   (1 &lt=
;&lt; 3)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETAD=
DR_FATAL_ON_SIGNAL         (1 &lt;&lt; 4)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define GETADDR_WARN_ON_SIGNAL          (1 &lt;&lt; 5)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_MSG_VI=
RT_OUT            (1 &lt;&lt; 6)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define GETADDR_TRY_ONCE                (1 &lt;&lt; 7)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_UPDATE_MANAGEME=
NT_STATE (1 &lt;&lt; 8)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define GETADDR_RANDOMIZE               (1 &lt;&lt; 9)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_PASSIVE                 =
(1 &lt;&lt; 10)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e GETADDR_DATAGRAM                (1 &lt;&lt; 11)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define GETADDR_RESOLVE                 (1u &=
lt;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define G=
ETADDR_FATAL                   (1u &lt;&lt; 1)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define GETADDR_HOST_ORDER              (1u &lt;=
&lt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETA=
DDR_MENTION_RESOLVE_RETRY   (1u &lt;&lt; 3)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define GETADDR_FATAL_ON_SIGNAL         (1u &lt;&lt=
; 4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR=
_WARN_ON_SIGNAL          (1u &lt;&lt; 5)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define GETADDR_MSG_VIRT_OUT            (1u &lt;&lt; 6=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_TR=
Y_ONCE                (1u &lt;&lt; 7)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define GETADDR_UPDATE_MANAGEMENT_STATE (1u &lt;&lt; 8)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_RANDO=
MIZE               (1u &lt;&lt; 9)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define GETADDR_PASSIVE                 (1u &lt;&lt; 10)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_DATAGRA=
M                (1u &lt;&lt; 11)</span><br><span> </span><br><span> #defin=
e GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)</span><br><span> =
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1131?usp=3Demail">change 1131</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1131?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ef21e425786a49c90d4b7305c3=
fb174ab6ddf92 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1131 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--/0KcPyNQApA=--

