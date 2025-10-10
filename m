From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 07:33:25 +0000
In-Reply-To: <gerrit.1755877911000.Id440917f433aab1a7db608ba04fa95ba47c2ddde@...2715...>
References: <gerrit.1755877911000.Id440917f433aab1a7db608ba04fa95ba47c2ddde@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <5f4397fe3f4a213e9615e0a68fe4013640c74ca7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pt8niS8ENTg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: Review use
 of positive_atoi vs atoi_constrained
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pt8niS8ENTg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1153?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: options: Review use of positive_atoi vs atoi_constrained
......................................................................

options: Review use of positive_atoi vs atoi_constrained

Replace where it is useful.

While here also add a missing cast in atoi_constrained.

Change-Id: Id440917f433aab1a7db608ba04fa95ba47c2ddde
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1153
Message-Id: <20251009205951.32301-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59244617/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 21 insertions(+), 31 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/1153/7

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fabcc1e..fec17b4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6421,21 +6421,15 @@
     else if (streq(p[0], "tun-mtu-max") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
-        int max_mtu =3D positive_atoi(p[1], msglevel);
-        if (max_mtu < 68 || max_mtu > 65536)
-        {
-            msg(msglevel, "--tun-mtu-max value '%s' is invalid", p[1]);
-        }
-        else
-        {
-            options->ce.tun_mtu_max =3D max_mtu;
-        }
+        atoi_constrained(p[1], &options->ce.tun_mtu_max, p[0], TUN_MTU_MAX=
_MIN, 65536, msglevel);
     }
     else if (streq(p[0], "tun-mtu-extra") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
-        options->ce.tun_mtu_extra =3D positive_atoi(p[1], msglevel);
-        options->ce.tun_mtu_extra_defined =3D true;
+        if (atoi_constrained(p[1], &options->ce.tun_mtu_extra, p[0], 0, 65=
536, msglevel))
+        {
+            options->ce.tun_mtu_extra_defined =3D true;
+        }
     }
     else if (streq(p[0], "max-packet-size") && p[1] && !p[2])
     {
@@ -6467,11 +6461,8 @@
     else if (streq(p[0], "fragment") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
-        options->ce.fragment =3D positive_atoi(p[1], msglevel);
-
-        if (options->ce.fragment < 68)
+        if (!atoi_constrained(p[1], &options->ce.fragment, p[0], 68, INT_M=
AX, msglevel))
         {
-            msg(msglevel, "--fragment needs to be at least 68");
             goto err;
         }

@@ -7145,12 +7136,14 @@
         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         if (p[1])
         {
-            int mssfix =3D positive_atoi(p[1], msglevel);
-            /* can be 0, but otherwise it needs to be high enough so we can
-             * substract room for headers. */
-            if (mssfix !=3D 0 && (mssfix < TLS_CHANNEL_MTU_MIN || mssfix >=
 UINT16_MAX))
+            int mssfix;
+            if (!atoi_constrained(p[1], &mssfix, p[0], 0, UINT16_MAX, msgl=
evel))
             {
-                msg(msglevel, "--mssfix value '%s' is invalid", p[1]);
+                goto err;
+            }
+            if (mssfix !=3D 0 && mssfix < TLS_CHANNEL_MTU_MIN)
+            {
+                msg(msglevel, "mssfix needs to be >=3D %d, not %d", TLS_CH=
ANNEL_MTU_MIN, mssfix);
                 goto err;
             }

@@ -7403,7 +7396,7 @@
     else if (streq(p[0], "max-routes-per-client") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_INHERIT);
-        options->max_routes_per_client =3D max_int(positive_atoi(p[1], msg=
level), 1);
+        atoi_constrained(p[1], &options->max_routes_per_client, p[0], 1, I=
NT_MAX, msglevel);
     }
     else if (streq(p[0], "client-cert-not-required") && !p[1])
     {
@@ -9222,8 +9215,6 @@
     }
     else if (streq(p[0], "keying-material-exporter") && p[1] && p[2])
     {
-        int ekm_length =3D positive_atoi(p[2], msglevel);
-
         VERIFY_PERMISSION(OPT_P_GENERAL);

         if (strncmp(p[1], "EXPORTER", 8))
@@ -9237,14 +9228,14 @@
             msg(msglevel,
                 "Keying material exporter label must not be '" EXPORT_KEY_=
DATA_LABEL "'.");
         }
-        if (ekm_length < 16 || ekm_length > 4095)
+
+        if (!atoi_constrained(p[2], &options->keying_material_exporter_len=
gth,
+                              p[0], 16, 4095, msglevel))
         {
-            msg(msglevel, "Invalid keying material exporter length");
             goto err;
         }

         options->keying_material_exporter_label =3D p[1];
-        options->keying_material_exporter_length =3D ekm_length;
     }
     else if (streq(p[0], "allow-recursive-routing") && !p[1])
     {
@@ -9279,15 +9270,14 @@
     }
     else if (streq(p[0], "vlan-pvid") && p[1] && !p[2])
     {
+        int vlan_pvid;
         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INSTANCE);
-        options->vlan_pvid =3D positive_atoi(p[1], msglevel);
-        if (options->vlan_pvid < OPENVPN_8021Q_MIN_VID
-            || options->vlan_pvid > OPENVPN_8021Q_MAX_VID)
+        if (!atoi_constrained(p[1], &vlan_pvid, p[0],
+                              OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID=
, msglevel))
         {
-            msg(msglevel, "the parameter of --vlan-pvid parameters must be=
 >=3D %u and <=3D %u",
-                OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);
             goto err;
         }
+        options->vlan_pvid =3D (uint16_t)vlan_pvid;
     }
     else
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1153?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id440917f433aab1a7db608ba04fa95ba47c2ddde
Gerrit-Change-Number: 1153
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pt8niS8ENTg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #7</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1153?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">options: Review use of positive_ato=
i vs atoi_constrained<br><br>Replace where it is useful.<br><br>While here =
also add a missing cast in atoi_constrained.<br><br>Change-Id: Id440917f433=
aab1a7db608ba04fa95ba47c2ddde<br>Signed-off-by: Frank Lichtenheld &lt;frank=
@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit=
 URL: https://gerrit.openvpn.net/c/openvpn/+/1153<br>Message-Id: &lt;202510=
