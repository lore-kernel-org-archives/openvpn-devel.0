From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 13:15:51 +0000
In-Reply-To: <gerrit.1683717398000.Id8321dfbb8ad8d79f4bb2a9da61f8cd6b6c6ee26@...2715...>
References: <gerrit.1683717398000.Id8321dfbb8ad8d79f4bb2a9da61f8cd6b6c6ee26@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5895134db4e0fdf9096653973d1dadcc2a6bdae0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9cBqHfdPWGk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Change type of
 frame.mss_fix to uint16_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9cBqHfdPWGk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/268?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Change type of frame.mss_fix to uint16_t
......................................................................

Change type of frame.mss_fix to uint16_t

Since in the end this always ends up as an uint16_t
anyway, just make the conversion much earlier. Cleans
up the code and removes some -Wconversion warnings.

v2:
 - proper error handling in options.c
v4:
 - also introduce a minimum mssfix

Change-Id: Id8321dfbb8ad8d79f4bb2a9da61f8cd6b6c6ee26
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20231009105151.34074-1-frank@...2641...>
URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20231009105151.34074-1=
-frank@...2641...
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mss.c
M src/openvpn/mss.h
M src/openvpn/mtu.c
M src/openvpn/mtu.h
M src/openvpn/options.c
5 files changed, 26 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/268/5

diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 816e65b..4227047 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -44,7 +44,7 @@
  *              if yes, hand to mss_fixup_dowork()
  */
 void
-mss_fixup_ipv4(struct buffer *buf, int maxmss)
+mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss)
 {
     const struct openvpn_iphdr *pip;
     int hlen;
@@ -72,7 +72,7 @@
             struct openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *) BPTR(&=
newbuf);
             if (tc->flags & OPENVPN_TCPH_SYN_MASK)
             {
-                mss_fixup_dowork(&newbuf, (uint16_t) maxmss);
+                mss_fixup_dowork(&newbuf, maxmss);
             }
         }
     }
@@ -84,7 +84,7 @@
  *              (IPv6 header structure is sufficiently different from IPv4=
...)
  */
 void
-mss_fixup_ipv6(struct buffer *buf, int maxmss)
+mss_fixup_ipv6(struct buffer *buf, uint16_t maxmss)
 {
     const struct openvpn_ipv6hdr *pip6;
     struct buffer newbuf;
@@ -130,7 +130,7 @@
         struct openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *) BPTR(&newb=
uf);
         if (tc->flags & OPENVPN_TCPH_SYN_MASK)
         {
-            mss_fixup_dowork(&newbuf, (uint16_t) maxmss-20);
+            mss_fixup_dowork(&newbuf, maxmss-20);
         }
     }
 }
@@ -191,13 +191,14 @@
                 {
                     continue;
                 }
-                mssval =3D (opt[2]<<8)+opt[3];
+                mssval =3D opt[2] << 8;
+                mssval +=3D opt[3];
                 if (mssval > maxmss)
                 {
-                    dmsg(D_MSS, "MSS: %d -> %d", (int) mssval, (int) maxms=
s);
+                    dmsg(D_MSS, "MSS: %" PRIu16 " -> %" PRIu16, mssval, ma=
xmss);
                     accumulate =3D htons(mssval);
-                    opt[2] =3D (maxmss>>8)&0xff;
-                    opt[3] =3D maxmss&0xff;
+                    opt[2] =3D (uint8_t)((maxmss>>8)&0xff);
+                    opt[3] =3D (uint8_t)(maxmss&0xff);
                     accumulate -=3D htons(maxmss);
                     ADJUST_CHECKSUM(accumulate, tc->check);
                 }
@@ -291,7 +292,7 @@
     {
         /* we subtract IPv4 and TCP overhead here, mssfix method will add =
the
          * extra 20 for IPv6 */
-        frame->mss_fix =3D options->ce.mssfix - (20 + 20);
+        frame->mss_fix =3D (uint16_t)(options->ce.mssfix - (20 + 20));
         return;
     }

