Message-ID: <f80646d4-0fc3-4e5a-bc05-22b929452d00@...1800...>
Date: Thu, 28 Sep 2023 17:11:10 -0400
MIME-Version: 1.0
Content-Language: en-US
From: mike tancsa <mike@...1800...>
Subject: [Openvpn-devel] pkcs11 config changes from 2.5.4 to 2.6.6 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

I am starting to test out 2.6.6 with a config that worked in 2.5.4 but 
am getting a failure con connect.  I did have a look through the 
Changes.rst file but didnt see anything different ? The only pkcs11 bits 
I have in the config are

pkcs11-providers eTpkcs11.dll
pkcs11-id 'pkcs11:model=eToken;token=....'

and the same config works with the older version. Are there new 
directives I need to add ?  This is an Gemalto/Thales etoken. Again, it 
works fine in this environment with the only change being the version of 
OpenVPN.


2023-09-28 17:05:12 us=484000 OpenVPN 2.6.6 
[git:v2.6.6/c9540130121bfc21] Windows-MSVC [SSL (OpenSSL)] [LZO] [LZ4] 
[PKCS11] [AEAD] [DCO] built on Aug 15 2023
2023-09-28 17:05:12 us=484000 Windows version 10.0 (Windows 10 or 
greater), amd64 executable
2023-09-28 17:05:12 us=484000 library versions: OpenSSL 3.1.2 1 Aug 
2023, LZO 2.10
2023-09-28 17:05:12 us=484000 DCO version: v0
2023-09-28 17:05:12 us=484000 PKCS#11: pkcs11h_setProperty return 
rv=0-'CKR_OK'
2023-09-28 17:05:12 us=484000 PKCS#11: pkcs11h_setProperty entry 
property='1', value=0000007116AFD5A0, value_size=4
2023-09-28 17:05:12 us=484000 PKCS#11: pkcs11h_setProperty return 
rv=84-'CKR_FUNCTION_NOT_SUPPORTED'
2023-09-28 17:05:12 us=484000 PKCS#11: pkcs11h_setProperty entry 
property='7', value=0000007116AFD5A8, value_size=8
2023-09-28 17:05:12 us=484000 PKCS#11: Setting property 7=*size*
2023-09-28 17:05:12 us=484000 PKCS#11: pkcs11h_setProperty return 
rv=0-'CKR_OK'
2023-09-28 17:05:12 us=484000 NOTE: --mute triggered...
2023-09-28 17:05:12 us=484000 15 variation(s) on previous 20 message(s) 
suppressed by --mute
2023-09-28 17:05:12 us=484000 PKCS#11: Adding PKCS#11 provider 
'eTpkcs11.dll'
2023-09-28 17:05:12 us=484000 PKCS#11: pkcs11h_registerProvider entry 
version='1.29.0', reference='eTpkcs11.dll'
2023-09-28 17:05:12 us=484000 PKCS#11: Register provider 'eTpkcs11.dll'
2023-09-28 17:05:12 us=484000 PKCS#11: pkcs11h_registerProvider Provider 
'eTpkcs11.dll'
2023-09-28 17:05:12 us=484000 PKCS#11: Provider 'eTpkcs11.dll' 
registered rv=0-'CKR_OK'
2023-09-28 17:05:12 us=484000 PKCS#11: pkcs11h_registerProvider return 
rv=0-'CKR_OK'
2023-09-28 17:05:12 us=484000 PKCS#11: pkcs11h_setProviderProperty entry 
reference='eTpkcs11.dll', property='0', value=0000018E5DBA6E88, 
value_size=13
2023-09-28 17:05:12 us=484000 NOTE: --mute triggered...
2023-09-28 17:05:12 us=578000 75 variation(s) on previous 20 message(s) 
suppressed by --mute
2023-09-28 17:05:12 us=578000 PKCS#11: Failed to set cert and private 
key for OpenSSL
2023-09-28 17:05:12 us=578000 PKCS#11: __pkcs11h_openssl_ex_data_free 
entered - parent=0000018E5F93D200, ptr=0000000000000000, 
ad=0000018E5F93D290, idx=1, argl=0, argp=00007FFDBF4E3D38
2023-09-28 17:05:12 us=578000 PKCS#11: 
pkcs11h_certificate_freeCertificate entry certificate=0000018E5DC4BA20
2023-09-28 17:05:12 us=578000 PKCS#11: _pkcs11h_session_release entry 
session=0000018E5DC00AC0
2023-09-28 17:05:12 us=578000 PKCS#11: _pkcs11h_session_release return 
rv=0-'CKR_OK'
2023-09-28 17:05:12 us=578000 PKCS#11: 
pkcs11h_certificate_freeCertificateId entry certificate_id=0000018E5FAF18B0
2023-09-28 17:05:12 us=578000 PKCS#11: pkcs11h_token_freeTokenId entry 
certificate_id=0000018E5FAF1CE0
2023-09-28 17:05:12 us=578000 NOTE: --mute triggered...
2023-09-28 17:05:12 us=578000 8 variation(s) on previous 20 message(s) 
suppressed by --mute
2023-09-28 17:05:12 us=578000 Cannot load certificate 
"pkcs11:model=eToken;token=ess123456mdt;manufacturer=SafeNet%2c%20Inc.;serial=02ca3753;id=%d2-%f7%94%98%8f%a2%60" 
using PKCS#11 interface
2023-09-28 17:05:12 us=578000 Error: private key password verification 
failed
2023-09-28 17:05:12 us=578000 Exiting due to fatal error


Thanks,

     ---Mike


