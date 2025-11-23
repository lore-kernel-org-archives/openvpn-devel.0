From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 23 Nov 2025 13:28:42 +0000
In-Reply-To: <gerrit.1763880426000.Icaeca22bdbd8ead0cb12345b1bcc2b5c0f46236f@...2715...>
References: <gerrit.1763880426000.Icaeca22bdbd8ead0cb12345b1bcc2b5c0f46236f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ca641178eeb3f93ff32d0546f0c63e5283e69cad-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IJHXb7TVEsg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: make sure
 registry string is terminated
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IJHXb7TVEsg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1392?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: iservice: make sure registry string is terminated
......................................................................

iservice: make sure registry string is terminated

When reading the interface domains from the registry, check that the
string is zero terminated, since the code in GetItfDnsDomains depends
on the fact when doing size calculations during the conversion.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: Icaeca22bdbd8ead0cb12345b1bcc2b5c0f46236f
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1392
Message-Id: <20251123115851.19555-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
610.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1392/2

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index d778e89..860375d 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2163,7 +2163,7 @@
     {
         *size =3D buf_size;
         err =3D RegGetValueW(itf, NULL, values[i], RRF_RT_REG_SZ, NULL, (P=
BYTE)domains, size);
-        if (!err && *size > one_glyph && wcschr(domains, '.'))
+        if (!err && *size > one_glyph && domains[(*size / one_glyph) - 1] =
=3D=3D '\0' && wcschr(domains, '.'))
         {
             /*
              * Found domain(s), now convert them:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1392?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icaeca22bdbd8ead0cb12345b1bcc2b5c0f46236f
Gerrit-Change-Number: 1392
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IJHXb7TVEsg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by d12fk.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1392?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">iservice: make sure registry string=
 is terminated<br><br>When reading the interface domains from the registry,=
 check that the<br>string is zero terminated, since the code in GetItfDnsDo=
mains depends<br>on the fact when doing size calculations during the conver=
sion.<br><br>Reported-by: Marc Heuse &lt;marc@...2953...&gt;<br>Reported-by=
: stephan@...2953...<br>Change-Id: Icaeca22bdbd8ead0cb12345b1bcc2b5c0f46236=
f<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Gert D=
oering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/=
openvpn/+/1392<br>Message-Id: &lt;20251123115851.19555-1-gert@...1296...&gt=
;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/=
msg34610.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---=
<br>M src/openvpnserv/interactive.c<br>1 file changed, 1 insertion(+), 1 de=
letion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/92/1392/2</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/inter=
active.c b/src/openvpnserv/interactive.c</span><br><span>index d778e89..860=
375d 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><=
span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -2163,7 +2163,7=
 @@</span><br><span>     {</span><br><span>         *size =3D buf_size;</sp=
an><br><span>         err =3D RegGetValueW(itf, NULL, values[i], RRF_RT_REG=
_SZ, NULL, (PBYTE)domains, size);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (!err &amp;&amp; *size &gt; one_glyph &amp;&amp; wcs=
chr(domains, &#39;.&#39;))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (!err &amp;&amp; *size &gt; one_glyph &amp;&amp; domains[=
(*size / one_glyph) - 1] =3D=3D &#39;\0&#39; &amp;&amp; wcschr(domains, &#3=
9;.&#39;))</span><br><span>         {</span><br><span>             /*</span=
><br><span>              * Found domain(s), now convert them:</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1392?usp=3Demail">change 1392</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1392?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icaeca22bdbd8ead0cb12345b1bc=
c2b5c0f46236f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1392 </div>
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

--IJHXb7TVEsg=--

