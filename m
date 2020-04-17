From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <0a607581-4179-a97b-1e8b-e19dd6bd85bd@...515...>
Date: Fri, 17 Apr 2020 15:45:15 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gbofdJoTkm4JQqnQGH9bjk65HK3soUCme"
Subject: [Openvpn-devel] OpenVPN 2.4.9 released
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
--gbofdJoTkm4JQqnQGH9bjk65HK3soUCme
Content-Type: multipart/mixed; boundary="Yj4nclatwvuyj3Vd3u9Cesl7oBd3b1VpV"

--Yj4nclatwvuyj3Vd3u9Cesl7oBd3b1VpV
Content-Type: multipart/mixed;
 boundary="------------20EF14A97BF18CBD29A5C782"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------20EF14A97BF18CBD29A5C782
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.4.9. It
can be downloaded from here:

<https://openvpn.net/community-downloads/>

This is primarily a maintenance release with bugfixes and improvements.
This release also fixes a security issue (CVE-2020-11810, trac #1272)
which allows disrupting service of a freshly connected client that has
not yet not negotiated session keys. The vulnerability cannot be used to
inject or steal VPN traffic.

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


--------------20EF14A97BF18CBD29A5C782
Content-Type: text/plain; charset=UTF-8;
 name="openvpn-2.4.9-changelog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="openvpn-2.4.9-changelog"

QW50b25pbyBRdWFydHVsbGkgKDEpOgogICAgICBzb2NrczogdXNlIHRoZSByaWdodCBmdW5j
dGlvbiB3aGVuIHByaW50aW5nIHN0cnVjdCBvcGVudnBuX3NvY2thZGRyCgpBcm5lIFNjaHdh
YmUgKDMpOgogICAgICBGZXRjaCBPcGVuU1NMIHZlcnNpb25zIHZpYSBzb3VyY2Uvb2xkIGxp
bmtzCiAgICAgIEZpeCBPcGVuU1NMIGVycm9yIHN0YWNrIGhhbmRsaW5nIG9mIHRsc19jdHhf
YWRkX2V4dHJhX2NlcnRzCiAgICAgIEZpeCBPcGVuU1NMIDEuMS4xIG5vdCB1c2luZyBhdXRv
IGVsbGlwdGljIGN1cnZlIHNlbGVjdGlvbgoKR2VydCBEb2VyaW5nICgxKToKICAgICAgUHJl
cGFyaW5nIHJlbGVhc2UgdjIuNC45IChDaGFuZ2VMb2csIHZlcnNpb24ubTQsIENoYW5nZXMu
cnN0KQoKTGV2IFN0aXBha292ICg0KToKICAgICAgRml4IGJyb2tlbiBmcmFnbWVudGF0aW9u
IGxvZ2ljIHdoZW4gdXNpbmcgTkNQCiAgICAgIEZpeCBidWlsZGluZyB3aXRoIC0tZW5hYmxl
LWFzeW5jLXB1c2ggaW4gRnJlZUJTRAogICAgICBGaXggYnJva2VuIGFzeW5jIHB1c2ggd2l0
aCBOQ1AgaXMgdXNlZAogICAgICBGaXggaWxsZWdhbCBjbGllbnQgZmxvYXQgKENWRS0yMDIw
LTExODEwKQoKTWF4aW0gUGxvdG5pa292ICgxKToKICAgICAgT3BlblNTTDogRml4IC0tY3Js
LXZlcmlmeSBub3QgbG9hZGluZyBtdWx0aXBsZSBDUkxzIGluIG9uZSBmaWxlCgpTYW50dHUg
TGFra2FsYSAoMSk6CiAgICAgIEZpeCBPcGVuU1NMIHByaXZhdGUga2V5IHBhc3NwaHJhc2Ug
bm90aWNlcwoKU2VsdmEgTmFpciAoNyk6CiAgICAgIFN3YXAgdGhlIG9yZGVyIG9mIGNoZWNr
cyBmb3IgdmFsaWRhdGluZyBpbnRlcmFjdGl2ZSBzZXJ2aWNlIHVzZXIKICAgICAgTW92ZSBx
dWVyeWluZyB1c2VybmFtZS9wYXNzd29yZCBmcm9tIG1hbmFnZW1lbnQgaW50ZXJmYWNlIHRv
IGEgZnVuY3Rpb24KICAgICAgV2hlbiBhdXRoLXVzZXItcGFzcyBmaWxlIGhhcyBubyBwYXNz
d29yZCBxdWVyeSB0aGUgbWFuYWdlbWVudCBpbnRlcmZhY2UgKGlmIGF2YWlsYWJsZSkuCiAg
ICAgIEZpeCBwb3NzaWJseSB1bmluaXRpYWxpemVkIHJldHVybiB2YWx1ZSBpbiBHZXRPcGVu
dnBuU2V0dGluZ3MoKQogICAgICBGaXggcG9zc2libGUgYWNjZXNzIG9mIHVuaW5pdGlhbGl6
ZWQgcGlwZSBoYW5kbGVzCiAgICAgIFNraXAgZXhwaXJlZCBjZXJ0aWZpY2F0ZXMgaW4gV2lu
ZG93cyBjZXJ0aWZpY2F0ZSBzdG9yZQogICAgICBBbGxvdyB1bmljb2RlIHNlYXJjaCBzdHJp
bmcgaW4gLS1jcnlwdG9hcGljZXJ0IG9wdGlvbgoKVG9tIHZhbiBMZWV1d2VuICgxKToKICAg
ICAgbWJlZFRMUzogTWFrZSBzdXJlIFRMUyBzZXNzaW9uIHN1cnZpdmVzIG1vdmUKCldHSCAo
MSk6CiAgICAgIGRvY3M6IEFkZCByZWZlcmVuY2UgdG8gWDUwOV9MT09LVVBfaGFzaF9kaXIo
MykKCg==

--------------20EF14A97BF18CBD29A5C782--

--Yj4nclatwvuyj3Vd3u9Cesl7oBd3b1VpV--

--gbofdJoTkm4JQqnQGH9bjk65HK3soUCme
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl6ZpNsACgkQKVhNn0CG
RXgRcQf+Mw+qL9UCANEUhYXti5/a9vLtkfA6yjsyxf6RUcKC4X1CReQ4r8jiOXOB
ApU6pQnH4JBkpWoTUpfvRjQu/J57O19SPjQZvppJ0ofdqst+KvuDEiM+tK/caJvq
Mc5iMSqiB7nBasP8lCMdrru8udB0RT/G0CAF9rCOIjrT3qvWcYYrmO+8Jsxy4Oso
s0KgIKksm6GV4VADSXdxs4Msc3ak1ZgHibK6KWPz1FCXosdrjCswWYkHGk6jhPRq
xsA5qGtwcvodI4BagW3AF3dBvXeBm9MFPJth/Ze8Bp3wmTiSJsDZJs2yJIGAeNAU
4VugQycm742nBbPYex555bcM1s7b9Q==
=NIgK
-----END PGP SIGNATURE-----

--gbofdJoTkm4JQqnQGH9bjk65HK3soUCme--

