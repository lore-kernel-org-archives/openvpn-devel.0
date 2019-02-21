From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <ef819f31-d8e8-4926-ecef-df20f3237564@...515...>
Date: Thu, 21 Feb 2019 11:36:47 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Qs1e5PNJQ6yaK7vlAKUvJolDPrpPSQv8c"
Subject: [Openvpn-devel] OpenVPN 2.4.7 released
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
--Qs1e5PNJQ6yaK7vlAKUvJolDPrpPSQv8c
Content-Type: multipart/mixed; boundary="MTh7zUuEHJDbPJFYOPM9nOivdKCeJLgws";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net,
 openvpn-announce@lists.sourceforge.net
Message-ID: <ef819f31-d8e8-4926-ecef-df20f3237564@...515...>
Subject: OpenVPN 2.4.7 released

--MTh7zUuEHJDbPJFYOPM9nOivdKCeJLgws
Content-Type: multipart/mixed;
 boundary="------------7DFBC506C2D804066B2E2F89"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7DFBC506C2D804066B2E2F89
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.4.7. It
can be downloaded from here:

<https://openvpn.net/community-downloads/>

This is primarily a maintenance release with bugfixes and improvements.
One of the big things is enhanced TLS 1.3 support

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

--------------7DFBC506C2D804066B2E2F89
Content-Type: text/plain; charset=UTF-8;
 name="openvpn-2.4.7-changelog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="openvpn-2.4.7-changelog"

