References: <CAN-X3HSXj9a1kiKGBJ1eHgoTeA97WmpqQJPCYf5esKYQa8fLjA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <564B255F.2020402@...1227...>
Date: Tue, 17 Nov 2015 14:02:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAN-X3HSXj9a1kiKGBJ1eHgoTeA97WmpqQJPCYf5esKYQa8fLjA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix info.af == AF_UNSPEC case after
 commit 2bed089d31a12c2d0277e36a64964ebab6640f75
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Christian Pellegrin <chripell@...410...>, openvpn-devel@lists.sourceforge.net

Am 17.11.15 um 13:32 schrieb Christian Pellegrin:
> Looks better than just adding AF_UNSPEC case but I noted many other
> FIXMEs about AF_UNSPEC that could be solved this way. So let me know
> if there is any reason to not use the ai_family field (and just add
> the AF_UNSPEC case in set_mtu_discovery)
> 

Still not very pretty but this is better than failing so ACK from me.

Arne


