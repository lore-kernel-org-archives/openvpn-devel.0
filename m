From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 14 Jan 2025 14:44:19 +0000
References: <gerrit.1736865848000.Iaaf80c688ddff79ac9472d7237003713637c140b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e134b37d6a19e861d14d95e462c11e5b0f25c43b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i/+6ejObgfA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 tls_crypt_v2_write_client_key_file: Fix missing-field-initializers co...
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

--i/+6ejObgfA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/867?usp=3Demail

to review the following change.


Change subject: tls_crypt_v2_write_client_key_file: Fix missing-field-initi=
alizers compiler warning
......................................................................

tls_crypt_v2_write_client_key_file: Fix missing-field-initializers compiler=
 warning

GCC wants us to be more explicit here.

Change-Id: Iaaf80c688ddff79ac9472d7237003713637c140b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/tls_crypt.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/867/1

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 24df930..4c421aa 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -691,7 +691,7 @@
     struct buffer client_key_pem =3D { 0 };
     struct buffer dst =3D alloc_buf_gc(TLS_CRYPT_V2_CLIENT_KEY_LEN
                                      + TLS_CRYPT_V2_MAX_WKC_LEN, &gc);
-    struct key2 client_key =3D { 2 };
+    struct key2 client_key =3D { .n =3D 2 };

     if (!rand_bytes((void *)client_key.keys, sizeof(client_key.keys)))
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/867?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaaf80c688ddff79ac9472d7237003713637c140b
Gerrit-Change-Number: 867
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--i/+6ejObgfA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/867?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">tls_crypt_v2_write_client_key_file: Fix missing-field-initial=
izers compiler warning<br><br>GCC wants us to be more explicit here.<br><br=
>Change-Id: Iaaf80c688ddff79ac9472d7237003713637c140b<br>Signed-off-by: Fra=
nk Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/tls_crypt.c=
<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/67/867/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br><span>index =
24df930..4c421aa 100644</span><br><span>--- a/src/openvpn/tls_crypt.c</span=
><br><span>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -691,7 +691,7 @=
@</span><br><span>     struct buffer client_key_pem =3D { 0 };</span><br><s=
pan>     struct buffer dst =3D alloc_buf_gc(TLS_CRYPT_V2_CLIENT_KEY_LEN</sp=
an><br><span>                                      + TLS_CRYPT_V2_MAX_WKC_L=
EN, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct key2 client_key =3D { 2 };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct key2 client_key =3D { .n =3D 2 };</span><br><span> </s=
pan><br><span>     if (!rand_bytes((void *)client_key.keys, sizeof(client_k=
ey.keys)))</span><br><span>     {</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/867?usp=3Demail"=
>change 867</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/867?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaaf80c688ddff79ac9472d72370=
03713637c140b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 867 </div>
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


--i/+6ejObgfA=--

