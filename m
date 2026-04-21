From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 21 Apr 2026 15:20:20 +0000
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@...2715...>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <e9c9e6a29650ee65ccafcbadfe8418377a251d30-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E27Zu2wWkLg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Multisocket: use
 event engine rwflags for UDP I/O
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--E27Zu2wWkLg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex, plaisthos.

Hello ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1635?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by ordex


Change subject: Multisocket: use event engine rwflags for UDP I/O
......................................................................

Multisocket: use event engine rwflags for UDP I/O

udp_flags does not guarantee correct association with the socket being
processed. Use the rwflags returned by the event engine together with the
event to ensure proper per-socket I/O handling.

Remove udp_flags entirely.

This change is based on an investigation triggered by a report from
Joshua Rogers using ZeroPath.

Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/mudp.c
M src/openvpn/mudp.h
M src/openvpn/multi_io.c
M src/openvpn/multi_io.h
5 files changed, 5 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/1635/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 27cfd36..3937942 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2153,7 +2153,6 @@
     unsigned int out_socket;

     multi_io_process_flags(c, multi_io->es, flags, &out_socket, NULL);
-    multi_io->udp_flags =3D (out_socket << SOCKET_SHIFT);
 }

 /*
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 432c79a..beec57a 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -336,18 +336,17 @@
  * Process a UDP socket event.
  */
 void
-multi_process_io_udp(struct multi_context *m, struct link_socket *sock)
+multi_process_io_udp(struct multi_context *m, struct link_socket *sock, un=
signed int rwflags)
 {
-    const unsigned int status =3D m->multi_io->udp_flags;
     const unsigned int mpp_flags =3D (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);

     /* UDP port ready to accept write */
-    if (status & SOCKET_WRITE)
+    if (rwflags & SOCKET_WRITE)
     {
         multi_process_outgoing_link(m, mpp_flags);
     }
     /* Incoming data on UDP port */
-    else if (status & SOCKET_READ)
+    else if (rwflags & SOCKET_READ)
     {
         read_incoming_link(&m->top, sock);
         if (!IS_SIG(&m->top))
@@ -355,8 +354,6 @@
             multi_process_incoming_link(m, NULL, mpp_flags, sock);
         }
     }
