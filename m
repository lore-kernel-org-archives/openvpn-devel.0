From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 21 Apr 2026 08:32:19 +0000
In-Reply-To: <gerrit.1776701747000.I974e10ec91a0b63f52387f1406ce1b49145eb0be@...2715...>
References: <gerrit.1776701747000.I974e10ec91a0b63f52387f1406ce1b49145eb0be@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726...
Message-ID: <79d68a79e03e25272396ab260b04602444a0b2e1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0HKX/e5koec="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: dco: port
 core/context infrastructure needed for backport of commit 7...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0HKX/e5koec=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 ralf_lici. ( http://gerrit.openvpn.net/c/openvpn/+/1631?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dco: port core/context infrastructure needed for backport o=
f commit 7791f53
......................................................................

dco: port core/context infrastructure needed for backport of commit 7791f53

Change ovpn_dco_init() to take a reference to struct context, add a
backlink from the platform DCO contexts to the owning openvpn context,
and store the top multi context in struct context for server mode.

This prepares the tree for the follow-up backend changes from commit
7791f53 ("dco: process messages immediately after read") where Linux and
FreeBSD process DCO notifications directly from their backend read
paths.

It is part of a reworked backport of PR #945 originally proposed by
Nikolai Shelekhov <nickshv13@...2314...>.

The original commits in master are

    commit a699681bb86c6e9a2c9f205543f60400208aea4b
    Author: Antonio Quartulli <antonio@...2726...>
    Date:   Wed Jul 23 15:39:11 2025 +0200

	dco: only pass struct context to init function

    commit 7f5a6deae33a338a23d7e8ff8526db8fdddf4bc2
    Author: Antonio Quartulli <antonio@...2726...>
    Date:   Wed Jul 23 08:10:25 2025 +0200

	multi: store multi_context address inside top instance

Change-Id: I974e10ec91a0b63f52387f1406ce1b49145eb0be
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1631
Message-Id: <20260420165923.14226-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
691.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_freebsd.h
M src/openvpn/dco_linux.c
M src/openvpn/dco_linux.h
M src/openvpn/dco_win.c
M src/openvpn/init.c
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
M src/openvpn/openvpn.h
10 files changed, 25 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/1631/2

diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 50ebb35..334d468 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -104,11 +104,10 @@
 /**
  * Initialize the DCO context
  *
- * @param mode      the instance operating mode (P2P or multi-peer)
- * @param dco       the context to initialize
+ * @param c         the main instance context
  * @return          true on success, false otherwise
  */
-bool ovpn_dco_init(int mode, dco_context_t *dco);
+bool ovpn_dco_init(struct context *c);

 /**
  * Open/create a DCO interface
@@ -284,7 +283,7 @@
 }

 static inline bool
-ovpn_dco_init(int mode, dco_context_t *dco)
+ovpn_dco_init(struct context *c)
 {
     return true;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 15add74..b164bd3 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -220,9 +220,11 @@
 }

 bool
-ovpn_dco_init(int mode, dco_context_t *dco)
+ovpn_dco_init(struct context *c)
 {
-    if (open_fd(dco) < 0)
+    c->c1.tuntap->dco.c =3D c;
+
+    if (open_fd(&c->c1.tuntap->dco) < 0)
     {
         msg(M_ERR, "Failed to open socket");
         return false;
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index ab5891e8..e8f723e 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -57,6 +57,7 @@
     int dco_message_peer_id;
     int dco_del_peer_reason;
     struct sockaddr_storage dco_float_peer_ss;
+    struct context *c;
     uint64_t dco_read_bytes;
     uint64_t dco_write_bytes;
 } dco_context_t;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b2584b9..493fce6 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -391,9 +391,11 @@
 }

 bool
-ovpn_dco_init(int mode, dco_context_t *dco)
+ovpn_dco_init(struct context *c)
 {
-    switch (mode)
+    dco_context_t *dco =3D &c->c1.tuntap->dco;
+
+    switch (c->mode)
     {
         case CM_TOP:
             dco->ifmode =3D OVPN_MODE_MP;
@@ -407,6 +409,10 @@
             ASSERT(false);
     }

+    /* store pointer to context as it may be required by message
+     * parsing routines
+     */
+    dco->c =3D c;
     ovpn_dco_init_netlink(dco);
     return true;
 }
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 5179912..cf6bdd4 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -43,6 +43,8 @@
     struct nl_cb *nl_cb;
     int status;

+    struct context *c;
+
     enum ovpn_mode ifmode;

     int ovpn_dco_id;
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 0b8f831..bc465db 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -53,7 +53,7 @@
 }

 bool
-ovpn_dco_init(int mode, dco_context_t *dco)
+ovpn_dco_init(struct context *c)
 {
     return true;
 }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1476737..c2cfd24 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1882,7 +1882,7 @@
 #endif
         if (dco_enabled(&c->options))
         {
-            ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
+            ovpn_dco_init(c);
         }

         /* open the tun device */
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 3e33b15..38c938e 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -792,6 +792,7 @@
     int status;

     top->mode =3D CM_TOP;