09205951.32301-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/open=
vpn/mailman/message/59244617/<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>---<br>M src/openvpn/options.c<br>1 file changed, 21 insertion=
s(+), 31 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/53/1153/7</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/options.c b/src/openvpn/options.c</span><br><span>index fabcc1e..fec17b4=
 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/s=
rc/openvpn/options.c</span><br><span>@@ -6421,21 +6421,15 @@</span><br><spa=
n>     else if (streq(p[0], &quot;tun-mtu-max&quot;) &amp;&amp; p[1] &amp;&=
amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSI=
ON(OPT_P_MTU | OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        int max_mtu =3D positive_atoi(p[1], msglevel);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (max_mtu &lt; 68 ||=
 max_mtu &gt; 65536)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
sg(msglevel, &quot;--tun-mtu-max value &#39;%s&#39; is invalid&quot;, p[1])=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            options-&gt;ce.tun_mtu_max =3D max_mtu;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        atoi_constrained(p[1], &a=
mp;options-&gt;ce.tun_mtu_max, p[0], TUN_MTU_MAX_MIN, 65536, msglevel);</sp=
an><br><span>     }</span><br><span>     else if (streq(p[0], &quot;tun-mtu=
-extra&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</spa=
n><br><span>         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce.tun_=
mtu_extra =3D positive_atoi(p[1], msglevel);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        options-&gt;ce.tun_mtu_extra_defined =3D tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (atoi_=
constrained(p[1], &amp;options-&gt;ce.tun_mtu_extra, p[0], 0, 65536, msglev=
el))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;c=
e.tun_mtu_extra_defined =3D true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span>     }</span><br><span>     else if=
 (streq(p[0], &quot;max-packet-size&quot;) &amp;&amp; p[1] &amp;&amp; !p[2]=
)</span><br><span>     {</span><br><span>@@ -6467,11 +6461,8 @@</span><br><=
span>     else if (streq(p[0], &quot;fragment&quot;) &amp;&amp; p[1] &amp;&=
amp; !p[3])</span><br><span>     {</span><br><span>         VERIFY_PERMISSI=
ON(OPT_P_MTU | OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        options-&gt;ce.fragment =3D positive_atoi(p[1], msgleve=
l);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;ce.fragment &lt=
; 68)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!a=
toi_constrained(p[1], &amp;options-&gt;ce.fragment, p[0], 68, INT_MAX, msgl=
evel))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            msg(msglevel, &quot;--fragment needs to be at least=
 68&quot;);</span><br><span>             goto err;</span><br><span>        =
 }</span><br><span> </span><br><span>@@ -7145,12 +7136,14 @@</span><br><spa=
n>         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);</span><br><=
span>         if (p[1])</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            int mssfix =3D positive_atoi(p[1],=
 msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  /* can be 0, but otherwise it needs to be high enough so we can</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-             * substract room f=
or headers. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     if (mssfix !=3D 0 &amp;&amp; (mssfix &lt; TLS_CHANNEL_MTU_MIN || mssfi=
x &gt; UINT16_MAX))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            int mssfix;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (!atoi_constrained(p[1], &amp;mssfix, p[0], 0, UINT16_MA=
X, msglevel))</span><br><span>             {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                msg(msglevel, &quot;--mssfix value &=
#39;%s&#39; is invalid&quot;, p[1]);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                goto err;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (mssfix !=3D 0 &amp;&amp; mssfix &lt; TLS_C=
HANNEL_MTU_MIN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      msg(msglevel, &quot;mssfix needs to be &gt;=3D %d, not %d&quot;, TLS_=
CHANNEL_MTU_MIN, mssfix);</span><br><span>                 goto err;</span>=
<br><span>             }</span><br><span> </span><br><span>@@ -7403,7 +7396=
,7 @@</span><br><span>     else if (streq(p[0], &quot;max-routes-per-client=
&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br>=
<span>         VERIFY_PERMISSION(OPT_P_INHERIT);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        options-&gt;max_routes_per_client =3D ma=
x_int(positive_atoi(p[1], msglevel), 1);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        atoi_constrained(p[1], &amp;options-&gt;max_ro=
utes_per_client, p[0], 1, INT_MAX, msglevel);</span><br><span>     }</span>=
<br><span>     else if (streq(p[0], &quot;client-cert-not-required&quot;) &=
amp;&amp; !p[1])</span><br><span>     {</span><br><span>@@ -9222,8 +9215,6 =
@@</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;k=
eying-material-exporter&quot;) &amp;&amp; p[1] &amp;&amp; p[2])</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in=
t ekm_length =3D positive_atoi(p[2], msglevel);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>         VERIFY_PERMISSION(OPT_P=
_GENERAL);</span><br><span> </span><br><span>         if (strncmp(p[1], &qu=
ot;EXPORTER&quot;, 8))</span><br><span>@@ -9237,14 +9228,14 @@</span><br><s=
pan>             msg(msglevel,</span><br><span>                 &quot;Keyin=
g material exporter label must not be &#39;&quot; EXPORT_KEY_DATA_LABEL &qu=
ot;&#39;.&quot;);</span><br><span>         }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (ekm_length &lt; 16 || ekm_length &gt; 40=
95)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constrained(p[2],=
 &amp;options-&gt;keying_material_exporter_length,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                              p[0], 16, 4095=
, msglevel))</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            msg(msglevel, &quot;Invalid keying material e=
xporter length&quot;);</span><br><span>             goto err;</span><br><sp=
an>         }</span><br><span> </span><br><span>         options-&gt;keying=
_material_exporter_label =3D p[1];</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        options-&gt;keying_material_exporter_length =3D ekm_le=
ngth;</span><br><span>     }</span><br><span>     else if (streq(p[0], &quo=
t;allow-recursive-routing&quot;) &amp;&amp; !p[1])</span><br><span>     {</=
span><br><span>@@ -9279,15 +9270,14 @@</span><br><span>     }</span><br><sp=
an>     else if (streq(p[0], &quot;vlan-pvid&quot;) &amp;&amp; p[1] &amp;&a=
mp; !p[2])</span><br><span>     {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        int vlan_pvid;</span><br><span>         VERIFY_PERMIS=
SION(OPT_P_GENERAL | OPT_P_INSTANCE);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        options-&gt;vlan_pvid =3D positive_atoi(p[1], msgle=
vel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (opti=
ons-&gt;vlan_pvid &lt; OPENVPN_8021Q_MIN_VID</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            || options-&gt;vlan_pvid &gt; OPENVPN_80=
21Q_MAX_VID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!atoi_constrained(p[1], &amp;vlan_pvid, p[0],</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                              OPENVPN_8021Q_=
MIN_VID, OPENVPN_8021Q_MAX_VID, msglevel))</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &=
quot;the parameter of --vlan-pvid parameters must be &gt;=3D %u and &lt;=3D=
 %u&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);</span><br><span>       =
      goto err;</span><br><span>         }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        options-&gt;vlan_pvid =3D (uint16_t)vlan_pvi=
d;</span><br><span>     }</span><br><span>     else</span><br><span>     {<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1153?usp=3Demail">change 1153</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1153?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id440917f433aab1a7db608ba04f=
a95ba47c2ddde </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1153 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--pt8niS8ENTg=--

