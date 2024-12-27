From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 27 Dec 2024 12:39:19 +0000
In-Reply-To: <gerrit.1727098847000.Ie2471e6b2d6974e70423b09918ad1c2136253754@...2715...>
References: <gerrit.1727098847000.Ie2471e6b2d6974e70423b09918ad1c2136253754@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <dd4609d6a8c291b21a265395285e44ba1b733c51-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Sbb/mpzCGho="; charset=UTF-8
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

--Sbb/mpzCGho=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos.

Hello cron2, flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/762?usp=3Demail

to look at the new patch set (#9).


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
1 file changed, 16 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/762/9

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7921433..b84521a 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -488,9 +488,8 @@
         sig_info =3D &sigrec;
     }

-    /* try numeric ipv6 addr first */
+    /* try numeric ip addr first */
     CLEAR(hints);
-    hints.ai_family =3D ai_family;
     hints.ai_flags =3D AI_NUMERICHOST;

     if (flags & GETADDR_PASSIVE)
@@ -507,6 +506,13 @@
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
@@ -518,6 +524,10 @@
         const char *fmt;
         int level =3D 0;

+        /* this is not a numeric IP, therefore force resolution using the
+         * provided ai_family */
+        hints.ai_family =3D ai_family;
+
         if (hostname && (flags & GETADDR_RANDOMIZE))
         {
             hostname =3D hostname_randomize(hostname, &gc);
@@ -1716,6 +1726,10 @@
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
Gerrit-PatchSet: 9
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--Sbb/mpzCGho=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, ordex, p=
laisthos. </p>
<p>its_Giaan <strong>uploaded patch set #9</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/762?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">override ai_family if &#39;local&#39; numeric address was specified<b=
r><br>This change ensures that when a numeric IP address is specified<br>as=
 argument to a &#39;local&#39; directive, its ai_family overrides<br>the on=
e extracted from the &#39;proto&#39; config option.<br><br>Change-Id: Ie247=
1e6b2d6974e70423b09918ad1c2136253754<br>Signed-off-by: Antonio Quartulli &l=
t;a@...2181...&gt;<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...493...=
2726...&gt;<br>---<br>M src/openvpn/socket.c<br>1 file changed, 16 insertio=
ns(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/62/762/9</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/=
openvpn/socket.c</span><br><span>index 7921433..b84521a 100644</span><br><s=
pan>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</=
span><br><span>@@ -488,9 +488,8 @@</span><br><span>         sig_info =3D &a=
mp;sigrec;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* try numeric ipv6 addr first */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* try numeric ip add=
r first */</span><br><span>     CLEAR(hints);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    hints.ai_family =3D ai_family;</span><br><span>=
     hints.ai_flags =3D AI_NUMERICHOST;</span><br><span> </span><br><span> =
    if (flags &amp; GETADDR_PASSIVE)</span><br><span>@@ -507,6 +506,13 @@</=
span><br><span>         hints.ai_socktype =3D SOCK_STREAM;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* if hostname is not set, we want to bind to &#39;ANY&#39;, with<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the correct a=
ddress family - v4-only or v6/v6-dual-stack */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!hostname)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        hints.ai_family =3D ai_family;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span>     status =3D getaddrinfo(hostname, ser=
vname, &amp;hints, res);</span><br><span> </span><br><span>     if (status =
!=3D 0) /* parse as numeric address failed? */</span><br><span>@@ -518,6 +5=
24,10 @@</span><br><span>         const char *fmt;</span><br><span>        =
 int level =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* this is not a numeric IP, therefore force resolu=
tion using the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    * provided ai_family */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        hints.ai_family =3D ai_family;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>         if (hostname &amp;&amp=
; (flags &amp; GETADDR_RANDOMIZE))</span><br><span>         {</span><br><sp=
an>             hostname =3D hostname_randomize(hostname, &amp;gc);</span><=
br><span>@@ -1716,6 +1726,10 @@</span><br><span>                 sock-&gt;l=
ocal_host, sock-&gt;local_port,</span><br><span>                 gai_strerr=
or(status));</span><br><span>         }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* the resolved &#39;local entry&#39; might have a different famil=
y than what</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * was globally configured */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        sock-&gt;info.af =3D sock-&gt;info.lsa-&gt;bind_local-&gt=
;ai_family;</span><br><span>     }</span><br><span> </span><br><span>     g=
c_free(&amp;gc);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/762?usp=3Demail">change 762</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/762?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie2471e6b2d6974e70423b09918a=
d1c2136253754 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 762 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Sbb/mpzCGho=--

