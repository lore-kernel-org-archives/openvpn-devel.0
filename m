From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_EC2D08B3-B605-4229-97FA-B537E3710FFB"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Message-Id: <F9AC0F13-BA48-414B-8BC3-53408FB9AD41@...2722...>
Date: Wed, 22 Apr 2026 23:31:20 +0300
Subject: [Openvpn-devel] OpenVPN 2.7.2 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

--Apple-Mail=_EC2D08B3-B605-4229-97FA-B537E3710FFB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.7.2.
This is a bugfix release containing security fixes.


Security fixes:

* CVE-2026-40215: fix race condition in TLS handshake that could lead to le=
aking of
  packet data from a previous handshake under specific circumstances
* CVE-2026-35058: fix server ASSERT() on receiving a suitably malformed pac=
ket with
  a valid tls-crypt-v2 key

New features:

* management interface: permit input of very long passwords in
  base64-encoded multiline format.  Signal support to management
  clients via "management version 6".

User-visible Changes:

* improve error messages on ``--verify-x509-name`` failures
* improve error logging when overlong username or passwords can not
  be written to TLS buffer

Bugfixes:

* when using a config file with inlined username and no password,
  fix prompting for the password from management interface.
* Windows: fix DNSSEC flag handling - this got never applied due to
  a bad comparison being always false.
* Windows: fix deinstallation progress bar on adapter deletion.

Windows MSI changes since 2.7.1:
* Built against OpenSSL 3.6.2
* Included openvpn-gui updated to 11.63.0.0
  * Translation cleanup. Remove obsolete strings related to support for Ope=
nVPN < 2.0
  * Translation updates.

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/v2.7.2/Changes.rst <https://github=
.com/OpenVPN/openvpn/blob/v2.7./Changes.rst>>

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community/>

Packages for Debian, Ubuntu, Fedora, RHEL, and openSUSE are available in th=
e various
official Community repositories:

<https://community.openvpn.net/Pages/OpenVPN%20software%20repos>=

--Apple-Mail=_EC2D08B3-B605-4229-97FA-B537E3710FFB
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" c=
ontent=3D"text/html; charset=3Dus-ascii"></head><body style=3D"overflow-wra=
p: break-word; -webkit-nbsp-mode: space; line-break: after-white-space;"><d=
iv>The OpenVPN community project team is proud to release OpenVPN 2.7.2.</d=
iv><div>This is a bugfix release containing security fixes.</div><div><br><=
/div><div><br></div><div>Security fixes:</div><div><br></div><div>* CVE-202=
6-40215: fix race condition in TLS handshake that could lead to leaking of<=
/div><div>&nbsp; packet data from a previous handshake under specific circu=
mstances</div><div>* CVE-2026-35058: fix server ASSERT() on receiving a sui=
tably malformed packet with</div><div>&nbsp; a valid tls-crypt-v2 key</div>=
<div><br></div><div>New features:</div><div><br></div><div>* management int=
erface: permit input of very long passwords in</div><div>&nbsp; base64-enco=
ded multiline format. &nbsp;Signal support to management</div><div>&nbsp; c=
lients via "management version 6".</div><div><br></div><div>User-visible Ch=
anges:</div><div><br></div><div>* improve error messages on ``--verify-x509=
-name`` failures</div><div>* improve error logging when overlong username o=
r passwords can not</div><div>&nbsp; be written to TLS buffer</div><div><br=
></div><div>Bugfixes:</div><div><br></div><div>* when using a config file w=
ith inlined username and no password,</div><div>&nbsp; fix prompting for th=
e password from management interface.</div><div>* Windows: fix DNSSEC flag =
handling - this got never applied due to</div><div>&nbsp; a bad comparison =
being always false.</div><div>* Windows: fix deinstallation progress bar on=
 adapter deletion.</div><div><br></div><div>Windows MSI changes since 2.7.1=
:</div><div>* Built against OpenSSL 3.6.2</div><div>* Included openvpn-gui =
updated to 11.63.0.0</div><div>&nbsp; * Translation cleanup. Remove obsolet=
e strings related to support for OpenVPN &lt; 2.0</div><div>&nbsp; * Transl=
ation updates.</div><br>More details can be found in the Changes document:<=
br><br>&lt;<a href=3D"https://github.com/OpenVPN/openvpn/blob/v2.7./Changes=
.rst">https://github.com/OpenVPN/openvpn/blob/v2.7.2/Changes.rst</a>&gt;<br=
><br>Source code and Windows installers can be downloaded from our download=
 page:<br><br>&lt;<a href=3D"https://openvpn.net/community/">https://openvp=
n.net/community/</a>&gt;<br><br>Packages for Debian, Ubuntu, Fedora, RHEL, =
and openSUSE are available in the various<br>official Community repositorie=
s:<br><br>&lt;<a href=3D"https://community.openvpn.net/Pages/OpenVPN%20soft=
ware%20repos">https://community.openvpn.net/Pages/OpenVPN%20software%20repo=
s</a>&gt;</body></html>=

--Apple-Mail=_EC2D08B3-B605-4229-97FA-B537E3710FFB--

