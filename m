From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 18 Mar 2025 03:32:49 +0000
In-Reply-To: <gerrit.1741816346000.I27f305d3ae9bf650bab409e99173688d9f88ab65@...2715...>
References: <gerrit.1741816346000.I27f305d3ae9bf650bab409e99173688d9f88ab65@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a8f823abfb38d474b43253970b376e490c783fa3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UGXrUwssPtM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: don't
 transfer bind family to socket in case of ANY address
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

--UGXrUwssPtM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/907?usp=3Demail

to look at the new patch set (#2).


Change subject: socket: don't transfer bind family to socket in case of ANY=
 address
......................................................................

socket: don't transfer bind family to socket in case of ANY address

With the introduction of multisocket, we need to transfer the
AI family of the bound address to the socket, as it may differ
from what was set globally.

However, this operation makes sense only when getaddrinfo()
for bind is performed on a non-empty hostname.
An empty hostname (ANY) may return AF_INET which will break
following connection attempts to v6 only remotes.

Change-Id: I27f305d3ae9bf650bab409e99173688d9f88ab65
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/socket.c
1 file changed, 13 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/907/2

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6b32e30..be7395d 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1724,9 +1724,19 @@
                 gai_strerror(status));
         }

-        /* the resolved 'local entry' might have a different family than w=
hat
-         * was globally configured */
-        sock->info.af =3D sock->info.lsa->bind_local->ai_family;
+        /* the address family returned by openvpn_getaddrinfo() should be
+         * taken into consideration only if we really passed an hostname
+         * to resolve. Otherwise its value is not useful to us and may
+         * actually break our socket, i.e. when it returns AF_INET
+         * but our remote is v6 only.
+         */
+        if (sock->local_host)
+        {
+            /* the resolved 'local entry' might have a different family th=
an
+             * what was globally configured
+             */
+            sock->info.af =3D sock->info.lsa->bind_local->ai_family;
+        }
     }

     gc_free(&gc);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/907?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I27f305d3ae9bf650bab409e99173688d9f88ab65
Gerrit-Change-Number: 907
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--UGXrUwssPtM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/907?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">socket: don&#39;t transfer bind family to socket in case of ANY address<b=
r><br>With the introduction of multisocket, we need to transfer the<br>AI f=
amily of the bound address to the socket, as it may differ<br>from what was=
 set globally.<br><br>However, this operation makes sense only when getaddr=
info()<br>for bind is performed on a non-empty hostname.<br>An empty hostna=
me (ANY) may return AF_INET which will break<br>following connection attemp=
ts to v6 only remotes.<br><br>Change-Id: I27f305d3ae9bf650bab409e99173688d9=
f88ab65<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>-=
--<br>M src/openvpn/socket.c<br>1 file changed, 13 insertions(+), 3 deletio=
ns(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/07/907/2</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c=
</span><br><span>index 6b32e30..be7395d 100644</span><br><span>--- a/src/op=
envpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@=
@ -1724,9 +1724,19 @@</span><br><span>                 gai_strerror(status)=
);</span><br><span>         }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        /* the resolved &#39;local entry&#39; mig=
ht have a different family than what</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         * was globally configured */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;info.af =3D sock-&gt;info.=
lsa-&gt;bind_local-&gt;ai_family;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* the address family returned by openvpn_getaddrinfo=
() should be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  * taken into consideration only if we really passed an hostname</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * to resolve. Otherw=
ise its value is not useful to us and may</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         * actually break our socket, i.e. when it re=
turns AF_INET</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * but our remote is v6 only.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (sock-&gt;local_host)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            /* the resolved &#39;local entry&#39; might have a diffe=
rent family than</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          * what was globally configured</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+             */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            sock-&gt;info.af =3D sock-&gt;info.lsa-&gt;bin=
d_local-&gt;ai_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span>     }</span><br><span> </span><br><span>     =
gc_free(&amp;gc);</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/907?usp=3Demail">change 907</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/907?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I27f305d3ae9bf650bab409e9917=
3688d9f88ab65 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 907 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--UGXrUwssPtM=--

