References: <20200917131223.11519-1-themiron@...2010...>
 <20200920205704.18274-1-themiron@...2010...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0175aef6-8f4c-c482-12d7-189c677085ab@...2181...>
Date: Thu, 24 Sep 2020 10:11:41 +0200
MIME-Version: 1.0
In-Reply-To: <20200920205704.18274-1-themiron@...2010...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v6 1/2] Selectively reformat too long
 lines
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

Hi,

On 20/09/2020 22:57, Vladislav Grishenko wrote:
> @@ -3170,7 +3179,7 @@ static const struct proto_names proto_names[] = {
>      {"udp6","UDPv6", AF_INET6, PROTO_UDP},
>      {"tcp6-server","TCPv6_SERVER", AF_INET6, PROTO_TCP_SERVER},
>      {"tcp6-client","TCPv6_CLIENT", AF_INET6, PROTO_TCP_CLIENT},
> -    {"tcp6","TCPv6", AF_INET6, PROTO_TCP},
> +    {"tcp6",       "TCPv6", AF_INET6, PROTO_TCP},

What are you actually fixing here? Adding a tab?
I feel there should be a space after each ',', but that is probably out
of the scope of this patch?


-- 
Antonio Quartulli

