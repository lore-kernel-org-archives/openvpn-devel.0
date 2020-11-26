References: <CAAUX2SWGzsjeCxjQ1C+zh8+qKXL3mUv5AJqEd6rM=A8f-Q1dBA@...278...>
 <a2152b6e-1429-6637-aef8-7eaf527316e3@...2181...>
 <CAAUX2SWEOk5TC1J9jBoiS6=chMbY_6DTMvPV1J07d3L26k9b0A@...278...>
 <228b401e-e700-447c-4c30-29d28cb22585@...2181...>
 <CAAUX2SX-90sKC-+MBQ9ycimK0YvHZC0rMjVKMKH_oFSDW=x5Tw@...278...>
 <8a1dc0cf-61d4-2ded-1c51-ccb755ba7ef9@...2181...>
 <CAAUX2SUqFRWcP+aTXUaW2+5zK6AGcAO51-rbcikexKXVPsc84g@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4017b96e-e344-bfd2-cc72-e40dc0d7a271@...1227...>
Date: Thu, 26 Nov 2020 10:22:21 +0100
MIME-Version: 1.0
In-Reply-To: <CAAUX2SUqFRWcP+aTXUaW2+5zK6AGcAO51-rbcikexKXVPsc84g@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [ovpn-dco] Is cbc-hmac supported?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tony He <huangya90@...277...>, Antonio Quartulli <a@...2181...>
Cc: lev@...515..., openvpn-devel@lists.sourceforge.net

Am 26.11.20 um 01:46 schrieb Tony He:
>>OpenSSL directly talks to the crypto engine via a proprietary interface
>>that the FW/driver exposes to userspace. The *data* flow does not cross
>>the linux kernel crypto API
> 
> No, OpenSSL doesn't directly talk to the  crypto engine via a
> proprietary interface that the FW/driver exposes to userspace.
> "cryptodev engine" is NOT the "HW engine" chip vendor provides. It's a
> common interface and its source is not from


To be honest. We currently aim to feature current state of the art
support. And with supporting only the AEAD algorithm we support all
clients of 2.4 and later.

Since the original thread was not on the mailing list I am missing your
goal but if your crypto acelator already works with OpenSSL, then it
will also work with the "normal" OpenVPN.

If you look over the fence at IPSec accleration in Intel NIC hardware,
you will find that those also only support AES-GCM. And that with even
hardware that came out almost 10 years ago.

Or look at TLS 1.3. De facto there is only AES-GCM and Chacha20-Poly1305
left as standard. TLS1_3_RFC_AES_128_CCM_8_SHA256 is specified but you
need to specifically configure your TLS library to support this. This
inclusion of AES-CCM is specifically to cater for use use cases like yours.

Since AES-CCM is an AEAD cipher supporting that makes more sense and
might very straightforword if it is supported by the AEAD APIs we
already use.

Arne

