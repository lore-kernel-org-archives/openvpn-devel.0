From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_400FC8E1-DFF5-4E98-B683-5CE3E0CDF4EC"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Message-Id: <3FCD6D52-EA95-4C82-8C98-AD88F8A86C3A@...2722...>
Date: Tue, 18 Nov 2025 20:46:51 +0200
Subject: [Openvpn-devel] OpenVPN 2.6.16 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-announce@lists.sourceforge.net, openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--Apple-Mail=_400FC8E1-DFF5-4E98-B683-5CE3E0CDF4EC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.6.16.

This is a bugfix release containing one security fix.

Security fixes:

* CVE-2025-13086: Fix memcmp check for the hmac verification in the 3way ha=
ndshake.
  This bug renders the HMAC based protection against state exhaustion on
  receiving spoofed TLS handshake packets in the OpenVPN server inefficient.

Bug fixes:

* fix invalid pointer creation in tls_pre_decrypt() - technically this is
  a memory over-read issue, in practice, the compilers optimize it away
  so no negative effects could be observed.
* Windows: in the interactive service, fix the "undo DNS config" handling.
* Windows: in the interactive service, disallow using of "stdin" for the
  config file, unless the caller is authorized OpenVPN Administrator
* Windows: in the interactive service, change all netsh calls to use
  interface index and not interface name - sidesteps all possible attack
  avenues with special characters in interface names.
* Windows: in the interactive service, improve error handling in
  some "unlikely to happen" paths.
* auth plugin/script handling: properly check for errors in creation on
  $auth_failed_reason_file (arf).
* for incoming TCP connections, close-on-exec option was applied to
  the wrong socket fd, leaking socket FDs to child processes.
* sitnl: set close-on-exec flag on netlink socket
* ssl_mbedtls: fix missing perf_pop() call (optional performance profiling)

Windows MSI changes since 2.6.15-I001:

* Built against OpenSSL 3.6.0
* Included openvpn-gui updated to 11.58.0.0
	* Check the return value of GetProp()
	* Make config path check similar to that in interactive service
	* Escape the type id of password message received from openvpn
	* Add a message source for event logging
	* Check correct management daemon path when OpenVPN3 is enabled
	* Fix OpenVPN3 radio button label size when OVPN3 is enabled
	* Use GetTempPath() for debug file in plap as well
	* Migrate all saved plain usernames to encrypted format
* Included win-dco driver updated to 2.8.0

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/release/2.6/Changes.rst>

(The Changes document also contains a section with work-arounds for
common problems encountered when using OpenVPN with OpenSSL 3)

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos#DebianUbun=
tu:UsingOpenVPNaptrepositories>

On Red Hat derivatives we recommend using the Fedora Copr repository.

<https://copr.fedorainfracloud.org/coprs/g/OpenVPN/openvpn-release-2.6/>

Kind regards,
Yuriy Darnobyt=

--Apple-Mail=_400FC8E1-DFF5-4E98-B683-5CE3E0CDF4EC
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-=
mode: space; line-break: after-white-space;"><span style=3D"caret-color: rg=
b(0, 0, 0); color: rgb(0, 0, 0);">The OpenVPN community project team is pro=
ud to release OpenVPN 2.6.16.</span><br style=3D"caret-color: rgb(0, 0, 0);=
 color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0=
, 0, 0);"><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);=
">This is a bugfix release containing one security fix.</span></font><br st=
yle=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-=
color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><div>Security fixes:</div><div><=
br></div><div>* CVE-2025-13086: Fix memcmp check for the hmac verification =
in the 3way handshake.</div><div>&nbsp; This bug renders the HMAC based pro=
tection against state exhaustion on</div><div>&nbsp; receiving spoofed TLS =
handshake packets in the OpenVPN server inefficient.</div><div><br></div><d=
iv>Bug fixes:</div><div><br></div><div>* fix invalid pointer creation in tl=
s_pre_decrypt() - technically this is</div><div>&nbsp; a memory over-read i=
ssue, in practice, the compilers optimize it away</div><div>&nbsp; so no ne=
gative effects could be observed.</div><div>* Windows: in the interactive s=
ervice, fix the "undo DNS config" handling.</div><div>* Windows: in the int=
eractive service, disallow using of "stdin" for the</div><div>&nbsp; config=
 file, unless the caller is authorized OpenVPN Administrator</div><div>* Wi=
