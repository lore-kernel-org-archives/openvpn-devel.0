From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 11 Nov 2025 11:55:23 +0000
References: <gerrit.1762862118000.I509ea79990305f39e3385136fc0d9e5fbfa68e6c@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0a4cad9665cdc89fd989021146eb9e734ad8e215-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4PfCejbm2Bc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mudp: fix handling
 of multiple UDP socket flags
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

--4PfCejbm2Bc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1365?usp=3Demail

to review the following change.


Change subject: mudp: fix handling of multiple UDP socket flags
......................................................................

mudp: fix handling of multiple UDP socket flags

The handler previously used an 'else-if' chain to process
only the first matching flag, and then overwrote
'm->multi_io->udp_flags' with a fixed value (e.g. 'ES_ERROR').
This caused remaining event bits to be ignored if multiple
flags (such as SOCKET_READ and SOCKET_WRITE) were set
simultaneously.

This patch changes the logic to test each flag independently
and clear only the bits that were actually handled.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com)

Change-Id: I509ea79990305f39e3385136fc0d9e5fbfa68e6c
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/mudp.c
1 file changed, 4 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/1365/1

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 71c742f..1f3594a 100644
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
@@ -361,6 +362,7 @@
     if (status & SOCKET_WRITE)
     {
         multi_process_outgoing_link(m, mpp_flags);
+        processed_flags |=3D SOCKET_WRITE;
     }
     /* Incoming data on UDP port */
     else if (status & SOCKET_READ)
@@ -370,9 +372,10 @@
         {
             multi_process_incoming_link(m, NULL, mpp_flags, sock);
         }
+        processed_flags |=3D SOCKET_READ;
     }

-    m->multi_io->udp_flags =3D ES_ERROR;
+    m->multi_io->udp_flags &=3D ~processed_flags;
 }

 /*

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1365?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I509ea79990305f39e3385136fc0d9e5fbfa68e6c
Gerrit-Change-Number: 1365
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--4PfCejbm2Bc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1365?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">mudp: fix handling of multiple UDP socket f=
lags<br><br>The handler previously used an &#39;else-if&#39; chain to proce=
ss<br>only the first matching flag, and then overwrote<br>&#39;m-&gt;multi_=
io-&gt;udp_flags&#39; with a fixed value (e.g. &#39;ES_ERROR&#39;).<br>This=
 caused remaining event bits to be ignored if multiple<br>flags (such as SO=
CKET_READ and SOCKET_WRITE) were set<br>simultaneously.<br><br>This patch c=
hanges the logic to test each flag independently<br>and clear only the bits=
 that were actually handled.<br><br>Reported-by: Joshua Rogers &lt;contact@=
...2949...&gt;<br>Found-by: ZeroPath (https://zeropath.com)<br><br>Change-I=
d: I509ea79990305f39e3385136fc0d9e5fbfa68e6c<br>Signed-off-by: Gianmarco De=
 Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/mudp.c<br>1 f=
ile changed, 4 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/1365/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index =
71c742f..1f3594a 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br>=
<span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -342,6 +342,7 @@</span><b=
r><span>     const unsigned int mpp_flags =3D m-&gt;top.c2.fast_io</span><b=
r><span>                                        ? (MPP_CONDITIONAL_PRE_SELE=
CT | MPP_CLOSE_ON_SIGNAL)</span><br><span>                                 =
       : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    unsigned int processed_flags =3D 0;</span>=
<br><span> </span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>=
     char buf[16];</span><br><span>@@ -361,6 +362,7 @@</span><br><span>    =
 if (status &amp; SOCKET_WRITE)</span><br><span>     {</span><br><span>    =
     multi_process_outgoing_link(m, mpp_flags);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        processed_flags |=3D SOCKET_WRITE;</spa=
n><br><span>     }</span><br><span>     /* Incoming data on UDP port */</sp=
an><br><span>     else if (status &amp; SOCKET_READ)</span><br><span>@@ -37=
0,9 +372,10 @@</span><br><span>         {</span><br><span>             mult=
i_process_incoming_link(m, NULL, mpp_flags, sock);</span><br><span>        =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        processed=
_flags |=3D SOCKET_READ;</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;multi_io-&gt;udp_flag=
s =3D ES_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
m-&gt;multi_io-&gt;udp_flags &amp;=3D ~processed_flags;</span><br><span> }<=
/span><br><span> </span><br><span> /*</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1365?usp=3De=
mail">change 1365</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1365?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I509ea79990305f39e3385136fc0=
d9e5fbfa68e6c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1365 </div>
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

--4PfCejbm2Bc=--

