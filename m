From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sat, 4 Apr 2026 23:02:31 +0000
References: <gerrit.1775343746000.I81b7168b64c438f759eace1e8f2735891c797bb9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <11023d1194144ddfd4aef697365923c4c97fe7bb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jXyYUXKduyw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Hide various
 functions when unused
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

--jXyYUXKduyw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1611?usp=3Demail

to review the following change.


Change subject: Hide various functions when unused
......................................................................

Hide various functions when unused

Wrap them into the same ifdef as their only user(s).

Identified by cppcheck.

Change-Id: I81b7168b64c438f759eace1e8f2735891c797bb9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/error.c
M src/openvpn/error.h
M src/openvpn/otime.h
M src/openvpn/socket.c
M src/openvpn/socket.h
M src/openvpn/socket_util.h
M src/openvpn/ssl_openssl.c
9 files changed, 23 insertions(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/1611/1

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 71f3769..eec91a6 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -589,6 +589,7 @@
     return str;
 }

+#ifdef _WIN32
 /*
  * like buf_null_terminate, but operate on strings
  */
@@ -605,6 +606,7 @@
         *(str + len - 1) =3D '\0';
     }
 }
+#endif

 /*
  * Remove trailing \r and \n chars.
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index aef29de..b4e65ef 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -469,7 +469,9 @@

 const char *skip_leading_whitespace(const char *str);

+#ifdef _WIN32
 void string_null_terminate(char *str, int len, int capacity);
+#endif

 /**
  * Write buffer contents to file.
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 2900352..26d4c7c 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -84,18 +84,20 @@
 /* If non-null, messages should be written here (used for debugging only) =
*/
 static FILE *msgfp; /* GLOBAL */

-/* If true, we forked from main OpenVPN process */
-static bool forked; /* GLOBAL */
-
 /* our default output targets */
 static FILE *default_out; /* GLOBAL */
 static FILE *default_err; /* GLOBAL */

+/* If true, we forked from main OpenVPN process */
+static bool forked; /* GLOBAL */
+
+#if PORT_SHARE
 void
 msg_forked(void)
 {
     forked =3D true;
 }
+#endif

 bool
 set_debug_level(const int level, const unsigned int flags)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 1198994..62948aa 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -260,8 +260,10 @@
     return check_debug_level(flags) && dont_mute(flags);
 }

+#if PORT_SHARE
 /* Call if we forked */
 void msg_forked(void);
+#endif

 /* syslog output */

diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index ad79120..84e315b 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -150,6 +150,7 @@
     }
 }

+#ifdef SCHEDULE_TEST
 static inline bool
 tv_lt(const struct timeval *t1, const struct timeval *t2)
 {
@@ -223,6 +224,7 @@
 {
     return t1->tv_sec =3D=3D t2->tv_sec && t1->tv_usec =3D=3D t2->tv_usec;
 }
+#endif /* ifdef SCHEDULE_TEST */

 static inline void
 tv_delta(struct timeval *dest, const struct timeval *t1, const struct time=
val *t2)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 624ce4f..da6f870 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2976,6 +2976,8 @@
     return rwflags;
 }

+#if UNIX_SOCK_SUPPORT
+
 void
 sd_close(socket_descriptor_t *sd)
 {
@@ -2986,8 +2988,6 @@
     }
 }

-#if UNIX_SOCK_SUPPORT
-
 /*
  * code for unix domain sockets
  */
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index cd4e8ed..6196af0 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -365,7 +365,9 @@

 void link_socket_close(struct link_socket *sock);

+#ifdef ENABLE_MANAGEMENT
 void sd_close(socket_descriptor_t *sd);
+#endif

 void bad_address_length(int actual, int expected);

diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index 13deeaa..13f5962 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -250,6 +250,7 @@
     }
 }

+#ifdef TARGET_ANDROID
 static inline bool
 addr_local(const struct sockaddr *addr)
 {
@@ -269,12 +270,12 @@
             return false;
     }
 }
+#endif

-
+#if ENABLE_IP_PKTINFO
 static inline bool
 addr_defined_ipi(const struct link_socket_actual *lsa)
 {
-#if ENABLE_IP_PKTINFO
     if (!lsa)
     {
         return 0;
@@ -296,11 +297,9 @@
         default:
             return 0;
     }
-#else /* if ENABLE_IP_PKTINFO */
-    ASSERT(0);
-#endif
     return false;
 }