ndows: in the interactive service, change all netsh calls to use</div><div>=
&nbsp; interface index and not interface name - sidesteps all possible atta=
ck</div><div>&nbsp; avenues with special characters in interface names.</di=
v><div>* Windows: in the interactive service, improve error handling in</di=
v><div>&nbsp; some "unlikely to happen" paths.</div><div>* auth plugin/scri=
pt handling: properly check for errors in creation on</div><div>&nbsp; $aut=
h_failed_reason_file (arf).</div><div>* for incoming TCP connections, close=
-on-exec option was applied to</div><div>&nbsp; the wrong socket fd, leakin=
g socket FDs to child processes.</div><div>* sitnl: set close-on-exec flag =
on netlink socket</div><div>* ssl_mbedtls: fix missing perf_pop() call (opt=
ional performance profiling)</div><br style=3D"caret-color: rgb(0, 0, 0); c=
olor: rgb(0, 0, 0);"><div>Windows MSI changes since 2.6.15-I001:</div><div>=
<br></div><div>* Built against OpenSSL 3.6.0</div><div>* Included openvpn-g=
ui updated to 11.58.0.0</div><div><span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">	</span>* Check the return value of GetProp()</div><div><sp=
an class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>* Make config=
 path check similar to that in interactive service</div><div><span class=3D=
"Apple-tab-span" style=3D"white-space:pre">	</span>* Escape the type id of =
password message received from openvpn</div><div><span class=3D"Apple-tab-s=
pan" style=3D"white-space:pre">	</span>* Add a message source for event log=
ging</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</=
span>* Check correct management daemon path when OpenVPN3 is enabled</div><=
div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>* Fix =
OpenVPN3 radio button label size when OVPN3 is enabled</div><div><span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">	</span>* Use GetTempPath() =
for debug file in plap as well</div><div><span class=3D"Apple-tab-span" sty=
le=3D"white-space:pre">	</span>* Migrate all saved plain usernames to encry=
pted format</div><div>* Included win-dco driver updated to 2.8.0</div><br s=
tyle=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"car=
et-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">More details can be found in =
the Changes document:</span><br style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);=
"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</spa=
n><a href=3D"https://github.com/OpenVPN/openvpn/blob/release/2.6/Changes.rs=
t">https://github.com/OpenVPN/openvpn/blob/release/2.6/Changes.rst</a><span=
 style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&gt;</span><br s=
tyle=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret=
-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb=
(0, 0, 0); color: rgb(0, 0, 0);">(The Changes document also contains a sect=
ion with work-arounds for</span><br style=3D"caret-color: rgb(0, 0, 0); col=
or: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, =
0, 0);">common problems encountered when using OpenVPN with OpenSSL 3)</spa=
n><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=
=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-c=
olor: rgb(0, 0, 0); color: rgb(0, 0, 0);">Source code and Windows installer=
s can be downloaded from our download page:</span><br style=3D"caret-color:=
 rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0)=
; color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rg=
b(0, 0, 0);">&lt;</span><a href=3D"https://openvpn.net/community/">https://=
openvpn.net/community/</a><span style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0);">&gt;</span><br style=3D"caret-color: rgb(0, 0, 0); color: rg=
b(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">=
<span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">Debian and =
Ubuntu packages are available in the official apt repositories:</span><br s=
tyle=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret=
-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb=
(0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"https://community.op=
envpn.net/openvpn/wiki/OpenvpnSoftwareRepos#DebianUbuntu:UsingOpenVPNaptrep=
ositories">https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos#=
DebianUbuntu:UsingOpenVPNaptrepositories</a><span style=3D"caret-color: rgb=
(0, 0, 0); color: rgb(0, 0, 0);">&gt;</span><br style=3D"caret-color: rgb(0=
, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); colo=
r: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0=
, 0);">On Red Hat derivatives we recommend using the Fedora Copr repository=
.</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br s=
tyle=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"car=
et-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"https:/=
/copr.fedorainfracloud.org/coprs/g/OpenVPN/openvpn-release-2.6/">https://co=
pr.fedorainfracloud.org/coprs/g/OpenVPN/openvpn-release-2.6/</a><span style=
=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&gt;</span><div><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br></span></div>=
<div><p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal=
; font-width: normal; line-height: normal; font-size-adjust: none; font-ker=
ning: auto; font-variant-alternates: normal; font-variant-ligatures: normal=
; font-variant-numeric: normal; font-variant-east-asian: normal; font-varia=
nt-position: normal; font-variant-emoji: normal; font-feature-settings: nor=
mal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb=
(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0=
, 0, 0);"><span style=3D"font-kerning: none">Kind regards,</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0);"><span style=3D"font-kerning: none">Yuriy Darnobyt</span></p></div></bo=
dy></html>=

--Apple-Mail=_400FC8E1-DFF5-4E98-B683-5CE3E0CDF4EC--

