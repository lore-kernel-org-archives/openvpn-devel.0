From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 12 Sep 2025 16:13:39 +0000
In-Reply-To: <gerrit.1757613551000.I889b53ed72efaec546a6609491fae9715726ea00@...2715...>
References: <gerrit.1757613551000.I889b53ed72efaec546a6609491fae9715726ea00@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <50f9a370ebbb7a19b3b89983996a85ff159c580f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5WAWB1ZA5JM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: remove newline
 characters at the end of msg() calls
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5WAWB1ZA5JM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1180?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: remove newline characters at the end of msg() calls
......................................................................

remove newline characters at the end of msg() calls

Unlike debugging with printf(), or msg() calls do not need or want
a '\n' at the end of the string.  Remove those that were overlooked.

Change-Id: I889b53ed72efaec546a6609491fae9715726ea00
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250912131609.43444-1-frank@...2641...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59232448/
URL: https://gerrit.openvpn.net/c/openvpn/+/1180
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
M src/openvpn/plugin.c
M src/openvpn/socket_util.h
M src/openvpn/tun.c
M src/openvpn/xkey_helper.c
M src/openvpn/xkey_provider.c
M tests/unit_tests/openvpn/test_cryptoapi.c
M tests/unit_tests/openvpn/test_pkcs11.c
8 files changed, 15 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1180/2

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 85975ff..7db4eda 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1036,7 +1036,7 @@
 #ifdef ENABLE_ASYNC_PUSH
     if (m->inotify_watchers)
     {
-        msg(D_MULTI_DEBUG, "inotify watchers count: %d\n", hash_n_elements=
(m->inotify_watchers));
+        msg(D_MULTI_DEBUG, "inotify watchers count: %d", hash_n_elements(m=
->inotify_watchers));
     }
 #endif
 }
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index e65a3bc..ea76a08 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -1007,7 +1007,7 @@
         msg(msglevel, "PLUGIN #%d (%s)", i, prefix);
         while (l)
         {
-            msg(msglevel, "[%d] '%s' -> '%s'\n", ++count, l->name, l->valu=
e);
+            msg(msglevel, "[%d] '%s' -> '%s'", ++count, l->name, l->value);
             l =3D l->next;
         }
     }
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index 5ea37dd..361edff 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -475,7 +475,7 @@
         default:
 #if 0
             /* could be called from socket_do_accept() with empty addr */
-            msg(M_ERR, "Bad address family: %d\n", af);
+            msg(M_ERR, "Bad address family: %d", af);
             ASSERT(0);
 #endif
             return 0;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 6c3096b..29f74a2 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2392,7 +2392,7 @@
     {
         if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0)
         {
-            msg(M_ERR, "Can't get flags\n");
+            msg(M_ERR, "Can't get flags");
         }
         strncpynt(ifr.lifr_name, tt->actual_name, sizeof(ifr.lifr_name));
         ifr.lifr_ppa =3D ppa;
@@ -2403,7 +2403,7 @@
         }
         if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0)
         {
-            msg(M_ERR, "Can't get flags\n");
+            msg(M_ERR, "Can't get flags");
         }
         /* Push arp module to if_fd */
         if (ioctl(if_fd, I_PUSH, "arp") < 0)
@@ -2422,18 +2422,18 @@
         /* Push arp module to ip_fd */
         if (ioctl(tt->ip_fd, I_PUSH, "arp") < 0)
         {
-            msg(M_ERR, "Can't push ARP module\n");
+            msg(M_ERR, "Can't push ARP module");
         }

         /* Open arp_fd */
         if ((arp_fd =3D open(arp_node, O_RDWR, 0)) < 0)
         {
-            msg(M_ERR, "Can't open %s\n", arp_node);
+            msg(M_ERR, "Can't open %s", arp_node);
         }
         /* Push arp module to arp_fd */
         if (ioctl(arp_fd, I_PUSH, "arp") < 0)
         {
-            msg(M_ERR, "Can't push ARP module\n");
+            msg(M_ERR, "Can't push ARP module");
         }

         /* Set ifname to arp */
@@ -2443,7 +2443,7 @@
         strioc_if.ic_dp =3D (char *)&ifr;
         if (ioctl(arp_fd, I_STR, &strioc_if) < 0)
         {
-            msg(M_ERR, "Can't set ifname to arp\n");
+            msg(M_ERR, "Can't set ifname to arp");
         }
     }

diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 3820808..72a24b5 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -53,7 +53,7 @@
     unsigned long e;
     while ((e =3D ERR_get_error()))
     {
-        msg(M_WARN, "OpenSSL error %lu: %s\n", e, ERR_error_string(e, NULL=
));
+        msg(M_WARN, "OpenSSL error %lu: %s", e, ERR_error_string(e, NULL));
     }
 }

@@ -429,7 +429,7 @@
     if (derlen > (int)capacity)
     {
         ECDSA_SIG_free(ecsig);
-        msg(M_NONFATAL, "Error: DER encoded ECDSA signature is too long (%=
d)\n", derlen);
+        msg(M_NONFATAL, "Error: DER encoded ECDSA signature is too long (%=
d)", derlen);
         return 0;
     }
     derlen =3D i2d_ECDSA_SIG(ecsig, &buf);
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index 1819ab0..168b554 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -944,7 +944,7 @@
 signature_sign(void *ctx, unsigned char *sig, size_t *siglen, size_t sigsi=
ze,
                const unsigned char *tbs, size_t tbslen)
 {
-    xkey_dmsg(D_XKEY, "entry with siglen =3D %zu\n", *siglen);
+    xkey_dmsg(D_XKEY, "entry with siglen =3D %zu", *siglen);

     XKEY_SIGNATURE_CTX *sctx =3D ctx;
     ASSERT(sctx);
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/o=
penvpn/test_cryptoapi.c
index 0cfc952..6e83465 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -64,7 +64,7 @@
     unsigned long e;
     while ((e =3D ERR_get_error()))
     {
-        msg(flags, "OpenSSL error %lu: %s\n", e, ERR_error_string(e, NULL)=
);
+        msg(flags, "OpenSSL error %lu: %s", e, ERR_error_string(e, NULL));
     }
 }

diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index 56125df..9ba6cfc 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -52,7 +52,7 @@
     unsigned long e;
     while ((e =3D ERR_get_error()))
     {
-        msg(flags, "OpenSSL error %lu: %s\n", e, ERR_error_string(e, NULL)=
);
+        msg(flags, "OpenSSL error %lu: %s", e, ERR_error_string(e, NULL));
     }
 }

@@ -170,7 +170,7 @@
     }
     else
     {
-        msg(M_NONFATAL, "ERROR: get_user_pass called with unknown request =
<%s> ignored\n", prefix);
+        msg(M_NONFATAL, "ERROR: get_user_pass called with unknown request =
<%s> ignored", prefix);
         ret =3D false;
     }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1180?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I889b53ed72efaec546a6609491fae9715726ea00
Gerrit-Change-Number: 1180
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--5WAWB1ZA5JM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1180?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">remove newline characters at the end of msg()=
 calls<br><br>Unlike debugging with printf(), or msg() calls do not need or=
 want<br>a &#39;\n&#39; at the end of the string.  Remove those that were o=
verlooked.<br><br>Change-Id: I889b53ed72efaec546a6609491fae9715726ea00<br>S=
igned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Frank Licht=
enheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20250912131609.43444-1-f=
rank@...2641...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/messa=
ge/59232448/<br>URL: https://gerrit.openvpn.net/c/openvpn/+/1180<br>Signed-=
off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/multi.=
c<br>M src/openvpn/plugin.c<br>M src/openvpn/socket_util.h<br>M src/openvpn=
/tun.c<br>M src/openvpn/xkey_helper.c<br>M src/openvpn/xkey_provider.c<br>M=
 tests/unit_tests/openvpn/test_cryptoapi.c<br>M tests/unit_tests/openvpn/te=
st_pkcs11.c<br>8 files changed, 15 insertions(+), 15 deletions(-)<br><br></=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1180/2</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span=
>index 85975ff..7db4eda 100644</span><br><span>--- a/src/openvpn/multi.c</s=
pan><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -1036,7 +1036,7 =
@@</span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>     if (m-&gt=
;inotify_watchers)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(D_MULTI_DEBUG, &quot;inotify watchers count=
: %d\n&quot;, hash_n_elements(m-&gt;inotify_watchers));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_DEBUG, &quot;inotif=
y watchers count: %d&quot;, hash_n_elements(m-&gt;inotify_watchers));</span=
><br><span>     }</span><br><span> #endif</span><br><span> }</span><br><spa=
n>diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c</span><br><span>=
index e65a3bc..ea76a08 100644</span><br><span>--- a/src/openvpn/plugin.c</s=
pan><br><span>+++ b/src/openvpn/plugin.c</span><br><span>@@ -1007,7 +1007,7=
 @@</span><br><span>         msg(msglevel, &quot;PLUGIN #%d (%s)&quot;, i, =
prefix);</span><br><span>         while (l)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, =
&quot;[%d] &#39;%s&#39; -&gt; &#39;%s&#39;\n&quot;, ++count, l-&gt;name, l-=
&gt;value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(msglevel, &quot;[%d] &#39;%s&#39; -&gt; &#39;%s&#39;&quot;, ++count=
, l-&gt;name, l-&gt;value);</span><br><span>             l =3D l-&gt;next;<=
/span><br><span>         }</span><br><span>     }</span><br><span>diff --gi=
t a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h</span><br><span>i=
ndex 5ea37dd..361edff 100644</span><br><span>--- a/src/openvpn/socket_util.=
h</span><br><span>+++ b/src/openvpn/socket_util.h</span><br><span>@@ -475,7=
 +475,7 @@</span><br><span>         default:</span><br><span> #if 0</span><=
