Message-ID: <ae79faf3-a36f-0743-558b-91b2f29658f5@...1227...>
Date: Tue, 28 Jun 2022 14:46:09 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220628094144.17471-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220628094144.17471-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt-v2: bail out if the client
 key is too small
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 28.06.22 um 11:41 schrieb Antonio Quartulli:
> The tls-crypt-v2 key should be at least 2 bytes long in order to read
> the actual length.
> 
> Bail out if the key is too short.
> Failing to do so will lead to a read out of the buffer boundary.

Actually not. We read from BEND(), so this is defined for TCP since the 
minimum length there is 3 bytes (pkt len + opcode). For UDP we might 
read past the beginning of the packet but since they are buffers coming 
from the packet stack we have the headroom/tailroom, so might read some 
random data (but not out of bound!).

So we copy some more or less random number into net_len/wkc_len but 
without actually reading from undefined memory.

The next line will then almost definitively fail


     if (!buf_advance(&wrapped_client_key, BLEN(&wrapped_client_key) - 
wkc_len))

Since BLEN(wrapped_client_key) is 0 or 1 or wkc_len has to be 0 or 1 to 
not fail this check

and then in turn

  tls_crypt_v2_unwrap_client_key

will fail at

     if (BLEN(&wrapped_client_key) < sizeof(net_len))


> While at it improve the error message a bit.
> 

Acked-BY: Arne Schwabe <arne@...1227...>

