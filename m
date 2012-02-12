MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_27358cd186ae00a50cc036bb631f606d"
Date: Sun, 12 Feb 2012 22:40:02 +0400
From: igor@...1550...
Message-ID: <7c22eb11c37c167998cc7975576fe585@...1550...>
Subject: [Openvpn-devel] =?utf-8?q?=5BPATCH=5D_Check_for_ENABLE=5FMANAGEME?=
 =?utf-8?q?NT_for_ENABLE=5FCLIENT=5FCR?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=_27358cd186ae00a50cc036bb631f606d
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit

 When building a very minimal OpenVPN for OpenWRT with 
 --disable-management among others,
 the compilaton fails due to ENABLE_CLIENT_CR being defined, although 
 the management interface,
 which makes use of it, has been disabled.

 The attached simple patch checks for ENABLE_MANAGEMENT before defining 
 ENABLE_CLIENT_CR.
--=_27358cd186ae00a50cc036bb631f606d
Content-Transfer-Encoding: base64
Content-Type: text/x-c;
 name=client-cr-check-for-management.patch
Content-Disposition: attachment; filename=client-cr-check-for-management.patch

LS0tIGEvc3lzaGVhZC5oDQorKysgYi9zeXNoZWFkLmgNCkBAIC03MTMsNyArNzEzLDkgQEANCiAv
Kg0KICAqIERvIHdlIHN1cHBvcnQgY2hhbGxlbmdlL3Jlc3BvbnNlIGF1dGhlbnRpY2F0aW9uIGFz
IGNsaWVudD8NCiAgKi8NCisjaWYgZGVmaW5lZChFTkFCTEVfTUFOQUdFTUVOVCkNCiAjZGVmaW5l
IEVOQUJMRV9DTElFTlRfQ1INCisjZW5kaWYNCg0KIC8qDQogICogRG8gd2Ugc3VwcG9ydCBwdXNo
aW5nIHBlZXIgaW5mbz8NCg==
--=_27358cd186ae00a50cc036bb631f606d--


