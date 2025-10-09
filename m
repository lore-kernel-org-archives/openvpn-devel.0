From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 9 Oct 2025 16:40:30 +0000
In-Reply-To: <gerrit.1755877911000.Id440917f433aab1a7db608ba04fa95ba47c2ddde@...2715...>
References: <gerrit.1755877911000.Id440917f433aab1a7db608ba04fa95ba47c2ddde@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, max@...2606...
Message-ID: <8d7d4044d969093740789814c54121e70046648b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jdvi/drW6u4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Jdvi/drW6u4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld, plaisthos.

Hello MaxF, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1153?usp=3Demail

to look at the new patch set (#6).

The following approvals got outdated and were removed:
Code-Review+1 by MaxF


Change subject: options: Review use of positive_atoi vs atoi_constrained
......................................................................

options: Review use of positive_atoi vs atoi_constrained

Replace where it is useful.

While here also add a missing cast in atoi_constrained.

Change-Id: Id440917f433aab1a7db608ba04fa95ba47c2ddde
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
1 file changed, 21 insertions(+), 31 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/1153/6

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f2e6dec..e6e0b6f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6415,21 +6415,15 @@
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
@@ -6461,11 +6455,8 @@
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

@@ -7139,12 +7130,14 @@
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

@@ -7397,7 +7390,7 @@
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
@@ -9216,8 +9209,6 @@
     }
     else if (streq(p[0], "keying-material-exporter") && p[1] && p[2])
     {
-        int ekm_length =3D positive_atoi(p[2], msglevel);
-
         VERIFY_PERMISSION(OPT_P_GENERAL);

         if (strncmp(p[1], "EXPORTER", 8))
@@ -9231,14 +9222,14 @@
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
@@ -9273,15 +9264,14 @@
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
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>

--Jdvi/drW6u4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #6</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1153?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+1 by MaxF</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">options: Review use of positive_atoi=
 vs atoi_constrained<br><br>Replace where it is useful.<br><br>While here a=
lso add a missing cast in atoi_constrained.<br><br>Change-Id: Id440917f433a=
ab1a7db608ba04fa95ba47c2ddde<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>---<br>M src/openvpn/options.c<br>1 file changed, 21 inse=
rtions(+), 31 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/53/1153/6</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/options.c b/src/openvpn/options.c</span><br><span>index f2e6dec..e6=
e0b6f 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>++=
+ b/src/openvpn/options.c</span><br><span>@@ -6415,21 +6415,15 @@</span><br=
><span>     else if (streq(p[0], &quot;tun-mtu-max&quot;) &amp;&amp; p[1] &=
amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PER=
MISSION(OPT_P_MTU | OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        int max_mtu =3D positive_atoi(p[1], msglevel);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (max_mtu &lt; =
68 || max_mtu &gt; 65536)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(msglevel, &quot;--tun-mtu-max value &#39;%s&#39; is invalid&quot;, =
p[1]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            options-&gt;ce.tun_mtu_max =3D max_m=
tu;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        atoi_constrained(p[1=
], &amp;options-&gt;ce.tun_mtu_max, p[0], TUN_MTU_MAX_MIN, 65536, msglevel)=
;</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;tu=
n-mtu-extra&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {=
</span><br><span>         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce=
.tun_mtu_extra =3D positive_atoi(p[1], msglevel);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        options-&gt;ce.tun_mtu_extra_defined =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (atoi_constrained(p[1], &amp;options-&gt;ce.tun_mtu_extra, p[0], 0, 65536,=
 msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            option=
s-&gt;ce.tun_mtu_extra_defined =3D true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span>     =
else if (streq(p[0], &quot;max-packet-size&quot;) &amp;&amp; p[1] &amp;&amp=
; !p[2])</span><br><span>     {</span><br><span>@@ -6461,11 +6455,8 @@</spa=
n><br><span>     else if (streq(p[0], &quot;fragment&quot;) &amp;&amp; p[1]=
 &amp;&amp; !p[3])</span><br><span>     {</span><br><span>         VERIFY_P=
ERMISSION(OPT_P_MTU | OPT_P_CONNECTION);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        options-&gt;ce.fragment =3D positive_atoi(p[1], =
msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;ce.fragm=
ent &lt; 68)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!atoi_constrained(p[1], &amp;options-&gt;ce.fragment, p[0], 68, INT_MA=
X, msglevel))</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            msg(msglevel, &quot;--fragment needs to be a=
t least 68&quot;);</span><br><span>             goto err;</span><br><span> =
        }</span><br><span> </span><br><span>@@ -7139,12 +7130,14 @@</span><=
br><span>         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);</spa=
n><br><span>         if (p[1])</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            int mssfix =3D positive_ato=
i(p[1], msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         /* can be 0, but otherwise it needs to be high enough so we can</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-             * substract=
 room for headers. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if (mssfix !=3D 0 &amp;&amp; (mssfix &lt; TLS_CHANNEL_MTU_MIN |=
| mssfix &gt; UINT16_MAX))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            int mssfix;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (!atoi_constrained(p[1], &amp;mssfix, p[0], 0, UI=
NT16_MAX, msglevel))</span><br><span>             {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                msg(msglevel, &quot;--mssfi=
x value &#39;%s&#39; is invalid&quot;, p[1]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (mssfix !=3D 0 &amp;&amp; mssfix=
 &lt; TLS_CHANNEL_MTU_MIN)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                msg(msglevel, &quot;mssfix needs to be &gt;=3D %d, not %d&=
quot;, TLS_CHANNEL_MTU_MIN, mssfix);</span><br><span>                 goto =
err;</span><br><span>             }</span><br><span> </span><br><span>@@ -7=
397,7 +7390,7 @@</span><br><span>     else if (streq(p[0], &quot;max-routes=
-per-client&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {=
</span><br><span>         VERIFY_PERMISSION(OPT_P_INHERIT);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;max_routes_per_cl=
ient =3D max_int(positive_atoi(p[1], msglevel), 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        atoi_constrained(p[1], &amp;optio=
ns-&gt;max_routes_per_client, p[0], 1, INT_MAX, msglevel);</span><br><span>=
     }</span><br><span>     else if (streq(p[0], &quot;client-cert-not-requ=
ired&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>@@ -92=
16,8 +9209,6 @@</span><br><span>     }</span><br><span>     else if (streq(=
p[0], &quot;keying-material-exporter&quot;) &amp;&amp; p[1] &amp;&amp; p[2]=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        int ekm_length =3D positive_atoi(p[2], msglevel);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         VERIFY_PER=
MISSION(OPT_P_GENERAL);</span><br><span> </span><br><span>         if (strn=
cmp(p[1], &quot;EXPORTER&quot;, 8))</span><br><span>@@ -9231,14 +9222,14 @@=
</span><br><span>             msg(msglevel,</span><br><span>               =
  &quot;Keying material exporter label must not be &#39;&quot; EXPORT_KEY_D=
ATA_LABEL &quot;&#39;.&quot;);</span><br><span>         }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (ekm_length &lt; 16 || ekm_l=
ength &gt; 4095)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_cons=
trained(p[2], &amp;options-&gt;keying_material_exporter_length,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                              p=
[0], 16, 4095, msglevel))</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;Invalid key=
ing material exporter length&quot;);</span><br><span>             goto err;=
</span><br><span>         }</span><br><span> </span><br><span>         opti=
ons-&gt;keying_material_exporter_label =3D p[1];</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        options-&gt;keying_material_exporter_len=
gth =3D ekm_length;</span><br><span>     }</span><br><span>     else if (st=
req(p[0], &quot;allow-recursive-routing&quot;) &amp;&amp; !p[1])</span><br>=
<span>     {</span><br><span>@@ -9273,15 +9264,14 @@</span><br><span>     }=
</span><br><span>     else if (streq(p[0], &quot;vlan-pvid&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        int vlan_pvid;</span><br><span>        =
 VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INSTANCE);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options-&gt;vlan_pvid =3D positive_=
atoi(p[1], msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (options-&gt;vlan_pvid &lt; OPENVPN_8021Q_MIN_VID</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            || options-&gt;vlan_pvid=
 &gt; OPENVPN_8021Q_MAX_VID)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!atoi_constrained(p[1], &amp;vlan_pvid, p[0],</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
  OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID, msglevel))</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 msg(msglevel, &quot;the parameter of --vlan-pvid parameters must be &gt;=
=3D %u and &lt;=3D %u&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);</span=
><br><span>             goto err;</span><br><span>         }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;vlan_pvid =3D =
(uint16_t)vlan_pvid;</span><br><span>     }</span><br><span>     else</span=
><br><span>     {</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1153?usp=3Demail">change 1153</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1153?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id440917f433aab1a7db608ba04f=
a95ba47c2ddde </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1153 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>

</body></html>=

--Jdvi/drW6u4=--

