From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 22:49:13 +0000
References: <gerrit.1760136547000.Ie41101bd00d038fa6fb906f3d30d44bf65788b96@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <75b7417db42e39ca23c773b117b795edf499f947-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zBjgPR4LY7g="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dhcp: Replace DHCP
 Option types with defines
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

--zBjgPR4LY7g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1266?usp=3Demail

to review the following change.


Change subject: dhcp: Replace DHCP Option types with defines
......................................................................

dhcp: Replace DHCP Option types with defines

Just nicer. Verified against
https://www.iana.org/assignments/bootp-dhcp-parameters/bootp-dhcp-parameter=
s.xhtml

Change-Id: Ie41101bd00d038fa6fb906f3d30d44bf65788b96
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/dhcp.c
M src/openvpn/dhcp.h
2 files changed, 22 insertions(+), 13 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1266/1

diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 653127d..56f03f2 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -342,27 +342,27 @@
     bool error =3D false;
     if (o->domain)
     {
-        write_dhcp_str(buf, 15, o->domain, &error);
+        write_dhcp_str(buf, DHCP_DOMAIN_NAME, o->domain, &error);
     }

     if (o->netbios_scope)
     {
-        write_dhcp_str(buf, 47, o->netbios_scope, &error);
+        write_dhcp_str(buf, DHCP_NETBIOS_SCOPE, o->netbios_scope, &error);
     }

     if (o->netbios_node_type)
     {
-        write_dhcp_u8(buf, 46, o->netbios_node_type, &error);
+        write_dhcp_u8(buf, DHCP_NETBIOS_NODE_TYPE, o->netbios_node_type, &=
error);
     }

-    write_dhcp_u32_array(buf, 6, (uint32_t *)o->dns, o->dns_len, &error);
-    write_dhcp_u32_array(buf, 44, (uint32_t *)o->wins, o->wins_len, &error=
);
-    write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &error);
-    write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, &error=
);
+    write_dhcp_u32_array(buf, DHCP_DOMAIN_SERVER, (uint32_t *)o->dns, o->d=
ns_len, &error);
+    write_dhcp_u32_array(buf, DHCP_NETBIOS_DOMAIN_SERVER, (uint32_t *)o->w=
ins, o->wins_len, &error);
+    write_dhcp_u32_array(buf, DHCP_NTP_SERVER, (uint32_t *)o->ntp, o->ntp_=
len, &error);
+    write_dhcp_u32_array(buf, DHCP_NETBIOS_DIST_SERVER, (uint32_t *)o->nbd=
d, o->nbdd_len, &error);

     if (o->domain_search_list_len > 0)
     {
-        write_dhcp_search_str(buf, 119, o->domain_search_list, o->domain_s=
earch_list_len, &error);
+        write_dhcp_search_str(buf, DHCP_DOMAIN_SEARCH, o->domain_search_li=
st, o->domain_search_list_len, &error);
     }

     /* the MS DHCP server option 'Disable Netbios-over-TCP/IP
@@ -375,7 +375,7 @@
             msg(M_WARN, "build_dhcp_options_string: buffer overflow buildi=
ng DHCP options");
             return false;
         }
-        buf_write_u8(buf, 43);
+        buf_write_u8(buf, DHCP_VENDOR);
         buf_write_u8(buf, 6); /* total length field */
         buf_write_u8(buf, 0x001);
         buf_write_u8(buf, 4); /* length of the vendor specified field */
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index 8e15a39..3fcd2b6 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -30,10 +30,19 @@
 #pragma pack(1)

 /* DHCP Option types */
