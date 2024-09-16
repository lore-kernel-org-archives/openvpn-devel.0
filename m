From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 16 Sep 2024 13:04:07 +0000
References: <gerrit.1726491830000.Ib8f12516dbe294e21d3fed77478fb7660d4600c1@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <e68618a6ac8d6564970820038521a006fed0c6b5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B6krI/TGAeA="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--B6krI/TGAeA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/749?usp=3Demail

to review the following change.


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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/749/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 30ebf28..8d37a7f 100644
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
index 8f30c41..cef54d0 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6680,7 +6680,6 @@
      * GUID using the registry */
     tt->actual_name =3D string_alloc((const char *)actual_buffer, NULL);

-    msg(M_INFO, "%s device [%s] opened", print_tun_backend_driver(tt->back=
end_driver), tt->actual_name);
     tt->adapter_index =3D get_adapter_index(*device_guid);
 }

diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 5287e0c..c52fd22 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -363,6 +363,12 @@

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
@@ -695,9 +701,6 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--B6krI/TGAeA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/749?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Use print_tun_backend_driver instead of custom code to print =
type<br><br>Also show the device type that we opened always instead of cert=
ain<br>conditions only.<br><br>Change-Id: Ib8f12516dbe294e21d3fed77478fb766=
0d4600c1<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M=
 src/openvpn/init.c<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>3 file=
s changed, 8 insertions(+), 5 deletions(-)<br><br></pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/49/749/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/init.c b/src/openvpn/init.c</span><br><span>index 30ebf28..8d37a7f 10=
0644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/ope=
nvpn/init.c</span><br><span>@@ -1876,6 +1876,7 @@</span><br><span>         =
open_tun(c-&gt;options.dev, c-&gt;options.dev_type, c-&gt;options.dev_node,=
</span><br><span>                  tt, &amp;c-&gt;net_ctx);</span><br><span=
>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_IN=
FO, &quot;%s device [%s] opened&quot;, print_tun_backend_driver(tt-&gt;back=
end_driver), tt-&gt;actual_name);</span><br><span> }</span><br><span> </spa=
n><br><span> </span><br><span>@@ -2056,7 +2057,7 @@</span><br><span> do_clo=
se_tun_simple(struct context *c)</span><br><span> {</span><br><span>     ms=
g(D_CLOSE, &quot;Closing %s interface&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        dco_enabled(&amp;c-&gt;options) ? &quot;DCO&=
quot; : &quot;TUN/TAP&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        print_tun_backend_driver(c-&gt;c1.tuntap-&gt;backend_driv=
er));</span><br><span> </span><br><span>     if (c-&gt;c1.tuntap)</span><br=
><span>     {</span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/=
tun.c</span><br><span>index 8f30c41..cef54d0 100644</span><br><span>--- a/s=
rc/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@=
 -6680,7 +6680,6 @@</span><br><span>      * GUID using the registry */</spa=
n><br><span>     tt-&gt;actual_name =3D string_alloc((const char *)actual_b=
uffer, NULL);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    msg(M_INFO, &quot;%s device [%s] opened&quot;, print_tun_back=
end_driver(tt-&gt;backend_driver), tt-&gt;actual_name);</span><br><span>   =
  tt-&gt;adapter_index =3D get_adapter_index(*device_guid);</span><br><span=
> }</span><br><span> </span><br><span>diff --git a/src/openvpn/tun.h b/src/=
openvpn/tun.h</span><br><span>index 5287e0c..c52fd22 100644</span><br><span=
>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</span><br>=
<span>@@ -363,6 +363,12 @@</span><br><span> </span><br><span> void warn_on_=
use_of_common_subnets(openvpn_net_ctx_t *ctx);</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Return a string representation of the tun b=
acked driver type</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+print_tun_backend_driver(=
enum tun_driver_type driver);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> /*</span><br><span>  * Should ifconfig be calle=
d before or after</span><br><span>  * tun dev open?</span><br><span>@@ -695=
,9 +701,6 @@</span><br><span>     return tuntap_is_dco_win(tt) &amp;&amp; (=
status &lt; 0) &amp;&amp; (openvpn_errno() =3D=3D ERROR_NETNAME_DELETED);</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-const char *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-print_tun_backend_driver(enum tun_driver_type driver);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #else  /* ifdef _WI=
N32 */</span><br><span> </span><br><span> static inline bool</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/749?usp=3Demail">change 749</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/749?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib8f12516dbe294e21d3fed77478=
fb7660d4600c1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 749 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--B6krI/TGAeA=--

