From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 23 Nov 2025 13:37:57 +0000
In-Reply-To: <gerrit.1763880426000.Icd7c7b08e317aefd91a60bfc62e92cd8707b6fac@...2715...>
References: <gerrit.1763880426000.Icd7c7b08e317aefd91a60bfc62e92cd8707b6fac@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7b53105b2846ff36824f4a6da26a7cc260a2bbbc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z4TzecGg0X0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: check for
 NULL pointer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Z4TzecGg0X0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
93?usp=3Demail )

Change subject: iservice: check for NULL pointer
......................................................................

iservice: check for NULL pointer

Check if the list argument to ListContainsDomain() is NULL. Otherwise
the call to wcsstr() will bail out.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: Icd7c7b08e317aefd91a60bfc62e92cd8707b6fac
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1393
Message-Id: <20251123120029.19736-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
611.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 860375d..07ca7c9 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2106,7 +2106,7 @@
 ListContainsDomain(PCWSTR list, PCWSTR domain, size_t len)
 {
     PCWSTR match =3D list;
-    while (TRUE)
+    while (match)
     {
         match =3D wcsstr(match, domain);
         if (!match)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1393?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icd7c7b08e317aefd91a60bfc62e92cd8707b6fac
Gerrit-Change-Number: 1393
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Z4TzecGg0X0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1393?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">iservice: check for NULL pointer<br><br>Check if=
 the list argument to ListContainsDomain() is NULL. Otherwise<br>the call t=
o wcsstr() will bail out.<br><br>Reported-by: Marc Heuse &lt;marc@...2966...=
.&gt;<br>Reported-by: stephan@...2953...<br>Change-Id: Icd7c7b08e317aefd91a=
60bfc62e92cd8707b6fac<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;=
<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://g=
errit.openvpn.net/c/openvpn/+/1393<br>Message-Id: &lt;20251123120029.19736-=
1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1224...=
sts.sourceforge.net/msg34611.html<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file changed, =
1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index 860375d..07ca7c9 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -2106,7 +2106,7 @@</span><br><span> ListContainsDomai=
n(PCWSTR list, PCWSTR domain, size_t len)</span><br><span> {</span><br><spa=
n>     PCWSTR match =3D list;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    while (TRUE)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    while (match)</span><br><span>     {</span><br><span>         matc=
h =3D wcsstr(match, domain);</span><br><span>         if (!match)</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1393?usp=3Demail">change 1393</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1393?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icd7c7b08e317aefd91a60bfc62e=
92cd8707b6fac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1393 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Z4TzecGg0X0=--

