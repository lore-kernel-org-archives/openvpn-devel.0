From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <96f33af8-062d-7c93-5835-dcb58ccf6b58@...515...>
Date: Thu, 1 Mar 2018 16:59:45 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CQuxdcFTx8gMjC2dXIN99jnNuIRiDgxSb"
Subject: [Openvpn-devel] OpenVPN 2.4.5 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CQuxdcFTx8gMjC2dXIN99jnNuIRiDgxSb
Content-Type: multipart/mixed; boundary="W0Aa7wk1IJCzKPI41WUz4bUtpCh7uv6LW";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>,
 "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>,
 openvpn-announce@lists.sourceforge.net
Message-ID: <96f33af8-062d-7c93-5835-dcb58ccf6b58@...515...>
Subject: OpenVPN 2.4.5 released

--W0Aa7wk1IJCzKPI41WUz4bUtpCh7uv6LW
Content-Type: multipart/mixed;
 boundary="------------D01E5FD8DFD05B4256920E6E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D01E5FD8DFD05B4256920E6E
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.4.5. It
can be downloaded from here:

<http://openvpn.net/index.php/open-source/downloads.html>

This release includes a large number of fixes and enhancements. One of
the biggest changes is that 2.4.5 Windows installers bundle OpenSSL
1.1.0 instead of OpenSSL 1.0.2 by default. The Windows installer also
comes with OpenVPN GUI (11.10.0.0) that has a large number of fixes and
improvements. Some easy-rsa 2 fixes are also included.

Please note that LibreSSL is not a supported crypto backend. We accept
patches and we do test on OpenBSD 6.0 which comes with LibreSSL, but if
newer versions of LibreSSL break API compatibility we do not take
responsibility to fix that.

Also note that  Windows installers have been built with NSIS version
that has been patched against several NSIS installer code execution and
privilege escalation problems:

<https://community.openvpn.net/openvpn/wiki/NSISBug1125>

Based on our testing, though, older Windows versions such as Windows 7
might not benefit from these fixes. We thus strongly encourage you to
always move NSIS installers to a non-user-writeable location before
running them. Our long-term plan is to migrate to using MSI installers
instead.

A summary of all included changes is available here:

<https://github.com/OpenVPN/openvpn/blob/release/2.4/Changes.rst>

A full list of changes is available here:

<https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24>

Compared to OpenVPN 2.3 this is a major update with a large number of
new features, improvements and fixes. Some of the major features are
AEAD (GCM) cipher and Elliptic Curve DH key exchange support, improved
IPv4/IPv6 dual stack support and more seamless connection migration when
client's IP address changes (Peer-ID). Also, the new --tls-crypt feature
can be used to increase users' connection privacy.

OpenVPN GUI bundled with the Windows installer has a large number of new
features compared to the one bundled with OpenVPN 2.3. One of major
features is the ability to run OpenVPN GUI without administrator privileges.

For full details, look here:

<https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24>

The new OpenVPN GUI features are documented here:

<https://github.com/OpenVPN/openvpn-gui>

Please note that OpenVPN 2.4 installers will not work on Windows XP.

For generic help use these support channels:

Official documentation:
<http://openvpn.net/index.php/open-source/documentation/howto.html>
Wiki: <https://community.openvpn.net>
Forums: <https://forums.openvpn.net>
User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
User IRC channel: #openvpn at irc.freenode.net

Please report bugs and ask development questions here:

Bug tracker and wiki: <https://community.openvpn.net>
Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
Freenode registration)

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------D01E5FD8DFD05B4256920E6E
Content-Type: text/plain; charset=UTF-8;
 name="openvpn-2.4.5-changelog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="openvpn-2.4.5-changelog"

