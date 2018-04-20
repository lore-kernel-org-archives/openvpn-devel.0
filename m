From: Eric Thorpe <eric@...1918...>
Message-ID: <d75b57da-d1ca-d4ca-41c1-f9af06ec54bb@...1918...>
Date: Fri, 20 Apr 2018 15:20:26 +1000
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------72D65BE447B1BC7813BDFFFE"
Content-Language: en-US
Subject: [Openvpn-devel] [Patch] Support client reason from auth plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------72D65BE447B1BC7813BDFFFE
Content-Type: multipart/alternative;
 boundary="------------E4B7A9C271B48D194E3677C6"

--------------E4B7A9C271B48D194E3677C6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

This patch allows for a client reason to be returned from an auth plugin 
and sent to the connecting client on an auth fail. This change is 
backwards compatible with existing plugins and hasn't caused issues with 
existing plugins like the included pam plugin in our testing. The main 
purpose of this change is to support dynamic challenge/response from 
plugins, currently this is only possible from the management interface.

Example usage for this change can be found in a new plugin here modified 
from the included PAM plugin - 
https://github.com/thesparklabs/openvpn-two-factor-extensions/tree/master/yubikey-u2f-pam-plugin

Regards,
Eric

-- 
--
Eric Thorpe
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...


--------------E4B7A9C271B48D194E3677C6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi All,</p>
    <p>This patch allows for a client reason to be returned from an auth
      plugin and sent to the connecting client on an auth fail. This
      change is backwards compatible with existing plugins and hasn't
      caused issues with existing plugins like the included pam plugin
      in our testing. The main purpose of this change is to support
      dynamic challenge/response from plugins, currently this is only
      possible from the management interface.<br>
    </p>
    <p>Example usage for this change can be found in a new plugin here
      modified from the included PAM plugin - <a
        class="moz-txt-link-freetext"
href="https://github.com/thesparklabs/openvpn-two-factor-extensions/tree/master/yubikey-u2f-pam-plugin">https://github.com/thesparklabs/openvpn-two-factor-extensions/tree/master/yubikey-u2f-pam-plugin</a></p>
    <p>Regards,<br>
      Eric<br>
    </p>
    <pre class="moz-signature" cols="72">-- 
--
Eric Thorpe
SparkLabs Developer
<a class="moz-txt-link-freetext" href="https://www.sparklabs.com">https://www.sparklabs.com</a>
<a class="moz-txt-link-freetext" href="https://twitter.com/sparklabs">https://twitter.com/sparklabs</a>
<a class="moz-txt-link-abbreviated" href="mailto:support@...1918...">support@...1918...</a></pre>
  </body>
</html>

--------------E4B7A9C271B48D194E3677C6--

--------------72D65BE447B1BC7813BDFFFE
Content-Type: text/plain; charset=UTF-8;
 name="0001-Modify-verify_user_pass_plugin-to-support-returning-.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Modify-verify_user_pass_plugin-to-support-returning-.pa";
 filename*1="tch"

