From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 07:33:28 +0000
In-Reply-To: <gerrit.1755877911000.Id440917f433aab1a7db608ba04fa95ba47c2ddde@...2715...>
References: <gerrit.1755877911000.Id440917f433aab1a7db608ba04fa95ba47c2ddde@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <5f4397fe3f4a213e9615e0a68fe4013640c74ca7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZmruhUjTrPc="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZmruhUjTrPc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
53?usp=3Demail )

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

Gerrit-MessageType: merged
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

--ZmruhUjTrPc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1153?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">options: Review use of positive_atoi vs atoi_con=
strained<br><br>Replace where it is useful.<br><br>While here also add a mi=
ssing cast in atoi_constrained.<br><br>Change-Id: Id440917f433aab1a7db608ba=
04fa95ba47c2ddde<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https:/=
/gerrit.openvpn.net/c/openvpn/+/1153<br>Message-Id: &lt;20251009205951.3230=
1-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/m=
essage/59244617/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>=
---<br>M src/openvpn/options.c<br>1 file changed, 21 insertions(+), 31 dele=
tions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index fabcc1e..fec17b4 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -6421,21 +=
6421,15 @@</span><br><span>     else if (streq(p[0], &quot;tun-mtu-max&quot=
;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span=
>         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        int max_mtu =3D positive_atoi(=
p[1], msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (max_mtu &lt; 68 || max_mtu &gt; 65536)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            msg(msglevel, &quot;--tun-mtu-max value &#39;%s&#39=
; is invalid&quot;, p[1]);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;ce.t=
un_mtu_max =3D max_mtu;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
atoi_constrained(p[1], &amp;options-&gt;ce.tun_mtu_max, p[0], TUN_MTU_MAX_M=
IN, 65536, msglevel);</span><br><span>     }</span><br><span>     else if (=
streq(p[0], &quot;tun-mtu-extra&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</s=
pan><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_MTU |=
 OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      options-&gt;ce.tun_mtu_extra =3D positive_atoi(p[1], msglevel);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce.tun_=
mtu_extra_defined =3D true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (atoi_constrained(p[1], &amp;options-&gt;ce.tun_mtu_extr=
a, p[0], 0, 65536, msglevel))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            options-&gt;ce.tun_mtu_extra_defined =3D true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</sp=
an><br><span>     else if (streq(p[0], &quot;max-packet-size&quot;) &amp;&a=
mp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>@@ -6467,=
11 +6461,8 @@</span><br><span>     else if (streq(p[0], &quot;fragment&quot=
;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span=
>         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce.fragment =3D po=
sitive_atoi(p[1], msglevel);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (op=
tions-&gt;ce.fragment &lt; 68)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (!atoi_constrained(p[1], &amp;options-&gt;ce.fragment=
, p[0], 68, INT_MAX, msglevel))</span><br><span>         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;--frag=
ment needs to be at least 68&quot;);</span><br><span>             goto err;=
</span><br><span>         }</span><br><span> </span><br><span>@@ -7145,12 +=
7136,14 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P=
_CONNECTION);</span><br><span>         if (p[1])</span><br><span>         {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            int mssfi=
x =3D positive_atoi(p[1], msglevel);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            /* can be 0, but otherwise it needs to be high e=
nough so we can</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
       * substract room for headers. */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            if (mssfix !=3D 0 &amp;&amp; (mssfix &lt; TLS=
_CHANNEL_MTU_MIN || mssfix &gt; UINT16_MAX))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            int mssfix;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (!atoi_constrained(p[1], &amp;m=
ssfix, p[0], 0, UINT16_MAX, msglevel))</span><br><span>             {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(msgleve=
l, &quot;--mssfix value &#39;%s&#39; is invalid&quot;, p[1]);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                goto err;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (mssfix !=3D 0 &am=
p;&amp; mssfix &lt; TLS_CHANNEL_MTU_MIN)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                msg(msglevel, &quot;mssfix needs to be &gt;=
=3D %d, not %d&quot;, TLS_CHANNEL_MTU_MIN, mssfix);</span><br><span>       =
          goto err;</span><br><span>             }</span><br><span> </span>=
<br><span>@@ -7403,7 +7396,7 @@</span><br><span>     else if (streq(p[0], &=
quot;max-routes-per-client&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><=
br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_INHERIT);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ma=
x_routes_per_client =3D max_int(positive_atoi(p[1], msglevel), 1);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        atoi_constrained(p[1=
], &amp;options-&gt;max_routes_per_client, p[0], 1, INT_MAX, msglevel);</sp=
an><br><span>     }</span><br><span>     else if (streq(p[0], &quot;client-=
cert-not-required&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br=
><span>@@ -9222,8 +9215,6 @@</span><br><span>     }</span><br><span>     el=
se if (streq(p[0], &quot;keying-material-exporter&quot;) &amp;&amp; p[1] &a=
mp;&amp; p[2])</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        int ekm_length =3D positive_atoi(p[2], msglevel);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>      =
   VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span> </span><br><span>    =
     if (strncmp(p[1], &quot;EXPORTER&quot;, 8))</span><br><span>@@ -9237,1=
4 +9228,14 @@</span><br><span>             msg(msglevel,</span><br><span>  =
               &quot;Keying material exporter label must not be &#39;&quot;=
 EXPORT_KEY_DATA_LABEL &quot;&#39;.&quot;);</span><br><span>         }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ekm_length &lt=
; 16 || ekm_length &gt; 4095)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (!atoi_constrained(p[2], &amp;options-&gt;keying_material_exporter_length=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
            p[0], 16, 4095, msglevel))</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot=
;Invalid keying material exporter length&quot;);</span><br><span>          =
   goto err;</span><br><span>         }</span><br><span> </span><br><span> =
        options-&gt;keying_material_exporter_label =3D p[1];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;keying_material_=
exporter_length =3D ekm_length;</span><br><span>     }</span><br><span>    =
 else if (streq(p[0], &quot;allow-recursive-routing&quot;) &amp;&amp; !p[1]=
)</span><br><span>     {</span><br><span>@@ -9279,15 +9270,14 @@</span><br>=
<span>     }</span><br><span>     else if (streq(p[0], &quot;vlan-pvid&quot=
;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        int vlan_pvid;</span><br><s=
pan>         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INSTANCE);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;vlan_pvid =3D=
 positive_atoi(p[1], msglevel);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (options-&gt;vlan_pvid &lt; OPENVPN_8021Q_MIN_VID</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            || options-&gt=
;vlan_pvid &gt; OPENVPN_8021Q_MAX_VID)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;vlan_pvid, p[0]=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
            OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID, msglevel))</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           msg(msglevel, &quot;the parameter of --vlan-pvid parameters must=
 be &gt;=3D %u and &lt;=3D %u&quot;,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID=
);</span><br><span>             goto err;</span><br><span>         }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;vlan_p=
vid =3D (uint16_t)vlan_pvid;</span><br><span>     }</span><br><span>     el=
se</span><br><span>     {</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1153?usp=3Demail">change=
 1153</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1153?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--ZmruhUjTrPc=--

