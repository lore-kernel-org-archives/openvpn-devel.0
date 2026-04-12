From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 12 Apr 2026 15:12:19 +0000
In-Reply-To: <gerrit.1775421558000.Idfe2afd9616e17f0f80a914ff054ae18f0b6972b@...2715...>
References: <gerrit.1775421558000.Idfe2afd9616e17f0f80a914ff054ae18f0b6972b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <d6eb4ce02f50a7ec5858846c6ecf20a6ca26d7d4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KE0PQLz3oBY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: networking_sitnl:
 Make sitnl_parse_rtattr* return void
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KE0PQLz3oBY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
14?usp=3Demail )

Change subject: networking_sitnl: Make sitnl_parse_rtattr* return void
......................................................................

networking_sitnl: Make sitnl_parse_rtattr* return void

It returned a constant value so it didn't actually
do anything.

Identified by cppcheck.

Change-Id: Idfe2afd9616e17f0f80a914ff054ae18f0b6972b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1614
Message-Id: <20260408204213.9892-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
559.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/networking_sitnl.c
1 file changed, 5 insertions(+), 16 deletions(-)




diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index baf6f89..b3f8e2b 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1351,7 +1351,7 @@
     return ret;
 }

-static int
+static void
 sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtattr *r=
ta, size_t len,
                          unsigned short flags)
 {
@@ -1375,14 +1375,12 @@
     {
         msg(D_ROUTE, "%s: %zu bytes not parsed! (rta_len=3D%u)", __func__,=
 len, rta->rta_len);
     }
-
-    return 0;
 }

-static int
+static void
 sitnl_parse_rtattr(struct rtattr *tb[], size_t max, struct rtattr *rta, si=
ze_t len)
 {
-    return sitnl_parse_rtattr_flags(tb, max, rta, len, 0);
+    sitnl_parse_rtattr_flags(tb, max, rta, len, 0);
 }

 #define sitnl_parse_rtattr_nested(tb, max, rta) \
@@ -1394,23 +1392,14 @@
     char *type =3D arg;
     struct ifinfomsg *ifi =3D NLMSG_DATA(n);
     struct rtattr *tb[IFLA_MAX + 1];
-    int ret;

-    ret =3D sitnl_parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), IFLA_PAYLOAD(n=
));
-    if (ret < 0)
-    {
-        return ret;
-    }
+    sitnl_parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), IFLA_PAYLOAD(n));

     if (tb[IFLA_LINKINFO])
     {
         struct rtattr *tb_link[IFLA_INFO_MAX + 1];

-        ret =3D sitnl_parse_rtattr_nested(tb_link, IFLA_INFO_MAX, tb[IFLA_=
LINKINFO]);
-        if (ret < 0)
-        {
-            return ret;
-        }
+        sitnl_parse_rtattr_nested(tb_link, IFLA_INFO_MAX, tb[IFLA_LINKINFO=
]);

         if (!tb_link[IFLA_INFO_KIND])
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1614?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idfe2afd9616e17f0f80a914ff054ae18f0b6972b
Gerrit-Change-Number: 1614
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KE0PQLz3oBY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1614?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">networking_sitnl: Make sitnl_parse_rtattr* retur=
n void<br><br>It returned a constant value so it didn&#39;t actually<br>do =
anything.<br><br>Identified by cppcheck.<br><br>Change-Id: Idfe2afd9616e17f=
0f80a914ff054ae18f0b6972b<br>Signed-off-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Ge=
rrit URL: https://gerrit.openvpn.net/c/openvpn/+/1614<br>Message-Id: &lt;20=
260408204213.9892-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.co=
m/openvpn-devel@lists.sourceforge.net/msg36559.html<br>Signed-off-by: Gert =
Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/networking_sitnl.c<=
br>1 file changed, 5 insertions(+), 16 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sit=
nl.c</span><br><span>index baf6f89..b3f8e2b 100644</span><br><span>--- a/sr=
c/openvpn/networking_sitnl.c</span><br><span>+++ b/src/openvpn/networking_s=
itnl.c</span><br><span>@@ -1351,7 +1351,7 @@</span><br><span>     return re=
t;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span> sitnl_parse_rtattr_flags(struct rtatt=
r *tb[], size_t max, struct rtattr *rta, size_t len,</span><br><span>      =
                    unsigned short flags)</span><br><span> {</span><br><spa=
n>@@ -1375,14 +1375,12 @@</span><br><span>     {</span><br><span>         m=
sg(D_ROUTE, &quot;%s: %zu bytes not parsed! (rta_len=3D%u)&quot;, __func__,=
 len, rta-&gt;rta_len);</span><br><span>     }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return 0;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span> sitnl_parse_rtattr(str=
uct rtattr *tb[], size_t max, struct rtattr *rta, size_t len)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl=
_parse_rtattr_flags(tb, max, rta, len, 0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    sitnl_parse_rtattr_flags(tb, max, rta, len, 0);<=
/span><br><span> }</span><br><span> </span><br><span> #define sitnl_parse_r=
tattr_nested(tb, max, rta) \</span><br><span>@@ -1394,23 +1392,14 @@</span>=
<br><span>     char *type =3D arg;</span><br><span>     struct ifinfomsg *i=
fi =3D NLMSG_DATA(n);</span><br><span>     struct rtattr *tb[IFLA_MAX + 1];=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D =
sitnl_parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), IFLA_PAYLOAD(n));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (ret &lt; 0)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        return ret;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    sitnl_parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), IFLA_PAYLOAD(=
n));</span><br><span> </span><br><span>     if (tb[IFLA_LINKINFO])</span><b=
r><span>     {</span><br><span>         struct rtattr *tb_link[IFLA_INFO_MA=
X + 1];</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        ret =3D sitnl_parse_rtattr_nested(tb_link, IFLA_INFO_MAX, tb[IF=
LA_LINKINFO]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (ret &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            retur=
n ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        sitnl_parse_rtatt=
r_nested(tb_link, IFLA_INFO_MAX, tb[IFLA_LINKINFO]);</span><br><span> </spa=
n><br><span>         if (!tb_link[IFLA_INFO_KIND])</span><br><span>        =
 {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1614?usp=3Demail">change 1614</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1614?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idfe2afd9616e17f0f80a914ff05=
4ae18f0b6972b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1614 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--KE0PQLz3oBY=--

