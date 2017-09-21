Resent-To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <551b53ee-a953-e192-ba7d-e5b7a33374c9@...2080...>
From: Guido Vranken <guidovranken@...277...>
Message-ID: <CAO5O-ELs7tpAcdDWXZipeFMkVAmRbVtK=u4+tXU-km_Tq4oHnQ@...278...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Remote memory corruption
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Date: Thu, 21 Sep 2017 23:48:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: security@...515...

Hello,

this concerns key_method 1. I know it's deprecated, but reporting it
just in case people still use it..

So key_method_1_read() calls read_key() which doesn't perform adequate
bounds checks. cipher_length and hmac_length are specified by the
peer:

1643     uint8_t cipher_length;
1644     uint8_t hmac_length;
1645
1646     CLEAR(*key);
1647     if (!buf_read(buf, &cipher_length, 1))
1648     {
1649         goto read_err;
1650     }
1651     if (!buf_read(buf, &hmac_length, 1))
1652     {
1653         goto read_err;
1654     }

And this many bytes of data are then read into key->cipher and key->hmac:

1656     if (!buf_read(buf, key->cipher, cipher_length))
1657     {
1658         goto read_err;
1659     }
1660     if (!buf_read(buf, key->hmac, hmac_length))
1661     {
1662         goto read_err;
1663     }

key->hmac is only 64 bytes. So it's trivial to overflow key->hmac.

Guido

