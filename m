From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 14:56:49 +0000
In-Reply-To: <gerrit.1754914153000.I525d7300e49f9a5a18e7146ee35ccc2af8184b8a@...2715...>
References: <gerrit.1754914153000.I525d7300e49f9a5a18e7146ee35ccc2af8184b8a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <aada5cd1268f3db45daeb36536449726bde33014-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qPYgArFjaD0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco-win: add support
 for multipeer stats
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qPYgArFjaD0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
43?usp=3Demail )

Change subject: dco-win: add support for multipeer stats
......................................................................

dco-win: add support for multipeer stats

Use the new driver API to fetch per-peer link and VPN byte counters
in both client and server modes.

Two usage modes are supported:

 - Single peer: pass the peer ID and a fixed-size output buffer. If the
   IOCTL is not supported (old driver), fall back to the legacy API.

 - All peers: first call the IOCTL with a small output buffer to get
   the required size, then allocate a buffer and call again to fetch
   stats for all peers.

Change-Id: I525d7300e49f9a5a18e7146ee35ccc2af8184b8a
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250902122542.31023-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
744.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
M src/openvpn/ovpn_dco_win.h
3 files changed, 184 insertions(+), 3 deletions(-)




diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 5317ac1..01ba017 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -30,6 +30,7 @@
 #include "forward.h"
 #include "tun.h"
 #include "crypto.h"
+#include "multi.h"
 #include "ssl_common.h"
 #include "openvpn.h"

@@ -190,6 +191,8 @@
 {
     dco_context_t *dco =3D &c->c1.tuntap->dco;

+    dco->c =3D c;
+
     switch (c->mode)
     {
         case MODE_POINT_TO_POINT:
@@ -714,12 +717,132 @@
 int
 dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_e=
rr)
 {
-    /* Not implemented. */
-    return 0;
+    struct gc_arena gc =3D gc_new();
+
+    int ret =3D 0;
+    struct tuntap *tt =3D dco->tt;
+
+    if (!tuntap_defined(tt))
+    {
+        ret =3D -1;
+        goto done;
+    }
+
+    OVPN_GET_PEER_STATS ps =3D {
+        .PeerId =3D -1
+    };
+
+    DWORD required_size =3D 0, bytes_returned =3D 0;
+    /* first, figure out buffer size */
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_GET_PEER_STATS, &ps, sizeof(=
ps), &required_size, sizeof(DWORD), &bytes_returned, NULL))
+    {
+        if (GetLastError() =3D=3D ERROR_MORE_DATA)
+        {
+            if (bytes_returned !=3D sizeof(DWORD))
+            {
+                msg(M_WARN, "%s: invalid bytes returned for size query (%l=
u, expected %zu)", __func__, bytes_returned, sizeof(DWORD));
+                ret =3D -1;
+                goto done;
+            }
+            /* required_size now contains the size written by the driver */
+            if (required_size =3D=3D 0)
+            {
+                ret =3D 0; /* no peers to process */
+                goto done;
+            }
+            if (required_size < sizeof(OVPN_PEER_STATS))
+            {
+                msg(M_WARN, "%s: invalid required size %lu (minimum %zu)",=
 __func__, required_size, sizeof(OVPN_PEER_STATS));
+                ret =3D -1;
+                goto done;
+            }
+        }
+        else
+        {
+            msg(M_WARN | M_ERRNO, "%s: failed to fetch required buffer siz=
e", __func__);
+            ret =3D -1;
+            goto done;
+        }
+    }
+    else
+    {
+        /* unexpected success? */
+        if (bytes_returned =3D=3D 0)
+        {
+            ret =3D 0; /* no peers to process */
+            goto done;
+        }
+
+        msg(M_WARN, "%s: first DeviceIoControl call succeeded unexpectedly=
 (%lu bytes returned)", __func__, bytes_returned);
+        ret =3D -1;
+        goto done;
+    }
+
+
+    /* allocate the buffer and fetch stats */
+    OVPN_PEER_STATS *peer_stats =3D gc_malloc(required_size, true, &gc);
+    if (!peer_stats)
+    {
+        msg(M_WARN, "%s: failed to allocate buffer of size %lu", __func__,=
 required_size);
+        ret =3D -1;
+        goto done;
+    }
+
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_GET_PEER_STATS, &ps, sizeof(=
ps), peer_stats, required_size, &bytes_returned, NULL))
+    {
+        /* unlikely case when a peer has been added since fetching buffer =
size, not an error! */
+        if (GetLastError() =3D=3D ERROR_MORE_DATA)
+        {
+            msg(M_WARN, "%s: peer has been added, skip fetching stats", __=
func__);
+            ret =3D 0;
+            goto done;
+        }
+
+        msg(M_WARN | M_ERRNO, "%s: failed to fetch multipeer stats", __fun=
c__);
+        ret =3D -1;
+        goto done;
+    }
+
+    /* iterate over stats and update peers */
+    for (int i =3D 0; i < bytes_returned / sizeof(OVPN_PEER_STATS); ++i)
+    {
+        OVPN_PEER_STATS *stat =3D &peer_stats[i];
+
+        if (stat->PeerId >=3D dco->c->multi->max_clients)
+        {
+            msg(M_WARN, "%s: received out of bound peer_id %u (max=3D%u)",=
 __func__, stat->PeerId,
+                dco->c->multi->max_clients);
+            continue;
+        }
+
+        struct multi_instance *mi =3D dco->c->multi->instances[stat->PeerI=
d];
+        if (!mi)
+        {
+            msg(M_WARN, "%s: received data for a non-existing peer %u", __=
func__, stat->PeerId);
+            continue;
+        }
+
+        /* update peer stats */
+        struct context_2 *c2 =3D &mi->context.c2;
+        c2->dco_read_bytes =3D stat->LinkRxBytes;
+        c2->dco_write_bytes =3D stat->LinkTxBytes;
+        c2->tun_read_bytes =3D stat->VpnRxBytes;
+        c2->tun_write_bytes =3D stat->VpnTxBytes;
+    }
+
+done:
+    gc_free(&gc);
+
+    if (raise_sigusr1_on_err && ret < 0)
+    {
+        register_signal(dco->c->sig, SIGUSR1, "dco peer stats error");
+    }
+
+    return ret;
 }

 int
-dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
+dco_get_peer_stats_fallback(struct context *c, const bool raise_sigusr1_on=
_err)
 {
     struct tuntap *tt =3D c->c1.tuntap;

@@ -747,6 +870,48 @@
     return 0;
 }

+int
+dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
+{
+    struct tuntap *tt =3D c->c1.tuntap;
+
+    if (!tuntap_defined(tt))
+    {
+        return -1;
+    }
+
+    /* first, try a new ioctl */
+    OVPN_GET_PEER_STATS ps =3D { .PeerId =3D c->c2.tls_multi->dco_peer_id =
};
+
+    OVPN_PEER_STATS peer_stats =3D { 0 };
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_GET_PEER_STATS, &ps, sizeof(=
ps), &peer_stats, sizeof(peer_stats),
+                         &bytes_returned, NULL))
+    {
+        if (GetLastError() =3D=3D ERROR_INVALID_FUNCTION)
+        {
+            /* are we using the old driver? */
+            return dco_get_peer_stats_fallback(c, raise_sigusr1_on_err);
+        }
+
+        msg(M_WARN | M_ERRNO, "%s: DeviceIoControl(OVPN_IOCTL_GET_PEER_STA=
TS) failed", __func__);
+        return -1;
+    }
+
+    if (bytes_returned !=3D sizeof(OVPN_PEER_STATS))
+    {
+        msg(M_WARN | M_ERRNO, "%s: DeviceIoControl(OVPN_IOCTL_GET_PEER_STA=
TS) returned invalid size", __func__);
+        return -1;
+    }
+
+    c->c2.dco_read_bytes =3D peer_stats.LinkRxBytes;
+    c->c2.dco_write_bytes =3D peer_stats.LinkTxBytes;
+    c->c2.tun_read_bytes =3D peer_stats.VpnRxBytes;
+    c->c2.tun_write_bytes =3D peer_stats.VpnTxBytes;
+
+    return 0;
+}
+
 void
 dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
 {
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index a7f4865..4f3f028 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -57,6 +57,8 @@

     uint64_t dco_read_bytes;
     uint64_t dco_write_bytes;
+
+    struct context *c;
 };

 typedef struct dco_context dco_context_t;
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index baf7214..9e1378a 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -83,6 +83,14 @@
 	LONG64 TunBytesReceived;
 } OVPN_STATS, * POVPN_STATS;

