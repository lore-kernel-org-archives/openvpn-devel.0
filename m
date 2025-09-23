From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 23 Sep 2025 15:56:37 +0000
References: <gerrit.1758642994000.I9cb8aa6ef01445cb99758583aba8ae8f9ded0862@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a63b86106ed918a65379d3f014278c0d572fbb23-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4gSDSQ94nWw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4gSDSQ94nWw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1209?usp=3Demail

to review the following change.


Change subject: multi_io_init: simplify
......................................................................

multi_io_init: simplify

We take two values and try to massage them in various
ways. But this function only has one caller and that
puts exactly the same value into both of them. So
simplify the code.

Change-Id: I9cb8aa6ef01445cb99758583aba8ae8f9ded0862
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/multi.c
M src/openvpn/multi_io.c
M src/openvpn/multi_io.h
3 files changed, 6 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/1209/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--4gSDSQ94nWw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1209?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">multi_io_init: simplify<br><br>We take two values and try to=
 massage them in various<br>ways. But this function only has one caller and=
 that<br>puts exactly the same value into both of them. So<br>simplify the =
code.<br><br>Change-Id: I9cb8aa6ef01445cb99758583aba8ae8f9ded0862<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn=
/multi.c<br>M src/openvpn/multi_io.c<br>M src/openvpn/multi_io.h<br>3 files=
 changed, 6 insertions(+), 9 deletions(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/09/1209/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/multi.c b/src/openvpn/multi.c</span><br><span>index 9256127..1d2ee53 =
100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/=
openvpn/multi.c</span><br><span>@@ -411,7 +411,7 @@</span><br><span>     /*=
</span><br><span>      * Initialize multi-socket I/O wait object</span><br>=
<span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&=
gt;multi_io =3D multi_io_init(t-&gt;options.max_clients, &amp;m-&gt;max_cli=
ents);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;mul=
ti_io =3D multi_io_init(m-&gt;max_clients);</span><br><span>     m-&gt;tcp_=
queue_limit =3D t-&gt;options.tcp_queue_limit;</span><br><span> </span><br>=
<span>     /*</span><br><span>diff --git a/src/openvpn/multi_io.c b/src/ope=
nvpn/multi_io.c</span><br><span>index ece789c..0bfbb63 100644</span><br><sp=
an>--- a/src/openvpn/multi_io.c</span><br><span>+++ b/src/openvpn/multi_io.=
c</span><br><span>@@ -113,21 +113,18 @@</span><br><span> }</span><br><span>=
 </span><br><span> struct multi_io *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-multi_io_init(int maxevents, int *maxclients)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+multi_io_init(const int maxclients=
)</span><br><span> {</span><br><span>     struct multi_io *multi_io;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    const int extra_events =
=3D BASE_N_EVENTS;</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ASSERT(maxevents &gt;=3D 1);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ASSERT(maxclients);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ASSERT(maxclients &gt;=3D 1);</span><br><=
span> </span><br><span>     ALLOC_OBJ_CLEAR(multi_io, struct multi_io);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_io-&gt;maxevent=
s =3D maxevents + extra_events;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    multi_io-&gt;maxevents =3D maxclients + BASE_N_EVENTS;</spa=
n><br><span>     multi_io-&gt;es =3D event_set_init(&amp;multi_io-&gt;maxev=
ents, 0);</span><br><span>     wait_signal(multi_io-&gt;es, MULTI_IO_SIG);<=
/span><br><span>     ALLOC_ARRAY(multi_io-&gt;esr, struct event_set_return,=
 multi_io-&gt;maxevents);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    *maxclients =3D max_int(min_int(multi_io-&gt;maxevents - extra_even=
ts, *maxclients), 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    msg(D_MULTI_LOW, &quot;MULTI IO: MULTI_IO INIT maxclients=3D%d maxevent=
s=3D%d&quot;, *maxclients,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    msg(D_MULTI_LOW, &quot;MULTI IO: MULTI_IO INIT maxclients=3D%d m=
axevents=3D%d&quot;, maxclients,</span><br><span>         multi_io-&gt;maxe=
vents);</span><br><span>     return multi_io;</span><br><span> }</span><br>=
<span>diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h</span><b=
r><span>index 07eb3d4..4a3c60d 100644</span><br><span>--- a/src/openvpn/mul=
ti_io.h</span><br><span>+++ b/src/openvpn/multi_io.h</span><br><span>@@ -61=
,7 +61,7 @@</span><br><span> #endif</span><br><span> };</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct multi_io *multi_=
io_init(int maxevents, int *maxclients);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+struct multi_io *multi_io_init(int maxclients);</span>=
<br><span> </span><br><span> void multi_io_free(struct multi_io *multi_io);=
</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1209?usp=3Demail">change 1209</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1209?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9cb8aa6ef01445cb99758583aba=
8ae8f9ded0862 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1209 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--4gSDSQ94nWw=--

