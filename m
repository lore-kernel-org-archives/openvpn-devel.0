Message-ID: <a24b93e8-c99d-4917-8873-a4334b63ac0e@...1227...>
Date: Mon, 20 Nov 2023 12:22:56 +0200
MIME-Version: 1.0
References: <8237adde-2523-9e48-5cd4-070463887dc1@...277...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <8237adde-2523-9e48-5cd4-070463887dc1@...277...>
Subject: Re: [Openvpn-devel] [PATCH] protocol_dump: support tls-crypt
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
To: Reynir <reynirr@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 30.10.23 um 11:58 schrieb Reynir:
> Dear list,
> 
> Please find attached a patch to add support for tls-crypt packets in 
> protocol_dump. Currently, protocol_dump will print garbage for tls-crypt 
> packets.
> 
> This patch makes protocol_dump print the clear text parts of the packet 
> such as the auth tag and replay packet id. It does not try to print the 
> wKc for HARD_RESET_CLIENT_V3 or CONTROL_WKC_V1 packets. A previous 
> iteration, not submitted to the list, printed ENCRYPTED placeholders for 
> ack list and DATA, but I decided to cut down on the noise instead.
> 
> This is my first patch submitted to openvpn so please bear with me.
>

Code looks good and works fine here.

Acked-By: Arne Schwabe <arne@...1227...>


