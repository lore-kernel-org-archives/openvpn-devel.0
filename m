From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 7 Sep 2025 10:22:07 +0000
References: <gerrit.1757240524000.I6480d6f741c2368a0d951004b91167d5943f8f9d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <337d8f32cca468935416388ead94cc75243352ba-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yee/f2YbEUM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: replace assert()
 calls with ASSERT()
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

--yee/f2YbEUM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1171?usp=3Demail

to review the following change.


Change subject: replace assert() calls with ASSERT()
......................................................................

replace assert() calls with ASSERT()

OpenVPN's ASSERT() macro will do a bit more than the standard-libc
assert() call, namely print out which function and what expression
failed, before calling _exit(1).  Also, it can not be accidentially
compiled-away (-DNDEBUG).

Use of ASSERT() generally only advised in cases of "this must not happen,
but if it does, it's a programming or state corruption error that we
must know about".  Use of assert() is lacking the extra debug info, and as
such, not advised at all.

Change-Id: I6480d6f741c2368a0d951004b91167d5943f8f9d
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
M src/openvpn/init.c
M src/openvpn/options.c
3 files changed, 8 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/1171/1

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 931f9f6..65303cd 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -100,7 +100,7 @@

             in->sin_len =3D sizeof(*in);
             data =3D nvlist_get_binary(nvl, "address", &len);
-            assert(len =3D=3D sizeof(in->sin_addr));
+            ASSERT(len =3D=3D sizeof(in->sin_addr));
             memcpy(&in->sin_addr, data, sizeof(in->sin_addr));
             in->sin_port =3D nvlist_get_number(nvl, "port");
             break;
@@ -114,7 +114,7 @@

             in6->sin6_len =3D sizeof(*in6);
             data =3D nvlist_get_binary(nvl, "address", &len);
