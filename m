From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 26 Jun 2025 12:28:34 +0000
In-Reply-To: <gerrit.1750934262000.I46132ebaf3bf3b16798b6f2416f7bf7272f5646b@...2715...>
References: <gerrit.1750934262000.I46132ebaf3bf3b16798b6f2416f7bf7272f5646b@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <5f1e6a82dfd9b0be64bd983befc91cbaac1b4e08-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RvpDRT3Dmdw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RvpDRT3Dmdw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1069?usp=3Demail

to look at the new patch set (#3).


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
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1069/3

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
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-MessageType: newpatchset

--RvpDRT3Dmdw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p>d12fk <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1069?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">dns: create NRPT registry key if it doesn&#39;t exist<br><br>Windows 201=
9 Server by default does not have the key where local system<br>NRPT rules =
are stored. Tests have determined that NRPT is actually<br>working when rul=
es are created under the key. So, instead of failing if<br>the key doesn&#3=
9;t exist, we create it, and things will start working.<br><br>Github: Open=
VPN/openvpn#768<br>Change-Id: I46132ebaf3bf3b16798b6f2416f7bf7272f5646b<br>=
Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M src/openvpns=
erv/interactive.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1069/3</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interact=
ive.c</span><br><span>index 3bd2722..628a96b 100644</span><br><span>--- a/s=
rc/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interact=
ive.c</span><br><span>@@ -2662,7 +2662,7 @@</span><br><span>     if (err =
=3D=3D ERROR_FILE_NOT_FOUND)</span><br><span>     {</span><br><span>       =
  *gpol =3D FALSE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE, sys_key, 0, KEY_ALL_ACCESS, =
&amp;nrpt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
err =3D RegCreateKeyExA(HKEY_LOCAL_MACHINE, sys_key, 0, NULL, 0, KEY_ALL_AC=
CESS, NULL, &amp;nrpt, NULL);</span><br><span>         if (err)</span><br><=
span>         {</span><br><span>             nrpt =3D INVALID_HANDLE_VALUE;=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1069?usp=3Demail">change 1069</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1069?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I46132ebaf3bf3b16798b6f2416f=
7bf7272f5646b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1069 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--RvpDRT3Dmdw=--

