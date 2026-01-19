From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 19 Jan 2026 17:09:36 +0000
In-Reply-To: <gerrit.1768578994000.I5ad13bc6674b3403251cc552d1f2c0f057431817@...2715...>
References: <gerrit.1768578994000.I5ad13bc6674b3403251cc552d1f2c0f057431817@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <aca10b510787ac8d72ed7a5e64540d8e12f51abc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9NaPAA5Y4kM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: Avoid
 conversion warning in get_addr_generic
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

--9NaPAA5Y4kM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
75?usp=3Demail )

Change subject: socket: Avoid conversion warning in get_addr_generic
......................................................................

socket: Avoid conversion warning in get_addr_generic

We already check earlier that bits is smaller that
max_bits, so the cast is safe.

While reviewing the callers, remove some unused
variables.

Change-Id: I5ad13bc6674b3403251cc552d1f2c0f057431817
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1475
Message-Id: <20260119122556.15225-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
324.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
M src/openvpn/socket.c
2 files changed, 11 insertions(+), 14 deletions(-)




diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cede758..85669e0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1144,10 +1144,7 @@
 static bool
 ipv6_addr_safe_hexplusbits(const char *ipv6_prefix_spec)
 {
-    struct in6_addr t_addr;
-    unsigned int t_bits;
-
-    return get_ipv6_addr(ipv6_prefix_spec, &t_addr, &t_bits, M_WARN);
+    return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WARN);
 }
=20
 static char *
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 093f822..331249d 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -72,11 +72,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Functions related to the translation of DNS names to IP addresses.
  */
@@ -180,7 +175,7 @@

     if (netbits)
     {
-        *netbits =3D bits;
+        *netbits =3D (unsigned int)bits;
     }

     /* restore '/' separator, if any */
@@ -683,6 +678,11 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static void
 create_socket(struct link_socket *sock, struct addrinfo *addr)
 {
@@ -738,6 +738,10 @@
     bind_local(sock, addr->ai_family);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #ifdef TARGET_ANDROID
 static void
 protect_fd_nonlocal(int fd, const struct sockaddr *addr)
@@ -861,10 +865,6 @@
     gc_free(&gc);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static socket_descriptor_t
 socket_listen_accept(socket_descriptor_t sd, struct link_socket_actual *ac=
t,
                      const struct addrinfo *local, bool do_listen,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1475?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ad13bc6674b3403251cc552d1f2c0f057431817
Gerrit-Change-Number: 1475
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9NaPAA5Y4kM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1475?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">socket: Avoid conversion warning in get_addr_gen=
eric<br><br>We already check earlier that bits is smaller that<br>max_bits,=
 so the cast is safe.<br><br>While reviewing the callers, remove some unuse=
d<br>variables.<br><br>Change-Id: I5ad13bc6674b3403251cc552d1f2c0f057431817=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: =
Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.=
net/c/openvpn/+/1475<br>Message-Id: &lt;20260119122556.15225-1-gert@...1726...=
...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1483...=
e.net/msg35324.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<=
br>---<br>M src/openvpn/options.c<br>M src/openvpn/socket.c<br>2 files chan=
ged, 11 insertions(+), 14 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index cede758..85669e0 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -1144,10 +=
1144,7 @@</span><br><span> static bool</span><br><span> ipv6_addr_safe_hexp=
lusbits(const char *ipv6_prefix_spec)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct in6_addr t_addr;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    unsigned int t_bits;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return get_ipv6_addr(ipv6_prefix_spec, &amp;t_ad=
dr, &amp;t_bits, M_WARN);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WARN);</span=
><br><span> }</span><br><span> </span><br><span> static char *</span><br><s=
pan>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><spa=
n>index 093f822..331249d 100644</span><br><span>--- a/src/openvpn/socket.c<=
/span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -72,11 +72,6 =
@@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> /*</span><br><span>  * Functions related to =
the translation of DNS names to IP addresses.</span><br><span>  */</span><b=
r><span>@@ -180,7 +175,7 @@</span><br><span> </span><br><span>     if (netb=
its)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        *netbits =3D bits;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        *netbits =3D (unsigned int)bits;</span><br><span>     =
}</span><br><span> </span><br><span>     /* restore &#39;/&#39; separator, =
if any */</span><br><span>@@ -683,6 +678,11 @@</span><br><span>     }</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored =
&quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> static void</span><br><span> create_socket(struct link_socket *so=
ck, struct addrinfo *addr)</span><br><span> {</span><br><span>@@ -738,6 +73=
8,10 @@</span><br><span>     bind_local(sock, addr-&gt;ai_family);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> #ifdef TARGET_ANDROID</span><=
br><span> static void</span><br><span> protect_fd_nonlocal(int fd, const st=
ruct sockaddr *addr)</span><br><span>@@ -861,10 +865,6 @@</span><br><span> =
    gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diag=
nostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static s=
ocket_descriptor_t</span><br><span> socket_listen_accept(socket_descriptor_=
t sd, struct link_socket_actual *act,</span><br><span>                     =
 const struct addrinfo *local, bool do_listen,</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/147=
5?usp=3Demail">change 1475</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1475?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ad13bc6674b3403251cc552d1f=
2c0f057431817 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1475 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--9NaPAA5Y4kM=--

