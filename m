MIME-Version: 1.0
In-Reply-To: <015601d0b436$d555ad60$80010820$@gmail.com>
References: <015601d0b436$d555ad60$80010820$@gmail.com>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 1 Jul 2015 23:28:28 +0200
Message-ID: <CAA1AbxKrPXnc1+PPH4dQV1OksY_0t3ewqRnqVrjhZL+i2Pbkmw@...278...>
Content-Type: multipart/mixed; boundary=001a1141bc34228f020519d702f0
Subject: Re: [Openvpn-devel] Compiling issue on Visual Studio 2010
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish Wang <fish.thss@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a1141bc34228f020519d702f0
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 1, 2015 at 9:47 PM, Fish Wang <fish.thss@...277...> wrote:
> The following patch resolves this issue.

I think we can do this more simple and robust.  See the attached
patch.  Can you please report if that works for you?  Thanks.

-Steffan

--001a1141bc34228f020519d702f0
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0001-Make-__func__-work-with-Visual-Studio-too.patch"
Content-Disposition: attachment; 
	filename="0001-Make-__func__-work-with-Visual-Studio-too.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ibl9yzju0

RnJvbSA2ZTAwNzMxNjNkZDNjMTNhOTU3ZjhiMTc2MGE4MWE1ZWYxNmU2NWE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmZmFuIEthcmdlciA8c3RlZmZhbkBrYXJnZXIubWU+CkRh
dGU6IFdlZCwgMSBKdWwgMjAxNSAyMzoyNTo1NiArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIE1ha2Ug
X19mdW5jX18gd29yayB3aXRoIFZpc3VhbCBTdHVkaW8gdG9vCgpCZWNhdXNlIGV2ZW4gVlMyMDEz
IGlzIGluY2FwYWJsZSBvZiBkb2luZyBDOTkuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmZmFuIEthcmdl
ciA8c3RlZmZhbkBrYXJnZXIubWU+Ci0tLQogc3JjL29wZW52cG4vc3lzaGVhZC5oIHwgNCArKysr
CiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc3JjL29wZW52
cG4vc3lzaGVhZC5oIGIvc3JjL29wZW52cG4vc3lzaGVhZC5oCmluZGV4IGNmMjkxMzEuLmZmMGJm
NDEgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVudnBuL3N5c2hlYWQuaAorKysgYi9zcmMvb3BlbnZwbi9z
eXNoZWFkLmgKQEAgLTQ1LDYgKzQ1LDEwIEBACiAjZGVmaW5lIHNyYW5kb20gc3JhbmQKICNlbmRp
ZgogCisjaWZkZWYgX01TQ19WRVIgLy8gVmlzdWFsIFN0dWRpbworI2RlZmluZSBfX2Z1bmNfXyBf
X0ZVTkNUSU9OX18KKyNlbmRpZgorCiAjaWYgZGVmaW5lZChfX0FQUExFX18pCiAjaWYgX19FTlZJ
Uk9OTUVOVF9NQUNfT1NfWF9WRVJTSU9OX01JTl9SRVFVSVJFRF9fID49IDEwNzAKICNkZWZpbmUg
X19BUFBMRV9VU0VfUkZDXzM1NDIgIDEKLS0gCjIuMS40Cgo=
--001a1141bc34228f020519d702f0--

