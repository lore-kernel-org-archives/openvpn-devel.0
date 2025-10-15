From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 15 Oct 2025 11:09:34 +0000
References: <gerrit.1760526572000.Ieb18101dcf8143efdae1c39bde356e7166cbefa5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <fc13c209e41ef9dcf10272a535726f102749d991-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pv2tRtCPdsY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: proxy: factor out
 send code common with socks proxy
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

--pv2tRtCPdsY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1279?usp=3Demail

to review the following change.


Change subject: proxy: factor out send code common with socks proxy
......................................................................

proxy: factor out send code common with socks proxy

Change-Id: Ieb18101dcf8143efdae1c39bde356e7166cbefa5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/proxy.c
M src/openvpn/proxy.h
M src/openvpn/socks.c
3 files changed, 12 insertions(+), 24 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1279/1

diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 4205991..6402469 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -184,13 +184,13 @@
     return true;
 }

-static bool
-send_line(socket_descriptor_t sd, const char *buf)
+bool
+proxy_send(socket_descriptor_t sd, const void *buf, size_t buf_len)
 {
-    const ssize_t size =3D openvpn_send(sd, buf, strlen(buf), MSG_NOSIGNAL=
);
-    if (size !=3D (ssize_t)strlen(buf))
+    const ssize_t size =3D openvpn_send(sd, buf, buf_len, MSG_NOSIGNAL);
+    if (size !=3D (ssize_t)buf_len)
     {
-        msg(D_LINK_ERRORS | M_ERRNO, "send_line: TCP port write failed on =
send()");
+        msg(D_LINK_ERRORS | M_ERRNO, "proxy_send: TCP port write failed on=
 send()");
         return false;
     }
     return true;
@@ -204,7 +204,7 @@
     struct buffer buf =3D alloc_buf(strlen(src) + 3);
     ASSERT(buf_write(&buf, src, strlen(src)));
     ASSERT(buf_write(&buf, "\r\n", 3));
-    ret =3D send_line(sd, BSTR(&buf));
+    ret =3D proxy_send(sd, BSTR(&buf), BLEN(&buf));
     free_buf(&buf);
     return ret;
 }
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 3bfa687..d14725c 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -83,6 +83,8 @@
 bool proxy_recv_char(uint8_t *c, const char *name, socket_descriptor_t sd,
                      struct timeval *timeout, volatile int *signal_receive=
d);

+bool proxy_send(socket_descriptor_t sd, const void *buf, size_t buf_len);
+
 bool establish_http_proxy_passthru(struct http_proxy_info *p,
                                    socket_descriptor_t sd, /* already open=
 to proxy */
                                    const char *host,       /* openvpn serv=
er remote */
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 9dc013e..7ecf01a 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -123,12 +123,8 @@
                         creds.username, (int)strlen(creds.password), creds=
.password);
     ASSERT(sret >=3D 0 && sret <=3D sizeof(to_send));

-    ssize_t size =3D openvpn_send(sd, to_send, strlen(to_send), MSG_NOSIGN=
AL);
-
-    if (size !=3D (ssize_t)strlen(to_send))
+    if (!proxy_send(sd, to_send, strlen(to_send)))
     {
-        msg(D_LINK_ERRORS | M_ERRNO,
-            "socks_username_password_auth: TCP port write failed on send()=
");
         goto cleanup;
     }

@@ -166,7 +162,6 @@
 {
     uint8_t buf[2];
     int len =3D 0;
-    ssize_t size;

     /* VER =3D 5, NMETHODS =3D 1, METHODS =3D [0 (no auth)] */
     uint8_t method_sel[3] =3D { 0x05, 0x01, 0x00 };
@@ -174,10 +169,8 @@
     {
         method_sel[2] =3D 0x02; /* METHODS =3D [2 (plain login)] */
     }
-    size =3D openvpn_send(sd, method_sel, sizeof(method_sel), MSG_NOSIGNAL=
);
-    if (size !=3D sizeof(method_sel))
+    if (!proxy_send(sd, method_sel, sizeof(method_sel)))
     {
-        msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port write fail=
ed on send()");
         return false;
     }

@@ -380,18 +373,11 @@
     buf[5 + len] =3D (char)(port >> 8);
     buf[5 + len + 1] =3D (char)(port & 0xff);

+    if (!proxy_send(sd, buf, 5 + len + 2))
     {
-        size_t send_len =3D 5 + len + 2;
-        const ssize_t size =3D openvpn_send(sd, buf, send_len, MSG_NOSIGNA=
L);
-        if (size !=3D (ssize_t)send_len)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO,
-                "establish_socks_proxy_passthru: TCP port write failed on =
send()");
-            goto error;
-        }
+        goto error;
     }

-
     /* receive reply from Socks proxy and discard */
     if (!recv_socks_reply(sd, NULL, server_poll_timeout, &sig_info->signal=
_received))
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1279?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ieb18101dcf8143efdae1c39bde356e7166cbefa5
Gerrit-Change-Number: 1279
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--pv2tRtCPdsY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1279?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">proxy: factor out send code common with soc=
ks proxy<br><br>Change-Id: Ieb18101dcf8143efdae1c39bde356e7166cbefa5<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/open=
vpn/proxy.c<br>M src/openvpn/proxy.h<br>M src/openvpn/socks.c<br>3 files ch=
anged, 12 insertions(+), 24 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1279/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><span>index 4=
205991..6402469 100644</span><br><span>--- a/src/openvpn/proxy.c</span><br>=
<span>+++ b/src/openvpn/proxy.c</span><br><span>@@ -184,13 +184,13 @@</span=
><br><span>     return true;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-send_line(socket_descriptor_t sd, const c=
har *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+proxy_send(socket_descrip=
tor_t sd, const void *buf, size_t buf_len)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    const ssize_t size =3D openvpn_=
send(sd, buf, strlen(buf), MSG_NOSIGNAL);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (size !=3D (ssize_t)strlen(buf))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const ssize_t size =3D openvpn_=
send(sd, buf, buf_len, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (size !=3D (ssize_t)buf_len)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_LINK_E=
RRORS | M_ERRNO, &quot;send_line: TCP port write failed on send()&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LINK_ER=
RORS | M_ERRNO, &quot;proxy_send: TCP port write failed on send()&quot;);</=
span><br><span>         return false;</span><br><span>     }</span><br><spa=
n>     return true;</span><br><span>@@ -204,7 +204,7 @@</span><br><span>   =
  struct buffer buf =3D alloc_buf(strlen(src) + 3);</span><br><span>     AS=
SERT(buf_write(&amp;buf, src, strlen(src)));</span><br><span>     ASSERT(bu=
f_write(&amp;buf, &quot;\r\n&quot;, 3));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    ret =3D send_line(sd, BSTR(&amp;buf));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ret =3D proxy_send(sd, BSTR(&=
amp;buf), BLEN(&amp;buf));</span><br><span>     free_buf(&amp;buf);</span><=
br><span>     return ret;</span><br><span> }</span><br><span>diff --git a/s=
rc/openvpn/proxy.h b/src/openvpn/proxy.h</span><br><span>index 3bfa687..d14=
725c 100644</span><br><span>--- a/src/openvpn/proxy.h</span><br><span>+++ b=
/src/openvpn/proxy.h</span><br><span>@@ -83,6 +83,8 @@</span><br><span> boo=
l proxy_recv_char(uint8_t *c, const char *name, socket_descriptor_t sd,</sp=
an><br><span>                      struct timeval *timeout, volatile int *s=
ignal_received);</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool proxy_send(socket_descriptor_t sd, const void *buf, siz=
e_t buf_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> bool establish_http_proxy_passthru(struct http_proxy_info *p,</=
span><br><span>                                    socket_descriptor_t sd, =
/* already open to proxy */</span><br><span>                               =
     const char *host,       /* openvpn server remote */</span><br><span>di=
ff --git a/src/openvpn/socks.c b/src/openvpn/socks.c</span><br><span>index =
9dc013e..7ecf01a 100644</span><br><span>--- a/src/openvpn/socks.c</span><br=
><span>+++ b/src/openvpn/socks.c</span><br><span>@@ -123,12 +123,8 @@</span=
><br><span>                         creds.username, (int)strlen(creds.passw=
ord), creds.password);</span><br><span>     ASSERT(sret &gt;=3D 0 &amp;&amp=
; sret &lt;=3D sizeof(to_send));</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ssize_t size =3D openvpn_send(sd, to_send,=
 strlen(to_send), MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (si=
ze !=3D (ssize_t)strlen(to_send))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!proxy_send(sd, to_send, strlen(to_send)))</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
sg(D_LINK_ERRORS | M_ERRNO,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            &quot;socks_username_password_auth: TCP port write failed=
 on send()&quot;);</span><br><span>         goto cleanup;</span><br><span> =
    }</span><br><span> </span><br><span>@@ -166,7 +162,6 @@</span><br><span=
> {</span><br><span>     uint8_t buf[2];</span><br><span>     int len =3D 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ssize_t size;</s=
pan><br><span> </span><br><span>     /* VER =3D 5, NMETHODS =3D 1, METHODS =
=3D [0 (no auth)] */</span><br><span>     uint8_t method_sel[3] =3D { 0x05,=
 0x01, 0x00 };</span><br><span>@@ -174,10 +169,8 @@</span><br><span>     {<=
/span><br><span>         method_sel[2] =3D 0x02; /* METHODS =3D [2 (plain l=
ogin)] */</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    size =3D openvpn_send(sd, method_sel, sizeof(method_sel), MS=
G_NOSIGNAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (s=
ize !=3D sizeof(method_sel))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!proxy_send(sd, method_sel, sizeof(method_sel)))</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
msg(D_LINK_ERRORS | M_ERRNO, &quot;socks_handshake: TCP port write failed o=
n send()&quot;);</span><br><span>         return false;</span><br><span>   =
  }</span><br><span> </span><br><span>@@ -380,18 +373,11 @@</span><br><span=
>     buf[5 + len] =3D (char)(port &gt;&gt; 8);</span><br><span>     buf[5 =
+ len + 1] =3D (char)(port &amp; 0xff);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!proxy_send(sd, buf, 5 + len =
+ 2))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        size_t send_len =3D 5 + len + 2;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        const ssize_t size =3D openvpn_send(sd, b=
uf, send_len, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (size !=3D (ssize_t)send_len)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            msg(D_LINK_ERRORS | M_ERRNO,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                &quot;establish_socks_prox=
y_passthru: TCP port write failed on send()&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            goto error;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        goto error;</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span>     /* receive reply from Socks proxy and discard */</span><br><span>=
     if (!recv_socks_reply(sd, NULL, server_poll_timeout, &amp;sig_info-&gt=
;signal_received))</span><br><span>     {</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1279?usp=
=3Demail">change 1279</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1279?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieb18101dcf8143efdae1c39bde3=
56e7166cbefa5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1279 </div>
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

--pv2tRtCPdsY=--