-            assert(len =3D=3D sizeof(in6->sin6_addr));
+            ASSERT(len =3D=3D sizeof(in6->sin6_addr));
             memcpy(&in6->sin6_addr, data, sizeof(in6->sin6_addr));
             in6->sin6_port =3D nvlist_get_number(nvl, "port");

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 39ea8e4..2821cd4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -319,7 +319,7 @@
 static unsigned int
 management_callback_remote_entry_count(void *arg)
 {
-    assert(arg);
+    ASSERT(arg);
     struct context *c =3D (struct context *)arg;
     struct connection_list *l =3D c->options.connection_list;

@@ -329,8 +329,8 @@
 static bool
 management_callback_remote_entry_get(void *arg, unsigned int index, char *=
*remote)
 {
-    assert(arg);
-    assert(remote);
+    ASSERT(arg);
+    ASSERT(remote);

     struct context *c =3D (struct context *)arg;
     struct connection_list *l =3D c->options.connection_list;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0616a17..6858a69 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3486,9 +3486,9 @@
     {
         /* Copy --dhcp-options to tuntap_options */
         struct dhcp_options *dhcp =3D &dns->from_dhcp;
-        assert(sizeof(dhcp->dns) =3D=3D sizeof(tt->dns));
-        assert(sizeof(dhcp->dns6) =3D=3D sizeof(tt->dns6));
-        assert(sizeof(dhcp->domain_search_list) =3D=3D sizeof(tt->domain_s=
earch_list));
+        ASSERT(sizeof(dhcp->dns) =3D=3D sizeof(tt->dns));
+        ASSERT(sizeof(dhcp->dns6) =3D=3D sizeof(tt->dns6));
+        ASSERT(sizeof(dhcp->domain_search_list) =3D=3D sizeof(tt->domain_s=
earch_list));

         tt->domain =3D dhcp->domain;
         tt->dns_len =3D dhcp->dns_len;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1171?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6480d6f741c2368a0d951004b91167d5943f8f9d
Gerrit-Change-Number: 1171
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--yee/f2YbEUM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1171?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">replace assert() calls with ASSERT()<br><br>OpenVPN&#39;s AS=
SERT() macro will do a bit more than the standard-libc<br>assert() call, na=
mely print out which function and what expression<br>failed, before calling=
 _exit(1).  Also, it can not be accidentially<br>compiled-away (-DNDEBUG).<=
br><br>Use of ASSERT() generally only advised in cases of &quot;this must n=
ot happen,<br>but if it does, it&#39;s a programming or state corruption er=
ror that we<br>must know about&quot;.  Use of assert() is lacking the extra=
 debug info, and as<br>such, not advised at all.<br><br>Change-Id: I6480d6f=
741c2368a0d951004b91167d5943f8f9d<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>---<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/init.c=
<br>M src/openvpn/options.c<br>3 files changed, 8 insertions(+), 8 deletion=
s(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/71/1171/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco=
_freebsd.c</span><br><span>index 931f9f6..65303cd 100644</span><br><span>--=
- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd=
.c</span><br><span>@@ -100,7 +100,7 @@</span><br><span> </span><br><span>  =
           in-&gt;sin_len =3D sizeof(*in);</span><br><span>             dat=
a =3D nvlist_get_binary(nvl, &quot;address&quot;, &amp;len);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            assert(len =3D=3D sizeof=
(in-&gt;sin_addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            ASSERT(len =3D=3D sizeof(in-&gt;sin_addr));</span><br><span>   =
          memcpy(&amp;in-&gt;sin_addr, data, sizeof(in-&gt;sin_addr));</spa=
n><br><span>             in-&gt;sin_port =3D nvlist_get_number(nvl, &quot;p=
ort&quot;);</span><br><span>             break;</span><br><span>@@ -114,7 +=
114,7 @@</span><br><span> </span><br><span>             in6-&gt;sin6_len =
=3D sizeof(*in6);</span><br><span>             data =3D nvlist_get_binary(n=
vl, &quot;address&quot;, &amp;len);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            assert(len =3D=3D sizeof(in6-&gt;sin6_addr));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(len =
=3D=3D sizeof(in6-&gt;sin6_addr));</span><br><span>             memcpy(&amp=
;in6-&gt;sin6_addr, data, sizeof(in6-&gt;sin6_addr));</span><br><span>     =
        in6-&gt;sin6_port =3D nvlist_get_number(nvl, &quot;port&quot;);</sp=
an><br><span> </span><br><span>diff --git a/src/openvpn/init.c b/src/openvp=
n/init.c</span><br><span>index 39ea8e4..2821cd4 100644</span><br><span>--- =
a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><sp=
an>@@ -319,7 +319,7 @@</span><br><span> static unsigned int</span><br><span=
> management_callback_remote_entry_count(void *arg)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert(arg);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(arg);</span><br><s=
pan>     struct context *c =3D (struct context *)arg;</span><br><span>     =
struct connection_list *l =3D c-&gt;options.connection_list;</span><br><spa=
n> </span><br><span>@@ -329,8 +329,8 @@</span><br><span> static bool</span>=
<br><span> management_callback_remote_entry_get(void *arg, unsigned int ind=
ex, char **remote)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    assert(arg);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    assert(remote);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ASSERT(arg);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ASSERT(remote);</span><br><span> </span><br><span>     struct c=
ontext *c =3D (struct context *)arg;</span><br><span>     struct connection=
_list *l =3D c-&gt;options.connection_list;</span><br><span>diff --git a/sr=
c/openvpn/options.c b/src/openvpn/options.c</span><br><span>index 0616a17..=
6858a69 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>=
+++ b/src/openvpn/options.c</span><br><span>@@ -3486,9 +3486,9 @@</span><br=
><span>     {</span><br><span>         /* Copy --dhcp-options to tuntap_opt=
ions */</span><br><span>         struct dhcp_options *dhcp =3D &amp;dns-&gt=
;from_dhcp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        as=
sert(sizeof(dhcp-&gt;dns) =3D=3D sizeof(tt-&gt;dns));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        assert(sizeof(dhcp-&gt;dns6) =3D=3D=
 sizeof(tt-&gt;dns6));</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        assert(sizeof(dhcp-&gt;domain_search_list) =3D=3D sizeof(tt-&gt;do=
main_search_list));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        ASSERT(sizeof(dhcp-&gt;dns) =3D=3D sizeof(tt-&gt;dns));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(sizeof(dhcp-&gt;=
dns6) =3D=3D sizeof(tt-&gt;dns6));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        ASSERT(sizeof(dhcp-&gt;domain_search_list) =3D=3D si=
zeof(tt-&gt;domain_search_list));</span><br><span> </span><br><span>       =
  tt-&gt;domain =3D dhcp-&gt;domain;</span><br><span>         tt-&gt;dns_le=
n =3D dhcp-&gt;dns_len;</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1171?usp=3Demail">change 1=
171</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1171?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6480d6f741c2368a0d951004b91=
167d5943f8f9d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1171 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--yee/f2YbEUM=--

