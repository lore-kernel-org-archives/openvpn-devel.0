Resent-To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <a87f9091-19fb-109c-331e-07388abe58f6@...2080...>
References: <CAO5O-ELs7tpAcdDWXZipeFMkVAmRbVtK=u4+tXU-km_Tq4oHnQ@...278...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <80690690-67ac-3320-1891-9fecedc6a1fa@...1435...>
In-Reply-To: <CAO5O-ELs7tpAcdDWXZipeFMkVAmRbVtK=u4+tXU-km_Tq4oHnQ@...278...>
Content-Type: multipart/mixed; boundary="------------CF181E9EADCDC90C83ED0E92"
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Remote memory corruption
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Date: Thu, 21 Sep 2017 23:48:12 -0000
To: Guido Vranken <guidovranken@...277...>, security@...515...

--------------CF181E9EADCDC90C83ED0E92
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 14-08-17 22:59, Guido Vranken wrote:
> this concerns key_method 1. I know it's deprecated, but reporting it
> just in case people still use it..
>=20
> So key_method_1_read() calls read_key() which doesn't perform adequate
> bounds checks. cipher_length and hmac_length are specified by the
> peer:
>=20
> 1643     uint8_t cipher_length;
> 1644     uint8_t hmac_length;
> 1645
> 1646     CLEAR(*key);
> 1647     if (!buf_read(buf, &cipher_length, 1))
> 1648     {
> 1649         goto read_err;
> 1650     }
> 1651     if (!buf_read(buf, &hmac_length, 1))
> 1652     {
> 1653         goto read_err;
> 1654     }
>=20
> And this many bytes of data are then read into key->cipher and key->hmac:
>=20
> 1656     if (!buf_read(buf, key->cipher, cipher_length))
> 1657     {
> 1658         goto read_err;
> 1659     }
> 1660     if (!buf_read(buf, key->hmac, hmac_length))
> 1661     {
> 1662         goto read_err;
> 1663     }
>=20
> key->hmac is only 64 bytes. So it's trivial to overflow key->hmac.

Ouch.  Thanks once more for the report!

To all: following <54FC26BB.2000202@...1856...> and commit 1ce06386, I
think it really is time to remove key method 1 from the master branch.

Attached a proposed patch to fix this issue in release/2.4 and master.

-Steffan

--------------CF181E9EADCDC90C83ED0E92
Content-Type: text/x-patch;
	name="0001-CVE-2017-xxx-fix-bounds-check-in-read_key.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-CVE-2017-xxx-fix-bounds-check-in-read_key.patch"

From f7390bf97af7f1977547586529be1d51adde4c67 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 15 Aug 2017 10:04:33 +0200
Subject: [PATCH] CVE-2017-xxx: fix bounds check in read_key()

The bounds check in read_key() was performed after using the value, instead
of before.  If 'key-method 1' is used, this allowed an attacker to send a
malformed packet to trigger a stack buffer overflow.

Fix this by moving the input validation to before the writes.

Note that 'key-method 1' has been replaced by 'key method 2' as the default
in OpenVPN 2.0 (released on 2005-04-17), and explicitly deprecated in 2.4
and marked for removal in 2.5.  This should limit the amount of users
impacted by this issue.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index cc3c7b6..0ebbcd0 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1653,6 +1653,11 @@ read_key(struct key *key, const struct key_type *kt,=
 struct buffer *buf)
         goto read_err;
     }
=20
+    if (cipher_length !=3D kt->cipher_length || hmac_length !=3D kt->hmac_=
length)
+    {
+        goto key_len_err;
+    }
+
     if (!buf_read(buf, key->cipher, cipher_length))
     {
         goto read_err;
@@ -1662,11 +1667,6 @@ read_key(struct key *key, const struct key_type *kt,=
 struct buffer *buf)
         goto read_err;
     }
=20
-    if (cipher_length !=3D kt->cipher_length || hmac_length !=3D kt->hmac_=
length)
-    {
-        goto key_len_err;
-    }
-
     return 1;
=20
 read_err:
--=20
2.7.4


--------------CF181E9EADCDC90C83ED0E92--