+typedef struct _OVPN_PEER_STATS {
+    int PeerId;
+    LONG64 LinkRxBytes;
+    LONG64 LinkTxBytes;
+    LONG64 VpnRxBytes;
+    LONG64 VpnTxBytes;
+} OVPN_PEER_STATS, * POVPN_PEER_STATS;
+
 typedef enum _OVPN_KEY_SLOT {
 	OVPN_KEY_SLOT_PRIMARY,
 	OVPN_KEY_SLOT_SECONDARY
@@ -185,6 +193,10 @@
     int IPv6;
 } OVPN_MP_IROUTE, * POVPN_MP_IROUTE;

+typedef struct _OVPN_GET_PEER_STATS {
+    int PeerId; // -1 for all peers stats
+} OVPN_GET_PEER_STATS, * POVPN_GET_PEER_STATS;
+
 #define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
@@ -207,3 +219,5 @@

 #define OVPN_IOCTL_MP_ADD_IROUTE CTL_CODE(FILE_DEVICE_UNKNOWN, 17, METHOD_=
BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_MP_DEL_IROUTE CTL_CODE(FILE_DEVICE_UNKNOWN, 18, METHOD_=
BUFFERED, FILE_ANY_ACCESS)
+
+#define OVPN_IOCTL_GET_PEER_STATS CTL_CODE(FILE_DEVICE_UNKNOWN, 19, METHOD=
_BUFFERED, FILE_ANY_ACCESS)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1143?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I525d7300e49f9a5a18e7146ee35ccc2af8184b8a
Gerrit-Change-Number: 1143
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--qPYgArFjaD0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1143?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dco-win: add support for multipeer stats<br><=
br>Use the new driver API to fetch per-peer link and VPN byte counters<br>i=
n both client and server modes.<br><br>Two usage modes are supported:<br><b=
r> - Single peer: pass the peer ID and a fixed-size output buffer. If the<b=
r>   IOCTL is not supported (old driver), fall back to the legacy API.<br><=
br> - All peers: first call the IOCTL with a small output buffer to get<br>=
   the required size, then allocate a buffer and call again to fetch<br>   =
stats for all peers.<br><br>Change-Id: I525d7300e49f9a5a18e7146ee35ccc2af81=
84b8a<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250902122542.31023-1=
-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1484...=
ts.sourceforge.net/msg32744.html<br>Signed-off-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>---<br>M src/openvpn/dco_win.c<br>M src/openvpn/dco_win.h<b=
r>M src/openvpn/ovpn_dco_win.h<br>3 files changed, 184 insertions(+), 3 del=
etions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><sp=
an>index 5317ac1..01ba017 100644</span><br><span>--- a/src/openvpn/dco_win.=
c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -30,6 +30,=
7 @@</span><br><span> #include &quot;forward.h&quot;</span><br><span> #incl=
ude &quot;tun.h&quot;</span><br><span> #include &quot;crypto.h&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi.h&quo=
t;</span><br><span> #include &quot;ssl_common.h&quot;</span><br><span> #inc=
lude &quot;openvpn.h&quot;</span><br><span> </span><br><span>@@ -190,6 +191=
,8 @@</span><br><span> {</span><br><span>     dco_context_t *dco =3D &amp;c=
-&gt;c1.tuntap-&gt;dco;</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    dco-&gt;c =3D c;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     switch (c-&gt;mode)</span><br>=
<span>     {</span><br><span>         case MODE_POINT_TO_POINT:</span><br><=
span>@@ -714,12 +717,132 @@</span><br><span> int</span><br><span> dco_get_p=
eer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_err)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* No=
t implemented. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tu=
ntap *tt =3D dco-&gt;tt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tunta=
p_defined(tt))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D -1;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    OVPN_GET_PEER_STATS ps =3D {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        .PeerId =3D -1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    DWORD required_size =3D 0, bytes_returned =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* first, figure out buffer size=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceI=
oControl(tt-&gt;hand, OVPN_IOCTL_GET_PEER_STATS, &amp;ps, sizeof(ps), &amp;=
required_size, sizeof(DWORD), &amp;bytes_returned, NULL))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (GetLastError() =3D=3D ERROR_MORE_DATA)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (bytes_returned=
 !=3D sizeof(DWORD))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           msg(M_WARN, &quot;%s: invalid bytes returned for size query (%lu=
, expected %zu)&quot;, __func__, bytes_returned, sizeof(DWORD));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                ret =3D -1;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                goto d=
one;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* requir=
ed_size now contains the size written by the driver */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (required_size =3D=3D 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                ret =3D 0;=
 /* no peers to process */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                goto done;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (required_size &lt; sizeof(OVPN_PEER_STATS))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                msg(M_WARN, &quot=
;%s: invalid required size %lu (minimum %zu)&quot;, __func__, required_size=
, sizeof(OVPN_PEER_STATS));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                ret =3D -1;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                goto done;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(M_WARN | M_ERRNO, &quot;%s: failed to fetch required buffer size&quot=
;, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* unexpected success? */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (bytes_returned =3D=3D =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            ret =3D 0; /* n=
o peers to process */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quo=
t;%s: first DeviceIoControl call succeeded unexpectedly (%lu bytes returned=
)&quot;, __func__, bytes_returned);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        ret =3D -1;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        goto done;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* allocate the buffer and fetch =
stats */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PE=
ER_STATS *peer_stats =3D gc_malloc(required_size, true, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!peer_stats)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;%s: failed to a=
llocate buffer of size %lu&quot;, __func__, required_size);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        ret =3D -1;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!DeviceIoControl(tt-&gt;hand, OVPN_IOCTL_GET_PEER_STATS, &amp=
;ps, sizeof(ps), peer_stats, required_size, &amp;bytes_returned, NULL))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        /* unlikely case when a peer =
has been added since fetching buffer size, not an error! */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (GetLastError() =3D=3D E=
RROR_MORE_DATA)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(M_WARN, &quot;%s: peer has been added, skip fetching stats&quot;, __func_=
_);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            g=
oto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s:=
 failed to fetch multipeer stats&quot;, __func__);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        ret =3D -1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        goto done;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* iterate over stats and update peers */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; bytes_returned / sizeof=
