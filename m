MIME-Version: 1.0
In-Reply-To: <56C0F10F.2080803@...1227...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
	<1454874438-5081-9-git-send-email-steffan@...1856...>
	<56BB3775.5010801@...1227...>
	<CAA1AbxL_S4umZr5Nd0VTvUvXEHjoWmji18GqM6FgmWqntOKqaA@...278...>
	<56C0F10F.2080803@...1227...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 15 Feb 2016 08:11:29 +0100
Message-ID: <CAA1AbxJVCjP=wvtobKamDaroaVX+4VpnuAq1L4v0iRn=DiWKAw@...278...>
Content-Type: multipart/mixed; boundary=001a11409402f97986052bc9ba5e
Subject: Re: [Openvpn-devel] [PATCH 08/10] Add AEAD cipher support (GCM)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a11409402f97986052bc9ba5e
Content-Type: text/plain; charset=UTF-8

On Sun, Feb 14, 2016 at 10:26 PM, Arne Schwabe <arne@...1227...> wrote:
> And we may need another patch for the Changes.rst

Woops, forgot this *again*...  Attached a patch for Changes.rst.  Feel
free to squash this into 8/10 when committing.

-Steffan

--001a11409402f97986052bc9ba5e
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0001-Add-Changes.rst-entry-for-AEAD-cipher-modes.patch"
Content-Disposition: attachment; 
	filename="0001-Add-Changes.rst-entry-for-AEAD-cipher-modes.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iknn6ng00

RnJvbSBkMjY0MDk2MjczYjgyMTNhYzdkNjVmYWIwMDA4MTBiMjdkY2FlNTY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmZmFuIEthcmdlciA8c3RlZmZhbkBrYXJnZXIubWU+CkRh
dGU6IE1vbiwgMTUgRmViIDIwMTYgMDg6MDg6NDEgKzAxMDAKU3ViamVjdDogW1BBVENIXSBBZGQg
Q2hhbmdlcy5yc3QgZW50cnkgZm9yIEFFQUQgY2lwaGVyIG1vZGVzCgpTaWduZWQtb2ZmLWJ5OiBT
dGVmZmFuIEthcmdlciA8c3RlZmZhbkBrYXJnZXIubWU+Ci0tLQogQ2hhbmdlcy5yc3QgfCA3ICsr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9DaGFu
Z2VzLnJzdCBiL0NoYW5nZXMucnN0CmluZGV4IGRkOWI5YjIuLmFmNzBkMTQgMTAwNjQ0Ci0tLSBh
L0NoYW5nZXMucnN0CisrKyBiL0NoYW5nZXMucnN0CkBAIC0zNyw2ICszNywxMyBAQCBXaW5kb3dz
IHZlcnNpb24KICAgICBXaW5kb3dzIHZlcnNpb24gaXMgZGV0ZWN0ZWQsIGxvZ2dlZCBhbmQgcG9z
c2libHkgc2lnbmFsbGVkIHRvIHNlcnZlcgogICAgIChJVl9QTEFUX1ZFUj08bm4+IGlmIC0tcHVz
aC1wZWVyLWluZm8gaXMgc2V0IG9uIGNsaWVudCkKIAorQUVBRCAoR0NNKSBkYXRhIGNoYW5uZWwg
Y2lwaGVyIHN1cHBvcnQKKyAgICBUaGUgZGF0YSBjaGFubmVsIG5vdyBzdXBwb3J0cyBBRUFEIGNp
cGhlcnMgKGN1cnJlbnRseSBvbmx5IEdDTSkuICBUaGUgQUVBRAorICAgIHBhY2tldCBmb3JtYXQg
aGFzIGEgc21hbGxlciBvdmVyaGVhZCB0aGFuIHRoZSBDQkMgcGFja2V0IGZvcm1hdCwgKGUuZy4g
MjAKKyAgICBieXRlcyBwZXIgcGFja2V0IGZvciBBRVMtMTI4LUdDTSBpbnN0ZWFkIG9mIDM2IGJ5
dGVzIHBlciBwYWNrZXQgZm9yCisgICAgQUVTLTEyOC1DQkMgKyBITUFDLVNIQTEpLgorCisKIFVz
ZXItdmlzaWJsZSBDaGFuZ2VzCiAtLS0tLS0tLS0tLS0tLS0tLS0tLQogLSBGb3IgY2VydGlmaWNh
dGUgRE5zIHdpdGggZHVwbGljYXRlIGZpZWxkcywgZS5nLiAiT1U9b25lLE9VPXR3byIsIGJvdGgg
ZmllbGRzCi0tIAoyLjUuMAoK
--001a11409402f97986052bc9ba5e--