+#endif

 /*
  * Overhead added to packets by various protocols.
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a26663a..001470c 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -462,6 +462,7 @@
     }
 }

+#ifdef TLS1_3_VERSION
 static void
 convert_tls13_list_to_openssl(char *openssl_ciphers, size_t len, const cha=
r *ciphers)
 {
@@ -486,6 +487,7 @@
         }
     }
 }
+#endif

 void
 tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphe=
rs)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1611?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I81b7168b64c438f759eace1e8f2735891c797bb9
Gerrit-Change-Number: 1611
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--jXyYUXKduyw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1611?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Hide various functions when unused<br><br>W=
rap them into the same ifdef as their only user(s).<br><br>Identified by cp=
pcheck.<br><br>Change-Id: I81b7168b64c438f759eace1e8f2735891c797bb9<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openv=
pn/buffer.c<br>M src/openvpn/buffer.h<br>M src/openvpn/error.c<br>M src/ope=
nvpn/error.h<br>M src/openvpn/otime.h<br>M src/openvpn/socket.c<br>M src/op=
envpn/socket.h<br>M src/openvpn/socket_util.h<br>M src/openvpn/ssl_openssl.=
c<br>9 files changed, 23 insertions(+), 10 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/161=
1/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span>=
<br><span>index 71f3769..eec91a6 100644</span><br><span>--- a/src/openvpn/b=
uffer.c</span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -589,=
6 +589,7 @@</span><br><span>     return str;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32=
</span><br><span> /*</span><br><span>  * like buf_null_terminate, but opera=
te on strings</span><br><span>  */</span><br><span>@@ -605,6 +606,7 @@</spa=
n><br><span>         *(str + len - 1) =3D &#39;\0&#39;;</span><br><span>   =
  }</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span> </span><br><span> /*</span><br><span>  * Remove =
trailing \r and \n chars.</span><br><span>diff --git a/src/openvpn/buffer.h=
 b/src/openvpn/buffer.h</span><br><span>index aef29de..b4e65ef 100644</span=
><br><span>--- a/src/openvpn/buffer.h</span><br><span>+++ b/src/openvpn/buf=
fer.h</span><br><span>@@ -469,7 +469,9 @@</span><br><span> </span><br><span=
> const char *skip_leading_whitespace(const char *str);</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><=
br><span> void string_null_terminate(char *str, int len, int capacity);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>=
 </span><br><span> /**</span><br><span>  * Write buffer contents to file.</=
span><br><span>diff --git a/src/openvpn/error.c b/src/openvpn/error.c</span=
><br><span>index 2900352..26d4c7c 100644</span><br><span>--- a/src/openvpn/=
error.c</span><br><span>+++ b/src/openvpn/error.c</span><br><span>@@ -84,18=
 +84,20 @@</span><br><span> /* If non-null, messages should be written here=
 (used for debugging only) */</span><br><span> static FILE *msgfp; /* GLOBA=
L */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/* If true, we forked from main OpenVPN process */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static bool forked; /* GLOBAL */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* our default=
 output targets */</span><br><span> static FILE *default_out; /* GLOBAL */<=
/span><br><span> static FILE *default_err; /* GLOBAL */</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* If true, we forked=
 from main OpenVPN process */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static bool forked; /* GLOBAL */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if PORT_SHARE</span><br><span> void</span><br><span> msg_forked(void)<=
