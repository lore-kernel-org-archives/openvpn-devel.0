From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 12:05:20 +0000
References: <gerrit.1756814708000.I0f2fff8358d4645c4ace504c65ae8559a68794cc@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <da43f937b096afa81fa81ff7e1f0398ce0087c7c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OrHxIYZOQKk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ps: Clean up
 conversion warnings in journal_add function
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

--OrHxIYZOQKk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1163?usp=3Demail

to review the following change.


Change subject: ps: Clean up conversion warnings in journal_add function
......................................................................

ps: Clean up conversion warnings in journal_add function

Since these are only local variables, these are trivial
changes.

Change-Id: I0f2fff8358d4645c4ace504c65ae8559a68794cc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ps.c
1 file changed, 7 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/1163/1

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index eae03e3..e95a33b 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -334,26 +334,22 @@
 static void
 journal_add(const char *journal_dir, struct proxy_connection *pc, struct p=
roxy_connection *cp)
 {
-    struct gc_arena gc =3D gc_new();
     struct openvpn_sockaddr from, to;
-    socklen_t slen, dlen;
-    int fnlen;
-    char *jfn;
-    int fd;

-    slen =3D sizeof(from.addr);
-    dlen =3D sizeof(to.addr);
+    socklen_t slen =3D sizeof(from.addr);
+    socklen_t dlen =3D sizeof(to.addr);
     if (!getpeername(pc->sd, (struct sockaddr *)&from.addr.sa, &slen)
         && !getsockname(cp->sd, (struct sockaddr *)&to.addr.sa, &dlen))
     {
+        struct gc_arena gc =3D gc_new();
         const char *f =3D print_openvpn_sockaddr(&from, &gc);
         const char *t =3D print_openvpn_sockaddr(&to, &gc);
-        fnlen =3D strlen(journal_dir) + strlen(t) + 2;
-        jfn =3D (char *)malloc(fnlen);
+        size_t fnlen =3D strlen(journal_dir) + strlen(t) + 2;
+        char *jfn =3D (char *)malloc(fnlen);
         check_malloc_return(jfn);
         snprintf(jfn, fnlen, "%s/%s", journal_dir, t);
         dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: client origin %s -> %s",=
 jfn, f);
-        fd =3D platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | =
S_IWUSR | S_IRGRP);
+        int fd =3D platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUS=
R | S_IWUSR | S_IRGRP);
         if (fd !=3D -1)
         {
             if (write(fd, f, strlen(f)) !=3D strlen(f))
@@ -368,8 +364,8 @@
             msg(M_WARN | M_ERRNO, "PORT SHARE: unable to write journal fil=
e in %s", jfn);
             free(jfn);
         }
+        gc_free(&gc);
     }
-    gc_free(&gc);
 }

 /*

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1163?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f2fff8358d4645c4ace504c65ae8559a68794cc
Gerrit-Change-Number: 1163
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--OrHxIYZOQKk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1163?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">ps: Clean up conversion warnings in journal_add function<br>=
<br>Since these are only local variables, these are trivial<br>changes.<br>=
<br>Change-Id: I0f2fff8358d4645c4ace504c65ae8559a68794cc<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ps.c<br>=
1 file changed, 7 insertions(+), 11 deletions(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/63/1163/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/ps.c b/src/openvpn/ps.c</span><br><span>index eae03e3..e95a33b=
 100644</span><br><span>--- a/src/openvpn/ps.c</span><br><span>+++ b/src/op=
envpn/ps.c</span><br><span>@@ -334,26 +334,22 @@</span><br><span> static vo=
id</span><br><span> journal_add(const char *journal_dir, struct proxy_conne=
ction *pc, struct proxy_connection *cp)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</=
span><br><span>     struct openvpn_sockaddr from, to;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    socklen_t slen, dlen;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int fnlen;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    char *jfn;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    int fd;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    slen =3D sizeof(from.addr);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    dlen =3D sizeof(to.addr);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    socklen_t slen =3D =
sizeof(from.addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   socklen_t dlen =3D sizeof(to.addr);</span><br><span>     if (!getpeernam=
e(pc-&gt;sd, (struct sockaddr *)&amp;from.addr.sa, &amp;slen)</span><br><sp=
an>         &amp;&amp; !getsockname(cp-&gt;sd, (struct sockaddr *)&amp;to.a=
ddr.sa, &amp;dlen))</span><br><span>     {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><=
span>         const char *f =3D print_openvpn_sockaddr(&amp;from, &amp;gc);=
</span><br><span>         const char *t =3D print_openvpn_sockaddr(&amp;to,=
 &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fnl=
en =3D strlen(journal_dir) + strlen(t) + 2;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        jfn =3D (char *)malloc(fnlen);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        size_t fnlen =3D strlen(jo=
urnal_dir) + strlen(t) + 2;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        char *jfn =3D (char *)malloc(fnlen);</span><br><span>      =
   check_malloc_return(jfn);</span><br><span>         snprintf(jfn, fnlen, =
&quot;%s/%s&quot;, journal_dir, t);</span><br><span>         dmsg(D_PS_PROX=
Y_DEBUG, &quot;PORT SHARE PROXY: client origin %s -&gt; %s&quot;, jfn, f);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fd =3D platfor=
m_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        int fd =3D plat=
form_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);<=
/span><br><span>         if (fd !=3D -1)</span><br><span>         {</span><=
br><span>             if (write(fd, f, strlen(f)) !=3D strlen(f))</span><br=
><span>@@ -368,8 +364,8 @@</span><br><span>             msg(M_WARN | M_ERRN=
O, &quot;PORT SHARE: unable to write journal file in %s&quot;, jfn);</span>=
<br><span>             free(jfn);</span><br><span>         }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><b=
r><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_=
free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span> /*</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1163?usp=3Demail">change 1163</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1163?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f2fff8358d4645c4ace504c65a=
e8559a68794cc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1163 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--OrHxIYZOQKk=--

