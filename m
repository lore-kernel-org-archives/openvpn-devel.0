From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 23 Sep 2024 13:41:25 +0000
References: <gerrit.1727098847000.Ie2471e6b2d6974e70423b09918ad1c2136253754@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <4b34686b59b394fe61dc447f3083b91eb681f37d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tyCxjNoe+Lo="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tyCxjNoe+Lo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/762?usp=3Demail

to review the following change.


Change subject: override ai_family if 'local' numeric address was specified
......................................................................

override ai_family if 'local' numeric address was specified

This change ensures that when a numeric IP address is specified
as argument to a 'local' directive, its ai_family overrides
the one extracted from the 'proto' config option.

Change-Id: Ie2471e6b2d6974e70423b09918ad1c2136253754
Signed-off-by: Antonio Quartulli <a@...2181...>
---
M src/openvpn/socket.c
1 file changed, 9 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/762/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 27566c6..f152071 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -489,9 +489,8 @@
         sig_info =3D &sigrec;
     }

-    /* try numeric ipv6 addr first */
+    /* try numeric ip addr first */
     CLEAR(hints);
-    hints.ai_family =3D ai_family;
     hints.ai_flags =3D AI_NUMERICHOST;

     if (flags & GETADDR_PASSIVE)
@@ -519,6 +518,10 @@
         const char *fmt;
         int level =3D 0;

+        /* this is not a numeric IP, therefore force resolution using the
+         * provided ai_family */
+        hints.ai_family =3D ai_family;
+
         if (hostname && (flags & GETADDR_RANDOMIZE))
         {
             hostname =3D hostname_randomize(hostname, &gc);
@@ -1712,6 +1715,10 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newchange

--tyCxjNoe+Lo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/762?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">override ai_family if &#39;local&#39; numeric address was spe=
cified<br><br>This change ensures that when a numeric IP address is specifi=
ed<br>as argument to a &#39;local&#39; directive, its ai_family overrides<b=
r>the one extracted from the &#39;proto&#39; config option.<br><br>Change-I=
d: Ie2471e6b2d6974e70423b09918ad1c2136253754<br>Signed-off-by: Antonio Quar=
tulli &lt;a@...2181...&gt;<br>---<br>M src/openvpn/socket.c<br>1 file chang=
ed, 9 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/62/762/1</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/s=
ocket.c b/src/openvpn/socket.c</span><br><span>index 27566c6..f152071 10064=
4</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/open=
vpn/socket.c</span><br><span>@@ -489,9 +489,8 @@</span><br><span>         s=
ig_info =3D &amp;sigrec;</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* try numeric ipv6 addr fi=
rst */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* try nu=
meric ip addr first */</span><br><span>     CLEAR(hints);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    hints.ai_family =3D ai_family;</spa=
n><br><span>     hints.ai_flags =3D AI_NUMERICHOST;</span><br><span> </span=
><br><span>     if (flags &amp; GETADDR_PASSIVE)</span><br><span>@@ -519,6 =
+518,10 @@</span><br><span>         const char *fmt;</span><br><span>      =
   int level =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /* this is not a numeric IP, therefore force reso=
lution using the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      * provided ai_family */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        hints.ai_family =3D ai_family;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>         if (hostname &amp;&a=
mp; (flags &amp; GETADDR_RANDOMIZE))</span><br><span>         {</span><br><=
span>             hostname =3D hostname_randomize(hostname, &amp;gc);</span=
><br><span>@@ -1712,6 +1715,10 @@</span><br><span>                 sock-&gt=
;local_host, sock-&gt;local_port,</span><br><span>                 gai_stre=
rror(status));</span><br><span>         }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* the resolved &#39;local entry&#39; might have a different fam=
ily than what</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * was globally configured */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        sock-&gt;info.af =3D sock-&gt;info.lsa-&gt;bind_local-&=
gt;ai_family;</span><br><span>     }</span><br><span> </span><br><span>    =
 gc_free(&amp;gc);</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/762?usp=3Demail">change 762</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/762?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie2471e6b2d6974e70423b09918a=
d1c2136253754 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 762 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--tyCxjNoe+Lo=--

