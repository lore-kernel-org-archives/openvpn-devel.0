From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 17 Oct 2025 10:48:55 +0000
References: <gerrit.1760698129000.I2d1fbe7ec080beb931253d09c1b5227e9bf4e756@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <047b3afa3a403385df3f422169960b032486700c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uiNt2nuKhCE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_util: Fix
 conversion warning in get_num_elements
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

--uiNt2nuKhCE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1281?usp=3Demail

to review the following change.


Change subject: ssl_util: Fix conversion warning in get_num_elements
......................................................................

ssl_util: Fix conversion warning in get_num_elements

Just use correct type.

Change-Id: I2d1fbe7ec080beb931253d09c1b5227e9bf4e756
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_util.c
1 file changed, 2 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/1281/1

diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index 50e8c03..fb7cf3e 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -290,21 +290,16 @@
     return NULL;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 get_num_elements(const char *string, char delimiter)
 {
-    int string_len =3D strlen(string);
+    const size_t string_len =3D strlen(string);

     ASSERT(0 !=3D string_len);

     int element_count =3D 1;
     /* Get number of ciphers */
-    for (int i =3D 0; i < string_len; i++)
+    for (size_t i =3D 0; i < string_len; i++)
     {
         if (string[i] =3D=3D delimiter)
         {
@@ -314,7 +309,3 @@

     return element_count;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1281?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2d1fbe7ec080beb931253d09c1b5227e9bf4e756
Gerrit-Change-Number: 1281
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--uiNt2nuKhCE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1281?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl_util: Fix conversion warning in get_num=
_elements<br><br>Just use correct type.<br><br>Change-Id: I2d1fbe7ec080beb9=
31253d09c1b5227e9bf4e756<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>---<br>M src/openvpn/ssl_util.c<br>1 file changed, 2 insertio=
ns(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/81/1281/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/ssl_util.c b/src/openvpn/ssl_util.c</span><br><span>index 50e8c03..fb7c=
f3e 100644</span><br><span>--- a/src/openvpn/ssl_util.c</span><br><span>+++=
 b/src/openvpn/ssl_util.c</span><br><span>@@ -290,21 +290,16 @@</span><br><=
span>     return NULL;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> int</span><br><span> get_num_elements(const cha=
r *string, char delimiter)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int string_len =3D strlen(string);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const size_t string_len =3D =
strlen(string);</span><br><span> </span><br><span>     ASSERT(0 !=3D string=
_len);</span><br><span> </span><br><span>     int element_count =3D 1;</spa=
n><br><span>     /* Get number of ciphers */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; string_len; i++)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i=
 &lt; string_len; i++)</span><br><span>     {</span><br><span>         if (=
string[i] =3D=3D delimiter)</span><br><span>         {</span><br><span>@@ -=
314,7 +309,3 @@</span><br><span> </span><br><span>     return element_count=
;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1281?usp=3Demail">change 1281</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1281?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2d1fbe7ec080beb931253d09c1b=
5227e9bf4e756 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1281 </div>
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

--uiNt2nuKhCE=--

