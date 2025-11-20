From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 20 Nov 2025 10:57:56 +0000
References: <gerrit.1763636270000.Id1457f8432b4f0a69108b91ca12f2cbd0818f90d@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <10c0feab18f2eaa86f6b4b4e795785916953c3bd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EGVPQ/0hAeY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EGVPQ/0hAeY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1384?usp=3Demail

to review the following change.


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
---
M src/openvpn/forward.c
M src/openvpn/multi_io.c
2 files changed, 2 insertions(+), 23 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/1384/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d57cbe0..ccb8404 100644
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id1457f8432b4f0a69108b91ca12f2cbd0818f90d
Gerrit-Change-Number: 1384
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--EGVPQ/0hAeY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>its_Giaan would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1384?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">multi-socket: remove duplicated/dead code<b=
r><br>Removed the event_ctl() for ENABLE_ASYNC_PUSH<br>in io_wait_dowork() =
since that function is<br>not executed by servers anymore.<br><br>Removed a=
 duplicated code in multi_io_process_io()<br>for new incoming TCP connectio=
ns since the same<br>thing is done couple lines above.<br><br>Change-Id: Id=
1457f8432b4f0a69108b91ca12f2cbd0818f90d<br>Signed-off-by: Gianmarco De Greg=
ori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/forward.c<br>M src=
/openvpn/multi_io.c<br>2 files changed, 2 insertions(+), 23 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/84/1384/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openv=
pn/forward.c</span><br><span>index d57cbe0..ccb8404 100644</span><br><span>=
--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</sp=
an><br><span>@@ -2214,9 +2214,7 @@</span><br><span>     static uintptr_t ma=
nagement_shift =3D</span><br><span>         MANAGEMENT_SHIFT; /* depends on=
 MANAGEMENT_READ and MANAGEMENT_WRITE */</span><br><span> #endif</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    static uintptr_t file_shi=
ft =3D FILE_SHIFT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span>    =
 static uintptr_t dco_shift =3D DCO_SHIFT; /* Event from DCO linux kernel m=
odule */</span><br><span> #endif</span><br><span>@@ -2242,14 +2240,6 @@</sp=
an><br><span>     }</span><br><span> #endif</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* arm inotify watcher */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;options.mo=
de =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        event_c=
tl(c-&gt;c2.event_set, c-&gt;c2.inotify_fd, EVENT_READ, (void *)file_shift)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span>     /*</span><br><span>      * Po=
ssible scenarios:</span><br><span>      *  (1) tcp/udp port has data availa=
ble to read</span><br><span>diff --git a/src/openvpn/multi_io.c b/src/openv=
pn/multi_io.c</span><br><span>index 6e31687..fe72456 100644</span><br><span=
>--- a/src/openvpn/multi_io.c</span><br><span>+++ b/src/openvpn/multi_io.c<=
/span><br><span>@@ -500,18 +500,7 @@</span><br><span>                      =
   multi_io_action(m, NULL, TA_TUN_READ, false);</span><br><span>          =
           }</span><br><span>                 }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                /* new incoming TCP client attemp=
ting to connect? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              else if (e-&gt;arg =3D=3D MULTI_IO_SOCKET)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    struct multi_instance *=
mi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  ASSERT(m-&gt;top.c2.link_sockets[0]);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    socket_reset_listen_persistent(m-&gt;=
top.c2.link_sockets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    mi =3D multi_create_instance_tcp(m, m-&gt;top.c2.lin=
k_sockets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             if (mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       multi_io_action(m, mi, TA_INITIAL, false);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(ENA=
BLE_DCO)</span><br><span>                 /* incoming data on DCO? */</span=
><br><span>                 else if (e-&gt;arg =3D=3D MULTI_IO_DCO)</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1384?usp=3Demail">change 1384</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1384?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id1457f8432b4f0a69108b91ca12=
f2cbd0818f90d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1384 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--EGVPQ/0hAeY=--

