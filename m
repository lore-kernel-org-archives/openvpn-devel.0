From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 11 Mar 2026 14:57:39 +0000
In-Reply-To: <gerrit.1771008284000.Ifc7ad2407b9cca8cfcef79d7392a058735416139@...2715...>
References: <gerrit.1771008284000.Ifc7ad2407b9cca8cfcef79d7392a058735416139@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <da9f0f1ef78e949335371bc4391c7bf82bdbb099-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5h4z/kIvOhg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun: Avoid
 sign-compare issues in tun_read_queue
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

--5h4z/kIvOhg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
25?usp=3Demail )

Change subject: tun: Avoid sign-compare issues in tun_read_queue
......................................................................

tun: Avoid sign-compare issues in tun_read_queue

Just use the same type that the other values
already have.

While here review and remove some other useless
casts in msg() calls.

Change-Id: Ifc7ad2407b9cca8cfcef79d7392a058735416139
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1525
Message-Id: <20260306162925.2359-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
956.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tun.c
1 file changed, 13 insertions(+), 24 deletions(-)




diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 7f96602..7a173c5 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3273,24 +3273,18 @@

 #elif defined(_WIN32)

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 int
 tun_read_queue(struct tuntap *tt, int maxsize)
 {
     if (tt->reads.iostate =3D=3D IOSTATE_INITIAL)
     {
-        DWORD len;
         BOOL status;
         int err;

         /* reset buf to its initial state */
         tt->reads.buf =3D tt->reads.buf_init;

-        len =3D maxsize ? maxsize : BLEN(&tt->reads.buf);
+        int len =3D maxsize ? maxsize : BLEN(&tt->reads.buf);
         ASSERT(len <=3D BLEN(&tt->reads.buf));

         /* the overlapped read will signal this event on I/O completion */
@@ -3307,8 +3301,8 @@
             tt->reads.iostate =3D IOSTATE_IMMEDIATE_RETURN;
             tt->reads.status =3D 0;

-            dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read immediate return [%d,%d]=
", (int)len,
-                 (int)tt->reads.size);
+            dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read immediate return [%d,%lu=
]", len,
+                 tt->reads.size);
         }
         else
         {
@@ -3317,7 +3311,7 @@
             {
                 tt->reads.iostate =3D IOSTATE_QUEUED;
                 tt->reads.status =3D err;
-                dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read queued [%d]", (int)l=
en);
+                dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read queued [%d]", len);
             }
             else /* error occurred */
             {
@@ -3325,7 +3319,7 @@
                 ASSERT(SetEvent(tt->reads.overlapped.hEvent));
                 tt->reads.iostate =3D IOSTATE_IMMEDIATE_RETURN;
                 tt->reads.status =3D err;
-                dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read error [%d] : %s", (i=
nt)len,
+                dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read error [%d] : %s", le=
n,
                      strerror_win32(status, &gc));
                 gc_free(&gc);
             }
@@ -3362,8 +3356,8 @@

             tt->writes.status =3D 0;

