From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 4 Nov 2025 15:55:49 +0000
References: <gerrit.1762271747000.I51e0ffd54fef817894f35f51c7c57c8167cfbd6c@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <423c5df78824a5a355790f932f24193a2f3abff9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uhC3iqTk/1U="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mudp: fix handling
 of multiple UDP event flags
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

--uhC3iqTk/1U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1347?usp=3Demail

to review the following change.


Change subject: mudp: fix handling of multiple UDP event flags
......................................................................

mudp: fix handling of multiple UDP event flags

The handler previously used an 'else-if' chain to process
only the first matching UDP event flag, and then overwrote
'm->multi_io->udp_flags' with a fixed value (e.g. 'ES_ERROR').
This caused remaining event bits to be ignored if multiple
flags (such as SOCKET_READ or SOCKET_WRITE) were set
simultaneously.

This patch changes the logic to test each flag independently
and clear only the bits that were actually handled.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: ZeroPath (https://zeropath.com)

Change-Id: I51e0ffd54fef817894f35f51c7c57c8167cfbd6c
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/mudp.c
1 file changed, 9 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/1347/1

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 31134be..6edefac 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -342,6 +342,7 @@
     const unsigned int mpp_flags =3D m->top.c2.fast_io
                                        ? (MPP_CONDITIONAL_PRE_SELECT | MPP=
_CLOSE_ON_SIGNAL)
                                        : (MPP_PRE_SELECT | MPP_CLOSE_ON_SI=
GNAL);
+    unsigned int processed_flags =3D 0;

 #ifdef MULTI_DEBUG_EVENT_LOOP
     char buf[16];
@@ -374,6 +375,7 @@
     {
         ASSERT(management);
         management_io(management);
+        processed_flags |=3D (MANAGEMENT_READ | MANAGEMENT_WRITE);
     }
 #endif

@@ -381,11 +383,13 @@
     if (status & SOCKET_WRITE)
     {
         multi_process_outgoing_link(m, mpp_flags);
+        processed_flags |=3D SOCKET_WRITE;
     }
     /* TUN device ready to accept write */
     else if (status & TUN_WRITE)
     {
         multi_process_outgoing_tun(m, mpp_flags);
+        processed_flags |=3D TUN_WRITE;
     }
     /* Incoming data on UDP port */
     else if (status & SOCKET_READ)
@@ -395,6 +399,7 @@
         {
             multi_process_incoming_link(m, NULL, mpp_flags, sock);
         }
+        processed_flags |=3D SOCKET_READ;
     }
     /* Incoming data on TUN device */
     else if (status & TUN_READ)
@@ -404,12 +409,14 @@
         {
             multi_process_incoming_tun(m, mpp_flags);
         }
+        processed_flags |=3D TUN_READ;
     }
 #ifdef ENABLE_ASYNC_PUSH
     /* INOTIFY callback */
     else if (status & FILE_CLOSED)
     {
         multi_process_file_closed(m, mpp_flags);
+        processed_flags |=3D FILE_CLOSED;
     }
 #endif
 #if defined(ENABLE_DCO)
@@ -423,10 +430,11 @@
                 ret =3D multi_process_incoming_dco(m);
             }
         }
+        processed_flags |=3D DCO_READ;
     }
 #endif

