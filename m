Message-ID: <44258b51-41a7-8d81-e362-c399e069f476@...1227...>
Date: Thu, 3 Mar 2022 15:08:25 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220301135054.277-1-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220301135054.277-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix incorrect default mssfix value in
 server mode
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Am 01.03.22 um 14:50 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
> 
> When calculating default mssfix, we take into account
> protocol overhead, which usually includes 3 bytes peer-id.
> 
> Peer-id usage is indicated by options->use_peer_id flag.
> In client mode it is set when applying pushed options.
> In server mode  it is not set and as a result mssfix value
> is 3 bytes off.
> 
> Fix by setting this flag in multi.c when calculating
> tunnel-specific options.

Acked-By: Arne Schwabe <arne@...1227...>

This fixes the issue at hand. It would be better to refactor the whole 
peerid in use signalling eventually but this is good enough for now.

Arne

