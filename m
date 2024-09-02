MIME-Version: 1.0
From: Petr Portnov <mrjarviscraft@...277...>
Date: Mon, 2 Sep 2024 22:34:21 +0300
Message-ID: <CAOrkh=VQFEkK9+8NXSLrKyhjoxd_bvj_3ubS=G1AntZJbJ6_8A@...278...>
Content-Type: multipart/mixed; boundary="000000000000c4bde3062128070c"
Subject: [Openvpn-devel] [PATCH] build: reduce hardcode in `asio_path`
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000c4bde3062128070c
Content-Type: multipart/alternative; boundary="000000000000c4bde0062128070a"

--000000000000c4bde0062128070a
Content-Type: text/plain; charset="UTF-8"

Hi there! While working on packaging `openvpn3-linux` for NixOS I've
discovered a problem with `asio_path` child path being too strict (since
not all distros have `asio` as the parent of `include` directory). Thus I
am suggesting a simple patch which allows better control over this path
allowing easier integration with distros.

--000000000000c4bde0062128070a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi there! While working on packaging `openvpn3-linux` for =
NixOS I&#39;ve discovered a problem with `asio_path` child path being too s=
trict (since not all distros have `asio` as the parent of `include` directo=
ry). Thus I am suggesting a simple patch which allows better control over t=
his path allowing easier integration with distros.<br></div>

--000000000000c4bde0062128070a--

--000000000000c4bde3062128070c
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-build-reduce-hardcode-in-asio_path.patch"
Content-Disposition: attachment; 
	filename="0001-build-reduce-hardcode-in-asio_path.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m0leesyy0>
X-Attachment-Id: f_m0leesyy0

RnJvbSAzMGIyNTI4MDU0ZTY2MjdhNzEyNGFjMDRjYjAxODM1NmVmMjNkODY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQZXRyIFBvcnRub3YgPG1yamFydmlzY3JhZnRAZ21haWwuY29t
PgpEYXRlOiBNb24sIDIgU2VwIDIwMjQgMjI6MjU6MzMgKzAzMDAKU3ViamVjdDogW1BBVENIIDEv
MV0gYnVpbGQ6IHJlZHVjZSBoYXJkY29kZSBpbiBgYXNpb19wYXRoYAoKQ3VycmVudGx5LCBgYXNp
b19wYXRoYCB2YXJpYWJsZSB2YWx1ZSBpcyBjb25jYXRlbmF0ZWQgd2l0aCBgL2FzaW8vaW5jbHVk
ZWAKdG8gc3BlY2lmeSB0aGUgcGF0aCB0byBjdXN0b20gYGFzaW9gIGluc3RhbGxhdGlvbi4KVGhl
IHByb2JsZW0gaXMgdGhhdCB0aGlzIGlzIHRvbyBzdHJpY3QgYXMgc29tZSBkaXN0cm9zIChuYW1l
bHkgTml4T1MpCm1heSBoYXZlIHRoZSBgaW5jbHVkZWAgZGlyZWN0b3J5IHdpdGggYSBkaWZmZXJl
bnRseSBuYW1lZCBwYXJlbnQuClRodXMgdGhpcyBjaGFuZ2UgbWluaW1pemVzIHRoZSBoYXJkY29k
ZWQgcGFydCBvZiB0aGUgcGF0aCB0byBtYWtlIGl0IG1vcmUgZmxleGlibGUuCgpTaWduZWQtb2Zm
LWJ5OiBQZXRyIFBvcnRub3YgPG1yamFydmlzY3JhZnRAZ21haWwuY29tPgotLS0KIG1lc29uLmJ1
aWxkICAgICAgIHwgMiArLQogbWVzb25fb3B0aW9ucy50eHQgfCAyICstCiAyIGZpbGVzIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tZXNvbi5i
dWlsZCBiL21lc29uLmJ1aWxkCmluZGV4IGM5ZTBhMmQuLmMwMWViOGUgMTAwNjQ0Ci0tLSBhL21l
c29uLmJ1aWxkCisrKyBiL21lc29uLmJ1aWxkCkBAIC03NCw3ICs3NCw3IEBAIGVuZGlmCiAjCiAj
ICBTZXR1cCBhZGRpdGlvbmFsIGluY2x1ZGUgaGVhZGVyIGRpcnMKICMKLWFzaW9faW5jID0gZ2V0
X29wdGlvbignYXNpb19wYXRoJykgLyAnYXNpbycgLyAnaW5jbHVkZScKK2FzaW9faW5jID0gZ2V0
X29wdGlvbignYXNpb19wYXRoJykgLyAnaW5jbHVkZScKIG1lc3NhZ2UgKCdBU0lPIGxpYnJhcnk6
ICcgKyBhc2lvX2luYykKIAogb3BlbnZwbjNfY29yZV9pbmMgPSBnZXRfb3B0aW9uKCdvcGVudnBu
M19jb3JlX3BhdGgnKQpkaWZmIC0tZ2l0IGEvbWVzb25fb3B0aW9ucy50eHQgYi9tZXNvbl9vcHRp
b25zLnR4dAppbmRleCBkOWNmMDJlLi40M2UzMDFlIDEwMDY0NAotLS0gYS9tZXNvbl9vcHRpb25z
LnR4dAorKysgYi9tZXNvbl9vcHRpb25zLnR4dApAQCAtMjYsNyArMjYsNyBAQCBvcHRpb24oJ2Rl
YnVnX29wdGlvbnMnLCB0eXBlOiAnYm9vbGVhbicsIHZhbHVlOiBmYWxzZSwKICMKICMgIEJ1aWxk
IGVudmlyb25tZW50IGFuZCByZWxhdGVkIGJ1aWxkIHRpbWUgb3B0aW9ucwogIwotb3B0aW9uKCdh
c2lvX3BhdGgnLCB0eXBlOiAnc3RyaW5nJywgdmFsdWU6ICcuL3ZlbmRvci9hc2lvJywKK29wdGlv
bignYXNpb19wYXRoJywgdHlwZTogJ3N0cmluZycsIHZhbHVlOiAnLi92ZW5kb3IvYXNpby9hc2lv
JywKICAgICAgICBkZXNjcmlwdGlvbjogJ1BhdGggdG8gdGhlIEFTSU8gaGVhZGVyIGZpbGVzJykK
IAogb3B0aW9uKCdvcGVudnBuM19jb3JlX3BhdGgnLCB0eXBlOiAnc3RyaW5nJywgdmFsdWU6ICcu
L29wZW52cG4zLWNvcmUnLAotLSAKMi40My4wCgo=
--000000000000c4bde3062128070c--

