From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 28 Jul 2023 13:03:27 +0000
References: <gerrit.1690549401000.I45cd0917d24570ae9e9db7eb6c370756e4595842@...2715...>
Reply-To: frank@...2641..., openvpn-devel@lists.sourceforge.net
Message-ID: <eec63649da3e2e5118634390cb6a88a02cbc5786-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TeAVvlWl3wU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix various
 "Uninitialized scalar variable" warnings from Coverity
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TeAVvlWl3wU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has uploaded this change for review. ( http://gerrit.openvpn.n=
et/c/openvpn/+/318?usp=3Demail )


Change subject: Fix various "Uninitialized scalar variable" warnings from C=
overity
......................................................................

Fix various "Uninitialized scalar variable" warnings from Coverity

These are all not actually problems, since the
uninitialized parts are either .unused members of the
struct (mroute_addr) or only written to (buflen), but
still doesn't hurt to explicitely initialize them.

Change-Id: I45cd0917d24570ae9e9db7eb6c370756e4595842
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/pkcs11_openssl.c
M src/openvpn/socket.c
4 files changed, 7 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/318/1

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 81625ea..e6c99ae 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -188,7 +188,7 @@
 multi_get_create_instance_udp(struct multi_context *m, bool *floated)
 {
     struct gc_arena gc =3D gc_new();
-    struct mroute_addr real;
+    struct mroute_addr real =3D {0};
     struct multi_instance *mi =3D NULL;
     struct hash *hash =3D m->hash;

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index aad11b1..728a7b8 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1234,7 +1234,7 @@
                       bool primary)
 {
     struct openvpn_sockaddr remote_si;
-    struct mroute_addr addr;
+    struct mroute_addr addr =3D {0};

     CLEAR(remote_si);
     remote_si.addr.in4.sin_family =3D AF_INET;
@@ -1273,7 +1273,7 @@
                      int netbits,   /* -1 if host route, otherwise # of ne=
twork bits in address */
                      bool primary)
 {
-    struct mroute_addr addr;
+    struct mroute_addr addr =3D {0};

     addr.len =3D 16;
     addr.type =3D MR_ADDR_IPV6;
@@ -3118,7 +3118,7 @@
 void
 multi_process_float(struct multi_context *m, struct multi_instance *mi)
 {
-    struct mroute_addr real;
+    struct mroute_addr real =3D {0};
     struct hash *hash =3D m->hash;
     struct gc_arena gc =3D gc_new();

@@ -3532,7 +3532,7 @@
     if (BLEN(&m->top.c2.buf) > 0)
     {
         unsigned int mroute_flags;
-        struct mroute_addr src, dest;
+        struct mroute_addr src =3D {0}, dest =3D {0};
         const int dev_type =3D TUNNEL_TYPE(m->top.c1.tuntap);
         int16_t vid =3D 0;

diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 40080ef..0ddabc7 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -166,7 +166,7 @@
     CK_RSA_PKCS_PSS_PARAMS pss_params =3D {0};

     unsigned char buf[EVP_MAX_MD_SIZE];
-    size_t buflen;
+    size_t buflen =3D 0;
     size_t siglen_max =3D *siglen;

     unsigned char enc[EVP_MAX_MD_SIZE + 32]; /* 32 bytes enough for Digest=
Info header */
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 2d765cc..58231fb 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3301,7 +3301,7 @@
 {
     struct iovec iov;
     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];
-    struct msghdr mesg;
+    struct msghdr mesg =3D {0};
     socklen_t fromlen =3D sizeof(from->dest.addr);

     ASSERT(sock->sd >=3D 0);                      /* can't happen */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/318?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I45cd0917d24570ae9e9db7eb6c370756e4595842
Gerrit-Change-Number: 318
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newchange

--TeAVvlWl3wU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>flichtenheld has uploaded this change for <strong>review</strong>.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/318?usp=3Demail">View Cha=
nge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">Fix various &quot;Uninitialized scalar variable&quot; warnings from=
 Coverity<br><br>These are all not actually problems, since the<br>uninitia=
lized parts are either .unused members of the<br>struct (mroute_addr) or on=
ly written to (buflen), but<br>still doesn&#39;t hurt to explicitely initia=
lize them.<br><br>Change-Id: I45cd0917d24570ae9e9db7eb6c370756e4595842<br>S=
igned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/op=
envpn/mudp.c<br>M src/openvpn/multi.c<br>M src/openvpn/pkcs11_openssl.c<br>=
M src/openvpn/socket.c<br>4 files changed, 7 insertions(+), 7 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/3=
18/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br=
><span>index 81625ea..e6c99ae 100644</span><br><span>--- a/src/openvpn/mudp=
.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -188,7 +188,=
7 @@</span><br><span> multi_get_create_instance_udp(struct multi_context *m=
, bool *floated)</span><br><span> {</span><br><span>     struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
uct mroute_addr real;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct mroute_addr real =3D {0};</span><br><span>     struct multi_in=
stance *mi =3D NULL;</span><br><span>     struct hash *hash =3D m-&gt;hash;=
</span><br><span> </span><br><span>diff --git a/src/openvpn/multi.c b/src/o=
penvpn/multi.c</span><br><span>index aad11b1..728a7b8 100644</span><br><spa=
n>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span=
><br><span>@@ -1234,7 +1234,7 @@</span><br><span>                       boo=
l primary)</span><br><span> {</span><br><span>     struct openvpn_sockaddr =
remote_si;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
mroute_addr addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct mroute_addr addr =3D {0};</span><br><span> </span><br><span>     C=
LEAR(remote_si);</span><br><span>     remote_si.addr.in4.sin_family =3D AF_=
INET;</span><br><span>@@ -1273,7 +1273,7 @@</span><br><span>               =
       int netbits,   /* -1 if host route, otherwise # of network bits in a=
ddress */</span><br><span>                      bool primary)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct mrout=
e_addr addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct mroute_addr addr =3D {0};</span><br><span> </span><br><span>     addr.l=
en =3D 16;</span><br><span>     addr.type =3D MR_ADDR_IPV6;</span><br><span=
>@@ -3118,7 +3118,7 @@</span><br><span> void</span><br><span> multi_process=
_float(struct multi_context *m, struct multi_instance *mi)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct mroute_a=
ddr real;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 mroute_addr real =3D {0};</span><br><span>     struct hash *hash =3D m-&gt=
;hash;</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><spa=
n> </span><br><span>@@ -3532,7 +3532,7 @@</span><br><span>     if (BLEN(&am=
p;m-&gt;top.c2.buf) &gt; 0)</span><br><span>     {</span><br><span>        =
 unsigned int mroute_flags;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        struct mroute_addr src, dest;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct mroute_addr src =3D {0}, dest =3D {0=
};</span><br><span>         const int dev_type =3D TUNNEL_TYPE(m-&gt;top.c1=
.tuntap);</span><br><span>         int16_t vid =3D 0;</span><br><span> </sp=
an><br><span>diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11=
_openssl.c</span><br><span>index 40080ef..0ddabc7 100644</span><br><span>--=
- a/src/openvpn/pkcs11_openssl.c</span><br><span>+++ b/src/openvpn/pkcs11_o=
penssl.c</span><br><span>@@ -166,7 +166,7 @@</span><br><span>     CK_RSA_PK=
CS_PSS_PARAMS pss_params =3D {0};</span><br><span> </span><br><span>     un=
signed char buf[EVP_MAX_MD_SIZE];</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    size_t buflen;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    size_t buflen =3D 0;</span><br><span>     size_t siglen_max =
=3D *siglen;</span><br><span> </span><br><span>     unsigned char enc[EVP_M=
AX_MD_SIZE + 32]; /* 32 bytes enough for DigestInfo header */</span><br><sp=
an>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span=
>index 2d765cc..58231fb 100644</span><br><span>--- a/src/openvpn/socket.c</=
span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -3301,7 +3301,=
7 @@</span><br><span> {</span><br><span>     struct iovec iov;</span><br><s=
pan>     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct msghdr mesg;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct msghdr mesg =3D {0};</span><br><sp=
an>     socklen_t fromlen =3D sizeof(from-&gt;dest.addr);</span><br><span> =
</span><br><span>     ASSERT(sock-&gt;sd &gt;=3D 0);                      /=
* can&#39;t happen */</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/318?usp=3Demail">change 318<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/318?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I45cd0917d24570ae9e9db7eb6c3=
70756e4595842 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 318 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--TeAVvlWl3wU=--

