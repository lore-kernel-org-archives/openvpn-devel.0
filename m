From: "ordex (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 15:18:58 +0000
In-Reply-To: <gerrit.1761573316000.I54845bf4dd17d06cfc3b402f188795f74f4b1d3e@...2715...>
References: <gerrit.1761573316000.I54845bf4dd17d06cfc3b402f188795f74f4b1d3e@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <71115e999939cd224d01d5fe954041f0acc87d07-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gcNf85E6JFI="; charset=UTF-8
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

--gcNf85E6JFI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1314?usp=3Demail

to look at the new patch set (#2).


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

Reported-by: ZeroPath (https://zeropath.com/)
Change-Id: I54845bf4dd17d06cfc3b402f188795f74f4b1d3e
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/networking_sitnl.c
1 file changed, 4 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/14/1314/2

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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1314?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I54845bf4dd17d06cfc3b402f188795f74f4b1d3e
Gerrit-Change-Number: 1314
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--gcNf85E6JFI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>ordex <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1314?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">sitnl: set FD_CLOEXEC on socket to prevent abuse<br><br=
>Since OpenVPN spawns various child processes, it is important<br>that sock=
ets are closed after calling exec.<br><br>The sitnl socket didn&#39;t have =
the right flag set, resulting<br>in it surviving in, for example, connect/d=
isconnect scripts<br>and giving the latter a chance to abuse the socket.<br=
><br>Ensure this doesn&#39;t happen by setting FD_CLOEXEC on<br>this socket=
 right after creation.<br><br>Reported-by: ZeroPath (https://zeropath.com/)=
<br>Change-Id: I54845bf4dd17d06cfc3b402f188795f74f4b1d3e<br>Signed-off-by: =
Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/openvpn/networ=
king_sitnl.c<br>1 file changed, 4 insertions(+), 0 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/14/1314/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/networking_sitnl.c b/src/openv=
pn/networking_sitnl.c</span><br><span>index b3adb16..3e20b70 100644</span><=
br><span>--- a/src/openvpn/networking_sitnl.c</span><br><span>+++ b/src/ope=
nvpn/networking_sitnl.c</span><br><span>@@ -27,6 +27,7 @@</span><br><span> =
</span><br><span> #include &quot;dco.h&quot;</span><br><span> #include &quo=
t;errlevel.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;fdmisc.h&quot;</span><br><span> #include &quot;buffer.h&quot;=
</span><br><span> #include &quot;misc.h&quot;</span><br><span> #include &qu=
ot;networking.h&quot;</span><br><span>@@ -181,6 +182,9 @@</span><br><span> =
        return fd;</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* set close on exec to avoid c=
hild processes access the socket */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    set_cloexec(fd);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span>     if (setsockopt(fd, SOL_SOCKET, SO_SN=
DBUF, &amp;sndbuf, sizeof(sndbuf)) &lt; 0)</span><br><span>     {</span><br=
><span>         msg(M_WARN | M_ERRNO, &quot;%s: SO_SNDBUF&quot;, __func__);=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1314?usp=3Demail">change 1314</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1314?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I54845bf4dd17d06cfc3b402f188=
795f74f4b1d3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1314 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--gcNf85E6JFI=--

