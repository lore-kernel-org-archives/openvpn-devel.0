From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 07:43:29 +0000
In-Reply-To: <gerrit.1758642994000.I9cb8aa6ef01445cb99758583aba8ae8f9ded0862@...2715...>
References: <gerrit.1758642994000.I9cb8aa6ef01445cb99758583aba8ae8f9ded0862@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f696f8e9a1d49e4b13131f602302fa28ab3fe8a8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7m3lfdL+HeA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io_init:
 simplify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7m3lfdL+HeA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1209?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: multi_io_init: simplify
......................................................................

multi_io_init: simplify

We take two values and try to massage them in various
ways. But this function only has one caller and that
puts exactly the same value into both of them. So
simplify the code.

Change-Id: I9cb8aa6ef01445cb99758583aba8ae8f9ded0862
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1209
Message-Id: <20250923160459.32273-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
176.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
M src/openvpn/multi_io.c
M src/openvpn/multi_io.h
3 files changed, 6 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/1209/2

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9256127..1d2ee53 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -411,7 +411,7 @@
     /*
      * Initialize multi-socket I/O wait object
      */
-    m->multi_io =3D multi_io_init(t->options.max_clients, &m->max_clients);
+    m->multi_io =3D multi_io_init(m->max_clients);
     m->tcp_queue_limit =3D t->options.tcp_queue_limit;

     /*
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index ece789c..0bfbb63 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -113,21 +113,18 @@
 }

 struct multi_io *
-multi_io_init(int maxevents, int *maxclients)
+multi_io_init(const int maxclients)
 {
     struct multi_io *multi_io;
-    const int extra_events =3D BASE_N_EVENTS;

-    ASSERT(maxevents >=3D 1);
-    ASSERT(maxclients);
+    ASSERT(maxclients >=3D 1);

     ALLOC_OBJ_CLEAR(multi_io, struct multi_io);
-    multi_io->maxevents =3D maxevents + extra_events;
+    multi_io->maxevents =3D maxclients + BASE_N_EVENTS;
     multi_io->es =3D event_set_init(&multi_io->maxevents, 0);
     wait_signal(multi_io->es, MULTI_IO_SIG);
     ALLOC_ARRAY(multi_io->esr, struct event_set_return, multi_io->maxevent=
s);
-    *maxclients =3D max_int(min_int(multi_io->maxevents - extra_events, *m=
axclients), 1);
-    msg(D_MULTI_LOW, "MULTI IO: MULTI_IO INIT maxclients=3D%d maxevents=3D=
%d", *maxclients,
+    msg(D_MULTI_LOW, "MULTI IO: MULTI_IO INIT maxclients=3D%d maxevents=3D=
%d", maxclients,
         multi_io->maxevents);
     return multi_io;
 }
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index 07eb3d4..4a3c60d 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -61,7 +61,7 @@
 #endif
 };

-struct multi_io *multi_io_init(int maxevents, int *maxclients);
+struct multi_io *multi_io_init(int maxclients);

 void multi_io_free(struct multi_io *multi_io);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1209?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9cb8aa6ef01445cb99758583aba8ae8f9ded0862
Gerrit-Change-Number: 1209
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--7m3lfdL+HeA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1209?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">multi_io_init: simplify<br><br>We take two values an=
d try to massage them in various<br>ways. But this function only has one ca=
ller and that<br>puts exactly the same value into both of them. So<br>simpl=
ify the code.<br><br>Change-Id: I9cb8aa6ef01445cb99758583aba8ae8f9ded0862<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.ne=
t/c/openvpn/+/1209<br>Message-Id: &lt;20250923160459.32273-1-gert@...2132...=
.&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...290...=
net/msg33176.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>---<br>M src/openvpn/multi.c<br>M src/openvpn/multi_io.c<br>M src/openvpn/=
multi_io.h<br>3 files changed, 6 insertions(+), 9 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/1209/2</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>in=
dex 9256127..1d2ee53 100644</span><br><span>--- a/src/openvpn/multi.c</span=
><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -411,7 +411,7 @@</s=
pan><br><span>     /*</span><br><span>      * Initialize multi-socket I/O w=
ait object</span><br><span>      */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    m-&gt;multi_io =3D multi_io_init(t-&gt;options.max_client=
s, &amp;m-&gt;max_clients);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    m-&gt;multi_io =3D multi_io_init(m-&gt;max_clients);</span><br>=
<span>     m-&gt;tcp_queue_limit =3D t-&gt;options.tcp_queue_limit;</span><=
br><span> </span><br><span>     /*</span><br><span>diff --git a/src/openvpn=
/multi_io.c b/src/openvpn/multi_io.c</span><br><span>index ece789c..0bfbb63=
 100644</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>+++ b/=
src/openvpn/multi_io.c</span><br><span>@@ -113,21 +113,18 @@</span><br><spa=
n> }</span><br><span> </span><br><span> struct multi_io *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-multi_io_init(int maxevents, int *maxcl=
ients)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_io_init=
(const int maxclients)</span><br><span> {</span><br><span>     struct multi=
_io *multi_io;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st int extra_events =3D BASE_N_EVENTS;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    ASSERT(maxevents &gt;=3D 1);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(maxclients);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(maxclients &gt=
;=3D 1);</span><br><span> </span><br><span>     ALLOC_OBJ_CLEAR(multi_io, s=
truct multi_io);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
ulti_io-&gt;maxevents =3D maxevents + extra_events;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;maxevents =3D maxclients=
 + BASE_N_EVENTS;</span><br><span>     multi_io-&gt;es =3D event_set_init(&=
amp;multi_io-&gt;maxevents, 0);</span><br><span>     wait_signal(multi_io-&=
gt;es, MULTI_IO_SIG);</span><br><span>     ALLOC_ARRAY(multi_io-&gt;esr, st=
ruct event_set_return, multi_io-&gt;maxevents);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    *maxclients =3D max_int(min_int(multi_io-&gt;=
maxevents - extra_events, *maxclients), 1);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    msg(D_MULTI_LOW, &quot;MULTI IO: MULTI_IO INIT ma=
xclients=3D%d maxevents=3D%d&quot;, *maxclients,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    msg(D_MULTI_LOW, &quot;MULTI IO: MULTI_IO =
INIT maxclients=3D%d maxevents=3D%d&quot;, maxclients,</span><br><span>    =
     multi_io-&gt;maxevents);</span><br><span>     return multi_io;</span><=
br><span> }</span><br><span>diff --git a/src/openvpn/multi_io.h b/src/openv=
pn/multi_io.h</span><br><span>index 07eb3d4..4a3c60d 100644</span><br><span=
>--- a/src/openvpn/multi_io.h</span><br><span>+++ b/src/openvpn/multi_io.h<=
/span><br><span>@@ -61,7 +61,7 @@</span><br><span> #endif</span><br><span> =
};</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
truct multi_io *multi_io_init(int maxevents, int *maxclients);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+struct multi_io *multi_io_init(i=
nt maxclients);</span><br><span> </span><br><span> void multi_io_free(struc=
t multi_io *multi_io);</span><br><span> </span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1209?usp=
=3Demail">change 1209</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1209?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9cb8aa6ef01445cb99758583aba=
8ae8f9ded0862 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1209 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--7m3lfdL+HeA=--