br><span>             /* could be called from socket_do_accept() with empty=
 addr */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
sg(M_ERR, &quot;Bad address family: %d\n&quot;, af);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_ERR, &quot;Bad address =
family: %d&quot;, af);</span><br><span>             ASSERT(0);</span><br><s=
pan> #endif</span><br><span>             return 0;</span><br><span>diff --g=
it a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 6c3096b..2=
9f74a2 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b=
/src/openvpn/tun.c</span><br><span>@@ -2392,7 +2392,7 @@</span><br><span>  =
   {</span><br><span>         if (ioctl(if_fd, SIOCGLIFFLAGS, &amp;ifr) &lt=
; 0)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            msg(M_ERR, &quot;Can&#39;t get flags\n&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_ERR, &qu=
ot;Can&#39;t get flags&quot;);</span><br><span>         }</span><br><span> =
        strncpynt(ifr.lifr_name, tt-&gt;actual_name, sizeof(ifr.lifr_name))=
;</span><br><span>         ifr.lifr_ppa =3D ppa;</span><br><span>@@ -2403,7=
 +2403,7 @@</span><br><span>         }</span><br><span>         if (ioctl(i=
f_fd, SIOCGLIFFLAGS, &amp;ifr) &lt; 0)</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_ERR, &quot;Ca=
n&#39;t get flags\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(M_ERR, &quot;Can&#39;t get flags&quot;);</span><br>=
<span>         }</span><br><span>         /* Push arp module to if_fd */</s=
pan><br><span>         if (ioctl(if_fd, I_PUSH, &quot;arp&quot;) &lt; 0)</s=
pan><br><span>@@ -2422,18 +2422,18 @@</span><br><span>         /* Push arp =
module to ip_fd */</span><br><span>         if (ioctl(tt-&gt;ip_fd, I_PUSH,=
 &quot;arp&quot;) &lt; 0)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_ERR, &quot;Can&#39;t push=
 ARP module\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(M_ERR, &quot;Can&#39;t push ARP module&quot;);</span><br>=
<span>         }</span><br><span> </span><br><span>         /* Open arp_fd =
*/</span><br><span>         if ((arp_fd =3D open(arp_node, O_RDWR, 0)) &lt;=
 0)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            msg(M_ERR, &quot;Can&#39;t open %s\n&quot;, arp_node);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_E=
RR, &quot;Can&#39;t open %s&quot;, arp_node);</span><br><span>         }</s=
pan><br><span>         /* Push arp module to arp_fd */</span><br><span>    =
     if (ioctl(arp_fd, I_PUSH, &quot;arp&quot;) &lt; 0)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ms=
g(M_ERR, &quot;Can&#39;t push ARP module\n&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(M_ERR, &quot;Can&#39;t push =
ARP module&quot;);</span><br><span>         }</span><br><span> </span><br><=
span>         /* Set ifname to arp */</span><br><span>@@ -2443,7 +2443,7 @@=
</span><br><span>         strioc_if.ic_dp =3D (char *)&amp;ifr;</span><br><=
span>         if (ioctl(arp_fd, I_STR, &amp;strioc_if) &lt; 0)</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     msg(M_ERR, &quot;Can&#39;t set ifname to arp\n&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(M_ERR, &quot;Can&#3=
9;t set ifname to arp&quot;);</span><br><span>         }</span><br><span>  =
   }</span><br><span> </span><br><span>diff --git a/src/openvpn/xkey_helper=
