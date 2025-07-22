From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 22 Jul 2025 20:26:46 +0000
In-Reply-To: <gerrit.1753215725000.I673a17f8c5dec66cc6c28c1ed44780a7a63927d7@...2715...>
References: <gerrit.1753215725000.I673a17f8c5dec66cc6c28c1ed44780a7a63927d7@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fe14d170cdf59a54cee0ac4857412e4969622e09-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hDmhNA0mSnY="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hDmhNA0mSnY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1094?usp=3Demail

to look at the new patch set (#2).


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
M src/openvpn/init.c
5 files changed, 15 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1094/2

diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index f38316d..9c5c01a 100644
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
index f04ebfe..c92c196 100644
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
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--hDmhNA0mSnY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
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
dco_linux.h<br>M src/openvpn/init.c<br>5 files changed, 15 insertions(+), 9=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/94/1094/2</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.h b/src/openvpn/dc=
o.h</span><br><span>index f38316d..9c5c01a 100644</span><br><span>--- a/src=
/openvpn/dco.h</span><br><span>+++ b/src/openvpn/dco.h</span><br><span>@@ -=
104,12 +104,10 @@</span><br><span> /**</span><br><span>  * Initialize the D=
CO context</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @param mode      the instance operating mode (P2P or multi-peer=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param dco       =
the context to initialize</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @param dev_node  device node, used on Windows to specify certain DCO=
 adapter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c=
         the main instance context</span><br><span>  * @return          tru=
e on success, false otherwise</span><br><span>  */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-bool ovpn_dco_init(int mode, dco_context_t *dc=
o, const char *dev_node);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+bool ovpn_dco_init(struct context *c);</span><br><span> </span><br><s=
pan> /**</span><br><span>  * Open/create a DCO interface</span><br><span>di=
ff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br>=
<span>index b8816c6..98d8fb5 100644</span><br><span>--- a/src/openvpn/dco_f=
reebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@=
 -165,9 +165,9 @@</span><br><span> }</span><br><span> </span><br><span> boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(int mo=
de, dco_context_t *dco, const char *dev_node)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ovpn_dco_init(struct context *c)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (open_fd(dco=
) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (op=
en_fd(&amp;c-&gt;c1.tuntap-&gt;dco) &lt; 0)</span><br><span>     {</span><b=
r><span>         msg(M_ERR, &quot;Failed to open socket&quot;);</span><br><=
span>         return false;</span><br><span>diff --git a/src/openvpn/dco_li=
nux.c b/src/openvpn/dco_linux.c</span><br><span>index f04ebfe..c92c196 1006=
44</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/=
openvpn/dco_linux.c</span><br><span>@@ -438,9 +438,11 @@</span><br><span> }=
</span><br><span> </span><br><span> bool</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-ovpn_dco_init(int mode, dco_context_t *dco, const char *=
dev_node)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_i=
nit(struct context *c)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    switch (mode)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    dco_context_t *dco =3D &amp;c-&gt;c1.tuntap-&gt;dco;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    switch (c-&gt;mode)</span><br><span=
>     {</span><br><span>         case CM_TOP:</span><br><span>             =
dco-&gt;ifmode =3D OVPN_MODE_MP;</span><br><span>@@ -454,6 +456,10 @@</span=
><br><span>             ASSERT(false);</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* store po=
inter to context as it may be required by message</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * parsing routines</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    dco-&gt;c =3D c;</span><br><span>     ovpn_dco_in=
it_netlink(dco);</span><br><span>     return true;</span><br><span> }</span=
><br><span>diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h</=
span><br><span>index 676b8cd..5e61cf1 100644</span><br><span>--- a/src/open=
vpn/dco_linux.h</span><br><span>+++ b/src/openvpn/dco_linux.h</span><br><sp=
an>@@ -65,6 +65,8 @@</span><br><span>     struct nl_cb *nl_cb;</span><br><s=
pan>     int status;</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct context *c;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     enum ovpn_mode ifmode;</span><b=
r><span> </span><br><span>     int ovpn_dco_id;</span><br><span>diff --git =
a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 77747a2..aa=
c8a6a 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b=
/src/openvpn/init.c</span><br><span>@@ -2007,7 +2007,7 @@</span><br><span> =
</span><br><span>         if (dco_enabled(&amp;c-&gt;options))</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     ovpn_dco_init(c-&gt;mode, &amp;c-&gt;c1.tuntap-&gt;dco, c-&gt;options.=
dev_node);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   ovpn_dco_init(c);</span><br><span>         }</span><br><span> </span><br=
><span>         /* open the tun device */</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1094?usp=
=3Demail">change 1094</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1094?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I673a17f8c5dec66cc6c28c1ed44=
780a7a63927d7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1094 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--hDmhNA0mSnY=--