+    top->multi =3D &multi;
     context_clear_2(top);

     /* initialize top-tunnel instance */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index f7c9ffd..8cc717b 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -466,6 +466,7 @@
     struct multi_context multi;

     top->mode =3D CM_TOP;
+    top->multi =3D &multi;
     context_clear_2(top);

     /* initialize top-tunnel instance */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 9cba1c5..3879772 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -492,6 +492,9 @@
                                  *   CM_P2P, \c CM_TOP, \c CM_TOP_CLONE,
                                  *   \c CM_CHILD_UDP, and \c CM_CHILD_TCP.=
 */

+    struct multi_context *multi; /**< Pointer to the main P2MP context.
+                                  *   Non-NULL only when mode =3D=3D CM_TO=
P. */
+
     struct gc_arena gc;         /**< Garbage collection arena for
                                  *   allocations done in the scope of this
                                  *   context structure. */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1631?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I974e10ec91a0b63f52387f1406ce1b49145eb0be
Gerrit-Change-Number: 1631
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0HKX/e5koec=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by ralf_lici.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1631?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">dco: port core/context infrastructu=
re needed for backport of commit 7791f53<br><br>Change ovpn_dco_init() to t=
ake a reference to struct context, add a<br>backlink from the platform DCO =
contexts to the owning openvpn context,<br>and store the top multi context =
in struct context for server mode.<br><br>This prepares the tree for the fo=
llow-up backend changes from commit<br>7791f53 (&quot;dco: process messages=
 immediately after read&quot;) where Linux and<br>FreeBSD process DCO notif=
ications directly from their backend read<br>paths.<br><br>It is part of a =
reworked backport of PR #945 originally proposed by<br>Nikolai Shelekhov &l=
t;nickshv13@...2314...&gt;.<br><br>The original commits in master are<br><b=
r>    commit a699681bb86c6e9a2c9f205543f60400208aea4b<br>    Author: Antoni=
o Quartulli &lt;antonio@...2726...&gt;<br>    Date:   Wed Jul 23 15:39:11 2=
025 +0200<br><br>	dco: only pass struct context to init function<br><br>   =
 commit 7f5a6deae33a338a23d7e8ff8526db8fdddf4bc2<br>    Author: Antonio Qua=
rtulli &lt;antonio@...2726...&gt;<br>    Date:   Wed Jul 23 08:10:25 2025 +=
0200<br><br>	multi: store multi_context address inside top instance<br><br>=
Change-Id: I974e10ec91a0b63f52387f1406ce1b49145eb0be<br>Signed-off-by: Ralf=
 Lici &lt;ralf@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...=