-            dmsg(D_WIN32_IO, "WIN32 I/O: TAP Write immediate return [%d,%d=
]", BLEN(&tt->writes.buf),
-                 (int)tt->writes.size);
+            dmsg(D_WIN32_IO, "WIN32 I/O: TAP Write immediate return [%d,%l=
u]", BLEN(&tt->writes.buf),
+                 tt->writes.size);
         }
         else
         {
@@ -5457,14 +5451,14 @@
     if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_VERSION, &info, sizeof=
(info), &info,
                         sizeof(info), &len, NULL))
     {
-        msg(D_TUNTAP_INFO, "TAP-Windows Driver Version %d.%d %s", (int)inf=
o[0], (int)info[1],
+        msg(D_TUNTAP_INFO, "TAP-Windows Driver Version %lu.%lu %s", info[0=
], info[1],
             (info[2] ? "(DEBUG)" : ""));
     }
     if (!(info[0] =3D=3D TAP_WIN_MIN_MAJOR && info[1] >=3D TAP_WIN_MIN_MIN=
OR))
     {
         msg(M_FATAL,
             "ERROR:  This version of " PACKAGE_NAME
-            " requires a TAP-Windows driver that is at least version %d.%d=
 -- If you recently upgraded your " PACKAGE_NAME
+            " requires a TAP-Windows driver that is at least version %u.%u=
 -- If you recently upgraded your " PACKAGE_NAME
             " distribution, a reboot is probably required at this point to=
 get Windows to see the new driver.",
             TAP_WIN_MIN_MAJOR, TAP_WIN_MIN_MINOR);
     }
@@ -5475,8 +5469,8 @@
     if (tt->type =3D=3D DEV_TYPE_TUN && info[0] =3D=3D 9 && info[1] < 8)
     {
         msg(M_INFO,
-            "WARNING:  Tap-Win32 driver version %d.%d does not support IPv=
6 in TUN mode. IPv6 will not work. Upgrade your Tap-Win32 driver.",
-            (int)info[0], (int)info[1]);
+            "WARNING:  Tap-Win32 driver version %lu.%lu does not support I=
Pv6 in TUN mode. IPv6 will not work. Upgrade your Tap-Win32 driver.",
+            info[0], info[1]);
     }

     /* tap driver 9.8 (2.2.0 and 2.2.1 release) is buggy
@@ -5484,8 +5478,7 @@
     if (tt->type =3D=3D DEV_TYPE_TUN && info[0] =3D=3D 9 && info[1] =3D=3D=
 8)
     {
         msg(M_FATAL,
-            "ERROR:  Tap-Win32 driver version %d.%d is buggy regarding sma=
ll IPv4 packets in TUN mode. Upgrade your Tap-Win32 driver.",
-            (int)info[0], (int)info[1]);
+            "ERROR:  Tap-Win32 driver version 9.8 is buggy regarding small=
 IPv4 packets in TUN mode. Upgrade your Tap-Win32 driver.");
     }
 }

@@ -5497,7 +5490,7 @@
     if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_MTU, &mtu, sizeof(mtu)=
, &mtu, sizeof(mtu), &len,
                         NULL))
     {
-        msg(D_MTU_INFO, "TAP-Windows MTU=3D%d", (int)mtu);
+        msg(D_MTU_INFO, "TAP-Windows MTU=3D%lu", mtu);
     }
 }

@@ -5618,10 +5611,6 @@
     gc_free(&gc);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 tuntap_set_connected(const struct tuntap *tt)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1525?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifc7ad2407b9cca8cfcef79d7392a058735416139
Gerrit-Change-Number: 1525
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5h4z/kIvOhg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1525?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">tun: Avoid sign-compare issues in tun_read_queue=
<br><br>Just use the same type that the other values<br>already have.<br><b=
r>While here review and remove some other useless<br>casts in msg() calls.<=
br><br>Change-Id: Ifc7ad2407b9cca8cfcef79d7392a058735416139<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt=
;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/=
1525<br>Message-Id: &lt;20260306162925.2359-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35956.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/o=
penvpn/tun.c<br>1 file changed, 13 insertions(+), 24 deletions(-)<br><br></=
pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index=
 7f96602..7a173c5 100644</span><br><span>--- a/src/openvpn/tun.c</span><br>=
<span>+++ b/src/openvpn/tun.c</span><br><span>@@ -3273,24 +3273,18 @@</span=
><br><span> </span><br><span> #elif defined(_WIN32)</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> int</span><br><span> tun_read_queue=
(struct tuntap *tt, int maxsize)</span><br><span> {</span><br><span>     if=
 (tt-&gt;reads.iostate =3D=3D IOSTATE_INITIAL)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        DWORD len;</span><b=
r><span>         BOOL status;</span><br><span>         int err;</span><br><=
span> </span><br><span>         /* reset buf to its initial state */</span>=
<br><span>         tt-&gt;reads.buf =3D tt-&gt;reads.buf_init;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        len =3D =
maxsize ? maxsize : BLEN(&amp;tt-&gt;reads.buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        int len =3D maxsize ? maxsize : BLEN(&=
amp;tt-&gt;reads.buf);</span><br><span>         ASSERT(len &lt;=3D BLEN(&am=
p;tt-&gt;reads.buf));</span><br><span> </span><br><span>         /* the ove=
rlapped read will signal this event on I/O completion */</span><br><span>@@=
 -3307,8 +3301,8 @@</span><br><span>             tt-&gt;reads.iostate =3D I=
OSTATE_IMMEDIATE_RETURN;</span><br><span>             tt-&gt;reads.status =
=3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            dmsg(D_WIN32_IO, &quot;WIN32 I/O: TAP Read immediate return =
[%d,%d]&quot;, (int)len,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                 (int)tt-&gt;reads.size);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            dmsg(D_WIN32_IO, &quot;WIN32 I/O: TAP =
Read immediate return [%d,%lu]&quot;, len,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                 tt-&gt;reads.size);</span><br><span=
>         }</span><br><span>         else</span><br><span>         {</span>=
<br><span>@@ -3317,7 +3311,7 @@</span><br><span>             {</span><br><s=
pan>                 tt-&gt;reads.iostate =3D IOSTATE_QUEUED;</span><br><sp=
an>                 tt-&gt;reads.status =3D err;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                dmsg(D_WIN32_IO, &quot;WIN32 I/O=
: TAP Read queued [%d]&quot;, (int)len);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                dmsg(D_WIN32_IO, &quot;WIN32 I/O: TAP =
Read queued [%d]&quot;, len);</span><br><span>             }</span><br><spa=
n>             else /* error occurred */</span><br><span>             {</sp=
an><br><span>@@ -3325,7 +3319,7 @@</span><br><span>                 ASSERT(=
SetEvent(tt-&gt;reads.overlapped.hEvent));</span><br><span>                =
 tt-&gt;reads.iostate =3D IOSTATE_IMMEDIATE_RETURN;</span><br><span>       =
          tt-&gt;reads.status =3D err;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                dmsg(D_WIN32_IO, &quot;WIN32 I/O: TAP Read=
 error [%d] : %s&quot;, (int)len,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                dmsg(D_WIN32_IO, &quot;WIN32 I/O: TAP Read er=
ror [%d] : %s&quot;, len,</span><br><span>                      strerror_wi=
n32(status, &amp;gc));</span><br><span>                 gc_free(&amp;gc);</=
span><br><span>             }</span><br><span>@@ -3362,8 +3356,8 @@</span><=
br><span> </span><br><span>             tt-&gt;writes.status =3D 0;</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 dmsg(D_WIN32_IO, &quot;WIN32 I/O: TAP Write immediate return [%d,%d]&quot;=
, BLEN(&amp;tt-&gt;writes.buf),</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                 (int)tt-&gt;writes.size);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            dmsg(D_WIN32_IO, &quot;WIN32 =
I/O: TAP Write immediate return [%d,%lu]&quot;, BLEN(&amp;tt-&gt;writes.buf=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
tt-&gt;writes.size);</span><br><span>         }</span><br><span>         el=
se</span><br><span>         {</span><br><span>@@ -5457,14 +5451,14 @@</span=
><br><span>     if (DeviceIoControl(tt-&gt;hand, TAP_WIN_IOCTL_GET_VERSION,=
 &amp;info, sizeof(info), &amp;info,</span><br><span>                      =
   sizeof(info), &amp;len, NULL))</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        msg(D_TUNTAP_INFO, &quot;TAP-Win=
dows Driver Version %d.%d %s&quot;, (int)info[0], (int)info[1],</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_TUNTAP_INFO, &quo=
t;TAP-Windows Driver Version %lu.%lu %s&quot;, info[0], info[1],</span><br>=
<span>             (info[2] ? &quot;(DEBUG)&quot; : &quot;&quot;));</span><=
br><span>     }</span><br><span>     if (!(info[0] =3D=3D TAP_WIN_MIN_MAJOR=
 &amp;&amp; info[1] &gt;=3D TAP_WIN_MIN_MINOR))</span><br><span>     {</spa=
n><br><span>         msg(M_FATAL,</span><br><span>             &quot;ERROR:=
  This version of &quot; PACKAGE_NAME</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            &quot; requires a TAP-Windows driver that is at=
 least version %d.%d -- If you recently upgraded your &quot; PACKAGE_NAME</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot; re=
quires a TAP-Windows driver that is at least version %u.%u -- If you recent=
ly upgraded your &quot; PACKAGE_NAME</span><br><span>             &quot; di=
stribution, a reboot is probably required at this point to get Windows to s=
ee the new driver.&quot;,</span><br><span>             TAP_WIN_MIN_MAJOR, T=
AP_WIN_MIN_MINOR);</span><br><span>     }</span><br><span>@@ -5475,8 +5469,=
8 @@</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; in=
fo[0] =3D=3D 9 &amp;&amp; info[1] &lt; 8)</span><br><span>     {</span><br>=
<span>         msg(M_INFO,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            &quot;WARNING:  Tap-Win32 driver version %d.%d does not su=
pport IPv6 in TUN mode. IPv6 will not work. Upgrade your Tap-Win32 driver.&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            (in=
t)info[0], (int)info[1]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            &quot;WARNING:  Tap-Win32 driver version %lu.%lu does not=
 support IPv6 in TUN mode. IPv6 will not work. Upgrade your Tap-Win32 drive=
r.&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  info[0], info[1]);</span><br><span>     }</span><br><span> </span><br><sp=
an>     /* tap driver 9.8 (2.2.0 and 2.2.1 release) is buggy</span><br><spa=
n>@@ -5484,8 +5478,7 @@</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYP=
E_TUN &amp;&amp; info[0] =3D=3D 9 &amp;&amp; info[1] =3D=3D 8)</span><br><s=
pan>     {</span><br><span>         msg(M_FATAL,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            &quot;ERROR:  Tap-Win32 driver versi=
on %d.%d is buggy regarding small IPv4 packets in TUN mode. Upgrade your Ta=
p-Win32 driver.&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            (int)info[0], (int)info[1]);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &quot;ERROR:  Tap-Win32 driver version 9.=
8 is buggy regarding small IPv4 packets in TUN mode. Upgrade your Tap-Win32=
 driver.&quot;);</span><br><span>     }</span><br><span> }</span><br><span>=
 </span><br><span>@@ -5497,7 +5490,7 @@</span><br><span>     if (DeviceIoCo=
ntrol(tt-&gt;hand, TAP_WIN_IOCTL_GET_MTU, &amp;mtu, sizeof(mtu), &amp;mtu, =
sizeof(mtu), &amp;len,</span><br><span>                         NULL))</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(D_MTU_INFO, &quot;TAP-Windows MTU=3D%d&quot;, (int)mtu);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MTU_INFO, &quot=
;TAP-Windows MTU=3D%lu&quot;, mtu);</span><br><span>     }</span><br><span>=
 }</span><br><span> </span><br><span>@@ -5618,10 +5611,6 @@</span><br><span=
>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC di=
agnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static=
 void</span><br><span> tuntap_set_connected(const struct tuntap *tt)</span>=
<br><span> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1525?usp=3Demail">change 1525</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1525?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifc7ad2407b9cca8cfcef79d7392=
a058735416139 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1525 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--5h4z/kIvOhg=--

