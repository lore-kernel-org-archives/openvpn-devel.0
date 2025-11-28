From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_F13B974B-455E-4EB6-9169-A1494EBD9326"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Message-Id: <1804EA24-7561-42E6-9308-5F0425823EC1@...2722...>
Date: Fri, 28 Nov 2025 21:41:30 +0200
Subject: [Openvpn-devel] OpenVPN 2.6.17 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

--Apple-Mail=_F13B974B-455E-4EB6-9169-A1494EBD9326
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.6.17.

This is a bugfix release containing one security fix.

Security fixes:

* CVE-2025-13751: Windows/interactive service: fix erroneous exit on error =
that could be
  used by a local Windows users to achieve a local denial-of-service

Bug fixes:

* Windows/interactive service: improve service pipe robustness against
  file access races (uuid) and access by unauthorized processes (ACL).
* upgrade bundled build instruction (vcpkg and patch) for pkcs11-helper
  to 1.31, fixing a parser bug

Windows MSI changes since 2.6.16-I001:

* Built against OpenSSL 3.6.0
* Included openvpn-gui updated to 11.59.0.0
	* Authorize config before opening the service pipe
	* Remove dependence on pathcch.dll not in Windows 7
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

--Apple-Mail=_F13B974B-455E-4EB6-9169-A1494EBD9326
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-=
mode: space; line-break: after-white-space;"><span style=3D"caret-color: rg=
b(0, 0, 0); color: rgb(0, 0, 0);">The OpenVPN community project team is pro=
ud to release OpenVPN 2.6.17.</span><br style=3D"caret-color: rgb(0, 0, 0);=
 color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0=
, 0, 0);"><font color=3D"#000000">This is a bugfix release containing one s=
ecurity fix.</font><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0,=
 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><div>Se=
curity fixes:</div><div><br></div><div><div>* CVE-2025-13751: Windows/inter=
active service: fix erroneous exit on error that could be</div><div>&nbsp; =
used by a local Windows users to achieve a local denial-of-service</div><di=
v><br></div><div>Bug fixes:</div><div><br></div><div>* Windows/interactive =
service: improve service pipe robustness against</div><div>&nbsp; file acce=
ss races (uuid) and access by unauthorized processes (ACL).</div><div>* upg=
rade bundled build instruction (vcpkg and patch) for pkcs11-helper</div><di=
v>&nbsp; to 1.31, fixing a parser bug</div></div><br style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);"><div>Windows MSI changes since 2.6.16-I=
001:</div><div><br></div><div>* Built against OpenSSL 3.6.0</div><div>* Inc=
luded openvpn-gui updated to 11.59.0.0</div><div><span class=3D"Apple-tab-s=
pan" style=3D"white-space:pre">	</span>* Authorize config before opening th=
e service pipe</div><div><span class=3D"Apple-tab-span" style=3D"white-spac=
e:pre">	</span>* Remove dependence on pathcch.dll not in Windows 7</div><di=
v>* Included win-dco driver updated to 2.8.0</div><br style=3D"caret-color:=
 rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, =
0); color: rgb(0, 0, 0);">More details can be found in the Changes document=
:</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br s=
tyle=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"car=
et-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"https:/=
/github.com/OpenVPN/openvpn/blob/release/2.6/Changes.rst">https://github.co=
m/OpenVPN/openvpn/blob/release/2.6/Changes.rst</a><span style=3D"caret-colo=
r: rgb(0, 0, 0); color: rgb(0, 0, 0);">&gt;</span><br style=3D"caret-color:=
 rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0)=
; color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rg=
b(0, 0, 0);">(The Changes document also contains a section with work-around=
s for</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><=
span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">common probl=
ems encountered when using OpenVPN with OpenSSL 3)</span><br style=3D"caret=
-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0=
, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); co=
lor: rgb(0, 0, 0);">Source code and Windows installers can be downloaded fr=
om our download page:</span><br style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);=
"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</spa=
n><a href=3D"https://openvpn.net/community/">https://openvpn.net/community/=
</a><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&gt;</s=
pan><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=
=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-c=
olor: rgb(0, 0, 0); color: rgb(0, 0, 0);">Debian and Ubuntu packages are av=
ailable in the official apt repositories:</span><br style=3D"caret-color: r=
gb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(=
0, 0, 0);">&lt;</span><a href=3D"https://community.openvpn.net/openvpn/wiki=
/OpenvpnSoftwareRepos#DebianUbuntu:UsingOpenVPNaptrepositories">https://com=
munity.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos#DebianUbuntu:UsingOpen=
VPNaptrepositories</a><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(=
0, 0, 0);">&gt;</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0,=
 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><spa=
n style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">On Red Hat deri=
vatives we recommend using the Fedora Copr repository.</span><br style=3D"c=
aret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: r=
gb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0)=
; color: rgb(0, 0, 0);">&lt;</span><a href=3D"https://copr.fedorainfracloud=
.org/coprs/g/OpenVPN/openvpn-release-2.6/">https://copr.fedorainfracloud.or=
g/coprs/g/OpenVPN/openvpn-release-2.6/</a><span style=3D"caret-color: rgb(0=
, 0, 0); color: rgb(0, 0, 0);">&gt;</span><div><span style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);"><br></span></div><div><p style=3D"margi=
n: 0px; font-width: normal; line-height: normal; font-size-adjust: none; fo=
nt-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: =
normal; font-variant-numeric: normal; font-variant-east-asian: normal; font=
-variant-position: normal; font-feature-settings: normal; font-optical-sizi=
ng: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-tex=
t-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kerning: none;">Kind reg=
ards,</span></p><p style=3D"margin: 0px; font-width: normal; line-height: n=
ormal; font-size-adjust: none; font-kerning: auto; font-variant-alternates:=
 normal; font-variant-ligatures: normal; font-variant-numeric: normal; font=
-variant-east-asian: normal; font-variant-position: normal; font-feature-se=
ttings: normal; font-optical-sizing: auto; font-variation-settings: normal;=
 color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=
=3D"font-kerning: none;">Yuriy Darnobyt</span></p></div></body></html>=

--Apple-Mail=_F13B974B-455E-4EB6-9169-A1494EBD9326--

