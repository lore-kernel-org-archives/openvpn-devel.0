Resent-To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <d1c7ace4-767a-07e7-49ad-5e65f47a3407@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
References: <CAO5O-ELs7tpAcdDWXZipeFMkVAmRbVtK=u4+tXU-km_Tq4oHnQ@...278...>
 <80690690-67ac-3320-1891-9fecedc6a1fa@...1435...>
Message-ID: <04873b30-023e-8531-2786-845109eb7328@...1435...>
In-Reply-To: <80690690-67ac-3320-1891-9fecedc6a1fa@...1435...>
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
Date: Thu, 21 Sep 2017 23:47:50 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Guido Vranken <guidovranken@...277...>, security@...515...

On 15-08-17 10:10, Steffan Karger wrote:
> On 14-08-17 22:59, Guido Vranken wrote:
>> this concerns key_method 1. I know it's deprecated, but reporting it
>> just in case people still use it..
>>
>> So key_method_1_read() calls read_key() which doesn't perform adequate
>> bounds checks. cipher_length and hmac_length are specified by the
>> peer:
>>
>> 1643     uint8_t cipher_length;
>> 1644     uint8_t hmac_length;
>> 1645
>> 1646     CLEAR(*key);
>> 1647     if (!buf_read(buf, &cipher_length, 1))
>> 1648     {
>> 1649         goto read_err;
>> 1650     }
>> 1651     if (!buf_read(buf, &hmac_length, 1))
>> 1652     {
>> 1653         goto read_err;
>> 1654     }
>>
>> And this many bytes of data are then read into key->cipher and key->hmac:
>>
>> 1656     if (!buf_read(buf, key->cipher, cipher_length))
>> 1657     {
>> 1658         goto read_err;
>> 1659     }
>> 1660     if (!buf_read(buf, key->hmac, hmac_length))
>> 1661     {
>> 1662         goto read_err;
>> 1663     }
>>
>> key->hmac is only 64 bytes. So it's trivial to overflow key->hmac.
>=20
> Ouch.  Thanks once more for the report!
>=20
> To all: following <54FC26BB.2000202@...1856...> and commit 1ce06386, I
> think it really is time to remove key method 1 from the master branch.
>=20
> Attached a proposed patch to fix this issue in release/2.4 and master.

What I should mention too is that 'key-method 1' only works for 'peer to
peer TLS setups' (i.e. 'tls-server'  and 'tls-client').  As soon as
someone uses 'mode server' (or 'server'), or 'pull' (or 'client'),
key-method 2 must be used.  This strongly limits the possible affected
users.

-Steffan

