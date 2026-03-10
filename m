From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 10 Mar 2026 13:21:27 +0000
In-Reply-To: <gerrit.1771008284000.Ifc7ad2407b9cca8cfcef79d7392a058735416139@...2715...>
References: <gerrit.1771008284000.Ifc7ad2407b9cca8cfcef79d7392a058735416139@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <eabab701c4e2ded64fd8450ca933d6a4fdbe7765-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0CEDV2rHSB4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0CEDV2rHSB4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1525?usp=3Demail

to look at the new patch set (#4).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: tun: Avoid sign-compare issues in tun_read_queue
......................................................................

tun: Avoid sign-compare issues in tun_read_queue

Just use the same type that the other values
already have.

While here review and remove some other useless
casts in msg() calls.

Change-Id: Ifc7ad2407b9cca8cfcef79d7392a058735416139
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/tun.c
1 file changed, 13 insertions(+), 24 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/1525/4

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8105db2..f46802f 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3264,24 +3264,18 @@

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
@@ -3298,8 +3292,8 @@
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
@@ -3308,7 +3302,7 @@
             {
                 tt->reads.iostate =3D IOSTATE_QUEUED;
                 tt->reads.status =3D err;
-                dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read queued [%d]", (int)l=
en);
+                dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read queued [%d]", len);
             }
             else /* error occurred */
             {
@@ -3316,7 +3310,7 @@
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
@@ -3353,8 +3347,8 @@

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
@@ -5447,14 +5441,14 @@
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
@@ -5465,8 +5459,8 @@
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
@@ -5474,8 +5468,7 @@
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

@@ -5487,7 +5480,7 @@
     if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_MTU, &mtu, sizeof(mtu)=
, &mtu, sizeof(mtu), &len,
                         NULL))
     {
-        msg(D_MTU_INFO, "TAP-Windows MTU=3D%d", (int)mtu);
+        msg(D_MTU_INFO, "TAP-Windows MTU=3D%lu", mtu);
     }
 }

@@ -5608,10 +5601,6 @@
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifc7ad2407b9cca8cfcef79d7392a058735416139
Gerrit-Change-Number: 1525
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--0CEDV2rHSB4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1525?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">tun: Avoid sign-compare issues in tu=
n_read_queue<br><br>Just use the same type that the other values<br>already=
 have.<br><br>While here review and remove some other useless<br>casts in m=
