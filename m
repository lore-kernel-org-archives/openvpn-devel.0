From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 27 Dec 2024 11:02:36 +0000
In-Reply-To: <gerrit.1727098847000.Ie2471e6b2d6974e70423b09918ad1c2136253754@...2715...>
References: <gerrit.1727098847000.Ie2471e6b2d6974e70423b09918ad1c2136253754@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <fa886e10b7658e8284e89c22194064328ed4fcae-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nXVp7BVEnWA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nXVp7BVEnWA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello cron2, flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/762?usp=3Demail

to look at the new patch set (#8).


Change subject: override ai_family if 'local' numeric address was specified
......................................................................

override ai_family if 'local' numeric address was specified

This change ensures that when a numeric IP address is specified
as argument to a 'local' directive, its ai_family overrides
the one extracted from the 'proto' config option.

Change-Id: Ie2471e6b2d6974e70423b09918ad1c2136253754
Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/socket.c
1 file changed, 14 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/762/8

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7921433..0d7cd21 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -488,11 +488,15 @@
         sig_info =3D &sigrec;
     }

-    /* try numeric ipv6 addr first */
+    /* try numeric ip addr first */
     CLEAR(hints);
-    hints.ai_family =3D ai_family;
     hints.ai_flags =3D AI_NUMERICHOST;

+    if (!hostname)
+    {
+        hints.ai_family =3D ai_family;
+    }
+
     if (flags & GETADDR_PASSIVE)
     {
         hints.ai_flags |=3D AI_PASSIVE;
@@ -518,6 +522,10 @@
         const char *fmt;
         int level =3D 0;

+        /* this is not a numeric IP, therefore force resolution using the
+         * provided ai_family */
+        hints.ai_family =3D ai_family;
+
         if (hostname && (flags & GETADDR_RANDOMIZE))
         {
             hostname =3D hostname_randomize(hostname, &gc);
@@ -1716,6 +1724,10 @@
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
Gerrit-PatchSet: 8
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--nXVp7BVEnWA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p>its_Giaan <strong>uploaded patch set #8</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/762?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">override ai_family if &#39;local&#39; numeric address was specified<b=
r><br>This change ensures that when a numeric IP address is specified<br>as=
 argument to a &#39;local&#39; directive, its ai_family overrides<br>the on=
e extracted from the &#39;proto&#39; config option.<br><br>Change-Id: Ie247=
1e6b2d6974e70423b09918ad1c2136253754<br>Signed-off-by: Antonio Quartulli &l=
t;a@...2181...&gt;<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...493...=
2726...&gt;<br>---<br>M src/openvpn/socket.c<br>1 file changed, 14 insertio=
ns(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/62/762/8</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/=
openvpn/socket.c</span><br><span>index 7921433..0d7cd21 100644</span><br><s=
pan>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</=
span><br><span>@@ -488,11 +488,15 @@</span><br><span>         sig_info =3D =
&amp;sigrec;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* try numeric ipv6 addr first */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* try numeric ip add=
r first */</span><br><span>     CLEAR(hints);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    hints.ai_family =3D ai_family;</span><br><span>=
     hints.ai_flags =3D AI_NUMERICHOST;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!hostname)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        hints.ai_family =3D ai_family;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     if (flags &amp; GETADDR_P=
ASSIVE)</span><br><span>     {</span><br><span>         hints.ai_flags |=3D=
 AI_PASSIVE;</span><br><span>@@ -518,6 +522,10 @@</span><br><span>         =
const char *fmt;</span><br><span>         int level =3D 0;</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* this is=
 not a numeric IP, therefore force resolution using the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * provided ai_family */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        hints.ai_family =
=3D ai_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>         if (hostname &amp;&amp; (flags &amp; GETADDR_RANDOMIZE=
))</span><br><span>         {</span><br><span>             hostname =3D hos=
tname_randomize(hostname, &amp;gc);</span><br><span>@@ -1716,6 +1724,10 @@<=
/span><br><span>                 sock-&gt;local_host, sock-&gt;local_port,<=
/span><br><span>                 gai_strerror(status));</span><br><span>   =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* the resolved &#39;lo=
cal entry&#39; might have a different family than what</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * was globally configured */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;info.=
af =3D sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span>    =
 }</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/762?usp=3Demail">change 762</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/762?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie2471e6b2d6974e70423b09918a=
d1c2136253754 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 762 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--nXVp7BVEnWA=--

