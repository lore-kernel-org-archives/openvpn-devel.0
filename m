From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 19 May 2025 13:02:08 +0000
In-Reply-To: <gerrit.1741816346000.I27f305d3ae9bf650bab409e99173688d9f88ab65@...2715...>
References: <gerrit.1741816346000.I27f305d3ae9bf650bab409e99173688d9f88ab65@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <fa4a2cef857da478dad4e9599df0d154b8790079-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vd9nDjsxCew="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Vd9nDjsxCew=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/90=
7?usp=3Demail )

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
Gerrit-MessageType: merged

--Vd9nDjsxCew=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/907?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">socket: don&#39;t transfer bind family to sock=
et in case of ANY address<br><br>With the introduction of multisocket, we n=
eed to transfer the<br>AI family of the bound address to the socket, as it =
may differ<br>from what was set globally.<br><br>However, this operation ma=
kes sense only when getaddrinfo()<br>for bind is performed on a non-empty h=
ostname.<br>An empty hostname (ANY) may return AF_INET which will break<br>=
following connection attempts to v6 only remotes.<br><br>Change-Id: I27f305=
d3ae9bf650bab409e99173688d9f88ab65<br>Signed-off-by: Antonio Quartulli &lt;=
antonio@...2726...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...2477...=
.&gt;<br>Message-Id: &lt;20250325090121.28813-1-gert@...1296...&gt;<br>URL:=
 https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31235.=
html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src=
/openvpn/socket.c<br>1 file changed, 13 insertions(+), 3 deletions(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span=
>index 34a049e..93d793b 100644</span><br><span>--- a/src/openvpn/socket.c</=
span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -1741,9 +1741,=
19 @@</span><br><span>                 gai_strerror(status));</span><br><sp=
an>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        /* the resolved &#39;local entry&#39; might have a differ=
ent family than what</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
        * was globally configured */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        sock-&gt;info.af =3D sock-&gt;info.lsa-&gt;bind_loca=
l-&gt;ai_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* the address family returned by openvpn_getaddrinfo() should be</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         * taken into co=
nsideration only if we really passed an hostname</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         * to resolve. Otherwise its value is =
not useful to us and may</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         * actually break our socket, i.e. when it returns AF_INET</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         * but our remo=
te is v6 only.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (s=
ock-&gt;local_host)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  /* the resolved &#39;local entry&#39; might have a different family than<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * what =
was globally configured</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+             */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            sock-&gt;info.af =3D sock-&gt;info.lsa-&gt;bind_local-&gt;ai_fa=
mily;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span>     }</span><br><span> </span><br><span>     gc_free(&amp;gc);=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/907?usp=3Demail">change 907</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/907?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Vd9nDjsxCew=--