@@ -325,7 +326,7 @@

     /* This is the target value our payload needs to be smaller */
     unsigned int target =3D options->ce.mssfix - overhead;
-    frame->mss_fix =3D adjust_payload_max_cbc(kt, target) - payload_overhe=
ad;
+    frame->mss_fix =3D (uint16_t)(adjust_payload_max_cbc(kt, target) - pay=
load_overhead);


 }
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 1c4704b..b2a68cf 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -29,9 +29,9 @@
 #include "mtu.h"
 #include "ssl_common.h"

-void mss_fixup_ipv4(struct buffer *buf, int maxmss);
+void mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss);

-void mss_fixup_ipv6(struct buffer *buf, int maxmss);
+void mss_fixup_ipv6(struct buffer *buf, uint16_t maxmss);

 void mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);

diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 56db118..81851d3 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -203,7 +203,7 @@
         buf_printf(&out, "%s ", prefix);
     }
     buf_printf(&out, "[");
-    buf_printf(&out, " mss_fix:%d", frame->mss_fix);
+    buf_printf(&out, " mss_fix:%" PRIu16, frame->mss_fix);
 #ifdef ENABLE_FRAGMENT
     buf_printf(&out, " max_frag:%d", frame->max_fragment_size);
 #endif
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index b602b86..c64398d 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -115,7 +115,7 @@
                                   *  decryption/encryption or compression.=
 */
     } buf;

-    unsigned int mss_fix;       /**< The actual MSS value that should be
+    uint16_t mss_fix;           /**< The actual MSS value that should be
                                  *   written to the payload packets. This
                                  *   is the value for IPv4 TCP packets. For
                                  *   IPv6 packets another 20 bytes must
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 134bb72..2b68bac 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7236,9 +7236,19 @@
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
         if (p[1])
         {
+            int mssfix =3D positive_atoi(p[1]);
+            /* can be 0, but otherwise it needs to be high enough so we can
+             * substract room for headers. */
+            if (mssfix !=3D 0
+                && (mssfix < TLS_CHANNEL_MTU_MIN || mssfix > UINT16_MAX))
+            {
+                msg(msglevel, "--mssfix value '%s' is invalid", p[1]);
+                goto err;
+            }
+
             /* value specified, assume encapsulation is not
              * included unless "mtu" follows later */
-            options->ce.mssfix =3D positive_atoi(p[1]);
+            options->ce.mssfix =3D mssfix;
             options->ce.mssfix_encap =3D false;
             options->ce.mssfix_default =3D false;
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/268?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id8321dfbb8ad8d79f4bb2a9da61f8cd6b6c6ee26
Gerrit-Change-Number: 268
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--9cBqHfdPWGk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/268?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Change type of frame.mss_fix to uint16_t<br><br>=
Since in the end this always ends up as an uint16_t<br>anyway, just make th=
e conversion much earlier. Cleans<br>up the code and removes some -Wconvers=
ion warnings.<br><br>v2:<br> - proper error handling in options.c<br>v4:<br=
> - also introduce a minimum mssfix<br><br>Change-Id: Id8321dfbb8ad8d79f4bb=
2a9da61f8cd6b6c6ee26<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2724...=
..&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message=
-Id: &lt;20231009105151.34074-1-frank@...2641...&gt;<br>URL: https://www.ma=
il-archive.com/search?l=3Dmid&amp;q=3D20231009105151.34074-1-frank@...2724...=
..<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/o=
penvpn/mss.c<br>M src/openvpn/mss.h<br>M src/openvpn/mtu.c<br>M src/openvpn=
/mtu.h<br>M src/openvpn/options.c<br>5 files changed, 26 insertions(+), 15 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/68/268/5</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/mss.c b/src/openvpn/mss.=
c</span><br><span>index 816e65b..4227047 100644</span><br><span>--- a/src/o=
penvpn/mss.c</span><br><span>+++ b/src/openvpn/mss.c</span><br><span>@@ -44=
,7 +44,7 @@</span><br><span>  *              if yes, hand to mss_fixup_dowo=
rk()</span><br><span>  */</span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-mss_fixup_ipv4(struct buffer *buf, int maxmss)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+mss_fixup_ipv4(struct =
buffer *buf, uint16_t maxmss)</span><br><span> {</span><br><span>     const=
 struct openvpn_iphdr *pip;</span><br><span>     int hlen;</span><br><span>=
@@ -72,7 +72,7 @@</span><br><span>             struct openvpn_tcphdr *tc =
=3D (struct openvpn_tcphdr *) BPTR(&amp;newbuf);</span><br><span>          =
   if (tc-&gt;flags &amp; OPENVPN_TCPH_SYN_MASK)</span><br><span>          =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                m=
ss_fixup_dowork(&amp;newbuf, (uint16_t) maxmss);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                mss_fixup_dowork(&amp;newbuf, =
maxmss);</span><br><span>             }</span><br><span>         }</span><b=
r><span>     }</span><br><span>@@ -84,7 +84,7 @@</span><br><span>  *       =
       (IPv6 header structure is sufficiently different from IPv4...)</span=
