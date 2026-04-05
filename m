From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 5 Apr 2026 20:39:31 +0000
References: <gerrit.1775421558000.Idfe2afd9616e17f0f80a914ff054ae18f0b6972b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9084e5f77c8403789068208b51b07e5249dc6925-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OYPTnA3qKII="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OYPTnA3qKII=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1614?usp=3Demail

to review the following change.


Change subject: networking_sitnl: Make sitnl_parse_rtattr* return void
......................................................................

networking_sitnl: Make sitnl_parse_rtattr* return void

It returned a constant value so it didn't actually
do anything.

Identified by cppcheck.

Change-Id: Idfe2afd9616e17f0f80a914ff054ae18f0b6972b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/networking_sitnl.c
1 file changed, 5 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/14/1614/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idfe2afd9616e17f0f80a914ff054ae18f0b6972b
Gerrit-Change-Number: 1614
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--OYPTnA3qKII=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1614?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">networking_sitnl: Make sitnl_parse_rtattr* =
return void<br><br>It returned a constant value so it didn&#39;t actually<b=
r>do anything.<br><br>Identified by cppcheck.<br><br>Change-Id: Idfe2afd961=
6e17f0f80a914ff054ae18f0b6972b<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>---<br>M src/openvpn/networking_sitnl.c<br>1 file chang=
ed, 5 insertions(+), 16 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/14/1614/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c</span=
><br><span>index baf6f89..b3f8e2b 100644</span><br><span>--- a/src/openvpn/=
networking_sitnl.c</span><br><span>+++ b/src/openvpn/networking_sitnl.c</sp=
an><br><span>@@ -1351,7 +1351,7 @@</span><br><span>     return ret;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span> sitnl_parse_rtattr_flags(struct rtattr *tb[], s=
ize_t max, struct rtattr *rta, size_t len,</span><br><span>                =
          unsigned short flags)</span><br><span> {</span><br><span>@@ -1375=
,14 +1375,12 @@</span><br><span>     {</span><br><span>         msg(D_ROUTE=
, &quot;%s: %zu bytes not parsed! (rta_len=3D%u)&quot;, __func__, len, rta-=
&gt;rta_len);</span><br><span>     }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn 0;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span> sitnl_parse_rtattr(struct rtattr=
 *tb[], size_t max, struct rtattr *rta, size_t len)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_parse_rta=
ttr_flags(tb, max, rta, len, 0);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    sitnl_parse_rtattr_flags(tb, max, rta, len, 0);</span><br>=
<span> }</span><br><span> </span><br><span> #define sitnl_parse_rtattr_nest=
ed(tb, max, rta) \</span><br><span>@@ -1394,23 +1392,14 @@</span><br><span>=
     char *type =3D arg;</span><br><span>     struct ifinfomsg *ifi =3D NLM=
SG_DATA(n);</span><br><span>     struct rtattr *tb[IFLA_MAX + 1];</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int ret;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D sitnl_pars=
e_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), IFLA_PAYLOAD(n));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (ret &lt; 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return ret;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    sitnl_parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), IFLA_PAYLOAD(n));</span=
><br><span> </span><br><span>     if (tb[IFLA_LINKINFO])</span><br><span>  =
   {</span><br><span>         struct rtattr *tb_link[IFLA_INFO_MAX + 1];</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  ret =3D sitnl_parse_rtattr_nested(tb_link, IFLA_INFO_MAX, tb[IFLA_LINKINF=
O]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ret &=
lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            return ret;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        sitnl_parse_rtattr_nested(t=
b_link, IFLA_INFO_MAX, tb[IFLA_LINKINFO]);</span><br><span> </span><br><spa=
n>         if (!tb_link[IFLA_INFO_KIND])</span><br><span>         {</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1614?usp=3Demail">change 1614</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1614?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idfe2afd9616e17f0f80a914ff05=
4ae18f0b6972b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1614 </div>
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

--OYPTnA3qKII=--

