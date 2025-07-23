From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 23 Jul 2025 09:59:41 +0000
In-Reply-To: <gerrit.1753215725000.I673a17f8c5dec66cc6c28c1ed44780a7a63927d7@...2715...>
References: <gerrit.1753215725000.I673a17f8c5dec66cc6c28c1ed44780a7a63927d7@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., gert@...1296...
Message-ID: <483fc7dc2aeb9f042a78b987528c0dbc9f6a52ae-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e1dWSF1TWnU="; charset=UTF-8
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

--e1dWSF1TWnU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1094?usp=3Demail

to look at the new patch set (#3).


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
---
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_linux.h
M src/openvpn/dco_win.c
M src/openvpn/init.c
6 files changed, 20 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1094/3

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
=20
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
index 83db739..1d20247 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -188,8 +188,10 @@
  * state. The server socket should be initialized later by dco_mp_start_vp=
n().
  */
 bool
-ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
+ovpn_dco_init(struct context *c)
 {
+    dco_context_t *dco =3D &c->c1.tuntap->dco;
+
     switch (mode)
     {
         case MODE_POINT_TO_POINT:
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
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-MessageType: newpatchset

--e1dWSF1TWnU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex, plais=
thos. </p>
<p>ordex <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1094?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">dco: only pass struct context to init function<br><br>Future DCO code wi=
ll require accessing the `multi` member of the<br>context object.<br><br>Fo=
r this reason a pointer to the context has to be stored in the<br>DCO conte=
xt along with the rest.<br><br>At this point, rather than making the call t=
o ovpn_dco_init()<br>longer with more and more parameters, pass the struct =
context<br>only and let the implementation extract the needed fields.<br><b=
r>Change-Id: I673a17f8c5dec66cc6c28c1ed44780a7a63927d7<br>Signed-off-by: An=
tonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/openvpn/dco.h<br=
>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/=
dco_linux.h<br>M src/openvpn/dco_win.c<br>M src/openvpn/init.c<br>6 files c=
hanged, 20 insertions(+), 12 deletions(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/94/1094/3</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/dco.h b/src/openvpn/dco.h</span><br><span>index f38316d..9078417 1006=
44</span><br><span>--- a/src/openvpn/dco.h</span><br><span>+++ b/src/openvp=
n/dco.h</span><br><span>@@ -104,12 +104,10 @@</span><br><span> /**</span><b=
r><span>  * Initialize the DCO context</span><br><span>  *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * @param mode      the instance opera=
ting mode (P2P or multi-peer)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @param dco       the context to initialize</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param dev_node  device node, used on Wi=
ndows to specify certain DCO adapter</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param c         the main instance context</span><br><s=
pan>  * @return          true on success, false otherwise</span><br><span> =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool ovpn_dco_init=
(int mode, dco_context_t *dco, const char *dev_node);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool ovpn_dco_init(struct context *c);</s=
pan><br><span> </span><br><span> /**</span><br><span>  * Open/create a DCO =
interface</span><br><span>@@ -297,7 +295,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> static inline bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-ovpn_dco_init(int mode, dco_context_t *dco, const cha=
r *dev_node)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dc=
o_init(struct context *c)</span><br><span> {</span><br><span>     return tr=
ue;</span><br><span> }</span><br><span>diff --git a/src/openvpn/dco_freebsd=
.c b/src/openvpn/dco_freebsd.c</span><br><span>index b8816c6..98d8fb5 10064=
4</span><br><span>--- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src=
/openvpn/dco_freebsd.c</span><br><span>@@ -165,9 +165,9 @@</span><br><span>=
 }</span><br><span> </span><br><span> bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-ovpn_dco_init(int mode, dco_context_t *dco, const char=
 *dev_node)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco=
_init(struct context *c)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (open_fd(dco) &lt; 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (open_fd(&amp;c-&gt;c1.tuntap-&gt;dco=
) &lt; 0)</span><br><span>     {</span><br><span>         msg(M_ERR, &quot;=
Failed to open socket&quot;);</span><br><span>         return false;</span>=
<br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</s=
pan><br><span>index 3652a49..ec6efaa 100644</span><br><span>--- a/src/openv=
pn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><spa=
n>@@ -438,9 +438,11 @@</span><br><span> }</span><br><span> </span><br><span=
> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(i=
nt mode, dco_context_t *dco, const char *dev_node)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ovpn_dco_init(struct context *c)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (mo=
de)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_context_=
t *dco =3D &amp;c-&gt;c1.tuntap-&gt;dco;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    switch (c-&gt;mode)</span><br><span>     {</span><br><span>         c=
ase CM_TOP:</span><br><span>             dco-&gt;ifmode =3D OVPN_MODE_MP;</=
span><br><span>@@ -454,6 +456,10 @@</span><br><span>             ASSERT(fal=
se);</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* store pointer to context as it may be requ=
ired by message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * parsing routines</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;=
c =3D c;</span><br><span>     ovpn_dco_init_netlink(dco);</span><br><span> =
    return true;</span><br><span> }</span><br><span>diff --git a/src/openvp=
n/dco_linux.h b/src/openvpn/dco_linux.h</span><br><span>index 676b8cd..5e61=
cf1 100644</span><br><span>--- a/src/openvpn/dco_linux.h</span><br><span>++=
+ b/src/openvpn/dco_linux.h</span><br><span>@@ -65,6 +65,8 @@</span><br><sp=
an>     struct nl_cb *nl_cb;</span><br><span>     int status;</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct cont=
ext *c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     enum ovpn_mode ifmode;</span><br><span> </span><br><span>     int=
 ovpn_dco_id;</span><br><span>diff --git a/src/openvpn/dco_win.c b/src/open=
vpn/dco_win.c</span><br><span>index 83db739..1d20247 100644</span><br><span=
>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</s=
pan><br><span>@@ -188,8 +188,10 @@</span><br><span>  * state. The server so=
cket should be initialized later by dco_mp_start_vpn().</span><br><span>  *=
/</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_init(struct contex=
t *c)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    dco_context_t *dco =3D &amp;c-&gt;c1.tuntap-&gt;dco;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     switch (mod=
e)</span><br><span>     {</span><br><span>         case MODE_POINT_TO_POINT=
:</span><br><span>@@ -198,7 +200,7 @@</span><br><span>             break;</=
span><br><span> </span><br><span>         case MODE_SERVER:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            ovpn_dco_init_mp(dco, dev=
_node);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
ovpn_dco_init_mp(dco, c-&gt;options.dev_node);</span><br><span>            =
 break;</span><br><span> </span><br><span>         default:</span><br><span=
>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index=
 77747a2..aac8a6a 100644</span><br><span>--- a/src/openvpn/init.c</span><br=
><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2007,7 +2007,7 @@</span=
><br><span> </span><br><span>         if (dco_enabled(&amp;c-&gt;options))<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            ovpn_dco_init(c-&gt;mode, &amp;c-&gt;c1.tuntap-&gt;dco, c-=
&gt;options.dev_node);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            ovpn_dco_init(c);</span><br><span>         }</span><br><span=
> </span><br><span>         /* open the tun device */</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1094?usp=3Demail">change 1094</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1094?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I673a17f8c5dec66cc6c28c1ed44=
780a7a63927d7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1094 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--e1dWSF1TWnU=--

