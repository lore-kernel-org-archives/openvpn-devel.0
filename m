From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 14 Sep 2025 17:26:14 +0000
In-Reply-To: <gerrit.1756814708000.I0f2fff8358d4645c4ace504c65ae8559a68794cc@...2715...>
References: <gerrit.1756814708000.I0f2fff8358d4645c4ace504c65ae8559a68794cc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5cfb469ee307a6085573e6047a16c09abb4b2129-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yZCtXPsP/mw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yZCtXPsP/mw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1163?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: ps: Clean up conversion warnings in journal_add function
......................................................................

ps: Clean up conversion warnings in journal_add function

Since these are only local variables, these are trivial
changes.

Change-Id: I0f2fff8358d4645c4ace504c65ae8559a68794cc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250914134713.19315-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
916.html
URL: https://gerrit.openvpn.net/c/openvpn/+/1163
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ps.c
1 file changed, 7 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/1163/2

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
=20
 /*

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1163?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f2fff8358d4645c4ace504c65ae8559a68794cc
Gerrit-Change-Number: 1163
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--yZCtXPsP/mw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1163?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">ps: Clean up conversion warnings in journal_add func=
tion<br><br>Since these are only local variables, these are trivial<br>chan=
ges.<br><br>Change-Id: I0f2fff8358d4645c4ace504c65ae8559a68794cc<br>Signed-=
off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250914134713.19315-1-gert@...1186...=
.1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1011...=
eforge.net/msg32916.html<br>URL: https://gerrit.openvpn.net/c/openvpn/+/116=
3<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/op=
envpn/ps.c<br>1 file changed, 7 insertions(+), 11 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/1163/2</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c</span><br><span>index ea=
e03e3..e95a33b 100644</span><br><span>--- a/src/openvpn/ps.c</span><br><spa=
n>+++ b/src/openvpn/ps.c</span><br><span>@@ -334,26 +334,22 @@</span><br><s=
pan> static void</span><br><span> journal_add(const char *journal_dir, stru=
ct proxy_connection *pc, struct proxy_connection *cp)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =
=3D gc_new();</span><br><span>     struct openvpn_sockaddr from, to;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    socklen_t slen, dlen;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int fnlen;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    char *jfn;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int fd;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    slen =3D sizeof(from.addr)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dlen =3D sizeof(=
to.addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sockle=
n_t slen =3D sizeof(from.addr);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    socklen_t dlen =3D sizeof(to.addr);</span><br><span>     if=
 (!getpeername(pc-&gt;sd, (struct sockaddr *)&amp;from.addr.sa, &amp;slen)<=
/span><br><span>         &amp;&amp; !getsockname(cp-&gt;sd, (struct sockadd=
r *)&amp;to.addr.sa, &amp;dlen))</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new()=
;</span><br><span>         const char *f =3D print_openvpn_sockaddr(&amp;fr=
om, &amp;gc);</span><br><span>         const char *t =3D print_openvpn_sock=
addr(&amp;to, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        fnlen =3D strlen(journal_dir) + strlen(t) + 2;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        jfn =3D (char *)malloc(fnlen);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t fnlen =
=3D strlen(journal_dir) + strlen(t) + 2;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        char *jfn =3D (char *)malloc(fnlen);</span><br=
><span>         check_malloc_return(jfn);</span><br><span>         snprintf=
(jfn, fnlen, &quot;%s/%s&quot;, journal_dir, t);</span><br><span>         d=
msg(D_PS_PROXY_DEBUG, &quot;PORT SHARE PROXY: client origin %s -&gt; %s&quo=
t;, jfn, f);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        f=
d =3D platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR | =
S_IRGRP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        in=
t fd =3D platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR=
 | S_IRGRP);</span><br><span>         if (fd !=3D -1)</span><br><span>     =
    {</span><br><span>             if (write(fd, f, strlen(f)) !=3D strlen(=
f))</span><br><span>@@ -368,8 +364,8 @@</span><br><span>             msg(M_=
WARN | M_ERRNO, &quot;PORT SHARE: unable to write journal file in %s&quot;,=
 jfn);</span><br><span>             free(jfn);</span><br><span>         }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;=
gc);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br>=
<span> /*</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1163?usp=3Demail">change 1163</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1163?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f2fff8358d4645c4ace504c65a=
e8559a68794cc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1163 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--yZCtXPsP/mw=--