sg() calls.<br><br>Change-Id: Ifc7ad2407b9cca8cfcef79d7392a058735416139<br>=
Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/o=
penvpn/tun.c<br>1 file changed, 13 insertions(+), 24 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/25/1525/4</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</s=
pan><br><span>index 8105db2..f46802f 100644</span><br><span>--- a/src/openv=
pn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -3264,2=
4 +3264,18 @@</span><br><span> </span><br><span> #elif defined(_WIN32)</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><s=
pan> tun_read_queue(struct tuntap *tt, int maxsize)</span><br><span> {</spa=
n><br><span>     if (tt-&gt;reads.iostate =3D=3D IOSTATE_INITIAL)</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
DWORD len;</span><br><span>         BOOL status;</span><br><span>         i=
nt err;</span><br><span> </span><br><span>         /* reset buf to its init=
ial state */</span><br><span>         tt-&gt;reads.buf =3D tt-&gt;reads.buf=
_init;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        len =3D maxsize ? maxsize : BLEN(&amp;tt-&gt;reads.buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        int len =3D maxsize=
 ? maxsize : BLEN(&amp;tt-&gt;reads.buf);</span><br><span>         ASSERT(l=
en &lt;=3D BLEN(&amp;tt-&gt;reads.buf));</span><br><span> </span><br><span>=
         /* the overlapped read will signal this event on I/O completion */=
</span><br><span>@@ -3298,8 +3292,8 @@</span><br><span>             tt-&gt;=
reads.iostate =3D IOSTATE_IMMEDIATE_RETURN;</span><br><span>             tt=
-&gt;reads.status =3D 0;</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            dmsg(D_WIN32_IO, &quot;WIN32 I/O: TAP Read=
 immediate return [%d,%d]&quot;, (int)len,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                 (int)tt-&gt;reads.size);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            dmsg(D_WIN32_IO, &qu=
ot;WIN32 I/O: TAP Read immediate return [%d,%lu]&quot;, len,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 tt-&gt;reads.size=
);</span><br><span>         }</span><br><span>         else</span><br><span=
>         {</span><br><span>@@ -3308,7 +3302,7 @@</span><br><span>         =
    {</span><br><span>                 tt-&gt;reads.iostate =3D IOSTATE_QUE=
UED;</span><br><span>                 tt-&gt;reads.status =3D err;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                dmsg(D_WIN32_I=
O, &quot;WIN32 I/O: TAP Read queued [%d]&quot;, (int)len);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                dmsg(D_WIN32_IO, &qu=
ot;WIN32 I/O: TAP Read queued [%d]&quot;, len);</span><br><span>           =
  }</span><br><span>             else /* error occurred */</span><br><span>=
             {</span><br><span>@@ -3316,7 +3310,7 @@</span><br><span>      =
           ASSERT(SetEvent(tt-&gt;reads.overlapped.hEvent));</span><br><spa=
n>                 tt-&gt;reads.iostate =3D IOSTATE_IMMEDIATE_RETURN;</span=
><br><span>                 tt-&gt;reads.status =3D err;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                dmsg(D_WIN32_IO, &quot;W=
IN32 I/O: TAP Read error [%d] : %s&quot;, (int)len,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                dmsg(D_WIN32_IO, &quot;WI=
N32 I/O: TAP Read error [%d] : %s&quot;, len,</span><br><span>             =
         strerror_win32(status, &amp;gc));</span><br><span>                =
 gc_free(&amp;gc);</span><br><span>             }</span><br><span>@@ -3353,=
8 +3347,8 @@</span><br><span> </span><br><span>             tt-&gt;writes.s=
tatus =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            dmsg(D_WIN32_IO, &quot;WIN32 I/O: TAP Write immediate =
return [%d,%d]&quot;, BLEN(&amp;tt-&gt;writes.buf),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                 (int)tt-&gt;writes.size);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dmsg(D_W=
IN32_IO, &quot;WIN32 I/O: TAP Write immediate return [%d,%lu]&quot;, BLEN(&=
amp;tt-&gt;writes.buf),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                 tt-&gt;writes.size);</span><br><span>         }</span>=
<br><span>         else</span><br><span>         {</span><br><span>@@ -5447=
,14 +5441,14 @@</span><br><span>     if (DeviceIoControl(tt-&gt;hand, TAP_W=
IN_IOCTL_GET_VERSION, &amp;info, sizeof(info), &amp;info,</span><br><span> =
                        sizeof(info), &amp;len, NULL))</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_TUNTA=
P_INFO, &quot;TAP-Windows Driver Version %d.%d %s&quot;, (int)info[0], (int=
)info[1],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(D_TUNTAP_INFO, &quot;TAP-Windows Driver Version %lu.%lu %s&quot;, info[0]=
, info[1],</span><br><span>             (info[2] ? &quot;(DEBUG)&quot; : &q=
uot;&quot;));</span><br><span>     }</span><br><span>     if (!(info[0] =3D=
=3D TAP_WIN_MIN_MAJOR &amp;&amp; info[1] &gt;=3D TAP_WIN_MIN_MINOR))</span>=
<br><span>     {</span><br><span>         msg(M_FATAL,</span><br><span>    =
         &quot;ERROR:  This version of &quot; PACKAGE_NAME</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            &quot; requires a TAP-Wind=
ows driver that is at least version %d.%d -- If you recently upgraded your =
&quot; PACKAGE_NAME</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &quot; requires a TAP-Windows driver that is at least version %=
u.%u -- If you recently upgraded your &quot; PACKAGE_NAME</span><br><span> =
            &quot; distribution, a reboot is probably required at this poin=
t to get Windows to see the new driver.&quot;,</span><br><span>            =
 TAP_WIN_MIN_MAJOR, TAP_WIN_MIN_MINOR);</span><br><span>     }</span><br><s=
pan>@@ -5465,8 +5459,8 @@</span><br><span>     if (tt-&gt;type =3D=3D DEV_T=
YPE_TUN &amp;&amp; info[0] =3D=3D 9 &amp;&amp; info[1] &lt; 8)</span><br><s=
pan>     {</span><br><span>         msg(M_INFO,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            &quot;WARNING:  Tap-Win32 driver vers=
ion %d.%d does not support IPv6 in TUN mode. IPv6 will not work. Upgrade yo=
ur Tap-Win32 driver.&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            (int)info[0], (int)info[1]);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            &quot;WARNING:  Tap-Win32 driver ver=
sion %lu.%lu does not support IPv6 in TUN mode. IPv6 will not work. Upgrade=
 your Tap-Win32 driver.&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            info[0], info[1]);</span><br><span>     }</span><br>=
<span> </span><br><span>     /* tap driver 9.8 (2.2.0 and 2.2.1 release) is=
 buggy</span><br><span>@@ -5474,8 +5468,7 @@</span><br><span>     if (tt-&g=
t;type =3D=3D DEV_TYPE_TUN &amp;&amp; info[0] =3D=3D 9 &amp;&amp; info[1] =
=3D=3D 8)</span><br><span>     {</span><br><span>         msg(M_FATAL,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;ERROR:  =
Tap-Win32 driver version %d.%d is buggy regarding small IPv4 packets in TUN=
 mode. Upgrade your Tap-Win32 driver.&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            (int)info[0], (int)info[1]);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            &quot;ERROR:  Tap-W=
in32 driver version 9.8 is buggy regarding small IPv4 packets in TUN mode. =
Upgrade your Tap-Win32 driver.&quot;);</span><br><span>     }</span><br><sp=
an> }</span><br><span> </span><br><span>@@ -5487,7 +5480,7 @@</span><br><sp=
an>     if (DeviceIoControl(tt-&gt;hand, TAP_WIN_IOCTL_GET_MTU, &amp;mtu, s=
izeof(mtu), &amp;mtu, sizeof(mtu), &amp;len,</span><br><span>              =
           NULL))</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        msg(D_MTU_INFO, &quot;TAP-Windows MTU=3D%d&quot;=
, (int)mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(D_MTU_INFO, &quot;TAP-Windows MTU=3D%lu&quot;, mtu);</span><br><span> =
    }</span><br><span> }</span><br><span> </span><br><span>@@ -5608,10 +560=
1,6 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> static void</span><br><span> tuntap_set_connected(const str=
uct tuntap *tt)</span><br><span> {</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1525?usp=3Demai=
l">change 1525</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1525?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifc7ad2407b9cca8cfcef79d7392=
a058735416139 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1525 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--0CEDV2rHSB4=--

