MIME-Version: 1.0
In-Reply-To: <9e0cf0bf0905200345w3d0f7314m75cabed0b6220653@...278...>
References: <4A13BBB4.8020101@...41...>
	<9e0cf0bf0905200345w3d0f7314m75cabed0b6220653@...278...>
Date: Wed, 20 May 2009 16:00:54 +0300
Message-ID: <9e0cf0bf0905200600k2f0a4fe8x3f0d015cd8286fb8@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Content-Type: multipart/mixed; boundary=001636c5b0ee1f06fb046a579eed
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.1_rc16 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <jim@...41...>
Cc: Openvpn-devel@lists.sourceforge.net, OpenVpn-Users <openvpn-users@lists.sourceforge.net>

--001636c5b0ee1f06fb046a579eed
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/09, Alon Bar-Lev <alon.barlev@...277...> wrote:
> On 5/20/09, James Yonan <jim@...41...> wrote:
>  >    5. In cryptoapi.c, renamed CryptAcquireCertificatePrivateKey to
>  >       OpenVPNCryptAcquireCertificatePrivateKey to work around
>  >       a symbol conflict in MinGW-5.1.4.
>
>
> Too much rename.
>  Please revert at GetProcAddress and ERR_PACK.
>

You also forgot the following patch.
This avoid clash with MS constant, exists in psdk and mingw64.
Instead of #undef it, use another name.

Alon.

--001636c5b0ee1f06fb046a579eed
Content-Type: text/x-patch; charset=US-ASCII; name="openvpn-003-windows.patch"
Content-Disposition: attachment; filename="openvpn-003-windows.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fuy1k00k

SW5kZXg6IGEvc3NsLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gYS9zc2wuYwkocmV2aXNpb24gMzQ1MCkKKysr
IGIvc3NsLmMJKHdvcmtpbmcgY29weSkKQEAgLTE2NTMsOCArMTY1Myw4IEBACiAgICAgICByZXR1
cm4gIlNfR09UX0tFWSI7CiAgICAgY2FzZSBTX0FDVElWRToKICAgICAgIHJldHVybiAiU19BQ1RJ
VkUiOwotICAgIGNhc2UgU19OT1JNQUw6Ci0gICAgICByZXR1cm4gIlNfTk9STUFMIjsKKyAgICBj
YXNlIFNfTk9STUFMX09QOgorICAgICAgcmV0dXJuICJTX05PUk1BTF9PUCI7CiAgICAgY2FzZSBT
X0VSUk9SOgogICAgICAgcmV0dXJuICJTX0VSUk9SIjsKICAgICBkZWZhdWx0OgpAQCAtMzU2NCw4
ICszNTY0LDggQEAKIAkJfQogCSAgICAgIGVsc2UgLyogYXNzdW1lIHRoYXQga3MtPnN0YXRlID09
IFNfQUNUSVZFICovCiAJCXsKLQkJICBkbXNnIChEX1RMU19ERUJVR19NRUQsICJTVEFURSBTX05P
Uk1BTCIpOwotCQkgIGtzLT5zdGF0ZSA9IFNfTk9STUFMOworCQkgIGRtc2cgKERfVExTX0RFQlVH
X01FRCwgIlNUQVRFIFNfTk9STUFMX09QIik7CisJCSAga3MtPnN0YXRlID0gU19OT1JNQUxfT1A7
CiAJCSAga3MtPm11c3RfbmVnb3RpYXRlID0gMDsKIAkJfQogCSAgICB9CkluZGV4OiBhL3NzbC5o
Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KLS0tIGEvc3NsLmgJKHJldmlzaW9uIDM0NTApCisrKyBiL3NzbC5oCSh3b3Jr
aW5nIGNvcHkpCkBAIC0yMzAsNyArMjMwLDcgQEAKICNkZWZpbmUgU19TRU5UX0tFWSAgICAgICAg
NAkvKiBjbGllbnQgZG9lcyBTX1NFTlRfS0VZIC0+IFNfR09UX0tFWSAqLwogI2RlZmluZSBTX0dP
VF9LRVkgICAgICAgICA1CS8qIHNlcnZlciBkb2VzIFNfR09UX0tFWSAtPiBTX1NFTlRfS0VZICov
CiAjZGVmaW5lIFNfQUNUSVZFICAgICAgICAgIDYJLyogcmVhZHkgdG8gZXhjaGFuZ2UgZGF0YSBj
aGFubmVsIHBhY2tldHMgKi8KLSNkZWZpbmUgU19OT1JNQUwgICAgICAgICAgNwkvKiBub3JtYWwg
b3BlcmF0aW9ucyAqLworI2RlZmluZSBTX05PUk1BTF9PUCAgICAgICA3CS8qIG5vcm1hbCBvcGVy
YXRpb25zICovCiAKIC8qCiAgKiBBcmUgd2UgcmVhZHkgdG8gcmVjZWl2ZSBkYXRhIGNoYW5uZWwg
cGFja2V0cz8KSW5kZXg6IGEvY29uZmlnLXdpbjMyLmguaW4KPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gYS9jb25m
aWctd2luMzIuaC5pbgkocmV2aXNpb24gMzQ1MCkKKysrIGIvY29uZmlnLXdpbjMyLmguaW4JKHdv
cmtpbmcgY29weSkKQEAgLTMxOCw3ICszMTgsNiBAQAogI2RlZmluZSBTX0lSVVNSIDAKICNkZWZp
bmUgU19JV1VTUiAwCiB0eXBlZGVmIGludCBpbnRwdHJfdDsKLSN1bmRlZiBTX05PUk1BTAogLyog
VmlzdWFsIFN0dWRpbyAyMDA1IHN1cHBvcnRzIHZhcmFyZyBtYWNyb3MgKi8KICNpZiBfTVNDX1ZF
UiA+PSAxNDAwCiAjZGVmaW5lIEhBVkVfQ1BQX1ZBUkFSR19NQUNST19JU08gMQo=
--001636c5b0ee1f06fb046a579eed--

