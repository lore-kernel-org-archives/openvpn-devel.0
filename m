From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 10:08:19 +0000
References: <gerrit.1700474896000.Ie25aa287f3534090c1d93fc3bb69727dd20fc6fe@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <239072d555cb45830e7e28000f6a95977c06c052-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WfvRgZpESSA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: protocol_dump:
 tls-crypt support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WfvRgZpESSA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/442?usp=3Demail

to review the following change.


Change subject: protocol_dump: tls-crypt support
......................................................................

protocol_dump: tls-crypt support

Change-Id: Ie25aa287f3534090c1d93fc3bb69727dd20fc6fe
---
M src/openvpn/openvpn.h
M src/openvpn/ssl.c
M src/openvpn/ssl.h
3 files changed, 29 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/442/1

diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 5b2be63..dabc5be 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -541,7 +541,8 @@
 #define PROTO_DUMP(buf, gc) protocol_dump((buf), \
                                           PROTO_DUMP_FLAGS   \
                                           |(c->c2.tls_multi ? PD_TLS : 0) =
  \
-                                          |(c->options.tls_auth_file ? md_=
kt_size(c->c1.ks.key_type.digest) : 0), \
+                                          |(c->options.tls_auth_file ? md_=
kt_size(c->c1.ks.key_type.digest) : 0) \
+                                          |(c->options.tls_crypt_file || c=
->options.tls_crypt_v2_file ? PD_TLS_CRYPT : 0), \
                                           gc)

 /* this represents "disabled peer-id" */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b4cd8f5..400230c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -4272,6 +4272,32 @@
         }
         buf_printf(&out, " pid=3D%s", packet_id_net_print(&pin, (flags & P=
D_VERBOSE), gc));
     }
+    /*
+     * packet_id + tls-crypt hmac
+     */
+    if (flags & PD_TLS_CRYPT)
+    {
+        struct packet_id_net pin;
+        uint8_t tls_crypt_hmac[TLS_CRYPT_TAG_SIZE];
+
+        if (!packet_id_read(&pin, &buf, true))
+        {
+            goto done;
+        }
+        buf_printf(&out, " pid=3D%s", packet_id_net_print(&pin, (flags & P=
D_VERBOSE), gc));
+        if (!buf_read(&buf, tls_crypt_hmac, TLS_CRYPT_TAG_SIZE))
+        {
+            goto done;
+        }
+        if (flags & PD_VERBOSE)
+        {
+            buf_printf(&out, " tls_crypt_hmac=3D%s", format_hex(tls_crypt_=
hmac, TLS_CRYPT_TAG_SIZE, 0, gc));
+        }
+        /*
+         * Remainder is encrypted and optional wKc
+         */
+        goto done;
+    }

     /*
      * ACK list
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 3c40fbe..e842746 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -525,6 +525,7 @@
 #define PD_SHOW_DATA               (1<<8)
 #define PD_TLS                     (1<<9)
 #define PD_VERBOSE                 (1<<10)
+#define PD_TLS_CRYPT               (1<<11)

 const char *protocol_dump(struct buffer *buffer,
                           unsigned int flags,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/442?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie25aa287f3534090c1d93fc3bb69727dd20fc6fe
Gerrit-Change-Number: 442
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--WfvRgZpESSA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/442?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">protocol_dump: tls-crypt support<br><br>Change-Id: Ie25aa287f=
3534090c1d93fc3bb69727dd20fc6fe<br>---<br>M src/openvpn/openvpn.h<br>M src/=
openvpn/ssl.c<br>M src/openvpn/ssl.h<br>3 files changed, 29 insertions(+), =
1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/42/442/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/openvpn.h b/src/openvpn=
/openvpn.h</span><br><span>index 5b2be63..dabc5be 100644</span><br><span>--=
- a/src/openvpn/openvpn.h</span><br><span>+++ b/src/openvpn/openvpn.h</span=
><br><span>@@ -541,7 +541,8 @@</span><br><span> #define PROTO_DUMP(buf, gc)=
 protocol_dump((buf), \</span><br><span>                                   =
        PROTO_DUMP_FLAGS   \</span><br><span>                              =
             |(c-&gt;c2.tls_multi ? PD_TLS : 0)   \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                          |=
(c-&gt;options.tls_auth_file ? md_kt_size(c-&gt;c1.ks.key_type.digest) : 0)=
, \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                          |(c-&gt;options.tls_auth_file ? md_kt_size(c-&gt;=
c1.ks.key_type.digest) : 0) \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                          |(c-&gt;options.tls_cry=
pt_file || c-&gt;options.tls_crypt_v2_file ? PD_TLS_CRYPT : 0), \</span><br=
><span>                                           gc)</span><br><span> </sp=
an><br><span> /* this represents &quot;disabled peer-id&quot; */</span><br>=
<span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>in=
dex b4cd8f5..400230c 100644</span><br><span>--- a/src/openvpn/ssl.c</span><=
br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -4272,6 +4272,32 @@</sp=
an><br><span>         }</span><br><span>         buf_printf(&amp;out, &quot=
; pid=3D%s&quot;, packet_id_net_print(&amp;pin, (flags &amp; PD_VERBOSE), g=
c));</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* packet_id + tls-crypt hmac</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (flags &amp; PD_TLS_CRYPT)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct packet_id_net pin;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        uint8_t tls_crypt_hmac[TLS_CRYPT_TAG_SIZE];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!packet_id_read(&amp;pin, &amp;buf, tru=
e))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            goto done;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quo=
t; pid=3D%s&quot;, packet_id_net_print(&amp;pin, (flags &amp; PD_VERBOSE), =
gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!b=
uf_read(&amp;buf, tls_crypt_hmac, TLS_CRYPT_TAG_SIZE))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            goto done;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (flags &amp; PD_VERBOSE)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot; tls_crypt_h=
mac=3D%s&quot;, format_hex(tls_crypt_hmac, TLS_CRYPT_TAG_SIZE, 0, gc));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * Remainder is encrypted and opt=
ional wKc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an> </span><br><span>     /*</span><br><span>      * ACK list</span><br><sp=
an>diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h</span><br><span>index=
 3c40fbe..e842746 100644</span><br><span>--- a/src/openvpn/ssl.h</span><br>=
<span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -525,6 +525,7 @@</span><br=
><span> #define PD_SHOW_DATA               (1&lt;&lt;8)</span><br><span> #d=
efine PD_TLS                     (1&lt;&lt;9)</span><br><span> #define PD_V=
ERBOSE                 (1&lt;&lt;10)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define PD_TLS_CRYPT               (1&lt;&lt;11)</span><br=
><span> </span><br><span> const char *protocol_dump(struct buffer *buffer,<=
/span><br><span>                           unsigned int flags,</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/442?usp=3Demail">change 442</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/442?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie25aa287f3534090c1d93fc3bb6=
9727dd20fc6fe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 442 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--WfvRgZpESSA=--

