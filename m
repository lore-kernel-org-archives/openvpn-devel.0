From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 12:11:52 +0000
In-Reply-To: <gerrit.1755877911000.Id440917f433aab1a7db608ba04fa95ba47c2ddde@...2715...>
References: <gerrit.1755877911000.Id440917f433aab1a7db608ba04fa95ba47c2ddde@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c0a95ec5e7c46865410a7546c03e822df03b3d9c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pwP5hSi1EZc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pwP5hSi1EZc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1153?usp=3Demail

to look at the new patch set (#3).


Change subject: options: Review use of positive_atoi vs atoi_constrained
......................................................................

options: Review use of positive_atoi vs atoi_constrained

Replace where it is useful.

Change-Id: Id440917f433aab1a7db608ba04fa95ba47c2ddde
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
1 file changed, 21 insertions(+), 31 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/1153/3

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 227a85d..7c2b3c8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7011,21 +7011,15 @@
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
@@ -7057,11 +7051,8 @@
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

@@ -7736,12 +7727,14 @@
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

@@ -7994,7 +7987,7 @@
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
@@ -9808,8 +9801,6 @@
     }
     else if (streq(p[0], "keying-material-exporter") && p[1] && p[2])
     {
-        int ekm_length =3D positive_atoi(p[2], msglevel);
-
         VERIFY_PERMISSION(OPT_P_GENERAL);

         if (strncmp(p[1], "EXPORTER", 8))
@@ -9823,14 +9814,14 @@
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
@@ -9865,15 +9856,14 @@
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
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id440917f433aab1a7db608ba04fa95ba47c2ddde
Gerrit-Change-Number: 1153
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--pwP5hSi1EZc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1153?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">options: Review use of positive_atoi vs atoi_constrained<br><br>R=
eplace where it is useful.<br><br>Change-Id: Id440917f433aab1a7db608ba04fa9=
5ba47c2ddde<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>---<br>M src/openvpn/options.c<br>1 file changed, 21 insertions(+), 31 del=
etions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/53/1153/3</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/op=
tions.c</span><br><span>index 227a85d..7c2b3c8 100644</span><br><span>--- a=
/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><b=
r><span>@@ -7011,21 +7011,15 @@</span><br><span>     else if (streq(p[0], &=
quot;tun-mtu-max&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span> =
    {</span><br><span>         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTI=
ON);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int max_m=
tu =3D positive_atoi(p[1], msglevel);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (max_mtu &lt; 68 || max_mtu &gt; 65536)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;--tun-mtu-=
max value &#39;%s&#39; is invalid&quot;, p[1]);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     options-&gt;ce.tun_mtu_max =3D max_mtu;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        atoi_constrained(p[1], &amp;options-&gt;ce.tun_mtu_max=
, p[0], TUN_MTU_MAX_MIN, 65536, msglevel);</span><br><span>     }</span><br=
><span>     else if (streq(p[0], &quot;tun-mtu-extra&quot;) &amp;&amp; p[1]=
 &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_P=
ERMISSION(OPT_P_MTU | OPT_P_CONNECTION);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        options-&gt;ce.tun_mtu_extra =3D positive_atoi(p=
[1], msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  options-&gt;ce.tun_mtu_extra_defined =3D true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (atoi_constrained(p[1], &amp;option=
s-&gt;ce.tun_mtu_extra, p[0], 0, 65536, msglevel))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            options-&gt;ce.tun_mtu_extra_defined =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span>     }</span><br><span>     else if (streq(p[0], &quot;max-packe=
t-size&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</spa=
n><br><span>@@ -7057,11 +7051,8 @@</span><br><span>     else if (streq(p[0]=
, &quot;fragment&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span> =
    {</span><br><span>         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTI=
ON);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&=
gt;ce.fragment =3D positive_atoi(p[1], msglevel);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (options-&gt;ce.fragment &lt; 68)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;=
options-&gt;ce.fragment, p[0], 68, INT_MAX, msglevel))</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg=
(msglevel, &quot;--fragment needs to be at least 68&quot;);</span><br><span=
>             goto err;</span><br><span>         }</span><br><span> </span>=
<br><span>@@ -7736,12 +7727,14 @@</span><br><span>         VERIFY_PERMISSIO=
N(OPT_P_GENERAL | OPT_P_CONNECTION);</span><br><span>         if (p[1])</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            int mssfix =3D positive_atoi(p[1], msglevel);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            /* can be 0, but otherwis=
e it needs to be high enough so we can</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-             * substract room for headers. */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (mssfix !=3D 0 &amp=
;&amp; (mssfix &lt; TLS_CHANNEL_MTU_MIN || mssfix &gt; UINT16_MAX))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            int mssfix;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!atoi_c=
onstrained(p[1], &amp;mssfix, p[0], 0, UINT16_MAX, msglevel))</span><br><sp=
an>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            msg(msglevel, &quot;--mssfix value &#39;%s&#39; is invalid&quot=
;, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (mssfix !=3D 0 &amp;&amp; mssfix &lt; TLS_CHANNEL_MTU_MIN)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;m=
ssfix needs to be &gt;=3D %d, not %d&quot;, TLS_CHANNEL_MTU_MIN, mssfix);</=
span><br><span>                 goto err;</span><br><span>             }</s=
pan><br><span> </span><br><span>@@ -7994,7 +7987,7 @@</span><br><span>     =
else if (streq(p[0], &quot;max-routes-per-client&quot;) &amp;&amp; p[1] &am=
p;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMI=
SSION(OPT_P_INHERIT);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        options-&gt;max_routes_per_client =3D max_int(positive_atoi(p[1], m=
sglevel), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  atoi_constrained(p[1], &amp;options-&gt;max_routes_per_client, p[0], 1, I=
NT_MAX, msglevel);</span><br><span>     }</span><br><span>     else if (str=
eq(p[0], &quot;client-cert-not-required&quot;) &amp;&amp; !p[1])</span><br>=
<span>     {</span><br><span>@@ -9808,8 +9801,6 @@</span><br><span>     }</=
span><br><span>     else if (streq(p[0], &quot;keying-material-exporter&quo=
t;) &amp;&amp; p[1] &amp;&amp; p[2])</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        int ekm_length =3D positive_a=
toi(p[2], msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>=
 </span><br><span>         if (strncmp(p[1], &quot;EXPORTER&quot;, 8))</spa=
n><br><span>@@ -9823,14 +9814,14 @@</span><br><span>             msg(msglev=
el,</span><br><span>                 &quot;Keying material exporter label m=
ust not be &#39;&quot; EXPORT_KEY_DATA_LABEL &quot;&#39;.&quot;);</span><br=
><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (ekm_length &lt; 16 || ekm_length &gt; 4095)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!atoi_constrained(p[2], &amp;options-&gt;keying_=
material_exporter_length,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                              p[0], 16, 4095, msglevel))</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     msg(msglevel, &quot;Invalid keying material exporter length&quot;);</s=
pan><br><span>             goto err;</span><br><span>         }</span><br><=
span> </span><br><span>         options-&gt;keying_material_exporter_label =
=3D p[1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        opti=
ons-&gt;keying_material_exporter_length =3D ekm_length;</span><br><span>   =
  }</span><br><span>     else if (streq(p[0], &quot;allow-recursive-routing=
&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>@@ -9865,1=
5 +9856,14 @@</span><br><span>     }</span><br><span>     else if (streq(p[=
0], &quot;vlan-pvid&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int=
 vlan_pvid;</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_=
P_INSTANCE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o=
ptions-&gt;vlan_pvid =3D positive_atoi(p[1], msglevel);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;vlan_pvid &lt; OP=
ENVPN_8021Q_MIN_VID</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          || options-&gt;vlan_pvid &gt; OPENVPN_8021Q_MAX_VID)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constrained(p[=
1], &amp;vlan_pvid, p[0],</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                              OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MA=
X_VID, msglevel))</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;the parameter of --v=
lan-pvid parameters must be &gt;=3D %u and &lt;=3D %u&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                OPENVPN_8021Q_MIN_VI=
D, OPENVPN_8021Q_MAX_VID);</span><br><span>             goto err;</span><br=
><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      options-&gt;vlan_pvid =3D (uint16_t)vlan_pvid;</span><br><span>     }=
</span><br><span>     else</span><br><span>     {</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1153?usp=3Demail">change 1153</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1153?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id440917f433aab1a7db608ba04f=
a95ba47c2ddde </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1153 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--pwP5hSi1EZc=--

