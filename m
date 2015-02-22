Message-ID: <54EA08C0.1030701@...1856...>
Date: Sun, 22 Feb 2015 17:50:08 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1423390725-13438-1-git-send-email-gert@...1296...>
	<1424031695-10218-1-git-send-email-gert@...1296...>
In-Reply-To: <1424031695-10218-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2 for 2.3] New approach to handle
 peer-id related changes to link-mtu.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 15-02-15 21:21, Gert Doering wrote:
> Instead of statically increasing link-mtu by +3, keep the old value for
> OCC compatibility with old servers/clients, and only increase link-mtu
> if peer-id option is enabled (right now: is pushed by server).
>
> If link-mtu has been set in the config, keep configured value, and log
> warning (because the extra overhead has to decrease tun-mtu).
>
> Reserve extra +3 bytes in frame->extra_link.
>
> v2: use frame->extra_link, not frame->extra_buffer (receive path on server)
>      introduce frame_add_to_link_mtu() to manipulate frame->link_mtu value
>      rework comments to make more clear what is happening
>
> Adaption to 2.3: reserve +8 bytes in frame->extra_buffer - if compression
>      is not enabled, the 2.3 code does not reserve space for compression
>      overhead (2.4 code does), so the buffer ends up being too small.
>      +3 is not sufficient because the buffer handling code also does some
>      alignment tricks...
>
> This reverts commit 4ec70ca227370380011d072c09b739135e236183.
>
> Signed-off-by: Gert Doering <gert@...1296...>
> Message-Id: <1423390725-13438-1-git-send-email-gert@...1296...>
> URL: http://article.gmane.org/gmane.network.openvpn.devel/9450
> (cherry picked from commit 9e0963c11aa439deb382d7d6bc40b6ade999401c)

ACK. Code looks good, and tests confirm this approach works.

-Steffan

