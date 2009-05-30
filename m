MIME-Version: 1.0
In-Reply-To: <4A210AB1.2050901@...41...>
References: <20090529110957.111780@...95...>
	<9e0cf0bf0905290425x396bb7f4o1c68c00a2f12ba0c@...278...>
	<4A210AB1.2050901@...41...>
Date: Sat, 30 May 2009 19:30:33 +0300
Message-ID: <9e0cf0bf0905300930j2a677780g1a04b0b7adace8b9@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Content-Type: multipart/mixed; boundary=001636c9240c51a8e0046b23b610
Subject: Re: [Openvpn-devel] Reporting issue with v2.1 rc16 and
	--cryptoapicert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

--001636c9240c51a8e0046b23b610
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello James,

I sent you several times correct patch.
You did not apply it as-is.
Anyway, the attached patches is in queue.

Alon.

On Sat, May 30, 2009 at 1:30 PM, James Yonan <jim@...41...> wrote:
> I would rather not have touched cryptoapi.c for rc16, but it wouldn't
> build with MinGW 5.1.4 (the .h files in this version of MinGW define the
> symbol CryptAcquireCertificatePrivateKey which conflicts with the symbol
> of the same definition in cryptoapi.c). =C2=A0So I did try to work around=
 the
> issue, but perhaps I broke something in the process.
>
> It would be great if one of the developers that uses the crypto API
> feature could take a look at it. =C2=A0We will certainly accept a patch t=
hat
> fixes any introduced breakage.
>
> James
>
> Alon Bar-Lev wrote:
>>
>> True.
>> I already reported this to James.
>> There were too many change-replace at the cryptoapi.c in this version.
>>
>> On Fri, May 29, 2009 at 2:09 PM, Markus Bickel <ZeroCool.2001@...68...>
>> wrote:
>>>
>>> Dear developers,
>>>
>>> I'm currently installing and testing OpenVPN 2.1 on windows environment
>>> and have seen that there's a newer version rc16.
>>>
>>> Since this version I cannot use the parameter:
>>>
>>> --cryptoapicert "Thumb:xx xx xx xx xx"
>>>
>>> Error message:
>>>
>>> cannot load certificate "Thumb:xx xx xx xx .... " from Microsoft
>>> Certificate Store:
>>> error:C506C064:microsoft cryptoapi:GetProcAddress:The specified procedu=
re
>>> could not be found.
>>>
>>>
>>> This behaviour is the same on server or client sides.
>>> With rc15 this worked well.
>>>
>>> Maybe this is a small bug.
>>> So I want to report this issue to you.
>>>
>>> Would it be fixed in rc17?
>>>
>>> Thanks in Adanvce,
>>>
>>> Markus
>>>
>>> --
>>> Nur bis 31.05.: GMX FreeDSL Komplettanschluss mit DSL 6.000 Flatrate und
>>> Telefonanschluss nur 17,95 Euro/mtl.!* http://portal.gmx.net/de/go/dsl02
>>>
>>>
>>> -----------------------------------------------------------------------=
-------
>>> Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
>>> is a gathering of tech-side developers & brand creativity professionals.
>>> Meet
>>> the minds behind Google Creative Lab, Visual Complexity, Processing, &
>>> iPhoneDevCamp as they present alongside digital heavyweights like
>>> Barbarian
>>> Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>
>>
>>
>> ------------------------------------------------------------------------=
------
>> Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT is a
>> gathering of tech-side developers & brand creativity professionals. Meet
>> the minds behind Google Creative Lab, Visual Complexity, Processing, &
>> iPhoneDevCamp as they present alongside digital heavyweights like Barbar=
ian
>> Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001636c9240c51a8e0046b23b610
Content-Type: application/octet-stream; name="cryptapi.patch"
Content-Disposition: attachment; filename="cryptapi.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvcjfzxs0

