From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 24 Sep 2024 08:26:28 +0000
In-Reply-To: <gerrit.1726491830000.Ib8f12516dbe294e21d3fed77478fb7660d4600c1@...2715...>
References: <gerrit.1726491830000.Ib8f12516dbe294e21d3fed77478fb7660d4600c1@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <c9c5739754a524ecd242a9041d6b28d0dc6c8f19-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VDDFR1YGEeg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Use
 print_tun_backend_driver instead of custom code to print type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VDDFR1YGEeg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/749?usp=3Demail

to look at the new patch set (#11).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: Use print_tun_backend_driver instead of custom code to prin=
t type
......................................................................

Use print_tun_backend_driver instead of custom code to print type

Also show the device type that we opened always instead of certain
conditions only.

Change-Id: Ib8f12516dbe294e21d3fed77478fb7660d4600c1
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/init.c
M src/openvpn/tun.c
M src/openvpn/tun.h
3 files changed, 8 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/749/11

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fbf2c5b..cd9203a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1876,6 +1876,7 @@
         open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
                  tt, &c->net_ctx);
     }
+    msg(M_INFO, "%s device [%s] opened", print_tun_backend_driver(tt->back=
end_driver), tt->actual_name);
 }


@@ -2056,7 +2057,7 @@
 do_close_tun_simple(struct context *c)
 {
     msg(D_CLOSE, "Closing %s interface",
-        dco_enabled(&c->options) ? "DCO" : "TUN/TAP");
+        print_tun_backend_driver(c->c1.tuntap->backend_driver));

     if (c->c1.tuntap)
     {
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 770e806..206ddc0 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6678,7 +6678,6 @@
      * GUID using the registry */
     tt->actual_name =3D string_alloc((const char *)actual_buffer, NULL);

-    msg(M_INFO, "%s device [%s] opened", print_tun_backend_driver(tt->back=
end_driver), tt->actual_name);
     tt->adapter_index =3D get_adapter_index(*device_guid);
 }

diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index b2c1b01..329cd10 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -361,6 +361,12 @@

 void warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx);

+/**
+ * Return a string representation of the tun backed driver type
+ */
+const char *
+print_tun_backend_driver(enum tun_driver_type driver);
+
 /*
  * Should ifconfig be called before or after
  * tun dev open?
@@ -689,9 +695,6 @@
     return tuntap_is_dco_win(tt) && (status < 0) && (openvpn_errno() =3D=
=3D ERROR_NETNAME_DELETED);
 }

-const char *
-print_tun_backend_driver(enum tun_driver_type driver);
-
 #else  /* ifdef _WIN32 */

 static inline bool

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/749?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib8f12516dbe294e21d3fed77478fb7660d4600c1
Gerrit-Change-Number: 749
Gerrit-PatchSet: 11
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--VDDFR1YGEeg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #11</strong> to this change.</p><p>=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/749?usp=3Demail">View Chan=
ge</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule i=
s unsatisfied now.</p><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">Use print_tun_backend_driver instead of custom code to p=
rint type<br><br>Also show the device type that we opened always instead of=
 certain<br>conditions only.<br><br>Change-Id: Ib8f12516dbe294e21d3fed77478=
fb7660d4600c1<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---=
<br>M src/openvpn/init.c<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>3=
 files changed, 8 insertions(+), 5 deletions(-)<br><br></pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/49/749/11</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index fbf2c5b..cd92=
03a 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/s=
rc/openvpn/init.c</span><br><span>@@ -1876,6 +1876,7 @@</span><br><span>   =
      open_tun(c-&gt;options.dev, c-&gt;options.dev_type, c-&gt;options.dev=
_node,</span><br><span>                  tt, &amp;c-&gt;net_ctx);</span><br=
><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ms=
g(M_INFO, &quot;%s device [%s] opened&quot;, print_tun_backend_driver(tt-&g=
t;backend_driver), tt-&gt;actual_name);</span><br><span> }</span><br><span>=
 </span><br><span> </span><br><span>@@ -2056,7 +2057,7 @@</span><br><span> =
do_close_tun_simple(struct context *c)</span><br><span> {</span><br><span> =
    msg(D_CLOSE, &quot;Closing %s interface&quot;,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        dco_enabled(&amp;c-&gt;options) ? &quo=
t;DCO&quot; : &quot;TUN/TAP&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        print_tun_backend_driver(c-&gt;c1.tuntap-&gt;backen=
d_driver));</span><br><span> </span><br><span>     if (c-&gt;c1.tuntap)</sp=
an><br><span>     {</span><br><span>diff --git a/src/openvpn/tun.c b/src/op=
envpn/tun.c</span><br><span>index 770e806..206ddc0 100644</span><br><span>-=
-- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><s=
pan>@@ -6678,7 +6678,6 @@</span><br><span>      * GUID using the registry *=
/</span><br><span>     tt-&gt;actual_name =3D string_alloc((const char *)ac=
tual_buffer, NULL);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    msg(M_INFO, &quot;%s device [%s] opened&quot;, print_tu=
n_backend_driver(tt-&gt;backend_driver), tt-&gt;actual_name);</span><br><sp=
an>     tt-&gt;adapter_index =3D get_adapter_index(*device_guid);</span><br=
><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/tun.h =
b/src/openvpn/tun.h</span><br><span>index b2c1b01..329cd10 100644</span><br=
><span>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</spa=
n><br><span>@@ -361,6 +361,12 @@</span><br><span> </span><br><span> void wa=
rn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx);</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Return a string representation of the=
 tun backed driver type</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_tun_backend_d=
river(enum tun_driver_type driver);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Should ifconfig be=
 called before or after</span><br><span>  * tun dev open?</span><br><span>@=
@ -689,9 +695,6 @@</span><br><span>     return tuntap_is_dco_win(tt) &amp;&=
amp; (status &lt; 0) &amp;&amp; (openvpn_errno() =3D=3D ERROR_NETNAME_DELET=
ED);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-const char *</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-print_tun_backend_driver(enum tun_driver_type driver);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #else  /* ifd=
ef _WIN32 */</span><br><span> </span><br><span> static inline bool</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/749?usp=3Demail">change 749</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
749?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib8f12516dbe294e21d3fed77478=
fb7660d4600c1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 749 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--VDDFR1YGEeg=--