(OVPN_PEER_STATS); ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        OV=
PN_PEER_STATS *stat =3D &amp;peer_stats[i];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (stat-&gt;PeerId &gt;=3D dco-&gt;c-&gt;multi-&gt;max_client=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &qu=
ot;%s: received out of bound peer_id %u (max=3D%u)&quot;, __func__, stat-&g=
t;PeerId,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      dco-&gt;c-&gt;multi-&gt;max_clients);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct multi_instance *mi =3D dco-&gt;c-&gt;multi-&gt;instances[stat-&=
gt;PeerId];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WAR=
N, &quot;%s: received data for a non-existing peer %u&quot;, __func__, stat=
-&gt;PeerId);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* update peer stats */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct contex=
t_2 *c2 =3D &amp;mi-&gt;context.c2;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        c2-&gt;dco_read_bytes =3D stat-&gt;LinkRxBytes;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        c2-&gt;dco_writ=
e_bytes =3D stat-&gt;LinkTxBytes;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        c2-&gt;tun_read_bytes =3D stat-&gt;VpnRxBytes;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        c2-&gt;tun_write_b=
ytes =3D stat-&gt;VpnTxBytes;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (raise_sigusr1_on_err &amp;&amp; ret &lt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        register_signal(dco-&gt;c-&g=
t;sig, SIGUSR1, &quot;dco peer stats error&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return ret;</span><br><span> }</span><br><span> </span><br><span> int</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_get_peer_stats(struct=
 context *c, const bool raise_sigusr1_on_err)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+dco_get_peer_stats_fallback(struct context *c, co=
nst bool raise_sigusr1_on_err)</span><br><span> {</span><br><span>     stru=
ct tuntap *tt =3D c-&gt;c1.tuntap;</span><br><span> </span><br><span>@@ -74=
7,6 +870,48 @@</span><br><span>     return 0;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_peer_stats(struct co=
ntext *c, const bool raise_sigusr1_on_err)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct tuntap *tt =3D c-&gt;c1.tuntap;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!tuntap_defined(tt))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* first, try a new ioctl =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER=
_STATS ps =3D { .PeerId =3D c-&gt;c2.tls_multi-&gt;dco_peer_id };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    OVPN_PEER_STATS peer_stats =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!Devi=
ceIoControl(tt-&gt;hand, OVPN_IOCTL_GET_PEER_STATS, &amp;ps, sizeof(ps), &a=
mp;peer_stats, sizeof(peer_stats),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                         &amp;bytes_returned, NULL))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (GetLastError() =3D=3D ERROR_I=
NVALID_FUNCTION)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /=
* are we using the old driver? */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            return dco_get_peer_stats_fallback(c, raise_sigus=
r1_on_err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%=
s: DeviceIoControl(OVPN_IOCTL_GET_PEER_STATS) failed&quot;, __func__);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (bytes_returned !=3D sizeof(OVPN_PEER_STATS))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s:=
 DeviceIoControl(OVPN_IOCTL_GET_PEER_STATS) returned invalid size&quot;, __=
