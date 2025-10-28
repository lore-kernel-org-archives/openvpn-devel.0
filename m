From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 16:35:39 +0000
In-Reply-To: <gerrit.1761573316000.I54845bf4dd17d06cfc3b402f188795f74f4b1d3e@...2715...>
References: <gerrit.1761573316000.I54845bf4dd17d06cfc3b402f188795f74f4b1d3e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <2f671f9d992948f379a09cdbbf8338573724f1ee-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8n6sBPLdMZ8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: sitnl: set
 FD_CLOEXEC on socket to prevent abuse
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8n6sBPLdMZ8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 ordex. ( http://gerrit.openvpn.net/c/openvpn/+/1314?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: sitnl: set FD_CLOEXEC on socket to prevent abuse
......................................................................

sitnl: set FD_CLOEXEC on socket to prevent abuse

Since OpenVPN spawns various child processes, it is important
that sockets are closed after calling exec.

The sitnl socket didn't have the right flag set, resulting
in it surviving in, for example, connect/disconnect scripts
and giving the latter a chance to abuse the socket.

Ensure this doesn't happen by setting FD_CLOEXEC on
this socket right after creation.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Change-Id: I54845bf4dd17d06cfc3b402f188795f74f4b1d3e
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1314
Message-Id: <20251028162843.18189-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
952.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M src/openvpn/networking_sitnl.c
M tests/unit_tests/openvpn/Makefile.am
3 files changed, 6 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/14/1314/5

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5954a6e..bf754f3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -923,6 +923,7 @@
             src/openvpn/crypto_openssl.c
             src/openvpn/crypto.c
             src/openvpn/crypto_epoch.c
+            src/openvpn/fdmisc.c
             src/openvpn/otime.c
             src/openvpn/packet_id.c
             )
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index b3adb16..3e20b70 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -27,6 +27,7 @@

 #include "dco.h"
 #include "errlevel.h"
+#include "fdmisc.h"
 #include "buffer.h"
 #include "misc.h"
 #include "networking.h"
@@ -181,6 +182,9 @@
         return fd;
     }

+    /* set close on exec to avoid child processes access the socket */
+    set_cloexec(fd);
+
     if (setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf)) < 0)
     {
         msg(M_WARN | M_ERRNO, "%s: SO_SNDBUF", __func__);
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 997703a..0f13172 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -196,6 +196,7 @@
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/fdmisc.c \
 	$(top_srcdir)/src/openvpn/otime.c \
 	$(top_srcdir)/src/openvpn/packet_id.c \
 	$(top_srcdir)/src/openvpn/platform.c

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1314?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I54845bf4dd17d06cfc3b402f188795f74f4b1d3e
Gerrit-Change-Number: 1314
Gerrit-PatchSet: 5
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8n6sBPLdMZ8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by ordex.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1314?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">sitnl: set FD_CLOEXEC on socket to =
prevent abuse<br><br>Since OpenVPN spawns various child processes, it is im=
portant<br>that sockets are closed after calling exec.<br><br>The sitnl soc=
ket didn&#39;t have the right flag set, resulting<br>in it surviving in, fo=
r example, connect/disconnect scripts<br>and giving the latter a chance to =
abuse the socket.<br><br>Ensure this doesn&#39;t happen by setting FD_CLOEX=
EC on<br>this socket right after creation.<br><br>Reported-by: Joshua Roger=
s &lt;contact@...2949...&gt;<br>Found-by: ZeroPath (https://zeropath.com/)<=
br>Change-Id: I54845bf4dd17d06cfc3b402f188795f74f4b1d3e<br>Signed-off-by: A=
ntonio Quartulli &lt;antonio@...2726...&gt;<br>Acked-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/13=
14<br>Message-Id: &lt;20251028162843.18189-1-gert@...1296...&gt;<br>URL: ht=
tps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33952.htm=
l<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeL=
ists.txt<br>M src/openvpn/networking_sitnl.c<br>M tests/unit_tests/openvpn/=
Makefile.am<br>3 files changed, 6 insertions(+), 0 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/14/1314/5</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br>=
<span>index 5954a6e..bf754f3 100644</span><br><span>--- a/CMakeLists.txt</s=
pan><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -923,6 +923,7 @@</spa=
n><br><span>             src/openvpn/crypto_openssl.c</span><br><span>     =
        src/openvpn/crypto.c</span><br><span>             src/openvpn/crypt=
o_epoch.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  src/openvpn/fdmisc.c</span><br><span>             src/openvpn/otime.c</sp=
an><br><span>             src/openvpn/packet_id.c</span><br><span>         =
    )</span><br><span>diff --git a/src/openvpn/networking_sitnl.c b/src/ope=
nvpn/networking_sitnl.c</span><br><span>index b3adb16..3e20b70 100644</span=
><br><span>--- a/src/openvpn/networking_sitnl.c</span><br><span>+++ b/src/o=
penvpn/networking_sitnl.c</span><br><span>@@ -27,6 +27,7 @@</span><br><span=
> </span><br><span> #include &quot;dco.h&quot;</span><br><span> #include &q=
uot;errlevel.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;fdmisc.h&quot;</span><br><span> #include &quot;buffer.h&quo=
t;</span><br><span> #include &quot;misc.h&quot;</span><br><span> #include &=
quot;networking.h&quot;</span><br><span>@@ -181,6 +182,9 @@</span><br><span=
>         return fd;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* set close on exec to avoid=
 child processes access the socket */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    set_cloexec(fd);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     if (setsockopt(fd, SOL_SOCKET, SO_=
SNDBUF, &amp;sndbuf, sizeof(sndbuf)) &lt; 0)</span><br><span>     {</span><=
br><span>         msg(M_WARN | M_ERRNO, &quot;%s: SO_SNDBUF&quot;, __func__=
);</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile.am b/test=
s/unit_tests/openvpn/Makefile.am</span><br><span>index 997703a..0f13172 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><s=
pan>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br><span>@@ -196,6 +1=
96,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span>=
<br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span> 	=
$(top_srcdir)/src/openvpn/crypto_openssl.c \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/fdmisc.c \</span><br><s=
pan> 	$(top_srcdir)/src/openvpn/otime.c \</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/packet_id.c \</span><br><span> 	$(top_srcdir)/src/openvpn/platfo=
rm.c</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1314?usp=3Demail">change 1314</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1314?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I54845bf4dd17d06cfc3b402f188=
795f74f4b1d3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1314 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--8n6sBPLdMZ8=--

