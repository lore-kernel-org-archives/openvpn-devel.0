From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 19 May 2025 13:02:06 +0000
In-Reply-To: <gerrit.1741816346000.I27f305d3ae9bf650bab409e99173688d9f88ab65@...2715...>
References: <gerrit.1741816346000.I27f305d3ae9bf650bab409e99173688d9f88ab65@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <fa4a2cef857da478dad4e9599df0d154b8790079-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="khLcBoL/oUA="; charset=UTF-8
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

--khLcBoL/oUA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 ordex. ( http://gerrit.openvpn.net/c/openvpn/+/907?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250325090121.28813-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
235.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
1 file changed, 13 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/907/3

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 34a049e..93d793b 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1741,9 +1741,19 @@
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
=20
     gc_free(&gc);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/907?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I27f305d3ae9bf650bab409e99173688d9f88ab65
Gerrit-Change-Number: 907
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--khLcBoL/oUA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by ordex.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/907?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">socket: don&#39;t transfer bind family to socket=
 in case of ANY address<br><br>With the introduction of multisocket, we nee=
d to transfer the<br>AI family of the bound address to the socket, as it ma=
y differ<br>from what was set globally.<br><br>However, this operation make=
s sense only when getaddrinfo()<br>for bind is performed on a non-empty hos=
tname.<br>An empty hostname (ANY) may return AF_INET which will break<br>fo=
llowing connection attempts to v6 only remotes.<br><br>Change-Id: I27f305d3=
ae9bf650bab409e99173688d9f88ab65<br>Signed-off-by: Antonio Quartulli &lt;an=
tonio@...2726...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&=
gt;<br>Message-Id: &lt;20250325090121.28813-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31235.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/o=
penvpn/socket.c<br>1 file changed, 13 insertions(+), 3 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/907/3</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><s=
pan>index 34a049e..93d793b 100644</span><br><span>--- a/src/openvpn/socket.=
c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -1741,9 +17=
41,19 @@</span><br><span>                 gai_strerror(status));</span><br>=
<span>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        /* the resolved &#39;local entry&#39; might have a dif=
ferent family than what</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-         * was globally configured */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        sock-&gt;info.af =3D sock-&gt;info.lsa-&gt;bind_l=
ocal-&gt;ai_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* the address family returned by openvpn_getaddrinfo() should be</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * taken into=
 consideration only if we really passed an hostname</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * to resolve. Otherwise its valu=
e is not useful to us and may</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+         * actually break our socket, i.e. when it returns AF_INE=
T</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * but our=
 remote is v6 only.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (sock-&gt;local_host)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* the resolved &#39;local entry&#39; might have a different family =
than</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * =
what was globally configured</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+             */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            sock-&gt;info.af =3D sock-&gt;info.lsa-&gt;bind_local-&gt;=
ai_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span>     }</span><br><span> </span><br><span>     gc_free(&amp=
;gc);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/907?usp=3Demail">change 907</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/907?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I27f305d3ae9bf650bab409e9917=
3688d9f88ab65 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 907 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--khLcBoL/oUA=--

