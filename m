From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 4 Dec 2025 12:37:26 +0000
References: <gerrit.1764851842000.I4f9a6baf2bdb45e5b79bf13c9f6fce3b7a2e982c@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <f52ad663a5735a8177b05a4a0f6088e6a06f36ef-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U8MapifDf40="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add a section about
 wolfSSL GPLv3 and point out missing TLS PRF support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--U8MapifDf40=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1416?usp=3Demail )


Change subject: Add a section about wolfSSL GPLv3 and point out missing TLS=
 PRF support
......................................................................

Add a section about wolfSSL GPLv3 and point out missing TLS PRF support

Change-Id: I4f9a6baf2bdb45e5b79bf13c9f6fce3b7a2e982c
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M README.wolfssl
1 file changed, 10 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/1416/1

diff --git a/README.wolfssl b/README.wolfssl
index 3918d0f..3e531ae 100644
--- a/README.wolfssl
+++ b/README.wolfssl
@@ -28,7 +28,17 @@
  * blowfish support (BF-CBC), you must use something like
    cipher AES-128-CBC to avoid trying to use BF-CBC
  * Windows CryptoAPI support
+ * No TLS1.0 PRF support (No compaitbility with OpenVPN 2.5 or older or
+   other build that do not support TLS EKM)

+
+*************************************************************************
+Newer wolfSSL versions (5.8.2 and newer) are GPLv3 licensed and this licen=
se is not
+compatible with OpenVPN's GPLv2 license.
+
+However wolfSSL Inc has granted an exception to combine the wolfSSL library
+with OpenVPN and OpenVPN-NL (https://github.com/wolfSSL/wolfssl/blob/maste=
r/LICENSING)
+with version 5.8.4 and later.
 *************************************************************************
 To build WolfSSL with post-quantum KEMs built in, the following command is=
 used:


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1416?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4f9a6baf2bdb45e5b79bf13c9f6fce3b7a2e982c
Gerrit-Change-Number: 1416
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--U8MapifDf40=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1416?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Add a section about wolfSSL GPLv3 and point out missing TLS PRF support=
<br><br>Change-Id: I4f9a6baf2bdb45e5b79bf13c9f6fce3b7a2e982c<br>Signed-off-=
by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M README.wolfssl<br>1 fi=
le changed, 10 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/1416/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/README.wolfssl b/README.wolfssl</span><br><span>index 3918d0f=
..3e531ae 100644</span><br><span>--- a/README.wolfssl</span><br><span>+++ b=
/README.wolfssl</span><br><span>@@ -28,7 +28,17 @@</span><br><span>  * blow=
fish support (BF-CBC), you must use something like</span><br><span>    ciph=
er AES-128-CBC to avoid trying to use BF-CBC</span><br><span>  * Windows Cr=
yptoAPI support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * N=
o TLS1.0 PRF support (No compaitbility with OpenVPN 2.5 or older or</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+   other build that do not =
support TLS EKM)</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+****=
*********************************************************************</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+Newer wolfSSL versions (5=
.8.2 and newer) are GPLv3 licensed and this license is not</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+compatible with OpenVPN&#39;s GPLv2 =
license.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+However wolfSSL Inc has grante=
d an exception to combine the wolfSSL library</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+with OpenVPN and OpenVPN-NL (https://github.com/w=
olfSSL/wolfssl/blob/master/LICENSING)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+with version 5.8.4 and later.</span><br><span> **********=
***************************************************************</span><br><=
span> To build WolfSSL with post-quantum KEMs built in, the following comma=
nd is used:</span><br><span> </span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1416?usp=3Demail">ch=
ange 1416</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1416?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4f9a6baf2bdb45e5b79bf13c9f6=
fce3b7a2e982c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1416 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--U8MapifDf40=--

