From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 13:45:14 +0000
References: <gerrit.1700055887000.I8c9ec61af9e786ec284e756ec3a77a959c79f49b@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e421e135fdda0f54c3af1637635955c5d1ec3407-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ae0t8xgNfHg="; charset=UTF-8
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

--ae0t8xgNfHg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/437?usp=3Demail

to review the following change.


Change subject: override ai_family if 'local' numeric address was specified
......................................................................

override ai_family if 'local' numeric address was specified

This change ensures that when a numeric IP address is specified
as argument to a 'local' directive, its ai_family overrides
the one extracted from the 'proto' config option.

Change-Id: I8c9ec61af9e786ec284e756ec3a77a959c79f49b
Signed-off-by: Antonio Quartulli <a@...2181...>
---
M src/openvpn/socket.c
1 file changed, 11 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/37/437/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 5d9e111..ffd8daf 100644
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
=20
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
@@ -1120,7 +1123,9 @@
             /* force binding IPv6-only if an address was specified
              * an it is a IPv6 */
             if (sock->local_host && ai_family =3D=3D AF_INET6)
+            {
                 v6only =3D true;
+            }

             socket_bind(sock->sd, sock->info.lsa->bind_local,
                         ai_family, "TCP/UDP", v6only);
@@ -1712,6 +1717,10 @@
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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/437?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8c9ec61af9e786ec284e756ec3a77a959c79f49b
Gerrit-Change-Number: 437
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--ae0t8xgNfHg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/437?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">override ai_family if &#39;local&#39; numeric address was spe=
cified<br><br>This change ensures that when a numeric IP address is specifi=
ed<br>as argument to a &#39;local&#39; directive, its ai_family overrides<b=
r>the one extracted from the &#39;proto&#39; config option.<br><br>Change-I=
d: I8c9ec61af9e786ec284e756ec3a77a959c79f49b<br>Signed-off-by: Antonio Quar=
tulli &lt;a@...2181...&gt;<br>---<br>M src/openvpn/socket.c<br>1 file chang=
ed, 11 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/37/437/1</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
socket.c b/src/openvpn/socket.c</span><br><span>index 5d9e111..ffd8daf 1006=
44</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/ope=
nvpn/socket.c</span><br><span>@@ -489,9 +489,8 @@</span><br><span>         =
sig_info =3D &amp;sigrec;</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    /* try numeric ipv6 addr f=
irst */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* try n=
umeric ip addr first */</span><br><span>     CLEAR(hints);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    hints.ai_family =3D ai_family;</sp=
an><br><span>     hints.ai_flags =3D AI_NUMERICHOST;</span><br><span> </spa=
n><br><span>     if (flags &amp; GETADDR_PASSIVE)</span><br><span>@@ -519,6=
 +518,10 @@</span><br><span>         const char *fmt;</span><br><span>     =
    int level =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        /* this is not a numeric IP, therefore force res=
olution using the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * provided ai_family */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        hints.ai_family =3D ai_family;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>         if (hostname &amp;&=
amp; (flags &amp; GETADDR_RANDOMIZE))</span><br><span>         {</span><br>=
<span>             hostname =3D hostname_randomize(hostname, &amp;gc);</spa=
n><br><span>@@ -1120,7 +1123,9 @@</span><br><span>             /* force bin=
ding IPv6-only if an address was specified</span><br><span>              * =
an it is a IPv6 */</span><br><span>             if (sock-&gt;local_host &am=
p;&amp; ai_family =3D=3D AF_INET6)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span>                 v6only =3D tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span> </span><br><span>             socket_bind(sock-&gt;sd, sock-=
&gt;info.lsa-&gt;bind_local,</span><br><span>                         ai_fa=
mily, &quot;TCP/UDP&quot;, v6only);</span><br><span>@@ -1712,6 +1717,10 @@<=
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
openvpn/+/437?usp=3Demail">change 437</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/437?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8c9ec61af9e786ec284e756ec3a=
77a959c79f49b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 437 </div>
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


--ae0t8xgNfHg=--

