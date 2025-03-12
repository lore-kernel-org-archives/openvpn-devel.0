From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 12 Mar 2025 21:52:28 +0000
References: <gerrit.1741816346000.I27f305d3ae9bf650bab409e99173688d9f88ab65@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <af3734d26265712334e0cba48f8b5876c2f0b7e3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wogSq2oTJck="; charset=UTF-8
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

--wogSq2oTJck=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/907?usp=3Demail

to review the following change.


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
1 file changed, 11 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/907/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6b32e30..808870b 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1724,9 +1724,17 @@
                 gai_strerror(status));
         }

-        /* the resolved 'local entry' might have a different family than w=
hat
-         * was globally configured */
-        sock->info.af =3D sock->info.lsa->bind_local->ai_family;
+        /* the resolved family makes sense only if the host is not ANY,
+         * otherwise getaddrinfo() may return v4 and break connections
+         * to v6 only remotes
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
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--wogSq2oTJck=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/907?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">socket: don&#39;t transfer bind family to socket in case of A=
NY address<br><br>With the introduction of multisocket, we need to transfer=
 the<br>AI family of the bound address to the socket, as it may differ<br>f=
rom what was set globally.<br><br>However, this operation makes sense only =
when getaddrinfo()<br>for bind is performed on a non-empty hostname.<br>An =
empty hostname (ANY) may return AF_INET which will break<br>following conne=
ction attempts to v6 only remotes.<br><br>Change-Id: I27f305d3ae9bf650bab40=
9e99173688d9f88ab65<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2787...=
...&gt;<br>---<br>M src/openvpn/socket.c<br>1 file changed, 11 insertions(+=
), 3 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/07/907/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/open=
vpn/socket.c</span><br><span>index 6b32e30..808870b 100644</span><br><span>=
--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span=
><br><span>@@ -1724,9 +1724,17 @@</span><br><span>                 gai_stre=
rror(status));</span><br><span>         }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /* the resolved &#39;local en=
try&#39; might have a different family than what</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-         * was globally configured */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;info.af =3D soc=
k-&gt;info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* the resolved family makes sense only if=
 the host is not ANY,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * otherwise getaddrinfo() may return v4 and break connections</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * to v6 only =
remotes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sock-&gt=
;local_host)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* th=
e resolved &#39;local entry&#39; might have a different family than</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+             * what was glo=
bally configured</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     sock-&gt;info.af =3D sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span>     }</span><br><span> </span><br><span>     gc_free(&amp;gc);</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/907?usp=3Demail">change 907</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/907?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I27f305d3ae9bf650bab409e9917=
3688d9f88ab65 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 907 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--wogSq2oTJck=--

