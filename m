MIME-Version: 1.0
Date: Tue, 17 Nov 2015 12:32:16 +0000
Message-ID: <CAN-X3HSXj9a1kiKGBJ1eHgoTeA97WmpqQJPCYf5esKYQa8fLjA@...278...>
From: Christian Pellegrin <chripell@...410...>
Content-Type: multipart/mixed; boundary=001a114683d4540bd60524bbb71f
Subject: [Openvpn-devel] [PATCH] Fix info.af == AF_UNSPEC case after commit
	2bed089d31a12c2d0277e36a64964ebab6640f75
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a114683d4540bd60524bbb71f
Content-Type: text/plain; charset=UTF-8

Looks better than just adding AF_UNSPEC case but I noted many other
FIXMEs about AF_UNSPEC that could be solved this way. So let me know
if there is any reason to not use the ai_family field (and just add
the AF_UNSPEC case in set_mtu_discovery)

Thanks!

--001a114683d4540bd60524bbb71f
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Fix-info.af-AF_UNSPEC-case-after-commit-2bed089d31a1.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-info.af-AF_UNSPEC-case-after-commit-2bed089d31a1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ih3cx3no0

RnJvbSA3MDQ0ZTI3MzFlZWFmY2M3Zjg3N2M3ZDhiNzc2NzZmYjVkNGRiZDY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gUGVsbGVncmluIDxjaHJpcGVsbEBnb29nbGUu
Y29tPgpEYXRlOiBUdWUsIDE3IE5vdiAyMDE1IDEyOjEyOjEwICswMDAwClN1YmplY3Q6IFtQQVRD
SF0gRml4IGluZm8uYWYgPT0gQUZfVU5TUEVDIGNhc2UgYWZ0ZXIgY29tbWl0CiAyYmVkMDg5ZDMx
YTEyYzJkMDI3N2UzNmE2NDk2NGViYWI2NjQwZjc1CgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4g
UGVsbGVncmluIDxjaHJpcGVsbEBnb29nbGUuY29tPgotLS0KIHNyYy9vcGVudnBuL3NvY2tldC5j
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvc3JjL29wZW52cG4vc29ja2V0LmMgYi9zcmMvb3BlbnZwbi9zb2NrZXQuYwpp
bmRleCAzZWY3Mjc5Li5jNzg4NWZkIDEwMDY0NAotLS0gYS9zcmMvb3BlbnZwbi9zb2NrZXQuYwor
KysgYi9zcmMvb3BlbnZwbi9zb2NrZXQuYwpAQCAtMTY3MCw3ICsxNjcwLDcgQEAgcGhhc2UyX3Nl
dF9zb2NrZXRfZmxhZ3MgKHN0cnVjdCBsaW5rX3NvY2tldCogc29jaykKICAgICBzZXRfY2xvZXhl
YyAoc29jay0+Y3RybF9zZCk7CiAKICAgLyogc2V0IFBhdGggTVRVIGRpc2NvdmVyeSBvcHRpb25z
IG9uIHRoZSBzb2NrZXQgKi8KLSAgc2V0X210dV9kaXNjb3Zlcl90eXBlIChzb2NrLT5zZCwgc29j
ay0+bXR1X2Rpc2NvdmVyX3R5cGUsIHNvY2stPmluZm8uYWYpOworICBzZXRfbXR1X2Rpc2NvdmVy
X3R5cGUgKHNvY2stPnNkLCBzb2NrLT5tdHVfZGlzY292ZXJfdHlwZSwgc29jay0+aW5mby5sc2Et
PmJpbmRfbG9jYWwtPmFpX2ZhbWlseSk7CiAKICNpZiBFWFRFTkRFRF9TT0NLRVRfRVJST1JfQ0FQ
QUJJTElUWQogICAvKiBpZiB0aGUgT1Mgc3VwcG9ydHMgaXQsIGVuYWJsZSBleHRlbmRlZCBlcnJv
ciBwYXNzaW5nIG9uIHRoZSBzb2NrZXQgKi8KLS0gCjIuNi4wLnJjMi4yMzAuZzNkZDE1YzAKCg==
--001a114683d4540bd60524bbb71f--

