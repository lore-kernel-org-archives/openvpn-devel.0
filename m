From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 19 Dec 2025 14:32:15 +0000
References: <gerrit.1766154731000.I380e842b7429060d13bc0264e55fa5c06ab427df@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <84d294bc571131f05a9e11d0aa5869c05f10a810-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kXDYoBrIdxI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_ncp: Avoid
 conversion warning in replace_default_in_ncp_ciphers_o...
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

--kXDYoBrIdxI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1452?usp=3Demail

to review the following change.


Change subject: ssl_ncp: Avoid conversion warning in replace_default_in_ncp=
_ciphers_option
......................................................................

ssl_ncp: Avoid conversion warning in replace_default_in_ncp_ciphers_option

Change-Id: I380e842b7429060d13bc0264e55fa5c06ab427df
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_ncp.c
1 file changed, 3 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/52/1452/1

diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index d4519b0..06262fe 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -534,11 +534,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * Replaces the string DEFAULT with the string \c replace.
  *
@@ -549,12 +544,13 @@
 replace_default_in_ncp_ciphers_option(struct options *o, const char *repla=
ce)
 {
     const char *search =3D "DEFAULT";
-    const int ncp_ciphers_len =3D strlen(o->ncp_ciphers) + strlen(replace)=
 - strlen(search) + 1;
+    const size_t ncp_ciphers_len =3D strlen(o->ncp_ciphers) + strlen(repla=
ce) - strlen(search) + 1;

     uint8_t *ncp_ciphers =3D gc_malloc(ncp_ciphers_len, true, &o->gc);

     struct buffer ncp_ciphers_buf;
-    buf_set_write(&ncp_ciphers_buf, ncp_ciphers, ncp_ciphers_len);
+    ASSERT(ncp_ciphers_len <=3D INT_MAX);
+    buf_set_write(&ncp_ciphers_buf, ncp_ciphers, (int)ncp_ciphers_len);

     const char *def =3D strstr(o->ncp_ciphers, search);

@@ -571,10 +567,6 @@
     o->ncp_ciphers =3D (char *)ncp_ciphers;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  * Checks for availibility of Chacha20-Poly1305 and sets
  * the ncp_cipher to either AES-256-GCM:AES-128-GCM or

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1452?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I380e842b7429060d13bc0264e55fa5c06ab427df
Gerrit-Change-Number: 1452
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--kXDYoBrIdxI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1452?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl_ncp: Avoid conversion warning in replac=
e_default_in_ncp_ciphers_option<br><br>Change-Id: I380e842b7429060d13bc0264=
e55fa5c06ab427df<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>---<br>M src/openvpn/ssl_ncp.c<br>1 file changed, 3 insertions(+), 11=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/52/1452/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_n=
cp.c b/src/openvpn/ssl_ncp.c</span><br><span>index d4519b0..06262fe 100644<=
/span><br><span>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openv=
pn/ssl_ncp.c</span><br><span>@@ -534,11 +534,6 @@</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &qu=
ot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> /**</span><br><span>  * Replaces the string DEFAULT with the string \c r=
eplace.</span><br><span>  *</span><br><span>@@ -549,12 +544,13 @@</span><br=
><span> replace_default_in_ncp_ciphers_option(struct options *o, const char=
 *replace)</span><br><span> {</span><br><span>     const char *search =3D &=
quot;DEFAULT&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const int ncp_ciphers_len =3D strlen(o-&gt;ncp_ciphers) + strlen(replace)=
 - strlen(search) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const size_t ncp_ciphers_len =3D strlen(o-&gt;ncp_ciphers) + strlen(=
replace) - strlen(search) + 1;</span><br><span> </span><br><span>     uint8=
_t *ncp_ciphers =3D gc_malloc(ncp_ciphers_len, true, &amp;o-&gt;gc);</span>=
<br><span> </span><br><span>     struct buffer ncp_ciphers_buf;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    buf_set_write(&amp;ncp_cipher=
s_buf, ncp_ciphers, ncp_ciphers_len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ASSERT(ncp_ciphers_len &lt;=3D INT_MAX);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    buf_set_write(&amp;ncp_ciphe=
rs_buf, ncp_ciphers, (int)ncp_ciphers_len);</span><br><span> </span><br><sp=
an>     const char *def =3D strstr(o-&gt;ncp_ciphers, search);</span><br><s=
pan> </span><br><span>@@ -571,10 +567,6 @@</span><br><span>     o-&gt;ncp_c=
iphers =3D (char *)ncp_ciphers;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> /**</span><br><span>  * Checks for availibility of Chacha20-Poly1305 and =
sets</span><br><span>  * the ncp_cipher to either AES-256-GCM:AES-128-GCM o=
r</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1452?usp=3Demail">change 1452</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1452?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I380e842b7429060d13bc0264e55=
fa5c06ab427df </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1452 </div>
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

--kXDYoBrIdxI=--

