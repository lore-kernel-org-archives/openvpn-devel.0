Message-ID: <89635e1a-2569-d6ce-e6c5-4217715138ff@...1227...>
Date: Thu, 15 Dec 2022 11:44:13 +0100
MIME-Version: 1.0
References: <20221213103142.1960-1-lstipakov@...277...>
 <20221214224220.307-1-lstipakov@...277...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20221214224220.307-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] management: add timer to output
 BYTECOUNT
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

Am 14.12.22 um 23:42 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
> 
> BYTECOUNT on management interface is used to display client stats,
> for example by openvpn-gui. At the moment BYTECOUNT is sent if
> there is a traffic. With DCO, userspace process doesn't see data
> channel traffic, BYTECOUNT is not sent and therefore stats
> are not updated.
> 
> Fix displaying DCO client stats by adding a timer, which is triggerd
> every n seconds, where n is set by existing management command
> bytecount <n>. Output stats, taking into account stats from DCO,
> when timer is triggered.
> 
> While on it, simplify bytecount routines call chains - inlining
> functions which are used only once.
> 
> DCO stats fetching is not yet implemented.
> 
> Stats for the server mode (BYTECOUNT_CLI) are unaffected
> by this change - to output those in timer callback we would need to
> enumerate all peers, and I am not sure we want to output stats
> for all peers every <n> seconds.
> 

Acked-By: Arne Schwabe <arne@...1227...>