><br><span>  */</span><br><span> void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-mss_fixup_ipv6(struct buffer *buf, int maxmss)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+mss_fixup_ipv6(struct buffer *bu=
f, uint16_t maxmss)</span><br><span> {</span><br><span>     const struct op=
envpn_ipv6hdr *pip6;</span><br><span>     struct buffer newbuf;</span><br><=
span>@@ -130,7 +130,7 @@</span><br><span>         struct openvpn_tcphdr *tc=
 =3D (struct openvpn_tcphdr *) BPTR(&amp;newbuf);</span><br><span>         =
if (tc-&gt;flags &amp; OPENVPN_TCPH_SYN_MASK)</span><br><span>         {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            mss_fixup_do=
work(&amp;newbuf, (uint16_t) maxmss-20);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            mss_fixup_dowork(&amp;newbuf, maxmss-20);<=
/span><br><span>         }</span><br><span>     }</span><br><span> }</span>=
<br><span>@@ -191,13 +191,14 @@</span><br><span>                 {</span><b=
r><span>                     continue;</span><br><span>                 }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mssval =
=3D (opt[2]&lt;&lt;8)+opt[3];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                mssval =3D opt[2] &lt;&lt; 8;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                mssval +=3D opt[3];</sp=
an><br><span>                 if (mssval &gt; maxmss)</span><br><span>     =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            dmsg(D_MSS, &quot;MSS: %d -&gt; %d&quot;, (int) mssval, (int) m=
axmss);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        dmsg(D_MSS, &quot;MSS: %&quot; PRIu16 &quot; -&gt; %&quot; PRIu16, =
mssval, maxmss);</span><br><span>                     accumulate =3D htons(=
mssval);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       opt[2] =3D (maxmss&gt;&gt;8)&amp;0xff;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    opt[3] =3D maxmss&amp;0xff;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    opt=
[2] =3D (uint8_t)((maxmss&gt;&gt;8)&amp;0xff);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    opt[3] =3D (uint8_t)(maxmss&=
amp;0xff);</span><br><span>                     accumulate -=3D htons(maxms=
s);</span><br><span>                     ADJUST_CHECKSUM(accumulate, tc-&gt=
;check);</span><br><span>                 }</span><br><span>@@ -291,7 +292,=
7 @@</span><br><span>     {</span><br><span>         /* we subtract IPv4 an=
d TCP overhead here, mssfix method will add the</span><br><span>          *=
 extra 20 for IPv6 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        frame-&gt;mss_fix =3D options-&gt;ce.mssfix - (20 + 20);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        frame-&gt;mss_fix =3D =
(uint16_t)(options-&gt;ce.mssfix - (20 + 20));</span><br><span>         ret=
urn;</span><br><span>     }</span><br><span> </span><br><span>@@ -325,7 +32=
6,7 @@</span><br><span> </span><br><span>     /* This is the target value o=
ur payload needs to be smaller */</span><br><span>     unsigned int target =
=3D options-&gt;ce.mssfix - overhead;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    frame-&gt;mss_fix =3D adjust_payload_max_cbc(kt, target=
) - payload_overhead;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    frame-&gt;mss_fix =3D (uint16_t)(adjust_payload_max_cbc(kt, target) -=
 payload_overhead);</span><br><span> </span><br><span> </span><br><span> }<=
