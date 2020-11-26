References: <CAAUX2SWGzsjeCxjQ1C+zh8+qKXL3mUv5AJqEd6rM=A8f-Q1dBA@...278...>
 <a2152b6e-1429-6637-aef8-7eaf527316e3@...2181...>
 <CAAUX2SWEOk5TC1J9jBoiS6=chMbY_6DTMvPV1J07d3L26k9b0A@...278...>
 <228b401e-e700-447c-4c30-29d28cb22585@...2181...>
 <CAAUX2SX-90sKC-+MBQ9ycimK0YvHZC0rMjVKMKH_oFSDW=x5Tw@...278...>
 <8a1dc0cf-61d4-2ded-1c51-ccb755ba7ef9@...2181...>
 <CAAUX2SUqFRWcP+aTXUaW2+5zK6AGcAO51-rbcikexKXVPsc84g@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <f34acee4-d928-509e-5bb3-9900c1578d5b@...2181...>
Date: Thu, 26 Nov 2020 08:48:12 +0100
MIME-Version: 1.0
In-Reply-To: <CAAUX2SUqFRWcP+aTXUaW2+5zK6AGcAO51-rbcikexKXVPsc84g@...278...>
Content-Language: en-US
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
To: Tony He <huangya90@...277...>
Cc: lev@...515..., openvpn-devel@lists.sourceforge.net

Hi Tony,

On 26/11/2020 01:46, Tony He wrote:
>>OpenSSL directly talks to the crypto engine via a proprietary interface
>>that the FW/driver exposes to userspace. The *data* flow does not cross
>>the linux kernel crypto API
> 
> No, OpenSSL doesn't directly talk to the  crypto engine via a
> proprietary interface that the FW/driver exposes to userspace.
> "cryptodev engine" is NOT the "HW engine" chip vendor provides. It's a
> common interface and its source is not from
> chip vendor. Please refer to:
> https://github.com/cryptodev-linux/cryptodev-linux
> <https://github.com/cryptodev-linux/cryptodev-linux>
> https://openwrt.org/docs/techref/hardware/cryptographic.hardware.accelerators
> <https://openwrt.org/docs/techref/hardware/cryptographic.hardware.accelerators>

Thanks for clarifying!
I thought you were talking about the crypto engine offload provided by
OpenSSL via vendor library.

So, if I understand this correctly, what you are saying is that the
vendor provides kernel patches in order to add HW support to the kernel
crypto API for an architecture that is normally not supported by the
upstream kernel. Then cryptodev is used to allow userspace to use the
kernel API.

This said, I am sorry, but I am not sure we should continue this
discussion any further, because as of now we have no plan to introduce
yet another crypto family in ovpn-dco.

One of the goal with ovpn-dco is to leave behind the legacy from
openvpn2 in userspace and focus on those features we believe to be
"state of the art". This is why we decided to only support AEAD with
only AES-GCM and CHACHA20POLY1305, DATA_V2 only, etc.

Focus is on keeping the code simple and ensure it can be accepted
upstream in the Linux kernel quickly.

It was an hard decision to make, but the whole group decided to take
this direction. People that want to use different
configurations/settings will still be able to do so by using openvpn2 in
userspace, as it happened until now.


Cheers,


> 
> Tony 
>  
> 
> Antonio Quartulli <a@...2181...> 于2020年11月26日周四 上午12:19写道：
> 
>     Hi Tony,
> 
>     > OpenVPN-> openssl->crypodev engine->cryptodev-linux->Linux kernel
>     crypto API->HW engine crypto API-> HW engine driver-> HW engine
> 
>     Now I understand better what you have in mind.
> 
>     To the best of my knowledge, this is not how it works.
> 
>     OpenSSL directly talks to the crypto engine via a proprietary interface
>     that the FW/driver exposes to userspace. The *data* flow does not cross
>     the linux kernel crypto API.
> 
>     Moist of the time this special interfaces are made "to work with openssl
>     only", so I am not even sure how the kernel API could use it.
> 
>     Do you have any pointer saying otherwise?
> 
> 
>     -- 
>     Antonio Quartulli
> 

-- 
Antonio Quartulli

