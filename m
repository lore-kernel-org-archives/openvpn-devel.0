Message-ID: <aa15d573-6998-4b7c-f364-251c439ffaac@...2669...>
Date: Wed, 10 Aug 2022 15:57:28 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220329192934.1415-1-timo@...2669...>
 <20220514103717.235-1-timo@...2669...>
From: Timo Rothenpieler <timo@...2669...>
In-Reply-To: <20220514103717.235-1-timo@...2669...>
Subject: Re: [Openvpn-devel] [PATCH v5] platform: Retain CAP_NET_ADMIN when
 dropping privileges
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
To: openvpn-devel@lists.sourceforge.net

On 14/05/2022 12:37, Timo Rothenpieler wrote:
> On Linux, when dropping privileges, interaction with
> the network configuration, such as tearing down routes
> or ovpn-dco interfaces will fail when --user/--group are
> used.
> 
> This patch sets the CAP_NET_ADMIN capability, which grants
> the needed privileges during the lifetime of the OpenVPN
> process when dropping root privileges.
> 
> Signed-off-by: Timo Rothenpieler <timo@...2669...>
> Reviewed-By: David Sommerseth <davids@...515...>

With Linux DCO now fully merged, this patch is ready to land.
It still applies cleanly for all I can tell.