/span><br><span>diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h</span><b=
r><span>index 1c4704b..b2a68cf 100644</span><br><span>--- a/src/openvpn/mss=
.h</span><br><span>+++ b/src/openvpn/mss.h</span><br><span>@@ -29,9 +29,9 @=
@</span><br><span> #include &quot;mtu.h&quot;</span><br><span> #include &qu=
ot;ssl_common.h&quot;</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void mss_fixup_ipv4(struct buffer *buf, int maxmss);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void mss_fixup_ipv4(stru=
ct buffer *buf, uint16_t maxmss);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void mss_fixup_ipv6(struct buffer *buf, int=
 maxmss);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void mss_f=
ixup_ipv6(struct buffer *buf, uint16_t maxmss);</span><br><span> </span><br=
><span> void mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);</span><=
br><span> </span><br><span>diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu=
.c</span><br><span>index 56db118..81851d3 100644</span><br><span>--- a/src/=
openvpn/mtu.c</span><br><span>+++ b/src/openvpn/mtu.c</span><br><span>@@ -2=
03,7 +203,7 @@</span><br><span>         buf_printf(&amp;out, &quot;%s &quot=
;, prefix);</span><br><span>     }</span><br><span>     buf_printf(&amp;out=
, &quot;[&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
buf_printf(&amp;out, &quot; mss_fix:%d&quot;, frame-&gt;mss_fix);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quo=
t; mss_fix:%&quot; PRIu16, frame-&gt;mss_fix);</span><br><span> #ifdef ENAB=
LE_FRAGMENT</span><br><span>     buf_printf(&amp;out, &quot; max_frag:%d&qu=
ot;, frame-&gt;max_fragment_size);</span><br><span> #endif</span><br><span>=
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h</span><br><span>index b6=
02b86..c64398d 100644</span><br><span>--- a/src/openvpn/mtu.h</span><br><sp=
an>+++ b/src/openvpn/mtu.h</span><br><span>@@ -115,7 +115,7 @@</span><br><s=
pan>                                   *  decryption/encryption or compress=
ion. */</span><br><span>     } buf;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    unsigned int mss_fix;       /**&lt; The=
 actual MSS value that should be</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    uint16_t mss_fix;           /**&lt; The actual MSS value t=
hat should be</span><br><span>                                  *   written=
 to the payload packets. This</span><br><span>                             =
     *   is the value for IPv4 TCP packets. For</span><br><span>           =
                       *   IPv6 packets another 20 bytes must</span><br><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 134bb72..2b68bac 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -7236,9 +7=
236,19 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CO=
NNECTION);</span><br><span>         if (p[1])</span><br><span>         {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            int mssfix=
 =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            /* can be 0, but otherwise it needs to be high enough so =
we can</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
* substract room for headers. */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if (mssfix !=3D 0</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                &amp;&amp; (mssfix &lt; TLS_CHANNEL_=
MTU_MIN || mssfix &gt; UINT16_MAX))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                msg(msglevel, &quot;--mssfix value &#39;%s&#39; i=
s invalid&quot;, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                goto err;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>             /* value specified, assume encapsulation =
is not</span><br><span>              * included unless &quot;mtu&quot; foll=
ows later */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   options-&gt;ce.mssfix =3D positive_atoi(p[1]);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            options-&gt;ce.mssfix =3D mssfix;=
</span><br><span>             options-&gt;ce.mssfix_encap =3D false;</span>=
<br><span>             options-&gt;ce.mssfix_default =3D false;</span><br><=
span>         }</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/268?usp=3Demail">change 268</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/268?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id8321dfbb8ad8d79f4bb2a9da61=
f8cd6b6c6ee26 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 268 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--9cBqHfdPWGk=--

