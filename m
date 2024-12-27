From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 27 Dec 2024 17:37:25 +0000
In-Reply-To: <gerrit.1727098847000.Ie2471e6b2d6974e70423b09918ad1c2136253754@...2715...>
References: <gerrit.1727098847000.Ie2471e6b2d6974e70423b09918ad1c2136253754@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <496ebeccb55cdfe13d169e37ecd63e3583c67d40-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hYFwmQgQwYI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: override ai_family
 if 'local' numeric address was specified
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hYFwmQgQwYI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#10) to the change originally created b=
y its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/762?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: override ai_family if 'local' numeric address was specified
......................................................................

override ai_family if 'local' numeric address was specified

This change ensures that when a numeric IP address is specified
as argument to a 'local' directive, its ai_family overrides
the one extracted from the 'proto' config option.

Change-Id: Ie2471e6b2d6974e70423b09918ad1c2136253754
Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241227161755.4010-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
257.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
1 file changed, 16 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/762/10

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 01874fe..b895bd4 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -467,9 +467,8 @@
         sig_info =3D &sigrec;
     }

-    /* try numeric ipv6 addr first */
+    /* try numeric ip addr first */
     CLEAR(hints);
-    hints.ai_family =3D ai_family;
     hints.ai_flags =3D AI_NUMERICHOST;

     if (flags & GETADDR_PASSIVE)
@@ -486,6 +485,13 @@
         hints.ai_socktype =3D SOCK_STREAM;
     }

+    /* if hostname is not set, we want to bind to 'ANY', with
+     * the correct address family - v4-only or v6/v6-dual-stack */
+    if (!hostname)
+    {
+        hints.ai_family =3D ai_family;
+    }
+
     status =3D getaddrinfo(hostname, servname, &hints, res);

     if (status !=3D 0) /* parse as numeric address failed? */
@@ -497,6 +503,10 @@
         const char *fmt;
         int level =3D 0;

+        /* this is not a numeric IP, therefore force resolution using the
+         * provided ai_family */
+        hints.ai_family =3D ai_family;
+
         if (hostname && (flags & GETADDR_RANDOMIZE))
         {
             hostname =3D hostname_randomize(hostname, &gc);
@@ -1690,6 +1700,10 @@
                 sock->local_host, sock->local_port,
                 gai_strerror(status));
         }
+
+        /* the resolved 'local entry' might have a different family than w=
hat
+         * was globally configured */
+        sock->info.af =3D sock->info.lsa->bind_local->ai_family;
     }

     gc_free(&gc);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/762?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie2471e6b2d6974e70423b09918ad1c2136253754
Gerrit-Change-Number: 762
Gerrit-PatchSet: 10
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--hYFwmQgQwYI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #10</strong> to the change originally c=
reated by its_Giaan.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/762?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">override ai_family if &#39;local&#39; numeric addres=
s was specified<br><br>This change ensures that when a numeric IP address i=
s specified<br>as argument to a &#39;local&#39; directive, its ai_family ov=
errides<br>the one extracted from the &#39;proto&#39; config option.<br><br=
>Change-Id: Ie2471e6b2d6974e70423b09918ad1c2136253754<br>Signed-off-by: Ant=
onio Quartulli &lt;a@...2181...&gt;<br>Signed-off-by: Gianmarco De Gregori =
&lt;gianmarco@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&=
gt;<br>Message-Id: &lt;20241227161755.4010-1-gert@...1296...&gt;<br>URL: ht=
tps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30257.htm=
l<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/op=
envpn/socket.c<br>1 file changed, 16 insertions(+), 2 deletions(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/762/10</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><s=
pan>index 01874fe..b895bd4 100644</span><br><span>--- a/src/openvpn/socket.=
c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -467,9 +467=
,8 @@</span><br><span>         sig_info =3D &amp;sigrec;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* try numeric ipv6 addr first */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* try numeric ip addr first */</span><br><span>    =
 CLEAR(hints);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hin=
ts.ai_family =3D ai_family;</span><br><span>     hints.ai_flags =3D AI_NUME=
RICHOST;</span><br><span> </span><br><span>     if (flags &amp; GETADDR_PAS=
SIVE)</span><br><span>@@ -486,6 +485,13 @@</span><br><span>         hints.a=
i_socktype =3D SOCK_STREAM;</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* if hostname is not =
set, we want to bind to &#39;ANY&#39;, with</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * the correct address family - v4-only or v6/v=
6-dual-stack */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!hostname)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hints.ai_fa=
mily =3D ai_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     status =3D getaddrinfo(hostname, servname, &amp;hints, res);</span>=
<br><span> </span><br><span>     if (status !=3D 0) /* parse as numeric add=
ress failed? */</span><br><span>@@ -497,6 +503,10 @@</span><br><span>      =
   const char *fmt;</span><br><span>         int level =3D 0;</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* this=
 is not a numeric IP, therefore force resolution using the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         * provided ai_family */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        hints.ai_family=
 =3D ai_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>         if (hostname &amp;&amp; (flags &amp; GETADDR_RANDOMIZ=
E))</span><br><span>         {</span><br><span>             hostname =3D ho=
stname_randomize(hostname, &amp;gc);</span><br><span>@@ -1690,6 +1700,10 @@=
</span><br><span>                 sock-&gt;local_host, sock-&gt;local_port,=
</span><br><span>                 gai_strerror(status));</span><br><span>  =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* the resolved &#39;l=
ocal entry&#39; might have a different family than what</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * was globally configured */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;info=
.af =3D sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span>   =
  }</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/762?usp=3Demail">change 762</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/762?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie2471e6b2d6974e70423b09918a=
d1c2136253754 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 762 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--hYFwmQgQwYI=--

