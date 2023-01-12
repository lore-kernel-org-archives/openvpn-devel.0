Message-ID: <2106db01-4d13-073d-2693-880f693da525@...1227...>
Date: Thu, 12 Jan 2023 02:52:33 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230112000435.14119-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230112000435.14119-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] dco: send SIGUSR1 upon ping timeout
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

Am 12.01.23 um 01:04 schrieb Antonio Quartulli:
> When a peer is removed with reason "ping expire", we should kill the
> instance with SIGUSR1 and not SIGTERM
> 
> Cc: Arne Schwabe <arne@...1227...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> --
> 
> Arne, I am not 100% sure why but it seems for ping-restart we always use
> SIGUSR1, right? but the DCO handling code was apparently using SIGTERM.
> 
> What do you think?

This makes no difference in p2mp mode.

Arne