-
-    m->multi_io->udp_flags =3D ES_ERROR;
 }

 /*
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 005ee10..1417651 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -32,7 +32,7 @@

 unsigned int p2mp_iow_flags(const struct multi_context *m);

-void multi_process_io_udp(struct multi_context *m, struct link_socket *soc=
k);
+void multi_process_io_udp(struct multi_context *m, struct link_socket *soc=
k, unsigned int rwflags);
 /*************************************************************************=
*/
 /**
  * Get, and if necessary create, the multi_instance associated with a
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index e6f4e9c..f9af800 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -457,7 +457,7 @@
                     }
                     else
                     {
-                        multi_process_io_udp(m, ev_arg->u.sock);
+                        multi_process_io_udp(m, ev_arg->u.sock, e->rwflags=
);
                         mi =3D m->pending;
                     }
                     /* monitor and/or handle events that are
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index 6b2f59a..d6734bd 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -55,7 +55,6 @@
     int n_esr;
     int maxevents;
     unsigned int tun_rwflags;
-    unsigned int udp_flags;
 #ifdef ENABLE_MANAGEMENT
     unsigned int management_persist_flags;
 #endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1635?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
Gerrit-Change-Number: 1635
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: ordex <antonio@...2726...>

--E27Zu2wWkLg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, ordex, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1635?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by ordex</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Multisocket: use event engine rwfla=
gs for UDP I/O<br><br>udp_flags does not guarantee correct association with=
 the socket being<br>processed. Use the rwflags returned by the event engin=
e together with the<br>event to ensure proper per-socket I/O handling.<br><=
br>Remove udp_flags entirely.<br><br>This change is based on an investigati=
on triggered by a report from<br>Joshua Rogers using ZeroPath.<br><br>Chang=
e-Id: I6b303805a3688b6f6363140c76853a58badecd8f<br>Signed-off-by: Gianmarco=
 De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/forward.c<=
br>M src/openvpn/mudp.c<br>M src/openvpn/mudp.h<br>M src/openvpn/multi_io.c=
<br>M src/openvpn/multi_io.h<br>5 files changed, 5 insertions(+), 10 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/35/1635/2</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/=
src/openvpn/forward.c</span><br><span>index 27cfd36..3937942 100644</span><=
br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forw=
ard.c</span><br><span>@@ -2153,7 +2153,6 @@</span><br><span>     unsigned i=
nt out_socket;</span><br><span> </span><br><span>     multi_io_process_flag=
s(c, multi_io-&gt;es, flags, &amp;out_socket, NULL);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    multi_io-&gt;udp_flags =3D (out_socket =
&lt;&lt; SOCKET_SHIFT);</span><br><span> }</span><br><span> </span><br><spa=
n> /*</span><br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c<=
/span><br><span>index 432c79a..beec57a 100644</span><br><span>--- a/src/ope=
nvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -33=
6,18 +336,17 @@</span><br><span>  * Process a UDP socket event.</span><br><=
span>  */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-multi_process_io_udp(struct multi_context *m, struct link_socket =
*sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_process=
_io_udp(struct multi_context *m, struct link_socket *sock, unsigned int rwf=
lags)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const unsigned int status =3D m-&gt;multi_io-&gt;udp_flags;</span><b=
r><span>     const unsigned int mpp_flags =3D (MPP_PRE_SELECT | MPP_CLOSE_O=
N_SIGNAL);</span><br><span> </span><br><span>     /* UDP port ready to acce=
pt write */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (st=
atus &amp; SOCKET_WRITE)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (rwflags &amp; SOCKET_WRITE)</span><br><span>     {</span><br><=
span>         multi_process_outgoing_link(m, mpp_flags);</span><br><span>  =
   }</span><br><span>     /* Incoming data on UDP port */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    else if (status &amp; SOCKET_READ)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (rwflags=
 &amp; SOCKET_READ)</span><br><span>     {</span><br><span>         read_in=
coming_link(&amp;m-&gt;top, sock);</span><br><span>         if (!IS_SIG(&am=
p;m-&gt;top))</span><br><span>@@ -355,8 +354,6 @@</span><br><span>         =
    multi_process_incoming_link(m, NULL, mpp_flags, sock);</span><br><span>=
         }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt=
;multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><span> }</span><br><span> <=
/span><br><span> /*</span><br><span>diff --git a/src/openvpn/mudp.h b/src/o=
penvpn/mudp.h</span><br><span>index 005ee10..1417651 100644</span><br><span=
>--- a/src/openvpn/mudp.h</span><br><span>+++ b/src/openvpn/mudp.h</span><b=
r><span>@@ -32,7 +32,7 @@</span><br><span> </span><br><span> unsigned int p=
2mp_iow_flags(const struct multi_context *m);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void multi_process_io_udp(struct =
multi_context *m, struct link_socket *sock);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void multi_process_io_udp(struct multi_context *m,=
 struct link_socket *sock, unsigned int rwflags);</span><br><span> /*******=
*******************************************************************/</span>=
<br><span> /**</span><br><span>  * Get, and if necessary create, the multi_=
instance associated with a</span><br><span>diff --git a/src/openvpn/multi_i=
o.c b/src/openvpn/multi_io.c</span><br><span>index e6f4e9c..f9af800 100644<=
/span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>+++ b/src/open=
vpn/multi_io.c</span><br><span>@@ -457,7 +457,7 @@</span><br><span>        =
             }</span><br><span>                     else</span><br><span>  =
                   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       multi_process_io_udp(m, ev_arg-&gt;u.sock);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        mult=
i_process_io_udp(m, ev_arg-&gt;u.sock, e-&gt;rwflags);</span><br><span>    =
                     mi =3D m-&gt;pending;</span><br><span>                =
     }</span><br><span>                     /* monitor and/or handle events=
 that are</span><br><span>diff --git a/src/openvpn/multi_io.h b/src/openvpn=
/multi_io.h</span><br><span>index 6b2f59a..d6734bd 100644</span><br><span>-=
-- a/src/openvpn/multi_io.h</span><br><span>+++ b/src/openvpn/multi_io.h</s=
pan><br><span>@@ -55,7 +55,6 @@</span><br><span>     int n_esr;</span><br><=
span>     int maxevents;</span><br><span>     unsigned int tun_rwflags;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int udp_flag=
s;</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     unsigned =
int management_persist_flags;</span><br><span> #endif</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1635?usp=3Demail">change 1635</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dema=
il">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1635?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b303805a3688b6f6363140c768=
53a58badecd8f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1635 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>

</body></html>=

--E27Zu2wWkLg=--