SW5kZXg6IGNyeXB0b2FwaS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGNyeXB0b2FwaS5jCShyZXZpc2lvbiA0
NDc0KQorKysgY3J5cHRvYXBpLmMJKHdvcmtpbmcgY29weSkKQEAgLTc1LDcgKzc1LDcgQEAKICAg
ICB7IEVSUl9QQUNLKEVSUl9MSUJfQ1JZUFRPQVBJLCAwLCAwKSwJCQkJICAgICJtaWNyb3NvZnQg
Y3J5cHRvYXBpIn0sCiAgICAgeyBFUlJfUEFDSygwLCBDUllQVE9BUElfRl9DRVJUX09QRU5fU1lT
VEVNX1NUT1JFLCAwKSwJCSAgICAiQ2VydE9wZW5TeXN0ZW1TdG9yZSIgfSwKICAgICB7IEVSUl9Q
QUNLKDAsIENSWVBUT0FQSV9GX0NFUlRfRklORF9DRVJUSUZJQ0FURV9JTl9TVE9SRSwgMCksCSAg
ICAiQ2VydEZpbmRDZXJ0aWZpY2F0ZUluU3RvcmUiIH0sCi0gICAgeyBFUlJfUEFDSygwLCBDUllQ
VE9BUElfRl9DUllQVF9BQ1FVSVJFX0NFUlRJRklDQVRFX1BSSVZBVEVfS0VZLCAwKSwgICAgIk9w
ZW5WUE5DcnlwdEFjcXVpcmVDZXJ0aWZpY2F0ZVByaXZhdGVLZXkiIH0sCisgICAgeyBFUlJfUEFD
SygwLCBDUllQVE9BUElfRl9DUllQVF9BQ1FVSVJFX0NFUlRJRklDQVRFX1BSSVZBVEVfS0VZLCAw
KSwgICAgIkNyeXB0QWNxdWlyZUNlcnRpZmljYXRlUHJpdmF0ZUtleSIgfSwKICAgICB7IEVSUl9Q
QUNLKDAsIENSWVBUT0FQSV9GX0NSWVBUX0NSRUFURV9IQVNILCAwKSwJCQkgICAgIkNyeXB0Q3Jl
YXRlSGFzaCIgfSwKICAgICB7IEVSUl9QQUNLKDAsIENSWVBUT0FQSV9GX0NSWVBUX0dFVF9IQVNI
X1BBUkFNLCAwKSwJCQkgICAgIkNyeXB0R2V0SGFzaFBhcmFtIiB9LAogICAgIHsgRVJSX1BBQ0so
MCwgQ1JZUFRPQVBJX0ZfQ1JZUFRfU0VUX0hBU0hfUEFSQU0sIDApLAkJCSAgICAiQ3J5cHRTZXRI
YXNoUGFyYW0iIH0sCkBAIC0zODksNyArMzg5LDcgQEAKICAgICB9CiAgICAgaWYgKE9wZW5WUE5D
cnlwdEFjcXVpcmVDZXJ0aWZpY2F0ZVByaXZhdGVLZXkgPT0gTlVMTCkgewogCU9wZW5WUE5Dcnlw
dEFjcXVpcmVDZXJ0aWZpY2F0ZVByaXZhdGVLZXkgPSBHZXRQcm9jQWRkcmVzcyhjcnlwdDMyZGxs
LAotCQkiT3BlblZQTkNyeXB0QWNxdWlyZUNlcnRpZmljYXRlUHJpdmF0ZUtleSIpOworCQkiQ3J5
cHRBY3F1aXJlQ2VydGlmaWNhdGVQcml2YXRlS2V5Iik7CiAJaWYgKE9wZW5WUE5DcnlwdEFjcXVp
cmVDZXJ0aWZpY2F0ZVByaXZhdGVLZXkgPT0gTlVMTCkgewogCSAgICBDUllQVE9BUEllcnIoQ1JZ
UFRPQVBJX0ZfR0VUX1BST0NfQUREUkVTUyk7CiAJICAgIGdvdG8gZXJyOwo=
--001636c9240c51a8e0046b23b610
Content-Type: application/octet-stream; name="openvpn-003-windows.patch"
Content-Disposition: attachment; filename="openvpn-003-windows.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvcjg4ti1

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
--001636c9240c51a8e0046b23b610--