/span><br><span> {</span><br><span>     forked =3D true;</span><br><span> }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan> </span><br><span> bool</span><br><span> set_debug_level(const int leve=
l, const unsigned int flags)</span><br><span>diff --git a/src/openvpn/error=
.h b/src/openvpn/error.h</span><br><span>index 1198994..62948aa 100644</spa=
n><br><span>--- a/src/openvpn/error.h</span><br><span>+++ b/src/openvpn/err=
or.h</span><br><span>@@ -260,8 +260,10 @@</span><br><span>     return check=
_debug_level(flags) &amp;&amp; dont_mute(flags);</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if PORT_=
SHARE</span><br><span> /* Call if we forked */</span><br><span> void msg_fo=
rked(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span> </span><br><span> /* syslog output */</span><br><span> </sp=
an><br><span>diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h</span><=
br><span>index ad79120..84e315b 100644</span><br><span>--- a/src/openvpn/ot=
ime.h</span><br><span>+++ b/src/openvpn/otime.h</span><br><span>@@ -150,6 +=
150,7 @@</span><br><span>     }</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef SCHEDULE_TEST</span=
><br><span> static inline bool</span><br><span> tv_lt(const struct timeval =
*t1, const struct timeval *t2)</span><br><span> {</span><br><span>@@ -223,6=
 +224,7 @@</span><br><span> {</span><br><span>     return t1-&gt;tv_sec =3D=
=3D t2-&gt;tv_sec &amp;&amp; t1-&gt;tv_usec =3D=3D t2-&gt;tv_usec;</span><b=
r><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /*=
 ifdef SCHEDULE_TEST */</span><br><span> </span><br><span> static inline vo=
id</span><br><span> tv_delta(struct timeval *dest, const struct timeval *t1=
, const struct timeval *t2)</span><br><span>diff --git a/src/openvpn/socket=
.c b/src/openvpn/socket.c</span><br><span>index 624ce4f..da6f870 100644</sp=
an><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/s=
ocket.c</span><br><span>@@ -2976,6 +2976,8 @@</span><br><span>     return r=
wflags;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> sd_close=
(socket_descriptor_t *sd)</span><br><span> {</span><br><span>@@ -2986,8 +29=
88,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#if UNIX_SOCK_SUPPORT</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><b=
r><span>  * code for unix domain sockets</span><br><span>  */</span><br><sp=
an>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br><span=
>index cd4e8ed..6196af0 100644</span><br><span>--- a/src/openvpn/socket.h</=
span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -365,7 +365,9 =
@@</span><br><span> </span><br><span> void link_socket_close(struct link_so=
cket *sock);</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span> void sd_close(socket_d=
escriptor_t *sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span> </span><br><span> void bad_address_length(int actual,=
 int expected);</span><br><span> </span><br><span>diff --git a/src/openvpn/=
socket_util.h b/src/openvpn/socket_util.h</span><br><span>index 13deeaa..13=
f5962 100644</span><br><span>--- a/src/openvpn/socket_util.h</span><br><spa=
n>+++ b/src/openvpn/socket_util.h</span><br><span>@@ -250,6 +250,7 @@</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_ANDROID</span><br><span> s=
tatic inline bool</span><br><span> addr_local(const struct sockaddr *addr)<=
/span><br><span> {</span><br><span>@@ -269,12 +270,12 @@</span><br><span>  =
           return false;</span><br><span>     }</span><br><span> }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if ENABLE_IP_PKTINFO</span><br><span> stati=
c inline bool</span><br><span> addr_defined_ipi(const struct link_socket_ac=
tual *lsa)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#if ENABLE_IP_PKTINFO</span><br><span>     if (!lsa)</span><br><spa=
n>     {</span><br><span>         return 0;</span><br><span>@@ -296,11 +297=
,9 @@</span><br><span>         default:</span><br><span>             return=
 0;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#else /* if ENABLE_IP_PKTINFO */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    ASSERT(0);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span>     return false;</span><br><span> }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> <=
/span><br><span> /*</span><br><span>  * Overhead added to packets by variou=
s protocols.</span><br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/o=
penvpn/ssl_openssl.c</span><br><span>index a26663a..001470c 100644</span><b=
r><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/s=
sl_openssl.c</span><br><span>@@ -462,6 +462,7 @@</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#ifdef TLS1_3_VERSION</span><br><span> static void</span><br>=
<span> convert_tls13_list_to_openssl(char *openssl_ciphers, size_t len, con=
st char *ciphers)</span><br><span> {</span><br><span>@@ -486,6 +487,7 @@</s=
pan><br><span>         }</span><br><span>     }</span><br><span> }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </sp=
an><br><span> void</span><br><span> tls_ctx_restrict_ciphers_tls13(struct t=
ls_root_ctx *ctx, const char *ciphers)</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1611?usp=3D=
email">change 1611</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1611?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I81b7168b64c438f759eace1e8f2=
735891c797bb9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1611 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--jXyYUXKduyw=--