QW50b25pbyBRdWFydHVsbGkgKDQpOgogICAgICByZWxvYWQgSFRUUCBwcm94eSBjcmVkZW50
aWFscyB3aGVuIG1vdmluZyB0byB0aGUgbmV4dCBjb25uZWN0aW9uIHByb2ZpbGUKICAgICAg
QWxsb3cgbGVhcm5pbmcgaXJvdXRlcyB3aXRoIG5ldHdvcmsgbWFkZSB1cCBvZiBhbGwgMHMg
KG9ubHkgaWYgbmV0Yml0cyA8IDgpCiAgICAgIG1iZWR0bHM6IGZpeCB0eXAwIGluIGNvbW1l
bnQKICAgICAgbWFucGFnZTogZml4IHNpbXBsZSB0eXAwCgpBcm5lIFNjaHdhYmUgKDIpOgog
ICAgICBUcmVhdCBkaGNwLW9wdGlvbiBETlM2IGFuZCBETlMgaWRlbnRpY2FsCiAgICAgIHNo
b3cgdGhlIHJpZ2h0IHN0cmluZyBmb3Iga2V5LWRpcmVjdGlvbgoKQmVydHJhbmQgQm9ubmVm
b3ktQ2xhdWRldCAoMSk6CiAgICAgIEZpeCB0eXBvIGluIGVycm9yIG1lc3NhZ2U6ICJvcHRp
b25lIiAtPiAib3B0aW9uIgoKRGF2aWQgU29tbWVyc2V0aCAoOCk6CiAgICAgIGx6NDogRml4
IGNvbmZ1c2VkIHZlcnNpb24gY2hlY2sKICAgICAgbHo0OiBGaXggYnJva2VuIGJ1aWxkcyB3
aGVuIHBrZy1jb25maWcgaXMgbm90IHByZXNlbnQgYnV0IHN5c3RlbSBsaWJyYXJ5IGlzCiAg
ICAgIFJlbW92ZSByZWZlcmVuY2VzIHRvIGtleWNoYWluLW1jZCBpbiBDaGFuZ2VzLnJzdAog
ICAgICBsejQ6IFJlYmFzZSBjb21wYXQtbHo0IGFnYWluc3QgdXBzdHJlYW0gdjEuNy41CiAg
ICAgIHN5c3RlbWQ6IEFkZCBhbmQgc2hpcCBSRUFETUUuc3lzdGVtZAogICAgICBVcGRhdGUg
Y29weXJpZ2h0IHRvIGluY2x1ZGUgMjAxOCBwbHVzIGNvbXBhbnkgbmFtZSBjaGFuZ2UKICAg
ICAgbWFuOiBBZGQgLlRRIGdyb2ZmIHN1cHBvcnQgbWFjcm8KICAgICAgbWFuOiBSZXdvcmQg
LS1tYW5hZ2VtZW50IHRvIHByZWZlciB1bml4IHNvY2tldHMgb3ZlciBUQ1AKCkVtbWFudWVs
IERlbG9nZXQgKDEpOgogICAgICBPcGVuU1NMOiBjaGVjayBFVlBfUEtFWSBrZXkgdHlwZXMg
YmVmb3JlIHJldHVybmluZyB0aGUgcGtleQoKR2VydCBEb2VyaW5nICgzKToKICAgICAgUmVt
b3ZlIHdhcm5pbmcgb24gcHVzaGVkIHR1bi1pcHY2IG9wdGlvbi4KICAgICAgRml4IHJlbW92
YWwgb2Ygb24tbGluayBwcmVmaXggb24gd2luZG93cyB3aXRoIG5ldHNoCiAgICAgIFByZXBh
cmluZyBmb3IgcmVsZWFzZSB2Mi40LjUgKENoYW5nZUxvZywgdmVyc2lvbi5tNCwgQ2hhbmdl
cy5yc3QpCgpJbHlhIFNoaXBpdHNpbiAoMik6CiAgICAgIHRyYXZpcy1jaTogYWRkIGJyZXcg
Y2FjaGUsIHJlbW92ZSBjY2FjaGUKICAgICAgdHJhdmlzLWNpOiBtb2RpZnkgb3BlbnNzbCBi
dWlsZCBzY3JpcHQgdG8gc3VwcG9ydCBvcGVuc3NsLTEuMS4wCgpKYW1lcyBCb3R0b21sZXkg
KDEpOgogICAgICBhdXRvY29uZjogRml4IGVuZ2luZSBjaGVja3MgZm9yIG9wZW5zc2wgMS4x
CgpKZXJlbWllIENvdXJyZWdlcy1BbmdsYXMgKDIpOgogICAgICBDYXN0IHRpbWVfdCB0byBs
b25nIGxvbmcgaW4gb3JkZXIgdG8gcHJpbnQgaXQuCiAgICAgIEZpeCBidWlsZCB3aXRoIExp
YnJlU1NMCgpTZWx2YSBOYWlyICgxNCk6CiAgICAgIENoZWNrIHdoZXRoZXIgaW4gcHVsbF9t
b2RlIGJlZm9yZSB3YXJuaW5nIGFib3V0IHByZXZpb3VzIGNvbm5lY3Rpb24gYmxvY2tzCiAg
ICAgIEF2b2lkIGlsbGVnYWwgbWVtb3J5IGFjY2VzcyB3aGVuIG1hbGZvcm1lZCBkYXRhIGlz
IHJlYWQgZnJvbSB0aGUgcGlwZQogICAgICBGaXggbWlzc2luZyBjaGVjayBmb3IgcmV0dXJu
IHZhbHVlIG9mIG1hbGxvYydkIGJ1ZmZlcgogICAgICBSZXR1cm4gTlVMTCBpZiBHZXRBZGFw
dGVyc0luZm8gZmFpbHMKICAgICAgVXNlIFJTQV9tZXRoX2ZyZWUgaW5zdGVhZCBvZiBmcmVl
CiAgICAgIEJyaW5nIGNyeXB0b2FwaS5jIHVwdG8gc3BlZWQgd2l0aCBvcGVuc3NsIDEuMQog
ICAgICBBZGQgU1NMX0NUWF9nZXRfbWF4X3Byb3RvX3ZlcnNpb24oKSBub3QgaW4gb3BlbnNz
bCAxLjAKICAgICAgVExTIHYxLjIgc3VwcG9ydCBmb3IgY3J5cHRvYXBpY2VydCAtLSBSU0Eg
b25seQogICAgICBSZWZhY3RvciBnZXRfaW50ZXJmYWNlX21ldHJpYyB0byByZXR1cm4gbWV0
cmljIGFuZCBhdXRvIGZsYWcgc2VwYXJhdGVseQogICAgICBFbnN1cmUgc3RyaW5ncyByZWFk
IGZyb20gcmVnaXN0cnkgYXJlIG51bGwtdGVybWluYXRlZAogICAgICBNYWtlIG1vc3QgcmVn
aXN0cnkgdmFsdWVzIG9wdGlvbmFsCiAgICAgIFVzZSBsb3dlc3QgbWV0cmljIGludGVyZmFj
ZSB3aGVuIG11bHRpcGxlIGludGVyZmFjZXMgbWF0Y2ggYSByb3V0ZQogICAgICBBZGFwdCB0
byBSZWdHZXRWYWx1ZSBicm9rZW5uZXNzIGluIFdpbmRvd3MgNwogICAgICBGaXggZm9ybWF0
IHNwZWMgZXJyb3JzIGluIFdpbmRvd3MgYnVpbGRzCgpTaW1vbiBSb3ptYW4gKDExKToKICAg
ICAgTG9jYWwgZnVuY3Rpb25zIGFyZSBub3Qgc3VwcG9ydGVkIGluIE1TVkMuIEJ1bW1lci4K
ICAgICAgTWl4aW5nIHdpZGUgYW5kIHJlZ3VsYXIgc3RyaW5ncyBpbiBjb25jYXRlbmF0aW9u
cyBpcyBub3QgYWxsb3dlZCBpbiBNU1ZDLgogICAgICBSdGxJcHY2QWRkcmVzc1RvU3RyaW5n
VygpIGFuZCBSdGxJcHY0QWRkcmVzc1RvU3RyaW5nVygpIHJlcXVpcmUgbXN0Y3BpcC5oCiAg
ICAgIFNpbXBsaWZ5IGlwaGxwYXBpLmRsbCBBUEkgY2FsbHMKICAgICAgRml4IGxvY2FsICNp
bmNsdWRlIHRvIHVzZSBxdW90ZWQgZm9ybQogICAgICBEb2N1bWVudCAiPlBBU1NXT1JEOkF1
dGgtVG9rZW4iIHJlYWwtdGltZSBtZXNzYWdlCiAgICAgIEZpeCB0eXBvIGluICJ2ZXJiIiBj
b21tYW5kIGV4YW1wbGVzCiAgICAgIFVuaWZvcm0gc3dwcmludGYoKSBhY3Jvc3MgTWluR1cg
YW5kIE1TVkMgY29tcGlsZXJzCiAgICAgIE1TVkMgbWV0YSBmaWxlcyBhZGRlZCB0byAuZ2l0
aWdub3JlIGxpc3QKICAgICAgb3BlbnZwbnNlcnY6IEFkZCBzdXBwb3J0IGZvciBtdWx0aS1p
bnN0YW5jZXMKICAgICAgRG9jdW1lbnQgbWlzc2luZyBPcGVuVlBOIHN0YXRlcwoKU3RlZmZh
biBLYXJnZXIgKDIxKToKICAgICAgbWFrZSBzdHJ1Y3Qga2V5ICogYXJndW1lbnQgb2YgaW5p
dF9rZXlfY3R4IGNvbnN0CiAgICAgIGJ1ZmZlcl9saXN0X2FnZ3JlZ2F0ZV9zZXBhcmF0b3Io
KTogYWRkIHVuaXQgdGVzdHMKICAgICAgQWRkIC0tdGxzLWNlcnQtcHJvZmlsZSBvcHRpb24u
CiAgICAgIFVzZSBQX0RBVEFfVjIgZm9yIHNlcnZlci0+Y2xpZW50IHBhY2tldHMgdG9vCiAg
ICAgIEZpeCBtZW1vcnkgbGVhayBpbiBidWZmZXIgdW5pdCB0ZXN0cwogICAgICBidWZmZXJf
bGlzdF9hZ2dyZWdhdGVfc2VwYXJhdG9yKCk6IHVwZGF0ZSBsaXN0IHNpemUgYWZ0ZXIgYWdn
cmVnYXRpbmcKICAgICAgYnVmZmVyX2xpc3RfYWdncmVnYXRlX3NlcGFyYXRvcigpOiBkb24n
dCBleGNlZWQgbWF4X2xlbgogICAgICBidWZmZXJfbGlzdF9hZ2dyZWdhdGVfc2VwYXJhdG9y
KCk6IHByZXZlbnQgMC1ieXRlIG1hbGxvYwogICAgICBGaXggdHlwZXMgYXJvdW5kIGJ1ZmZl
cl9saXN0X3B1c2goX2RhdGEpCiAgICAgIHNzbF9vcGVuc3NsOiBmaXggY29tcGlsZXIgd2Fy
bmluZyBieSByZW1vdmluZyBnZXRiaW8oKSB3cmFwcGVyCiAgICAgIHRyYXZpczogdXNlIGNs
YW5nJ3MgLWZzYW5pdGl6ZT1hZGRyZXNzIHRvIGNhdGNoIG1vcmUgYnVncwogICAgICBGaXgg
LS10bHMtdmVyc2lvbi1taW4gYW5kIC0tdGxzLXZlcnNpb24tbWF4IGZvciBPcGVuU1NMIDEu
MSsKICAgICAgQWRkIHN1cHBvcnQgZm9yIFRMUyAxLjMgaW4gLS10bHMtdmVyc2lvbi17bWlu
LCBtYXh9CiAgICAgIFBsdWcgbWVtb3J5IGxlYWsgaWYgcHVzaCBpcyBpbnRlcnJ1cHRlZAog
ICAgICBGaXggZm9ybWF0IGVycm9ycyB3aGVuIGNyb3NzLWNvbXBpbGluZyBmb3IgV2luZG93
cwogICAgICBMb2cgcHJlLWhhbmRzaGFrZSBwYWNrZXQgZHJvcHMgdXNpbmcgRF9NVUxUSV9E
Uk9QUEVECiAgICAgIEVuYWJsZSBzdHJpY3RlciBjb21waWxlciB3YXJuaW5ncyBieSBkZWZh
dWx0CiAgICAgIEdldCByaWQgb2YgYXhfY2hlY2tfY29tcGlsZV9mbGFnLm00CiAgICAgIG1i
ZWR0bHM6IGRvbid0IHVzZSBBUEkgZGVwcmVjYXRlZCBpbiBtYmVkIDIuNwogICAgICBXYXJu
IGlmIHRscy12ZXJzaW9uLW1heCA8IHRscy12ZXJzaW9uLW1pbgogICAgICBEb24ndCB0aHJv
dyBmYXRhbCBlcnJvcnMgZnJvbSBjcmVhdGVfdGVtcF9maWxlKCkKCmhhc2hpeiAoMSk6CiAg
ICAgIEZpeCAnLS1iaW5kIGlwdjZvbmx5JwoK

--------------D01E5FD8DFD05B4256920E6E--

--W0Aa7wk1IJCzKPI41WUz4bUtpCh7uv6LW--

--CQuxdcFTx8gMjC2dXIN99jnNuIRiDgxSb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlqYFWIACgkQKVhNn0CG
RXj7Pgf/btntg/FpAZ9Ef9v7eKr3OSsUJCngr41eO9eTaLfuVj8WzrrphuJdNYui
dkVfkn5gGvPP7/ERIVLj9YCm0087TxZ1tYfZC3Otn0wYD3c/bgEGe3rOohXYAZdM
dWGQsY1QPkKYCK1059y30Y662udeTnVrz8RCL/wDCJpC34grQP3r+rnOTNe6Hp5j
Wken39RkwI0OaWr3uCUG6/8jFsggWCdghA2BOkskHdbVl/sM4cgY9FaPgkLJSSVJ
Y39XM0m9DG6EpOFI5GspkjQTRUwKOr+3Kehod2g9oQrXxyLiFrvnCqhP15rJXceC
D7agB8jI8DjXXsFcLF57J3utiWnpGQ==
=pDFz
-----END PGP SIGNATURE-----

--CQuxdcFTx8gMjC2dXIN99jnNuIRiDgxSb--

