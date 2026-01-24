From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 24 Jan 2026 13:35:00 +0000
In-Reply-To: <gerrit.1766154731000.I380e842b7429060d13bc0264e55fa5c06ab427df@...2715...>
References: <gerrit.1766154731000.I380e842b7429060d13bc0264e55fa5c06ab427df@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2ab28e961b7935ca580fad2cc3811c904898b51a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="v5rAjSUirMw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--v5rAjSUirMw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
52?usp=3Demail )

Change subject: ssl_ncp: Avoid conversion warning in replace_default_in_ncp=
_ciphers_option
......................................................................

ssl_ncp: Avoid conversion warning in replace_default_in_ncp_ciphers_option

Change-Id: I380e842b7429060d13bc0264e55fa5c06ab427df
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1452
Message-Id: <20260122125829.108470-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
391.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_ncp.c
1 file changed, 3 insertions(+), 11 deletions(-)




diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 1a2405c..20fd2f0 100644
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I380e842b7429060d13bc0264e55fa5c06ab427df
Gerrit-Change-Number: 1452
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--v5rAjSUirMw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1452?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_ncp: Avoid conversion warning in replace_def=
ault_in_ncp_ciphers_option<br><br>Change-Id: I380e842b7429060d13bc0264e55fa=
5c06ab427df<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: http=
s://gerrit.openvpn.net/c/openvpn/+/1452<br>Message-Id: &lt;20260122125829.1=
08470-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-d=
evel@lists.sourceforge.net/msg35391.html<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_ncp.c<br>1 file changed, 3=
 insertions(+), 11 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c</span><br><sp=
an>index 1a2405c..20fd2f0 100644</span><br><span>--- a/src/openvpn/ssl_ncp.=
c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br><span>@@ -534,11 +5=
34,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defi=
ned(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma=
 GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Replaces the st=
ring DEFAULT with the string \c replace.</span><br><span>  *</span><br><spa=
n>@@ -549,12 +544,13 @@</span><br><span> replace_default_in_ncp_ciphers_opt=
ion(struct options *o, const char *replace)</span><br><span> {</span><br><s=
pan>     const char *search =3D &quot;DEFAULT&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const int ncp_ciphers_len =3D strlen(o-=
&gt;ncp_ciphers) + strlen(replace) - strlen(search) + 1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const size_t ncp_ciphers_len =3D s=
trlen(o-&gt;ncp_ciphers) + strlen(replace) - strlen(search) + 1;</span><br>=
<span> </span><br><span>     uint8_t *ncp_ciphers =3D gc_malloc(ncp_ciphers=
_len, true, &amp;o-&gt;gc);</span><br><span> </span><br><span>     struct b=
uffer ncp_ciphers_buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    buf_set_write(&amp;ncp_ciphers_buf, ncp_ciphers, ncp_ciphers_len);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(ncp_ciphers_=
len &lt;=3D INT_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    buf_set_write(&amp;ncp_ciphers_buf, ncp_ciphers, (int)ncp_ciphers_len=
);</span><br><span> </span><br><span>     const char *def =3D strstr(o-&gt;=
ncp_ciphers, search);</span><br><span> </span><br><span>@@ -571,10 +567,6 @=
@</span><br><span>     o-&gt;ncp_ciphers =3D (char *)ncp_ciphers;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Checks for avai=
libility of Chacha20-Poly1305 and sets</span><br><span>  * the ncp_cipher t=
o either AES-256-GCM:AES-128-GCM or</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1452?usp=3Dema=
il">change 1452</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1452?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I380e842b7429060d13bc0264e55=
fa5c06ab427df </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1452 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--v5rAjSUirMw=--

