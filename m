From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 18 Feb 2026 11:49:18 +0000
References: <gerrit.1771415352000.I2703f15144661f9cadfc8750884db270f3a5bfc6@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <0d4c7dc03326daa139c769a732a15be84dd91ab5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t/wAubWRz94="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: ntlm: fix
 discards 'const' qualifier from pointer target type
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

--t/wAubWRz94=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1546?usp=3Demail

to review the following change.


Change subject: ntlm: fix discards 'const' qualifier from pointer target ty=
pe
......................................................................

ntlm: fix discards 'const' qualifier from pointer target type

Since glibc-2.43:

For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr,
strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return pointers
into their input arrays now have definitions as macros that return a
pointer to a const-qualified type when the input argument is a pointer
to a const-qualified type.

fixes:
    src/openvpn/ntlm.c: In function 'ntlm_phase_3':
    src/openvpn/ntlm.c:241:15: warning: assignment discards 'const' qualifi=
er from pointer target type [-Wdiscarded-qualifiers]
      241 |     separator =3D strchr(p->up.username, '\\');
          |               ^

Change-Id: I2703f15144661f9cadfc8750884db270f3a5bfc6
Signed-off-by: Rudi Heitbaum <rudi@...2993...>
---
M src/openvpn/ntlm.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1546/1

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 9191a8b..6da4359 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -230,7 +230,7 @@

     char domain[128];
     char username[128];
-    char *separator;
+    const char *separator;

     bool ntlmv2_enabled =3D (p->auth_method =3D=3D HTTP_AUTH_NTLM2);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1546?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I2703f15144661f9cadfc8750884db270f3a5bfc6
Gerrit-Change-Number: 1546
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--t/wAubWRz94=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1546?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ntlm: fix discards &#39;const&#39; qualifie=
r from pointer target type<br><br>Since glibc-2.43:<br><br>For ISO C23, the=
 functions bsearch, memchr, strchr, strpbrk, strrchr,<br>strstr, wcschr, wc=
spbrk, wcsrchr, wcsstr and wmemchr that return pointers<br>into their input=
 arrays now have definitions as macros that return a<br>pointer to a const-=
qualified type when the input argument is a pointer<br>to a const-qualified=
 type.<br><br>fixes:<br>    src/openvpn/ntlm.c: In function &#39;ntlm_phase=
_3&#39;:<br>    src/openvpn/ntlm.c:241:15: warning: assignment discards &#3=
9;const&#39; qualifier from pointer target type [-Wdiscarded-qualifiers]<br=
>      241 |     separator =3D strchr(p-&gt;up.username, &#39;\\&#39;);<br>=
          |               ^<br><br>Change-Id: I2703f15144661f9cadfc8750884d=
b270f3a5bfc6<br>Signed-off-by: Rudi Heitbaum &lt;rudi@...2993...&gt;<br>---=
<br>M src/openvpn/ntlm.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/46/1546/1</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/ntlm.c b/src/openvpn=
/ntlm.c</span><br><span>index 9191a8b..6da4359 100644</span><br><span>--- a=
/src/openvpn/ntlm.c</span><br><span>+++ b/src/openvpn/ntlm.c</span><br><spa=
n>@@ -230,7 +230,7 @@</span><br><span> </span><br><span>     char domain[12=
8];</span><br><span>     char username[128];</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    char *separator;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const char *separator;</span><br><span> </span>=
<br><span>     bool ntlmv2_enabled =3D (p-&gt;auth_method =3D=3D HTTP_AUTH_=
NTLM2);</span><br><span> </span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1546?usp=3Demail">change=
 1546</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1546?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2703f15144661f9cadfc8750884=
db270f3a5bfc6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1546 </div>
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

--t/wAubWRz94=--

