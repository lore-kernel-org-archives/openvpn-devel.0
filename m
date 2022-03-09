Message-ID: <a89fb868-84ad-0542-df43-5863dce5c7c8@...2181...>
Date: Wed, 9 Mar 2022 09:35:12 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220224165557.22060-1-kprovost@...2661...>
 <20220224165557.22060-2-kprovost@...2661...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220224165557.22060-2-kprovost@...2661...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] dco: process DCO control packets
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
To: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Kristof,

On 24/02/2022 17:55, Kristof Provost via Openvpn-devel wrote:
> From: Kristof Provost <kp@...1376...>
> 
> If control packets come in through the DCO interface (i.e. via
> dco_do_read()) we must process them through process_incoming_link().
> This doesn't currently manifest, because Linux passes control packets
> through the regular socket, not via the DCO netlink interface, but other
> platforms will not.

This is an interesting catch - actually also ovpn-dco on Linux is 
expected to send control packets over netlink.

However, due to a little glitch packets were still sent over the UDP 
socket (this is expected only for the initial handshake).

Once this bug has been fixed, I could see that indeed 
process_incoming_dco() wasn't operating as it should and this patch was 
required.

I have squashed a modified version of this patch directly in my dco 
branch as it is needed to make ovpn-dco work.

Thanks a lot!

Best Regards,


-- 
Antonio Quartulli

