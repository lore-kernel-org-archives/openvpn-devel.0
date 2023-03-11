Message-ID: <8b0e27a3-8bc8-b50f-5223-a1c3705aea49@...1227...>
Date: Sat, 11 Mar 2023 20:39:46 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230310050814.67246-1-heiko@...2662...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230310050814.67246-1-heiko@...2662...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] dns option: allow up to eight
 addresses per server
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
To: Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net

Am 10.03.23 um 06:08 schrieb Heiko Hund:
> This change allows configuration of more than one address per family
> for a DNS server. This way you can specify backup addresses in case a
> server is not reachable. During closer inspection of the various DNS
> backend in supported operation systems it turned out that our previous
> idea to have more than one DNS server applied in order of priority does
> not work in most cases. Thus it became important to be able to specify
> backup addresses. So instead of doing
>

Acked-By: Arne Schwabe <arne@...1227...>


