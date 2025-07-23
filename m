From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 23 Jul 2025 15:00:14 +0000
In-Reply-To: <gerrit.1753215725000.I673a17f8c5dec66cc6c28c1ed44780a7a63927d7@...2715...>
References: <gerrit.1753215725000.I673a17f8c5dec66cc6c28c1ed44780a7a63927d7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., antonio@...2726...
Message-ID: <f6e33feda07214de000d4101863bdd4486142a1b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rG/rSXynNDY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: only pass
 struct context to init function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, stipa <lstipakov@...277...>

--rG/rSXynNDY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 ordex. ( http://gerrit.openvpn.net/c/openvpn/+/1094?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dco: only pass struct context to init function
......................................................................

dco: only pass struct context to init function

Future DCO code will require accessing the `multi` member of the
context object.

For this reason a pointer to the context has to be stored in the
DCO context along with the rest.

At this point, rather than making the call to ovpn_dco_init()
longer with more and more parameters, pass the struct context
only and let the implementation extract the needed fields.

Change-Id: I673a17f8c5dec66cc6c28c1ed44780a7a63927d7
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250723133918.19431-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
293.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_linux.h
M src/openvpn/dco_win.c
M src/openvpn/init.c
6 files changed, 21 insertions(+), 13 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1094/5

diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index f38316d..9078417 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -104,12 +104,10 @@
 /**
  * Initialize the DCO context
  *
- * @param mode      the instance operating mode (P2P or multi-peer)
- * @param dco       the context to initialize
- * @param dev_node  device node, used on Windows to specify certain DCO ad=
apter
+ * @param c         the main instance context
  * @return          true on success, false otherwise
  */
-bool ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node);
+bool ovpn_dco_init(struct context *c);

 /**
  * Open/create a DCO interface
@@ -297,7 +295,7 @@
 }

 static inline bool
-ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
+ovpn_dco_init(struct context *c)
 {
     return true;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index b8816c6..98d8fb5 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -165,9 +165,9 @@
 }

 bool
-ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
+ovpn_dco_init(struct context *c)
 {
-    if (open_fd(dco) < 0)
+    if (open_fd(&c->c1.tuntap->dco) < 0)
     {
         msg(M_ERR, "Failed to open socket");
         return false;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 3652a49..ec6efaa 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -438,9 +438,11 @@
 }

 bool
-ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
+ovpn_dco_init(struct context *c)
 {
-    switch (mode)
+    dco_context_t *dco =3D &c->c1.tuntap->dco;
+
+    switch (c->mode)
     {
         case CM_TOP:
             dco->ifmode =3D OVPN_MODE_MP;
@@ -454,6 +456,10 @@
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
index 676b8cd..5e61cf1 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -65,6 +65,8 @@
     struct nl_cb *nl_cb;
     int status;

+    struct context *c;
+
     enum ovpn_mode ifmode;

     int ovpn_dco_id;
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 83db739..e5a33a0 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -188,9 +188,11 @@
  * state. The server socket should be initialized later by dco_mp_start_vp=
n().
  */
 bool
-ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
+ovpn_dco_init(struct context *c)
 {
-    switch (mode)
+    dco_context_t *dco =3D &c->c1.tuntap->dco;
+
+    switch (c->mode)
     {
         case MODE_POINT_TO_POINT:
             dco->ifmode =3D DCO_MODE_P2P;
@@ -198,7 +200,7 @@
             break;

         case MODE_SERVER:
-            ovpn_dco_init_mp(dco, dev_node);
+            ovpn_dco_init_mp(dco, c->options.dev_node);
             break;

         default:
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 77747a2..aac8a6a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2007,7 +2007,7 @@

         if (dco_enabled(&c->options))
         {
-            ovpn_dco_init(c->mode, &c->c1.tuntap->dco, c->options.dev_node=
);
+            ovpn_dco_init(c);
         }

         /* open the tun device */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1094?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I673a17f8c5dec66cc6c28c1ed44780a7a63927d7
Gerrit-Change-Number: 1094
Gerrit-PatchSet: 5
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--rG/rSXynNDY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by ordex.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1094=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco: only pass struct context to init function<br><b=
r>Future DCO code will require accessing the `multi` member of the<br>conte=
xt object.<br><br>For this reason a pointer to the context has to be stored=
 in the<br>DCO context along with the rest.<br><br>At this point, rather th=
an making the call to ovpn_dco_init()<br>longer with more and more paramete=
rs, pass the struct context<br>only and let the implementation extract the =
needed fields.<br><br>Change-Id: I673a17f8c5dec66cc6c28c1ed44780a7a63927d7<=
br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250723133918.194=
31-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel=
@lists.sourceforge.net/msg32293.html<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>---<br>M src/openvpn/dco.h<br>M src/openvpn/dco_freebsd=
.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_linux.h<br>M src/openv=
pn/dco_win.c<br>M src/openvpn/init.c<br>6 files changed, 21 insertions(+), =
13 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/94/1094/5</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.h b/src/openvpn/=
dco.h</span><br><span>index f38316d..9078417 100644</span><br><span>--- a/s=
rc/openvpn/dco.h</span><br><span>+++ b/src/openvpn/dco.h</span><br><span>@@=
 -104,12 +104,10 @@</span><br><span> /**</span><br><span>  * Initialize the=
 DCO context</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @param mode      the instance operating mode (P2P or multi-pe=
er)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param dco     =
  the context to initialize</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @param dev_node  device node, used on Windows to specify certain D=
CO adapter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 c         the main instance context</span><br><span>  * @return          t=
rue on success, false otherwise</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool ovpn_dco_init(int mode, dco_context_t =
*dco, const char *dev_node);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool ovpn_dco_init(struct context *c);</span><br><span> </span><br=
><span> /**</span><br><span>  * Open/create a DCO interface</span><br><span=
>@@ -297,7 +295,7 @@</span><br><span> }</span><br><span> </span><br><span> =
static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovp=
n_dco_init(int mode, dco_context_t *dco, const char *dev_node)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_init(struct context *c)=
</span><br><span> {</span><br><span>     return true;</span><br><span> }</s=
pan><br><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_free=
bsd.c</span><br><span>index b8816c6..98d8fb5 100644</span><br><span>--- a/s=
rc/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</s=
pan><br><span>@@ -165,9 +165,9 @@</span><br><span> }</span><br><span> </spa=
n><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn=
_dco_init(int mode, dco_context_t *dco, const char *dev_node)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_init(struct context *c)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (open_fd(dco) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (open_fd(&amp;c-&gt;c1.tuntap-&gt;dco) &lt; 0)</span><br><span=
>     {</span><br><span>         msg(M_ERR, &quot;Failed to open socket&quo=
t;);</span><br><span>         return false;</span><br><span>diff --git a/sr=
c/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index 3652a=
49..ec6efaa 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br>=
<span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -438,9 +438,11 @@</s=
pan><br><span> }</span><br><span> </span><br><span> bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(int mode, dco_context_t *d=
co, const char *dev_node)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ovpn_dco_init(struct context *c)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    switch (mode)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    dco_context_t *dco =3D &amp;c-&gt;c1.=
tuntap-&gt;dco;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (c-&gt;mode)=
</span><br><span>     {</span><br><span>         case CM_TOP:</span><br><sp=
an>             dco-&gt;ifmode =3D OVPN_MODE_MP;</span><br><span>@@ -454,6 =
+456,10 @@</span><br><span>             ASSERT(false);</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* store pointer to context as it may be required by message</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * parsing routines</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;c =3D c;</span><br><span>=
     ovpn_dco_init_netlink(dco);</span><br><span>     return true;</span><b=
r><span> }</span><br><span>diff --git a/src/openvpn/dco_linux.h b/src/openv=
pn/dco_linux.h</span><br><span>index 676b8cd..5e61cf1 100644</span><br><spa=
n>--- a/src/openvpn/dco_linux.h</span><br><span>+++ b/src/openvpn/dco_linux=
.h</span><br><span>@@ -65,6 +65,8 @@</span><br><span>     struct nl_cb *nl_=
cb;</span><br><span>     int status;</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct context *c;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     enum ovpn_mode =
ifmode;</span><br><span> </span><br><span>     int ovpn_dco_id;</span><br><=
span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><=
span>index 83db739..e5a33a0 100644</span><br><span>--- a/src/openvpn/dco_wi=
n.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -188,9 +=
188,11 @@</span><br><span>  * state. The server socket should be initialize=
d later by dco_mp_start_vpn().</span><br><span>  */</span><br><span> bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(int mode,=
 dco_context_t *dco, const char *dev_node)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ovpn_dco_init(struct context *c)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (mode)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_context_t *dco =
=3D &amp;c-&gt;c1.tuntap-&gt;dco;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
witch (c-&gt;mode)</span><br><span>     {</span><br><span>         case MOD=
E_POINT_TO_POINT:</span><br><span>             dco-&gt;ifmode =3D DCO_MODE_=
P2P;</span><br><span>@@ -198,7 +200,7 @@</span><br><span>             break=
;</span><br><span> </span><br><span>         case MODE_SERVER:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            ovpn_dco_init_mp(dco, =
dev_node);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   ovpn_dco_init_mp(dco, c-&gt;options.dev_node);</span><br><span>         =
    break;</span><br><span> </span><br><span>         default:</span><br><s=
pan>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>in=
dex 77747a2..aac8a6a 100644</span><br><span>--- a/src/openvpn/init.c</span>=
<br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2007,7 +2007,7 @@</s=
pan><br><span> </span><br><span>         if (dco_enabled(&amp;c-&gt;options=
))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            ovpn_dco_init(c-&gt;mode, &amp;c-&gt;c1.tuntap-&gt;dco,=
 c-&gt;options.dev_node);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            ovpn_dco_init(c);</span><br><span>         }</span><br><s=
pan> </span><br><span>         /* open the tun device */</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1094?usp=3Demail">change 1094</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1094?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I673a17f8c5dec66cc6c28c1ed44=
780a7a63927d7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1094 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--rG/rSXynNDY=--