.c b/src/openvpn/xkey_helper.c</span><br><span>index 3820808..72a24b5 10064=
4</span><br><span>--- a/src/openvpn/xkey_helper.c</span><br><span>+++ b/src=
/openvpn/xkey_helper.c</span><br><span>@@ -53,7 +53,7 @@</span><br><span>  =
   unsigned long e;</span><br><span>     while ((e =3D ERR_get_error()))</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       msg(M_WARN, &quot;OpenSSL error %lu: %s\n&quot;, e, ERR_error_string=
(e, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(M_WARN, &quot;OpenSSL error %lu: %s&quot;, e, ERR_error_string(e, NULL)=
);</span><br><span>     }</span><br><span> }</span><br><span> </span><br><s=
pan>@@ -429,7 +429,7 @@</span><br><span>     if (derlen &gt; (int)capacity)=
</span><br><span>     {</span><br><span>         ECDSA_SIG_free(ecsig);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_NONFATAL, &=
quot;Error: DER encoded ECDSA signature is too long (%d)\n&quot;, derlen);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONFAT=
AL, &quot;Error: DER encoded ECDSA signature is too long (%d)&quot;, derlen=
);</span><br><span>         return 0;</span><br><span>     }</span><br><spa=
n>     derlen =3D i2d_ECDSA_SIG(ecsig, &amp;buf);</span><br><span>diff --gi=
t a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c</span><br><sp=
an>index 1819ab0..168b554 100644</span><br><span>--- a/src/openvpn/xkey_pro=
vider.c</span><br><span>+++ b/src/openvpn/xkey_provider.c</span><br><span>@=
@ -944,7 +944,7 @@</span><br><span> signature_sign(void *ctx, unsigned char=
 *sig, size_t *siglen, size_t sigsize,</span><br><span>                cons=
t unsigned char *tbs, size_t tbslen)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    xkey_dmsg(D_XKEY, &quot;entry with si=
glen =3D %zu\n&quot;, *siglen);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    xkey_dmsg(D_XKEY, &quot;entry with siglen =3D %zu&quot;, *s=
iglen);</span><br><span> </span><br><span>     XKEY_SIGNATURE_CTX *sctx =3D=
 ctx;</span><br><span>     ASSERT(sctx);</span><br><span>diff --git a/tests=
/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_crypto=
api.c</span><br><span>index 0cfc952..6e83465 100644</span><br><span>--- a/t=
ests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_cryptoapi.c</span><br><span>@@ -64,7 +64,7 @@</span><br><=
span>     unsigned long e;</span><br><span>     while ((e =3D ERR_get_error=
()))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        msg(flags, &quot;OpenSSL error %lu: %s\n&quot;, e, ERR_error_=
string(e, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(flags, &quot;OpenSSL error %lu: %s&quot;, e, ERR_error_string(e, =
NULL));</span><br><span>     }</span><br><span> }</span><br><span> </span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_t=
ests/openvpn/test_pkcs11.c</span><br><span>index 56125df..9ba6cfc 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>@@ -52,7 +52,7=
 @@</span><br><span>     unsigned long e;</span><br><span>     while ((e =
=3D ERR_get_error()))</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        msg(flags, &quot;OpenSSL error %lu: %s\n&quo=
t;, e, ERR_error_string(e, NULL));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(flags, &quot;OpenSSL error %lu: %s&quot;, e, ERR=
_error_string(e, NULL));</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span>@@ -170,7 +170,7 @@</span><br><span>     }</span>=
<br><span>     else</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        msg(M_NONFATAL, &quot;ERROR: get_user_pass cal=
led with unknown request &lt;%s&gt; ignored\n&quot;, prefix);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;ERR=
OR: get_user_pass called with unknown request &lt;%s&gt; ignored&quot;, pre=
fix);</span><br><span>         ret =3D false;</span><br><span>     }</span>=
<br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1180?usp=3Demail">change 1180</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1180?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I889b53ed72efaec546a6609491f=
ae9715726ea00 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1180 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--5WAWB1ZA5JM=--

