From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 22 Nov 2025 21:41:55 +0000
In-Reply-To: <gerrit.1763636270000.Id1457f8432b4f0a69108b91ca12f2cbd0818f90d@...2715...>
References: <gerrit.1763636270000.Id1457f8432b4f0a69108b91ca12f2cbd0818f90d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <8d6a45442ed913c2536fe9d6f721aadc2c67ab0d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YwzxMHywbL0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi-socket: remove
 duplicated/dead code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YwzxMHywbL0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/1384?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: multi-socket: remove duplicated/dead code
......................................................................

multi-socket: remove duplicated/dead code

Removed the event_ctl() for ENABLE_ASYNC_PUSH
in io_wait_dowork() since that function is
not executed by servers anymore.

Removed a duplicated code in multi_io_process_io()
for new incoming TCP connections since the same
thing is done couple lines above.

Change-Id: Id1457f8432b4f0a69108b91ca12f2cbd0818f90d
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1384
Message-Id: <20251122185239.26312-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
593.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
M src/openvpn/multi_io.c
2 files changed, 2 insertions(+), 23 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/1384/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f01fb4c..a6d3394 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2214,9 +2214,7 @@
     static uintptr_t management_shift =3D
         MANAGEMENT_SHIFT; /* depends on MANAGEMENT_READ and MANAGEMENT_WRI=
TE */
 #endif
-#ifdef ENABLE_ASYNC_PUSH
-    static uintptr_t file_shift =3D FILE_SHIFT;
-#endif
+
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     static uintptr_t dco_shift =3D DCO_SHIFT; /* Event from DCO linux kern=
el module */
 #endif
@@ -2242,14 +2240,6 @@
     }
 #endif

-#ifdef ENABLE_ASYNC_PUSH
-    /* arm inotify watcher */
-    if (c->options.mode =3D=3D MODE_SERVER)
-    {
-        event_ctl(c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void *)f=
ile_shift);
-    }
-#endif
-
     /*
      * Possible scenarios:
      *  (1) tcp/udp port has data available to read
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 6e31687..fe72456 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -500,18 +500,7 @@
                         multi_io_action(m, NULL, TA_TUN_READ, false);
                     }
                 }
-                /* new incoming TCP client attempting to connect? */
-                else if (e->arg =3D=3D MULTI_IO_SOCKET)
-                {
-                    struct multi_instance *mi;
-                    ASSERT(m->top.c2.link_sockets[0]);
-                    socket_reset_listen_persistent(m->top.c2.link_sockets[=
0]);
-                    mi =3D multi_create_instance_tcp(m, m->top.c2.link_soc=
kets[0]);
-                    if (mi)
-                    {
-                        multi_io_action(m, mi, TA_INITIAL, false);
-                    }
-                }
+
 #if defined(ENABLE_DCO)
                 /* incoming data on DCO? */
                 else if (e->arg =3D=3D MULTI_IO_DCO)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1384?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id1457f8432b4f0a69108b91ca12f2cbd0818f90d
Gerrit-Change-Number: 1384
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YwzxMHywbL0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by its_Giaan.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1384?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">multi-socket: remove duplicated/dea=
d code<br><br>Removed the event_ctl() for ENABLE_ASYNC_PUSH<br>in io_wait_d=
owork() since that function is<br>not executed by servers anymore.<br><br>R=
emoved a duplicated code in multi_io_process_io()<br>for new incoming TCP c=
onnections since the same<br>thing is done couple lines above.<br><br>Chang=
e-Id: Id1457f8432b4f0a69108b91ca12f2cbd0818f90d<br>Signed-off-by: Gianmarco=
 De Gregori &lt;gianmarco@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert=
@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1384<=
br>Message-Id: &lt;20251122185239.26312-1-gert@...1296...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34593.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openv=
pn/forward.c<br>M src/openvpn/multi_io.c<br>2 files changed, 2 insertions(+=
), 23 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/84/1384/2</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
forward.c b/src/openvpn/forward.c</span><br><span>index f01fb4c..a6d3394 10=
0644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/=
openvpn/forward.c</span><br><span>@@ -2214,9 +2214,7 @@</span><br><span>   =
  static uintptr_t management_shift =3D</span><br><span>         MANAGEMENT=
_SHIFT; /* depends on MANAGEMENT_READ and MANAGEMENT_WRITE */</span><br><sp=
an> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENAB=
LE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stat=
ic uintptr_t file_shift =3D FILE_SHIFT;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)=
</span><br><span>     static uintptr_t dco_shift =3D DCO_SHIFT; /* Event fr=
om DCO linux kernel module */</span><br><span> #endif</span><br><span>@@ -2=
242,14 +2240,6 @@</span><br><span>     }</span><br><span> #endif</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_=
ASYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* arm =
inotify watcher */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (c-&gt;options.mode =3D=3D MODE_SERVER)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        event_ctl(c-&gt;c2.event_set, c-&gt;c2.inotify_fd, EVENT_READ=
, (void *)file_shift);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /*</span=
><br><span>      * Possible scenarios:</span><br><span>      *  (1) tcp/udp=
 port has data available to read</span><br><span>diff --git a/src/openvpn/m=
ulti_io.c b/src/openvpn/multi_io.c</span><br><span>index 6e31687..fe72456 1=
00644</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>+++ b/sr=
c/openvpn/multi_io.c</span><br><span>@@ -500,18 +500,7 @@</span><br><span> =
                        multi_io_action(m, NULL, TA_TUN_READ, false);</span=
><br><span>                     }</span><br><span>                 }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                /* new incom=
ing TCP client attempting to connect? */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                else if (e-&gt;arg =3D=3D MULTI_IO_SOCKE=
T)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    str=
uct multi_instance *mi;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    ASSERT(m-&gt;top.c2.link_sockets[0]);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    socket_reset_list=
en_persistent(m-&gt;top.c2.link_sockets[0]);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    mi =3D multi_create_instance_tcp=
(m, m-&gt;top.c2.link_sockets[0]);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    if (mi)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                        multi_io_action(m, mi, TA_INITIA=
L, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> #if defined(ENABLE_DCO)</span><br><span>                 /* incoming d=
ata on DCO? */</span><br><span>                 else if (e-&gt;arg =3D=3D M=
ULTI_IO_DCO)</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1384?usp=3Demail">change 1384</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1384?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id1457f8432b4f0a69108b91ca12=
f2cbd0818f90d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1384 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--YwzxMHywbL0=--

