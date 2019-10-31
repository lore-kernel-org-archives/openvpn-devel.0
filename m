From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <6a1b6995-67c1-e30b-bdc1-af1d5485fda5@...515...>
Date: Thu, 31 Oct 2019 12:27:22 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wP9wzpmrrLSSz0SBqvav1FuxSFc4tLWDU"
Subject: [Openvpn-devel] OpenVPN 2.4.8 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wP9wzpmrrLSSz0SBqvav1FuxSFc4tLWDU
Content-Type: multipart/mixed; boundary="rwUYNvRfSdiIcrUQdVjVWccdnBk5hKRHm";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net,
 openvpn-announce@lists.sourceforge.net
Message-ID: <6a1b6995-67c1-e30b-bdc1-af1d5485fda5@...515...>
Subject: OpenVPN 2.4.8 released

--rwUYNvRfSdiIcrUQdVjVWccdnBk5hKRHm
Content-Type: multipart/mixed;
 boundary="------------084C8101308F008344FE0189"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------084C8101308F008344FE0189
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.4.8. It
can be downloaded from here:

<https://openvpn.net/community-downloads/>

This is primarily a maintenance release with bugfixes and improvements.
The Windows installers (I601) have several improvements compared to the
previous release:

* New tap-windows6 driver (9.24.2) which fixes some suspend and resume
issues
* Latest OpenVPN-GUI
* Considerable performance boost due to new compiler optimization flags

A summary of all included changes is available here:

<https://github.com/OpenVPN/openvpn/blob/release/2.4/Changes.rst>

A full list of changes is available here:

<https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24>

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


Samuli

--------------084C8101308F008344FE0189
Content-Type: text/plain; charset=UTF-8;
 name="openvpn-2.4.8-changelog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="openvpn-2.4.8-changelog"

