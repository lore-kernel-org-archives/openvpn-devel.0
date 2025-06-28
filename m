From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 28 Jun 2025 16:30:42 +0000
In-Reply-To: <gerrit.1750934262000.I46132ebaf3bf3b16798b6f2416f7bf7272f5646b@...2715...>
References: <gerrit.1750934262000.I46132ebaf3bf3b16798b6f2416f7bf7272f5646b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <63d5c9784708079815828a5e83a4748bbff5acae-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lIo42EYL4vo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: create NRPT
 registry key if it doesn't exist
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lIo42EYL4vo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1069?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa


Change subject: dns: create NRPT registry key if it doesn't exist
......................................................................

dns: create NRPT registry key if it doesn't exist

Windows 2019 Server by default does not have the key where local system
NRPT rules are stored. Tests have determined that NRPT is actually
working when rules are created under the key. So, instead of failing if
the key doesn't exist, we create it, and things will start working.

Github: OpenVPN/openvpn#768
Change-Id: I46132ebaf3bf3b16798b6f2416f7bf7272f5646b
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20250627082500.17075-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
001.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1069/4

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 3bd2722..628a96b 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2662,7 +2662,7 @@
     if (err =3D=3D ERROR_FILE_NOT_FOUND)
     {
         *gpol =3D FALSE;
-        err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE, sys_key, 0, KEY_ALL_ACCE=
SS, &nrpt);
+        err =3D RegCreateKeyExA(HKEY_LOCAL_MACHINE, sys_key, 0, NULL, 0, K=
EY_ALL_ACCESS, NULL, &nrpt, NULL);
         if (err)
         {
             nrpt =3D INVALID_HANDLE_VALUE;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1069?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I46132ebaf3bf3b16798b6f2416f7bf7272f5646b
Gerrit-Change-Number: 1069
Gerrit-PatchSet: 4
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--lIo42EYL4vo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by d12fk.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1069=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by stipa</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dns: create NRPT registry key if it doesn&#39;t exis=
t<br><br>Windows 2019 Server by default does not have the key where local s=
ystem<br>NRPT rules are stored. Tests have determined that NRPT is actually=
<br>working when rules are created under the key. So, instead of failing if=
<br>the key doesn&#39;t exist, we create it, and things will start working.=
<br><br>Github: OpenVPN/openvpn#768<br>Change-Id: I46132ebaf3bf3b16798b6f24=
16f7bf7272f5646b<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>A=
cked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Message-Id: &lt;202506=
27082500.17075-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/o=
penvpn-devel@lists.sourceforge.net/msg32001.html<br>Signed-off-by: Gert Doe=
ring &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1=
 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/69/1069/4</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><span>=
index 3bd2722..628a96b 100644</span><br><span>--- a/src/openvpnserv/interac=
tive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>=
@@ -2662,7 +2662,7 @@</span><br><span>     if (err =3D=3D ERROR_FILE_NOT_FO=
UND)</span><br><span>     {</span><br><span>         *gpol =3D FALSE;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D RegOpenKeyE=
xA(HKEY_LOCAL_MACHINE, sys_key, 0, KEY_ALL_ACCESS, &amp;nrpt);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        err =3D RegCreateKeyExA(=
HKEY_LOCAL_MACHINE, sys_key, 0, NULL, 0, KEY_ALL_ACCESS, NULL, &amp;nrpt, N=
ULL);</span><br><span>         if (err)</span><br><span>         {</span><b=
r><span>             nrpt =3D INVALID_HANDLE_VALUE;</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1069?usp=3Demail">change 1069</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1069?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I46132ebaf3bf3b16798b6f2416f=
7bf7272f5646b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1069 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--lIo42EYL4vo=--