&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1631<br>Message-=
Id: &lt;20260420165923.14226-1-gert@...1296...&gt;<br>URL: https://www.mail=
-archive.com/openvpn-devel@lists.sourceforge.net/msg36691.html<br>Signed-of=
f-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco.h<br=
>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_freebsd.h<br>M src/openvp=
n/dco_linux.c<br>M src/openvpn/dco_linux.h<br>M src/openvpn/dco_win.c<br>M =
src/openvpn/init.c<br>M src/openvpn/mtcp.c<br>M src/openvpn/mudp.c<br>M src=
/openvpn/openvpn.h<br>10 files changed, 25 insertions(+), 10 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/31/1631/2</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.h b/src/openvpn/=
dco.h</span><br><span>index 50ebb35..334d468 100644</span><br><span>--- a/s=
rc/openvpn/dco.h</span><br><span>+++ b/src/openvpn/dco.h</span><br><span>@@=
 -104,11 +104,10 @@</span><br><span> /**</span><br><span>  * Initialize the=
 DCO context</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @param mode      the instance operating mode (P2P or multi-pe=
er)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param dco     =
  the context to initialize</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param c         the main instance context</span><br><span>  * @=
return          true on success, false otherwise</span><br><span>  */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-bool ovpn_dco_init(int mode=
, dco_context_t *dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool ovpn_dco_init(struct context *c);</span><br><span> </span><br><span=
> /**</span><br><span>  * Open/create a DCO interface</span><br><span>@@ -2=
84,7 +283,7 @@</span><br><span> }</span><br><span> </span><br><span> static=
 inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_=
init(int mode, dco_context_t *dco)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ovpn_dco_init(struct context *c)</span><br><span> {</span><b=
r><span>     return true;</span><br><span> }</span><br><span>diff --git a/s=
rc/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index =
15add74..b164bd3 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</sp=
an><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -220,9 +220=
,11 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(int mode, dco_con=
text_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dc=
o_init(struct context *c)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (open_fd(dco) &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c1.tuntap-&gt;dco.c =3D c;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (open_fd(&amp;c-&gt;c1.tuntap-&gt;=
dco) &lt; 0)</span><br><span>     {</span><br><span>         msg(M_ERR, &qu=
ot;Failed to open socket&quot;);</span><br><span>         return false;</sp=
an><br><span>diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freeb=
sd.h</span><br><span>index ab5891e8..e8f723e 100644</span><br><span>--- a/s=
rc/openvpn/dco_freebsd.h</span><br><span>+++ b/src/openvpn/dco_freebsd.h</s=
pan><br><span>@@ -57,6 +57,7 @@</span><br><span>     int dco_message_peer_i=
d;</span><br><span>     int dco_del_peer_reason;</span><br><span>     struc=
t sockaddr_storage dco_float_peer_ss;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct context *c;</span><br><span>     uint64_t dco_=
read_bytes;</span><br><span>     uint64_t dco_write_bytes;</span><br><span>=
 } dco_context_t;</span><br><span>diff --git a/src/openvpn/dco_linux.c b/sr=
c/openvpn/dco_linux.c</span><br><span>index b2584b9..493fce6 100644</span><=
br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dc=
o_linux.c</span><br><span>@@ -391,9 +391,11 @@</span><br><span> }</span><br=
><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-ovpn_dco_init(int mode, dco_context_t *dco)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_init(struct context *c)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch =
(mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_conte=
xt_t *dco =3D &amp;c-&gt;c1.tuntap-&gt;dco;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    switch (c-&gt;mode)</span><br><span>     {</span><br><span>       =
  case CM_TOP:</span><br><span>             dco-&gt;ifmode =3D OVPN_MODE_MP=
;</span><br><span>@@ -407,6 +409,10 @@</span><br><span>             ASSERT(=
false);</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* store pointer to context as it may be r=
equired by message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * parsing routines</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&=
gt;c =3D c;</span><br><span>     ovpn_dco_init_netlink(dco);</span><br><spa=
n>     return true;</span><br><span> }</span><br><span>diff --git a/src/ope=
nvpn/dco_linux.h b/src/openvpn/dco_linux.h</span><br><span>index 5179912..c=
f6bdd4 100644</span><br><span>--- a/src/openvpn/dco_linux.h</span><br><span=
>+++ b/src/openvpn/dco_linux.h</span><br><span>@@ -43,6 +43,8 @@</span><br>=
<span>     struct nl_cb *nl_cb;</span><br><span>     int status;</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct c=
ontext *c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     enum ovpn_mode ifmode;</span><br><span> </span><br><span>     =
int ovpn_dco_id;</span><br><span>diff --git a/src/openvpn/dco_win.c b/src/o=
penvpn/dco_win.c</span><br><span>index 0b8f831..bc465db 100644</span><br><s=
pan>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c=
</span><br><span>@@ -53,7 +53,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovp=
n_dco_init(int mode, dco_context_t *dco)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ovpn_dco_init(struct context *c)</span><br><span> {</s=
pan><br><span>     return true;</span><br><span> }</span><br><span>diff --g=
it a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 1476737.=
.c2cfd24 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>++=
+ b/src/openvpn/init.c</span><br><span>@@ -1882,7 +1882,7 @@</span><br><spa=
n> #endif</span><br><span>         if (dco_enabled(&amp;c-&gt;options))</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            ovpn_dco_init(c-&gt;mode, &amp;c-&gt;c1.tuntap-&gt;dco);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            ovpn_dco_ini=
t(c);</span><br><span>         }</span><br><span> </span><br><span>        =
 /* open the tun device */</span><br><span>diff --git a/src/openvpn/mtcp.c =
b/src/openvpn/mtcp.c</span><br><span>index 3e33b15..38c938e 100644</span><b=
r><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</=
span><br><span>@@ -792,6 +792,7 @@</span><br><span>     int status;</span><=
br><span> </span><br><span>     top-&gt;mode =3D CM_TOP;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    top-&gt;multi =3D &amp;multi;</spa=
n><br><span>     context_clear_2(top);</span><br><span> </span><br><span>  =
   /* initialize top-tunnel instance */</span><br><span>diff --git a/src/op=
envpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index f7c9ffd..8cc717b 10=
0644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/ope=
nvpn/mudp.c</span><br><span>@@ -466,6 +466,7 @@</span><br><span>     struct=
 multi_context multi;</span><br><span> </span><br><span>     top-&gt;mode =
=3D CM_TOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    top-=
&gt;multi =3D &amp;multi;</span><br><span>     context_clear_2(top);</span>=
<br><span> </span><br><span>     /* initialize top-tunnel instance */</span=
><br><span>diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h</span=
><br><span>index 9cba1c5..3879772 100644</span><br><span>--- a/src/openvpn/=
openvpn.h</span><br><span>+++ b/src/openvpn/openvpn.h</span><br><span>@@ -4=
92,6 +492,9 @@</span><br><span>                                  *   CM_P2P=
, \c CM_TOP, \c CM_TOP_CLONE,</span><br><span>                             =
     *   \c CM_CHILD_UDP, and \c CM_CHILD_TCP. */</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m=
ulti; /**&lt; Pointer to the main P2MP context.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                  *   Non-NULL =
only when mode =3D=3D CM_TOP. */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     struct gc_arena gc;         /**&lt; Garb=
age collection arena for</span><br><span>                                  =
*   allocations done in the scope of this</span><br><span>                 =
                 *   context structure. */</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1631?us=
p=3Demail">change 1631</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1631?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I974e10ec91a0b63f52387f1406c=
e1b49145eb0be </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1631 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--0HKX/e5koec=--

