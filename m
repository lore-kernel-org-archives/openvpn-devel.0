From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 26 Jun 2025 10:37:45 +0000
References: <gerrit.1750934262000.I46132ebaf3bf3b16798b6f2416f7bf7272f5646b@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2ef8659a2c2e6d3c51653e1993a134c34526a353-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XBaBL7TKsNE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XBaBL7TKsNE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1069?usp=3Demail

to review the following change.


Change subject: dns: create NRPT registry key if it doesn't exist
......................................................................

dns: create NRPT registry key if it doesn't exist

Windows 2019 Server by default does not have the key where local system
NRPT rules are stored. Tests have determined that NRPT is actually
working when rules are created under the key. So, instead of failing if
the key doesn't exist, we create it, and things will start working.

Change-Id: I46132ebaf3bf3b16798b6f2416f7bf7272f5646b
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1069/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 3bd2722..0a00a6a 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2662,7 +2662,7 @@
     if (err =3D=3D ERROR_FILE_NOT_FOUND)
     {
         *gpol =3D FALSE;
-        err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE, sys_key, 0, KEY_ALL_ACCE=
SS, &nrpt);
+        err =3D RegCreateKeyExA(HKEY_LOCAL_MACHINE, sys_key, 0, NULL, 0, 0=
, NULL, &nrpt, NULL);
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
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--XBaBL7TKsNE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1069?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dns: create NRPT registry key if it doesn&#39;t exist<br><br=
>Windows 2019 Server by default does not have the key where local system<br=
>NRPT rules are stored. Tests have determined that NRPT is actually<br>work=
ing when rules are created under the key. So, instead of failing if<br>the =
key doesn&#39;t exist, we create it, and things will start working.<br><br>=
Change-Id: I46132ebaf3bf3b16798b6f2416f7bf7272f5646b<br>Signed-off-by: Heik=
o Hund &lt;heiko@...2662...&gt;<br>---<br>M src/openvpnserv/interactive.c<b=
r>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/69/1069/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><sp=
an>index 3bd2722..0a00a6a 100644</span><br><span>--- a/src/openvpnserv/inte=
ractive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><sp=
an>@@ -2662,7 +2662,7 @@</span><br><span>     if (err =3D=3D ERROR_FILE_NOT=
_FOUND)</span><br><span>     {</span><br><span>         *gpol =3D FALSE;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D RegOpenK=
eyExA(HKEY_LOCAL_MACHINE, sys_key, 0, KEY_ALL_ACCESS, &amp;nrpt);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D RegCreateKeyE=
xA(HKEY_LOCAL_MACHINE, sys_key, 0, NULL, 0, 0, NULL, &amp;nrpt, NULL);</spa=
n><br><span>         if (err)</span><br><span>         {</span><br><span>  =
           nrpt =3D INVALID_HANDLE_VALUE;</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1069?usp=
=3Demail">change 1069</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1069?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I46132ebaf3bf3b16798b6f2416f=
7bf7272f5646b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1069 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--XBaBL7TKsNE=--