QW50b25pbyBRdWFydHVsbGkgKDEpOgogICAgICBtYmVkdGxzOiBmaXggc2VnZmF1bHQgYnkg
Y2FsbGluZyBtYmVkdGxzX2NpcGhlcl9mcmVlKCkgaW4gY2lwaGVyX2N0eF9mcmVlKCkKCkFy
bmUgU2Nod2FiZSAoMSk6CiAgICAgIFJlbW92ZSAtbm8tY3BwLXByZWNvbXAgZmxhZyBmcm9t
IERhcndpbiBidWlsZHMKCkRhdmlkIFNvbW1lcnNldGggKDMpOgogICAgICBjbGVhbnVwOiBS
ZW1vdmUgUlBNIG9wZW52cG4uc3BlYyBidWlsZCBhcHByb2FjaAogICAgICBkb2NzOiBVcGRh
dGUgSU5TVEFMTAogICAgICBidWlsZDogUGFja2FnZSBtaXNzaW5nIG1vY2tfbXNnLmgKCkdl
cnQgRG9lcmluZyAoNSk6CiAgICAgIHJlcGFpciB3aW5kb3dzIGJ1aWxkcyAoMi40KQogICAg
ICBJbmNyZWFzZSBsaXN0ZW4oKSBiYWNrbG9nIHF1ZXVlIHRvIDMyCiAgICAgIEZvcmNlIGNv
bWJpbmF0aW9uYXRpb24gb2YgLS1zb2Nrcy1wcm94eSBhbmQgLS1wcm90byBVRFAgdG8gdXNl
IElQdjQuCiAgICAgIEZpeCBJUHY2IHJvdXRlcyBvbiB0YXAgaW50ZXJmYWNlcyBvbiBPcGVu
U29sYXJpcy9PcGVuSW5kaWFuYQogICAgICBwcmVwYXJpbmcgcmVsZWFzZSB2Mi40LjggKENo
YW5nZUxvZywgdmVyc2lvbi5tNCwgQ2hhbmdlcy5yc3QpCgpHaXNsZSBWYW5lbSAoMSk6CiAg
ICAgIFdyb25nIEZJTEVUWVBFIGluIC5yYyBmaWxlcwoKSGlsa28gQmVuZ2VuICgxKToKICAg
ICAgRG8gbm90IHNldCBwa2NzMTEtaGVscGVyICdzYWZlIGZvcmsgbW9kZScKCklseWEgU2hp
cGl0c2luICgyKToKICAgICAgdHJhdmlzLWNpOiBhZGQgImxpbnV4LXBwYzY0bGUiIHRvIGJ1
aWxkIG1hdHJpeCwgY2hhbmdlIHRydXN0eSBpbWFnZSB0byB4ZW5pYWwsIHVwZGF0ZSBvc3gg
dG8geGNvZGU5LjQgYW5kIG1vZGVybml6ZSBicmV3IG1hbmFnZW1lbnQKICAgICAgdHJhdmlz
LWNpOiBmaXggb3N4IGJ1aWxkcwoKS3lsZSBFdmFucyAoMSk6CiAgICAgIHRlc3RzL3RfbHBi
YWNrLnNoOiBTd2l0Y2ggc2VkKDEpIHRvIFBPU0lYLWNvbXBhdGlibGUgcmVnZXguCgpMZXYg
U3RpcGFrb3YgKDEpOgogICAgICBGaXggdmFyaW91cyBjb21waWxlciB3YXJuaW5ncwoKTWF0
dGhpYXMgQW5kcmVlICgxKToKICAgICAgRml4IHJlZ3Jlc3Npb24sIHJlaW5zdGF0ZSBMaWJy
ZVNTTCBzdXBwb3J0LgoKTWljaGFsIFNvbHR5cyAoMSk6CiAgICAgIG1hbjogY29ycmVjdCB0
aGUgZGVzY3JpcHRpb24gb2YgLS1jYXBhdGggYW5kIC0tY3JsLXZlcmlmeSByZWdhcmRpbmcg
Q1JMcwoKTXlrb2xhIEJhaWJ1eiAoMSk6CiAgICAgIEZpeCB0eXBvIGluIE5UTE0gcHJveHkg
ZGVidWcgbWVzc2FnZQoKUmljaGFyZCBCb25ob21tZSAoMSk6CiAgICAgIElnbm9yZSAtLXB1
bGwtZmlsdGVyIGZvciAtLW1vZGUgc2VydmVyCgpSb3NlbiBQZW5ldiAoMSk6CiAgICAgIG9w
ZW5zc2w6IEZpeCBjb21waWxhdGlvbiB3aXRob3V0IGRlcHJlY2F0ZWQgT3BlblNTTCAxLjEg
QVBJcwoKU2VsdmEgTmFpciAoMyk6CiAgICAgIEJldHRlciBlcnJvciBtZXNzYWdlIHdoZW4g
c2NyaXB0IGZhaWxzIGR1ZSB0byBzY3JpcHQtc2VjdXJpdHkgc2V0dGluZwogICAgICBDb3Jy
ZWN0IHRoZSByZXR1cm4gdmFsdWUgb2YgY3J5cHRvYXBpIFJTQSBzaWduYXR1cmUgY2FsbGJh
Y2tzCiAgICAgIEhhbmRsZSBQU1MgcGFkZGluZyBpbiBjcnlwdG9hcGljZXJ0CgpTdGVmZmFu
IEthcmdlciAoMSk6CiAgICAgIGNtb2NrYTogdXNlIHJlbGF0aXZlIHBhdGhzCgpUaG9tYXMg
UXVpbm90ICgxKToKICAgICAgRml4IGRvY3VtZW50YXRpb24gb2YgdGxzLXZlcmlmeSBzY3Jp
cHQgYXJndW1lbnQKCg==

--------------084C8101308F008344FE0189--

--rwUYNvRfSdiIcrUQdVjVWccdnBk5hKRHm--

--wP9wzpmrrLSSz0SBqvav1FuxSFc4tLWDU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl26twoACgkQKVhNn0CG
RXhKXQf9Eh8P4i+9u1hJbQTyKZDLuL0HmIOcXt2NMGICG/HGYFjLnZOBGhYgpUZS
SDJQwReQBYymZpYDcmErOK0RcxTh7hpkLJNzAjfLebvDQ16NfKUOCyiPRjSKRRAa
bDe/wC/6WELhsS/JlrsCY2N1FBIXzKF3Z8uP4l7A2toDdBIiz/byP+mYMGNsu/qE
JCJUN9J7WFENYvBPAWGNq4xLkKLYPb9o9tXteZkiy7VQLTc8wzZekaRmXkqbWPaN
PIyVsADtwSOaKGjLLmOx5JWhXq2zcCXN9O5yUizcjMAfMrKJoKc4RDX0vn7bHR7z
Gjn0ai+M294jY57K+qo3j1SrjgFcaw==
=l8SC
-----END PGP SIGNATURE-----

--wP9wzpmrrLSSz0SBqvav1FuxSFc4tLWDU--

