From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 19 Feb 2026 10:00:42 +0000
In-Reply-To: <gerrit.1771415352000.I2703f15144661f9cadfc8750884db270f3a5bfc6@...2715...>
References: <gerrit.1771415352000.I2703f15144661f9cadfc8750884db270f3a5bfc6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <08df4136e7adfcc26992a03c39a232592badf555-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1NimJ4NUM9s="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1NimJ4NUM9s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
46?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1546
(cherry picked from commit 720c2e97f609bf7bb7e628ddfa7d3e3783afa676)
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20260218214437.26912-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
723.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ntlm.c
1 file changed, 1 insertion(+), 1 deletion(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I2703f15144661f9cadfc8750884db270f3a5bfc6
Gerrit-Change-Number: 1546
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1NimJ4NUM9s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1546?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ntlm: fix discards &#39;const&#39; qualifier fro=
m pointer target type<br><br>Since glibc-2.43:<br><br>For ISO C23, the func=
tions bsearch, memchr, strchr, strpbrk, strrchr,<br>strstr, wcschr, wcspbrk=
, wcsrchr, wcsstr and wmemchr that return pointers<br>into their input arra=
ys now have definitions as macros that return a<br>pointer to a const-quali=
fied type when the input argument is a pointer<br>to a const-qualified type=
.<br><br>fixes:<br>    src/openvpn/ntlm.c: In function &#39;ntlm_phase_3&#3=
9;:<br>    src/openvpn/ntlm.c:241:15: warning: assignment discards &#39;con=
st&#39; qualifier from pointer target type [-Wdiscarded-qualifiers]<br>    =
  241 |     separator =3D strchr(p-&gt;up.username, &#39;\\&#39;);<br>     =
     |               ^<br><br>Change-Id: I2703f15144661f9cadfc8750884db270f=
3a5bfc6<br>Signed-off-by: Rudi Heitbaum &lt;rudi@...2993...&gt;<br>Acked-by=
: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvp=
n.net/c/openvpn/+/1546<br>(cherry picked from commit 720c2e97f609bf7bb7e628=
ddfa7d3e3783afa676)<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;=
<br>Message-Id: &lt;20260218214437.26912-1-gert@...1296...&gt;<br>URL: http=
s://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35723.html<=
br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/open=
vpn/ntlm.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c</span><br><span>ind=
ex 9191a8b..6da4359 100644</span><br><span>--- a/src/openvpn/ntlm.c</span><=
br><span>+++ b/src/openvpn/ntlm.c</span><br><span>@@ -230,7 +230,7 @@</span=
><br><span> </span><br><span>     char domain[128];</span><br><span>     ch=
ar username[128];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
char *separator;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *separator;</span><br><span> </span><br><span>     bool ntlmv2_=
enabled =3D (p-&gt;auth_method =3D=3D HTTP_AUTH_NTLM2);</span><br><span> </=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1546?usp=3Demail">change 1546</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1546?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2703f15144661f9cadfc8750884=
db270f3a5bfc6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1546 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--1NimJ4NUM9s=--