RnJvbSAwOTcwZjE2YzI3YzJiOTBkZjA0YWQxNDhiZWE4NGE5YmZkM2FkNGEwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBldGhvcnBlIDxlcmljQHNwYXJrbGFicy5jb20+CkRh
dGU6IFdlZCwgMTggQXByIDIwMTggMTk6MDU6NTQgKzEwMDAKU3ViamVjdDogW1BBVENIXSBN
b2RpZnkgdmVyaWZ5X3VzZXJfcGFzc19wbHVnaW4gdG8gc3VwcG9ydCByZXR1cm5pbmcgYQog
Y2xpZW50X3JlYXNvbiB3aGVuCgphdXRoIGlzIHJlamVjdGVkLiBUaGlzIGlzIGJhY2t3YXJk
cyBjb21wYXRpYmxlIHdpdGggZXhpc3RpbmcgcGx1Z2lucy4KLS0tCiBzcmMvb3BlbnZwbi9z
c2xfdmVyaWZ5LmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9z
cmMvb3BlbnZwbi9zc2xfdmVyaWZ5LmMgYi9zcmMvb3BlbnZwbi9zc2xfdmVyaWZ5LmMKaW5k
ZXggMjUzOTViMi4uNjI2NmZiMyAxMDA2NDQKLS0tIGEvc3JjL29wZW52cG4vc3NsX3Zlcmlm
eS5jCisrKyBiL3NyYy9vcGVudnBuL3NzbF92ZXJpZnkuYwpAQCAtMTE2Nyw3ICsxMTY3LDcg
QEAgZG9uZToKICAqIFZlcmlmeSB0aGUgdXNlcm5hbWUgYW5kIHBhc3N3b3JkIHVzaW5nIGEg
cGx1Z2luCiAgKi8KIHN0YXRpYyBpbnQKLXZlcmlmeV91c2VyX3Bhc3NfcGx1Z2luKHN0cnVj
dCB0bHNfc2Vzc2lvbiAqc2Vzc2lvbiwgY29uc3Qgc3RydWN0IHVzZXJfcGFzcyAqdXAsIGNv
bnN0IGNoYXIgKnJhd191c2VybmFtZSkKK3ZlcmlmeV91c2VyX3Bhc3NfcGx1Z2luKHN0cnVj
dCB0bHNfc2Vzc2lvbiAqc2Vzc2lvbiwgc3RydWN0IHRsc19tdWx0aSAqbXVsdGksIGNvbnN0
IHN0cnVjdCB1c2VyX3Bhc3MgKnVwLCBjb25zdCBjaGFyICpyYXdfdXNlcm5hbWUpCiB7CiAg
ICAgaW50IHJldHZhbCA9IE9QRU5WUE5fUExVR0lOX0ZVTkNfRVJST1I7CiAjaWZkZWYgUExV
R0lOX0RFRl9BVVRICkBAIC0xMTc3LDYgKzExNzcsOSBAQCB2ZXJpZnlfdXNlcl9wYXNzX3Bs
dWdpbihzdHJ1Y3QgdGxzX3Nlc3Npb24gKnNlc3Npb24sIGNvbnN0IHN0cnVjdCB1c2VyX3Bh
c3MgKnVwLAogICAgIC8qIElzIHVzZXJuYW1lIGRlZmluZWQ/ICovCiAgICAgaWYgKChzZXNz
aW9uLT5vcHQtPnNzbF9mbGFncyAmIFNTTEZfQVVUSF9VU0VSX1BBU1NfT1BUSU9OQUwpIHx8
IHN0cmxlbih1cC0+dXNlcm5hbWUpKQogICAgIHsKKyAgICAgICAgc3RydWN0IHBsdWdpbl9y
ZXR1cm4gcHIsIHByZmV0Y2g7CisgICAgICAgIHBsdWdpbl9yZXR1cm5faW5pdCgmcHIpOwor
CiAgICAgICAgIC8qIHNldCB1c2VybmFtZS9wYXNzd29yZCBpbiBwcml2YXRlIGVudiBzcGFj
ZSAqLwogICAgICAgICBzZXRlbnZfc3RyKHNlc3Npb24tPm9wdC0+ZXMsICJ1c2VybmFtZSIs
IChyYXdfdXNlcm5hbWUgPyByYXdfdXNlcm5hbWUgOiB1cC0+dXNlcm5hbWUpKTsKICAgICAg
ICAgc2V0ZW52X3N0cihzZXNzaW9uLT5vcHQtPmVzLCAicGFzc3dvcmQiLCB1cC0+cGFzc3dv
cmQpOwpAQCAtMTE5OCw3ICsxMjAxLDIzIEBAIHZlcmlmeV91c2VyX3Bhc3NfcGx1Z2luKHN0
cnVjdCB0bHNfc2Vzc2lvbiAqc2Vzc2lvbiwgY29uc3Qgc3RydWN0IHVzZXJfcGFzcyAqdXAs
CiAjZW5kaWYKIAogICAgICAgICAvKiBjYWxsIGNvbW1hbmQgKi8KLSAgICAgICAgcmV0dmFs
ID0gcGx1Z2luX2NhbGwoc2Vzc2lvbi0+b3B0LT5wbHVnaW5zLCBPUEVOVlBOX1BMVUdJTl9B
VVRIX1VTRVJfUEFTU19WRVJJRlksIE5VTEwsIE5VTEwsIHNlc3Npb24tPm9wdC0+ZXMpOwor
ICAgICAgICByZXR2YWwgPSBwbHVnaW5fY2FsbChzZXNzaW9uLT5vcHQtPnBsdWdpbnMsIE9Q
RU5WUE5fUExVR0lOX0FVVEhfVVNFUl9QQVNTX1ZFUklGWSwgTlVMTCwgJnByLCBzZXNzaW9u
LT5vcHQtPmVzKTsKKworICAgICAgICAvKiBGZXRjaCBjbGllbnQgcmVhc29uICovCisgICAg
ICAgIHBsdWdpbl9yZXR1cm5fZ2V0X2NvbHVtbigmcHIsICZwcmZldGNoLCAiY2xpZW50X3Jl
YXNvbiIpOworICAgICAgICBpZiAocGx1Z2luX3JldHVybl9kZWZpbmVkKCZwcmZldGNoKSkK
KyAgICAgICAgeworICAgICAgICAgICAgaW50IGk7CisgICAgICAgICAgICBmb3IgKGkgPSAw
OyBpIDwgcHJmZXRjaC5uOyArK2kpCisgICAgICAgICAgICB7CisgICAgICAgICAgICAgICAg
aWYgKHByZmV0Y2gubGlzdFtpXSAmJiBwcmZldGNoLmxpc3RbaV0tPnZhbHVlKQorICAgICAg
ICAgICAgICAgIHsKKyAgICAgICAgICAgICAgICAgICAgbWFuX2RlZl9hdXRoX3NldF9jbGll
bnRfcmVhc29uKG11bHRpLCBwcmZldGNoLmxpc3RbaV0tPnZhbHVlKTsKKyAgICAgICAgICAg
ICAgICB9CisgICAgICAgICAgICB9CisgICAgICAgIH0KKworICAgICAgICBwbHVnaW5fcmV0
dXJuX2ZyZWUoJnByKTsKIAogI2lmZGVmIFBMVUdJTl9ERUZfQVVUSAogICAgICAgICAvKiBw
dXJnZSBhdXRoIGNvbnRyb2wgZmlsZW5hbWUgKGFuZCBmaWxlIGl0c2VsZikgZm9yIG5vbi1k
ZWZlcnJlZCByZXR1cm5zICovCkBAIC0xMzc4LDcgKzEzOTcsNyBAQCB2ZXJpZnlfdXNlcl9w
YXNzKHN0cnVjdCB1c2VyX3Bhc3MgKnVwLCBzdHJ1Y3QgdGxzX211bHRpICptdWx0aSwKICNl
bmRpZgogICAgIGlmIChwbHVnaW5fZGVmaW5lZChzZXNzaW9uLT5vcHQtPnBsdWdpbnMsIE9Q
RU5WUE5fUExVR0lOX0FVVEhfVVNFUl9QQVNTX1ZFUklGWSkpCiAgICAgewotICAgICAgICBz
MSA9IHZlcmlmeV91c2VyX3Bhc3NfcGx1Z2luKHNlc3Npb24sIHVwLCByYXdfdXNlcm5hbWUp
OworICAgICAgICBzMSA9IHZlcmlmeV91c2VyX3Bhc3NfcGx1Z2luKHNlc3Npb24sIG11bHRp
LCB1cCwgcmF3X3VzZXJuYW1lKTsKICAgICB9CiAgICAgaWYgKHNlc3Npb24tPm9wdC0+YXV0
aF91c2VyX3Bhc3NfdmVyaWZ5X3NjcmlwdCkKICAgICB7Ci0tIAoyLjcuNAoK
--------------72D65BE447B1BC7813BDFFFE--