-#define DHCP_PAD      0
-#define DHCP_ROUTER   3
-#define DHCP_MSG_TYPE 53 /* message type (u8) */
-#define DHCP_END      255
+#define DHCP_PAD                   0
+#define DHCP_ROUTER                3
+#define DHCP_DOMAIN_SERVER         6
+#define DHCP_DOMAIN_NAME           15
+#define DHCP_NTP_SERVER            42
+#define DHCP_VENDOR                43
+#define DHCP_NETBIOS_DOMAIN_SERVER 44
+#define DHCP_NETBIOS_DIST_SERVER   45
+#define DHCP_NETBIOS_NODE_TYPE     46
+#define DHCP_NETBIOS_SCOPE         47
+#define DHCP_MSG_TYPE              53
+#define DHCP_DOMAIN_SEARCH         119
+#define DHCP_END                   255

 /* DHCP Messages types */
 #define DHCPDISCOVER 1

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1266?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie41101bd00d038fa6fb906f3d30d44bf65788b96
Gerrit-Change-Number: 1266
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--zBjgPR4LY7g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1266?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dhcp: Replace DHCP Option types with define=
s<br><br>Just nicer. Verified against<br>https://www.iana.org/assignments/b=
ootp-dhcp-parameters/bootp-dhcp-parameters.xhtml<br><br>Change-Id: Ie41101b=
d00d038fa6fb906f3d30d44bf65788b96<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>---<br>M src/openvpn/dhcp.c<br>M src/openvpn/dhcp.h<=
br>2 files changed, 22 insertions(+), 13 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1266/=
1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c</span><br><s=
pan>index 653127d..56f03f2 100644</span><br><span>--- a/src/openvpn/dhcp.c<=
/span><br><span>+++ b/src/openvpn/dhcp.c</span><br><span>@@ -342,27 +342,27=
 @@</span><br><span>     bool error =3D false;</span><br><span>     if (o-&=
gt;domain)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        write_dhcp_str(buf, 15, o-&gt;domain, &amp;error);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        write_dhcp_str(b=
uf, DHCP_DOMAIN_NAME, o-&gt;domain, &amp;error);</span><br><span>     }</sp=
an><br><span> </span><br><span>     if (o-&gt;netbios_scope)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        write=
_dhcp_str(buf, 47, o-&gt;netbios_scope, &amp;error);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        write_dhcp_str(buf, DHCP_NETBIOS_=
SCOPE, o-&gt;netbios_scope, &amp;error);</span><br><span>     }</span><br><=
span> </span><br><span>     if (o-&gt;netbios_node_type)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        write_dhc=
p_u8(buf, 46, o-&gt;netbios_node_type, &amp;error);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        write_dhcp_u8(buf, DHCP_NETBIOS_N=
ODE_TYPE, o-&gt;netbios_node_type, &amp;error);</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    writ=
e_dhcp_u32_array(buf, 6, (uint32_t *)o-&gt;dns, o-&gt;dns_len, &amp;error);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    write_dhcp_u32_ar=
ray(buf, 44, (uint32_t *)o-&gt;wins, o-&gt;wins_len, &amp;error);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    write_dhcp_u32_array(buf, 4=
2, (uint32_t *)o-&gt;ntp, o-&gt;ntp_len, &amp;error);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    write_dhcp_u32_array(buf, 45, (uint32_t=
 *)o-&gt;nbdd, o-&gt;nbdd_len, &amp;error);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    write_dhcp_u32_array(buf, DHCP_DOMAIN_SERVER, (=
uint32_t *)o-&gt;dns, o-&gt;dns_len, &amp;error);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    write_dhcp_u32_array(buf, DHCP_NETBIOS_DO=
MAIN_SERVER, (uint32_t *)o-&gt;wins, o-&gt;wins_len, &amp;error);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    write_dhcp_u32_array(buf,=
 DHCP_NTP_SERVER, (uint32_t *)o-&gt;ntp, o-&gt;ntp_len, &amp;error);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    write_dhcp_u32_array(b=
uf, DHCP_NETBIOS_DIST_SERVER, (uint32_t *)o-&gt;nbdd, o-&gt;nbdd_len, &amp;=
error);</span><br><span> </span><br><span>     if (o-&gt;domain_search_list=
_len &gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        write_dhcp_search_str(buf, 119, o-&gt;domain_search_l=
ist, o-&gt;domain_search_list_len, &amp;error);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        write_dhcp_search_str(buf, DHCP_DOMAIN_=
SEARCH, o-&gt;domain_search_list, o-&gt;domain_search_list_len, &amp;error)=
;</span><br><span>     }</span><br><span> </span><br><span>     /* the MS D=
HCP server option &#39;Disable Netbios-over-TCP/IP</span><br><span>@@ -375,=
7 +375,7 @@</span><br><span>             msg(M_WARN, &quot;build_dhcp_optio=
ns_string: buffer overflow building DHCP options&quot;);</span><br><span>  =
           return false;</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        buf_write_u8(buf, 43);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        buf_write_u8(buf, DHCP_V=
ENDOR);</span><br><span>         buf_write_u8(buf, 6); /* total length fiel=
d */</span><br><span>         buf_write_u8(buf, 0x001);</span><br><span>   =
      buf_write_u8(buf, 4); /* length of the vendor specified field */</spa=
n><br><span>diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h</span><br>=
<span>index 8e15a39..3fcd2b6 100644</span><br><span>--- a/src/openvpn/dhcp.=
h</span><br><span>+++ b/src/openvpn/dhcp.h</span><br><span>@@ -30,10 +30,19=
 @@</span><br><span> #pragma pack(1)</span><br><span> </span><br><span> /* =
DHCP Option types */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define DHCP_PAD      0</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define DHCP_ROUTER   3</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define DHCP_MSG_TYPE 53 /* message type (u8) */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define DHCP_END      255</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define DHCP_PAD                   0<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define DHCP_ROUTER =
               3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine DHCP_DOMAIN_SERVER         6</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define DHCP_DOMAIN_NAME           15</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define DHCP_NTP_SERVER            42</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define DHCP_VENDOR    =
            43</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne DHCP_NETBIOS_DOMAIN_SERVER 44</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define DHCP_NETBIOS_DIST_SERVER   45</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define DHCP_NETBIOS_NODE_TYPE     46</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define DHCP_NETBIOS_SCOPE=
         47</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
DHCP_MSG_TYPE              53</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define DHCP_DOMAIN_SEARCH         119</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define DHCP_END                   255</span><=
br><span> </span><br><span> /* DHCP Messages types */</span><br><span> #def=
ine DHCPDISCOVER 1</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1266?usp=3Demail">change 1266</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1266?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie41101bd00d038fa6fb906f3d30=
d44bf65788b96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1266 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--zBjgPR4LY7g=--

