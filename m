Message-ID: <5363A382.60106@...515...>
Date: Fri, 02 May 2014 16:54:10 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000909090908010508080303"
Subject: [Openvpn-devel] OpenVPN 2.3.4 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-announce@lists.sourceforge.net" <openvpn-announce@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000909090908010508080303
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The OpenVPN community project team is proud to release OpenVPN 2.3.4.
It can be downloaded from here:

<http://openvpn.net/index.php/open-source/downloads.html>

The most important change in this release is that TLS version
negotiation is no longer used unless it's explicitly turned on in the
configuration files, thus reverting back to the 2.3.2 behaviour as
interoperability issues were encountered in 2.3.3. Other notable
changes include addition of SSL library version reporting, fixing of
SOCKSv5 authentication logic and making serial env exporting
consistent between OpenSSL and PolarSSL. This release also contains a
number of other bug fixes and small enhancements.

The Windows installer I001 has additional code to prevent problems
during install and uninstall if installer bitness is wrong or if the
OpenVPN-GUI or an OpenVPN process is running. The Windows installers
also bundle OpenSSL 1.0.1g, which means that they are immune to the
heartbleed vulnerability:

<http://heartbleed.com/>
<https://community.openvpn.net/openvpn/wiki/heartbleed>

All Windows users of OpenVPN 2.3-rc2-I001 through OpenVPN 2.3.2-I003
should upgrade their installations immediately.

Experimental Windows installers with NDIS 6 -enabled tap-windows
drivers are also available for Windows Vista and above, here:

<https://community.openvpn.net/openvpn/wiki/ExperimentalVersions>

Note that it is possible, even if unlikely, that the NDIS 6 drivers
could crash, giving a BSOD. Long story short: please do not use them
on valuable production systems.

A full list of changes is available here:

<https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn23>

The changelog is also attached to this email.

For generic help use these support channels:

- - Official documentation:
<http://openvpn.net/index.php/open-source/documentation/howto.html>
- - Wiki: <https://community.openvpn.net>
- - Forums: <https://forums.openvpn.net>
- - User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
- - User IRC channel: #openvpn at irc.freenode.net

Please report bugs and ask development questions here:

- - Bug tracker and Wiki: <https://community.openvpn.net>
- - Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
- - Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
  Freenode registration)

- --=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNjo4EACgkQwp2X7RmNIqNOuACeM190nx7c4RPcSQ+x/JS4c1W5
ozoAn0Ep1W3PxFWaalXEoMo0JL/KtS82
=3D8CX/
-----END PGP SIGNATURE-----

--------------000909090908010508080303
Content-Type: text/plain; charset=UTF-8;
 name="openvpn-2.3.4-changelog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="openvpn-2.3.4-changelog"

QXJuZSBTY2h3YWJlICgxKToKICAgICAgRml4IG1hbiBwYWdlIGFuZCBPU0NQIHNjcmlwdDog
dGxzX3NlcmlhbF97bn0gaXMgZGVjaW1hbAoKRG1pdHJpaiBUZWpibHVtICgxKToKICAgICAg
Rml4IGlzX2lwdjYgaW4gY2FzZSBvZiB0YXAgaW50ZXJmYWNlLgoKR2VydCBEb2VyaW5nICg4
KToKICAgICAgSVB2NiBhZGRyZXNzL3JvdXRlIGRlbGV0ZSBmaXggZm9yIFdpbjgKICAgICAg
QWRkIFNTTCBsaWJyYXJ5IHZlcnNpb24gcmVwb3J0aW5nLgogICAgICBNaW5vciB0X2NsaWVu
dC5zaCBjbGVhbnVwcwogICAgICBSZXBhaXIgLS1tdWx0aWhvbWUgb24gRnJlZUJTRCBmb3Ig
SVB2NCBzb2NrZXRzLgogICAgICBSZXdyaXRlIG1hbnBhZ2Ugc2VjdGlvbiBhYm91dCAtLW11
bHRpaG9tZQogICAgICBNb3JlIElQdjYtcmVsYXRlZCB1cGRhdGVzIHRvIHRoZSBvcGVudnBu
IG1hbiBwYWdlLgogICAgICBDb25kaXRpb25hbGl6ZSBjYWxscyB0byBwcmludF9kZWZhdWx0
X2dhdGV3YXkgb24gIUVOQUJMRV9TTUFMTAogICAgICBQcmVwYXJpbmcgZm9yIHJlbGVhc2Ug
djIuMy40IChDaGFuZ2VMb2csIHZlcnNpb24ubTQpCgpKYW1lcyBZb25hbiAoMik6CiAgICAg
IFVzZSBuYXRpdmUgc3RydG91bGwoKSB3aXRoIE1TVkMgMjAxMy4KICAgICAgV2hlbiB0bHMt
dmVyc2lvbi1taW4gaXMgdW5zcGVjaWZpZWQsIHJldmVydCB0byBvcmlnaW5hbCB2ZXJzaW9u
aW5nIGFwcHJvYWNoLgoKU3RlZmZhbiBLYXJnZXIgKDQpOgogICAgICBDaGFuZ2Ugc2lnbmVk
bmVzcyBvZiBoYXNoIGluIHg1MDlfZ2V0X3NoYTFfaGFzaCgpLCBmaXhlcyBjb21waWxlciB3
YXJuaW5nLgogICAgICBGaXggT0NTUF9jaGVjay5zaCB0byBhbHNvIHVzZSBkZWNpbWFsIGZv
ciBzdGRvdXQgdmVyaWZpY2F0aW9uLgogICAgICBGaXggYnVpbGQgc3lzdGVtIHRvIGFjY2Vw
dCBub24tc3lzdGVtIGNyeXB0byBsaWJyYXJ5IGxvY2F0aW9ucyBmb3IgcGx1Z2lucy4KICAg
ICAgTWFrZSBzZXJpYWwgZW52IGV4cG9ydGluZyBjb25zaXN0ZW50IGFtb25nc3QgT3BlblNT
TCBhbmQgUG9sYXJTU0wgYnVpbGRzLgoKWWF3bmluZyBBbmdlbCAoMSk6CiAgICAgIEZpeCBT
T0NLU3Y1IG1ldGhvZCBzZWxlY3Rpb24KCmthbmdzdGVyaXplciAoMSk6CiAgICAgIEZpeCB0
eXBvIGluIHNhbXBsZSBidWlsZCBzY3JpcHQgdG8gdXNlIExERkxBR1MKCg==
--------------000909090908010508080303
Content-Type: application/pgp-signature;
 name="openvpn-2.3.4-changelog.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="openvpn-2.3.4-changelog.sig"

iEYEABECAAYFAlNjo4IACgkQwp2X7RmNIqOAVgCfXc1v1heuAR78GdV1nVHmQ4/MfV4AnAz7
R3bMbC9lkjrYB3v680KRbU0b
--------------000909090908010508080303--

