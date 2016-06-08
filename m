References: <1465388443-15484-1-git-send-email-steffan@...1856...>
	<1465388443-15484-3-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <12164a8f-9dcb-1b17-d224-c4c13bd10825@...1227...>
Date: Wed, 8 Jun 2016 14:50:52 +0200
MIME-Version: 1.0
In-Reply-To: <1465388443-15484-3-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 2/5] cleanup: remove alloc_buffers
 argument from multi_top_init()
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net



Am 08.06.16 um 14:20 schrieb Steffan Karger:
> multi_top_init() is always called with alloc_buffers=true, so just remove
> the argument and alloc unconditionally.
>
> Si
ACK. This is one is easy!

Arne

