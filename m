References: <1450602641-26831-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56768324.7050003@...1227...>
Date: Sun, 20 Dec 2015 11:29:56 +0100
MIME-Version: 1.0
In-Reply-To: <1450602641-26831-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Make assert_failed() print the failed
 condition
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

On 20.12.2015 10:10, Steffan Karger wrote:
> Easy change to make logging output more useful.
>
ACK. BUt I think if we keep the minimal build option, this should be
disabled int that option since the extra strings will increase code size.

Arne

