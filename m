From: Christian Lademann <lademann@...76...>
Message-Id: <20040907153222.48676d9a@...268...>
Reply-To: lademann@...76...
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__7_Sep_2004_15_32_22_+0200_=/b5sf_zZz+vBhao"
Subject: [Openvpn-devel] Small hack for OpenVPN-2.0beta11: tun + tcp + inetd + nowait
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Sep  7 06:33:07 2004
To: openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>

This is a multi-part message in MIME format.

--Multipart=_Tue__7_Sep_2004_15_32_22_+0200_=/b5sf_zZz+vBhao
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

here is a small patch, that allows a tun/tcp/inetd/nowait-configuration style.
Some inconveniances are still to be addressed:

  o ifconfig and route cannot be returned by the client-connect-script
    but have to be set right there

  o the visible name of the interface cannot be changed in accordance
    with the connecting client (i.e. 'vpn-cust0' instead of 'tun123')

  o ifconfig-pools and concurrent connections of the same clients
    cannot be handeled from openvpn by itself

On the other hand it gives me different processes and different interfaces
for every conneced client so they can be managed (i.e. killed :-)) separately.

This patch is just a first approach and not fully tested (as most software ;-)).

Excerpt from the config-file:

    dev tun
    inetd nowait
    proto tcp-server
    mode server


Regards,

Christian Lademann

PS.: All submissions and contributions to open-source-projects are released
     under the same license as the respective project.

--Multipart=_Tue__7_Sep_2004_15_32_22_+0200_=/b5sf_zZz+vBhao
Content-Type: application/octet-stream;
 name="openvpn-inetd.diff"
Content-Disposition: attachment;
 filename="openvpn-inetd.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtcnVOIG9wZW52cG4tMi4wX2JldGExMS5vcmlnL210Y3AuYyBvcGVudnBuLTIuMF9iZXRh
MTEvbXRjcC5jCi0tLSBvcGVudnBuLTIuMF9iZXRhMTEub3JpZy9tdGNwLmMJV2VkIEF1ZyAxOCAy
MzoyMzoyNSAyMDA0CisrKyBvcGVudnBuLTIuMF9iZXRhMTEvbXRjcC5jCVR1ZSBTZXAgIDcgMTQ6
Mzk6MzQgMjAwNApAQCAtNTAxLDkgKzUwMSwyMyBAQAogICAgICAgICovCiAgICAgICBpZiAodG91
Y2hlZCAmJiBJU19TSUcgKCZ0b3VjaGVkLT5jb250ZXh0KSkKIAl7CisJICBpbnQgZXhpdF9hZnRl
cl9jbG9zZSA9IDA7CisKKwkgIGlmICh0b3VjaGVkLT5jb250ZXh0LmMyLmxpbmtfc29ja2V0LT5p
bmV0ZCA9PSBJTkVURF9OT1dBSVQpCisJICAgIHsKKwkgICAgICBleGl0X2FmdGVyX2Nsb3NlID0g
MTsKKwkgICAgfQorCiAJICBpZiAobWkgPT0gdG91Y2hlZCkKIAkgICAgbWkgPSBOVUxMOwogCSAg
bXVsdGlfY2xvc2VfaW5zdGFuY2UgKG0sIHRvdWNoZWQsIGZhbHNlKTsKKworCSAgLyoKKwkgICAq
IElmIHRoaXMgc29ja2V0IHJlc3VsdHMgZnJvbSBhbiBpbmV0ZC1ub3dhaXQgLSBjb25uZWN0aW9u
CisJICAgKiBpdCBoYXMgdG8gYmUgdGhlIG9ubHkgb25lIGFuZCB3ZSBoYXZlIHRvIGV4aXQuCisJ
ICAgKi8KKwkgIGlmIChleGl0X2FmdGVyX2Nsb3NlKQorCSAgICBtLT50b3Auc2lnLT5zaWduYWxf
cmVjZWl2ZWQgPSBTSUdURVJNOwogCX0KICAgICB9CiAKZGlmZiAtcnVOIG9wZW52cG4tMi4wX2Jl
dGExMS5vcmlnL29wdGlvbnMuYyBvcGVudnBuLTIuMF9iZXRhMTEvb3B0aW9ucy5jCi0tLSBvcGVu
dnBuLTIuMF9iZXRhMTEub3JpZy9vcHRpb25zLmMJV2VkIEF1ZyAxOCAyMzozMjoxOSAyMDA0Cisr
KyBvcGVudnBuLTIuMF9iZXRhMTEvb3B0aW9ucy5jCVR1ZSBTZXAgIDcgMTU6MjA6MjQgMjAwNApA
QCAtMTAxNywxNSArMTAxNywxOSBAQAogICAgICAgKQogICAgIG1zZyAoTV9VU0FHRSwgIk9wdGlv
bnMgZXJyb3I6IC0taW5ldGQgbm93YWl0IGNhbiBvbmx5IGJlIHVzZWQgaW4gVExTIG1vZGUiKTsK
IAorLyoKICAgaWYgKG9wdGlvbnMtPmluZXRkID09IElORVREX05PV0FJVCAmJiBkZXYgIT0gREVW
X1RZUEVfVEFQKQogICAgIG1zZyAoTV9VU0FHRSwgIk9wdGlvbnMgZXJyb3I6IC0taW5ldGQgbm93
YWl0IG9ubHkgbWFrZXMgc2Vuc2UgaW4gLS1kZXYgdGFwIG1vZGUiKTsKKyovCiAKICAgLyoKICAg
ICogSW4gZm9ya2luZyBUQ1Agc2VydmVyIG1vZGUsIHlvdSBkb24ndCBuZWVkIHRvIGlmY29uZmln
CiAgICAqIHRoZSB0YXAgZGV2aWNlICh0aGUgYXNzdW1wdGlvbiBpcyB0aGF0IGl0IHdpbGwgYmUg
YnJpZGdlZCkuCiAgICAqLworLyoKICAgaWYgKG9wdGlvbnMtPmluZXRkID09IElORVREX05PV0FJ
VCkKICAgICBvcHRpb25zLT5pZmNvbmZpZ19ub2V4ZWMgPSB0cnVlOworKi8KIAogICAvKgogICAg
KiBTYW5pdHkgY2hlY2sgb24gVENQIG1vZGUgb3B0aW9ucwpkaWZmIC1ydU4gb3BlbnZwbi0yLjBf
YmV0YTExLm9yaWcvc29ja2V0LmMgb3BlbnZwbi0yLjBfYmV0YTExL3NvY2tldC5jCi0tLSBvcGVu
dnBuLTIuMF9iZXRhMTEub3JpZy9zb2NrZXQuYwlNb24gQXVnIDE2IDIxOjM5OjM2IDIwMDQKKysr
IG9wZW52cG4tMi4wX2JldGExMS9zb2NrZXQuYwlUdWUgU2VwICA3IDEzOjE1OjEzIDIwMDQKQEAg
LTg0NCw3ICs4NDQsOSBAQAogICAgIHsKICAgICAgIEFTU0VSVCAoYWNjZXB0X2Zyb20pOwogICAg
ICAgQVNTRVJUIChzb2NrLT5pbmZvLnByb3RvID09IFBST1RPX1RDUHY0X1NFUlZFUik7CisvKgog
ICAgICAgQVNTRVJUICghc29jay0+aW5ldGQpOworKi8KICAgICAgIHNvY2stPnNkID0gYWNjZXB0
X2Zyb20tPnNkOwogICAgIH0KIAo=

--Multipart=_Tue__7_Sep_2004_15_32_22_+0200_=/b5sf_zZz+vBhao--