-    m->multi_io->udp_flags =3D ES_ERROR;
+    m->multi_io->udp_flags &=3D ~processed_flags;
 }

 /*

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1347?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I51e0ffd54fef817894f35f51c7c57c8167cfbd6c
Gerrit-Change-Number: 1347
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--uhC3iqTk/1U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1347?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">mudp: fix handling of multiple UDP event fl=
ags<br><br>The handler previously used an &#39;else-if&#39; chain to proces=
s<br>only the first matching UDP event flag, and then overwrote<br>&#39;m-&=
gt;multi_io-&gt;udp_flags&#39; with a fixed value (e.g. &#39;ES_ERROR&#39;)=
.<br>This caused remaining event bits to be ignored if multiple<br>flags (s=
uch as SOCKET_READ or SOCKET_WRITE) were set<br>simultaneously.<br><br>This=
 patch changes the logic to test each flag independently<br>and clear only =
the bits that were actually handled.<br><br>Reported-By: Joshua Rogers &lt;=
contact@...2949...&gt;<br>Found-By: ZeroPath (https://zeropath.com)<br><br>=
Change-Id: I51e0ffd54fef817894f35f51c7c57c8167cfbd6c<br>Signed-off-by: Gian=
marco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/mudp.=
c<br>1 file changed, 9 insertions(+), 1 deletion(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/1347/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><spa=
n>index 31134be..6edefac 100644</span><br><span>--- a/src/openvpn/mudp.c</s=
pan><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -342,6 +342,7 @@<=
/span><br><span>     const unsigned int mpp_flags =3D m-&gt;top.c2.fast_io<=
/span><br><span>                                        ? (MPP_CONDITIONAL_=
PRE_SELECT | MPP_CLOSE_ON_SIGNAL)</span><br><span>                         =
               : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    unsigned int processed_flags =3D 0=
;</span><br><span> </span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><b=
r><span>     char buf[16];</span><br><span>@@ -374,6 +375,7 @@</span><br><s=
pan>     {</span><br><span>         ASSERT(management);</span><br><span>   =
      management_io(management);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        processed_flags |=3D (MANAGEMENT_READ | MANAGEMENT_WRI=
TE);</span><br><span>     }</span><br><span> #endif</span><br><span> </span=
><br><span>@@ -381,11 +383,13 @@</span><br><span>     if (status &amp; SOCK=
ET_WRITE)</span><br><span>     {</span><br><span>         multi_process_out=
going_link(m, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        processed_flags |=3D SOCKET_WRITE;</span><br><span>     }</sp=
an><br><span>     /* TUN device ready to accept write */</span><br><span>  =
   else if (status &amp; TUN_WRITE)</span><br><span>     {</span><br><span>=
         multi_process_outgoing_tun(m, mpp_flags);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        processed_flags |=3D TUN_WRITE;</spa=
n><br><span>     }</span><br><span>     /* Incoming data on UDP port */</sp=
an><br><span>     else if (status &amp; SOCKET_READ)</span><br><span>@@ -39=
5,6 +399,7 @@</span><br><span>         {</span><br><span>             multi=
_process_incoming_link(m, NULL, mpp_flags, sock);</span><br><span>         =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        processed_=
flags |=3D SOCKET_READ;</span><br><span>     }</span><br><span>     /* Inco=
ming data on TUN device */</span><br><span>     else if (status &amp; TUN_R=
EAD)</span><br><span>@@ -404,12 +409,14 @@</span><br><span>         {</span=
><br><span>             multi_process_incoming_tun(m, mpp_flags);</span><br=
><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      processed_flags |=3D TUN_READ;</span><br><span>     }</span><br><span=
> #ifdef ENABLE_ASYNC_PUSH</span><br><span>     /* INOTIFY callback */</spa=
n><br><span>     else if (status &amp; FILE_CLOSED)</span><br><span>     {<=
/span><br><span>         multi_process_file_closed(m, mpp_flags);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        processed_flags |=3D =
FILE_CLOSED;</span><br><span>     }</span><br><span> #endif</span><br><span=
> #if defined(ENABLE_DCO)</span><br><span>@@ -423,10 +430,11 @@</span><br><=
span>                 ret =3D multi_process_incoming_dco(m);</span><br><spa=
n>             }</span><br><span>         }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        processed_flags |=3D DCO_READ;</span><br><s=
pan>     }</span><br><span> #endif</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    m-&gt;multi_io-&gt;udp_flags =3D ES_ERR=
OR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;multi_=
io-&gt;udp_flags &amp;=3D ~processed_flags;</span><br><span> }</span><br><s=
pan> </span><br><span> /*</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1347?usp=3Demail">change=
 1347</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1347?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I51e0ffd54fef817894f35f51c7c=
57c8167cfbd6c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1347 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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

--uhC3iqTk/1U=--