QWRhbSBDaWFyY2luzIFza2kgKDEpOgogICAgICBGaXggc3VibmV0IHRvcG9sb2d5IG9uIE5l
dEJTRCAoMi40KS4KCkFudG9uaW8gUXVhcnR1bGxpICgzKToKICAgICAgYWRkIHN1cHBvcnQg
Zm9yICVsdSBpbiBhcmd2X3ByaW50ZiBhbmQgcHJldmVudCBBU1NFUlQKICAgICAgYnVmZmVy
X2xpc3Q6IGFkZCBmdW5jdGlvbnMgZG9jdW1lbnRhdGlvbgogICAgICBpZmNvbmZpZy1pcHY2
KC1wdXNoKTogYWxsb3cgdXNpbmcgaG9zdG5hbWVzCgpBcm5lIFNjaHdhYmUgKDcpOgogICAg
ICBQcm9wZXJseSBmcmVlIHR1bnRhcCBzdHJ1Y3Qgb24gYW5kcm9pZCB3aGVuIGVtdWxhdGlu
ZyBwZXJzaXN0LXR1bgogICAgICBBZGQgT3BlblNTTCBjb21wYXQgZGVmaW5pdGlvbiBmb3Ig
UlNBX21ldGhfc2V0X3NpZ24KICAgICAgQWRkIHN1cHBvcnQgZm9yIHRscy1jaXBoZXJzdWl0
ZXMgZm9yIFRMUyAxLjMKICAgICAgQWRkIGJldHRlciBzdXBwb3J0IGZvciBzaG93aW5nIFRM
UyAxLjMgY2lwaGVyc3VpdGVzIGluIC0tc2hvdy10bHMKICAgICAgVXNlIHJpZ2h0IGZ1bmN0
aW9uIHRvIHNldCBUTFMxLjMgcmVzdHJpY3Rpb25zIGluIHNob3ctdGxzCiAgICAgIEFkZCBt
ZXNzYWdlIGV4cGxhaW5pbmcgZWFybHkgVExTIGNsaWVudCBoZWxsbyBmYWlsdXJlCiAgICAg
IEZhbGxiYWNrIHRvIHBhc3N3b3JkIGF1dGhlbnRpY2F0aW9uIHdoZW4gYXV0aC10b2tlbiBm
YWlscwoKQ2hyaXN0aWFuIEVocmhhcmR0ICgxKToKICAgICAgc3lzdGVtZDogZXh0ZW5kIENh
cGFiaWxpdHlCb3VuZGluZ1NldCBmb3IgYXV0aF9wYW0KCkRhdmlkIFNvbW1lcnNldGggKDEp
OgogICAgICBwbHVnaW46IEV4cG9ydCBiYXNlNjQgZW5jb2RlIGFuZCBkZWNvZGUgZnVuY3Rp
b25zCgpHZXJ0IERvZXJpbmcgKDQpOgogICAgICBBZGQgJWQsICV1IGFuZCAlbHUgdGVzdHMg
dG8gdGVzdF9hcmd2IHVuaXQgdGVzdHMuCiAgICAgIEZpeCBjb21iaW5hdGlvbiBvZiAtLWRl
diB0YXAgYW5kIC0tdG9wb2xvZ3kgc3VibmV0IGFjcm9zcyBtdWx0aXBsZSBwbGF0Zm9ybXMu
CiAgICAgIEFkZCAncHJpbnRpbmcgb2YgcG9ydCBudW1iZXInIHRvIG1yb3V0ZV9hZGRyX3By
aW50X2V4KCkgZm9yIHY0LW1hcHBlZCB2Ni4KICAgICAgcHJlcGFyaW5nIHJlbGVhc2UgdjIu
NC43IChDaGFuZ2VMb2csIHZlcnNpb24ubTQsIENoYW5nZXMucnN0KQoKR2VydCB2YW4gRGlq
ayAoMSk6CiAgICAgIE1pbm9yIHJlbGlhYmlsaXR5IGxheWVyIGRvY3VtZW50YXRpb24gZml4
ZXMKCkphbWVzIEJla2tlbWEgKDEpOgogICAgICBSZXNvbHZlcyBzbWFsbCBJVl9HVUlfVkVS
IHR5cG8gaW4gdGhlIGRvY3VtZW50YXRpb24uCgpKb25hdGhhbiBLLiBCdWxsYXJkICgxKToK
ICAgICAgQ2xhcmlmeSBhbmQgZXhwYW5kIG1hbmFnZW1lbnQgaW50ZXJmYWNlIGRvY3VtZW50
YXRpb24KCkxldiBTdGlwYWtvdiAoNSk6CiAgICAgIFJlZmFjdG9yIE5DUC1uZWdvdGlhYmxl
IG9wdGlvbnMgaGFuZGxpbmcKICAgICAgaW5pdC5jOiByZWZpbmUgZnVuY3Rpb25zIG5hbWVz
IGFuZCBkZXNjcmlwdGlvbgogICAgICBpbnRlcmFjdGl2ZS5jOiBmaXggdXNhZ2Ugb2YgcG90
ZW50aWFsbHkgdW5pbml0aWFsaXplZCB2YXJpYWJsZQogICAgICBvcHRpb25zLmM6IGZpeCBi
cm9rZW4gdW5hcnkgbWludXMgdXNhZ2UKICAgICAgUmVtb3ZlIGV4dHJhIHRva2VuIGFmdGVy
ICNlbmRpZgoKUmljaGFyZCB2YW4gZGVuIEJlcmcgdmlhIE9wZW52cG4tZGV2ZWwgKDEpOgog
ICAgICBGaXggZXJyb3IgbWVzc2FnZSB3aGVuIHVzaW5nIFJIRUwgaW5pdCBzY3JpcHQKClNh
bXkgTWFobW91ZGkgKDEpOgogICAgICBtYW46IGNvcnJlY3QgYSAtLXJlZGlyZWN0aW9uLWdh
dGV3YXkgb3B0aW9uIGZsYWcKClNlbHZhIE5haXIgKDcpOgogICAgICBSZXBsYWNlIE1fREVC
VUcgd2l0aCBEX0xPVyBhcyB0aGUgZm9ybWVyIGlzIHRvbyB2ZXJib3NlCiAgICAgIENvcnJl
Y3QgdGhlIGRlY2xhcmF0aW9uIG9mIGhhbmRsZSBpbiAnc3RydWN0IG9wZW52cG5fcGx1Z2lu
X2FyZ3Nfb3Blbl9yZXR1cm4nCiAgICAgIEJ1bXAgdmVyc2lvbiBvZiBvcGVudnBuIHBsdWdp
biBhcmd1bWVudCBzdHJ1Y3RzIHRvIDUKICAgICAgTW92ZSBnZXQgc3lzdGVtIGRpcmVjdG9y
eSB0byBhIHNlcGFyYXRlIGZ1bmN0aW9uCiAgICAgIEVuYWJsZSBkaGNwIG9uIHRhcCBhZGFw
dGVyIHVzaW5nIGludGVyYWN0aXZlIHNlcnZpY2UKICAgICAgUGFzcyB0aGUgaGFzaCB3aXRo
b3V0IHRoZSBEaWdlc3RJbmZvIGhlYWRlciB0byBOQ3J5cHRTaWduSGFzaCgpCiAgICAgIFdo
aXRlLWxpc3QgcHVsbC1maWx0ZXIgYW5kIHNjcmlwdC1zZWN1cml0eSBpbiBpbnRlcmFjdGl2
ZSBzZXJ2aWNlCgpTaW1vbiBSb3ptYW4gKDIpOgogICAgICBBZGQgSW50ZXJhY3RpdmUgU2Vy
dmljZSBkZXZlbG9wZXIgZG9jdW1lbnRhdGlvbgogICAgICBEZXRlY3QgVEFQIGludGVyZmFj
ZXMgd2l0aCByb290LWVudW1lcmF0ZWQgaGFyZHdhcmUgSUQKClN0ZWZmYW4gS2FyZ2VyICg3
KToKICAgICAgbWFuOiBhZGQgc2VjdXJpdHkgY29uc2lkZXJhdGlvbnMgdG8gLS1jb21wcmVz
cyBzZWN0aW9uCiAgICAgIG1iZWR0bHM6IHByaW50IHdhcm5pbmcgaWYgcmFuZG9tIHBlcnNv
bmFsaXNhdGlvbiBmYWlscwogICAgICBGaXggbWVtb3J5IGxlYWsgYWZ0ZXIgc2lnaHVwCiAg
ICAgIHRyYXZpczogYWRkIE9wZW5TU0wgMS4xIFdpbmRvd3MgYnVpbGQKICAgICAgRml4IC0t
ZGlzYWJsZS1jcnlwdG8gYnVpbGQKICAgICAgRG9uJ3QgcHJpbnQgT0NDIHdhcm5pbmdzIGFi
b3V0ICdrZXktbWV0aG9kJywgJ2tleWRpcicgYW5kICd0bHMtYXV0aCcKICAgICAgYnVmZmVy
X2xpc3RfYWdncmVnYXRlX3NlcGFyYXRvcigpOiBzaW1wbGlmeSBjb2RlCgo=

--------------7DFBC506C2D804066B2E2F89--

--MTh7zUuEHJDbPJFYOPM9nOivdKCeJLgws--

--Qs1e5PNJQ6yaK7vlAKUvJolDPrpPSQv8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlxucS8ACgkQKVhNn0CG
RXh1nAgAhWD4nMSHRok7EMsJ05GWwDk9bvro1r3R5AwXCKTEN1rwRD/x40Rilvxv
l+gzlQ51CWOCReDpzNpKAoTgSXKxH+Hmiv+dVsCZv691qXWeBEnQoZOm9RZ2alNN
b4Tnkq/6A2phSpWODG+Xgodr8jwcyBHvfHsLEMbGAh+oMRhfa7V7sUuhzKF6ky2d
tUO9mMwiogMny65qLO8wcN7JJwZKF8DfhpVKpiojnZFIlSgT53A3/rMDwqyPiNZr
Ba2daqOfUeatTvG2PtHc5byMolo+fX8/MeciyxGPC0agO7sq0qc/mAtnSGukFVyI
/3Ci3XpZQtHod/5+VNak9IzYOIE3UQ==
=Dn54
-----END PGP SIGNATURE-----

--Qs1e5PNJQ6yaK7vlAKUvJolDPrpPSQv8c--