func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    c-&gt;c2.dco_read_bytes =3D peer_stats.Li=
nkRxBytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt=
;c2.dco_write_bytes =3D peer_stats.LinkTxBytes;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    c-&gt;c2.tun_read_bytes =3D peer_stats.VpnR=
xBytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=
.tun_write_bytes =3D peer_stats.VpnTxBytes;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> v=
oid</span><br><span> dco_event_set(dco_context_t *dco, struct event_set *es=
, void *arg)</span><br><span> {</span><br><span>diff --git a/src/openvpn/dc=
o_win.h b/src/openvpn/dco_win.h</span><br><span>index a7f4865..4f3f028 1006=
44</span><br><span>--- a/src/openvpn/dco_win.h</span><br><span>+++ b/src/op=
envpn/dco_win.h</span><br><span>@@ -57,6 +57,8 @@</span><br><span> </span><=
br><span>     uint64_t dco_read_bytes;</span><br><span>     uint64_t dco_wr=
ite_bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c;</span=
><br><span> };</span><br><span> </span><br><span> typedef struct dco_contex=
t dco_context_t;</span><br><span>diff --git a/src/openvpn/ovpn_dco_win.h b/=
src/openvpn/ovpn_dco_win.h</span><br><span>index baf7214..9e1378a 100644</s=
pan><br><span>--- a/src/openvpn/ovpn_dco_win.h</span><br><span>+++ b/src/op=
envpn/ovpn_dco_win.h</span><br><span>@@ -83,6 +83,14 @@</span><br><span> 	L=
ONG64 TunBytesReceived;</span><br><span> } OVPN_STATS, * POVPN_STATS;</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef=
 struct _OVPN_PEER_STATS {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int PeerId;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    LONG64 LinkRxBytes;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    LONG64 LinkTxBytes;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    LONG64 VpnRxBytes;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    LONG64 VpnTxBytes;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+} OVPN_PEER_STATS, * POVPN_PEER_STATS;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef enum _OVPN_KE=
Y_SLOT {</span><br><span> 	OVPN_KEY_SLOT_PRIMARY,</span><br><span> 	OVPN_KE=
Y_SLOT_SECONDARY</span><br><span>@@ -185,6 +193,10 @@</span><br><span>     =
int IPv6;</span><br><span> } OVPN_MP_IROUTE, * POVPN_MP_IROUTE;</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struc=
t _OVPN_GET_PEER_STATS {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int PeerId; // -1 for all peers stats</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+} OVPN_GET_PEER_STATS, * POVPN_GET_PEER_STATS;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #de=
fine OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFER=
ED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_GET_STATS    CTL_C=
ODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><sp=
an> #define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD=
_BUFFERED, FILE_ANY_ACCESS)</span><br><span>@@ -207,3 +219,5 @@</span><br><=
span> </span><br><span> #define OVPN_IOCTL_MP_ADD_IROUTE CTL_CODE(FILE_DEVI=
CE_UNKNOWN, 17, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define =
OVPN_IOCTL_MP_DEL_IROUTE CTL_CODE(FILE_DEVICE_UNKNOWN, 18, METHOD_BUFFERED,=
 FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_IOCTL_GE=
T_PEER_STATS CTL_CODE(FILE_DEVICE_UNKNOWN, 19, METHOD_BUFFERED, FILE_ANY_AC=
CESS)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1143?usp=3Demail">change 1143</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1143?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I525d7300e49f9a5a18e7146ee35=
ccc2af8184b8a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1143 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--qPYgArFjaD0=--

