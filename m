Message-ID: <54DDB8AD.2050507@...1227...>
Date: Fri, 13 Feb 2015 09:41:17 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1423335108-83928-1-git-send-email-gert@...1296...>
	<1423390725-13438-1-git-send-email-gert@...1296...>
In-Reply-To: <1423390725-13438-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] New approach to handle peer-id
 related changes to link-mtu.
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net


Am 08.02.15 um 11:18 schrieb Gert Doering:
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
>     introduce frame_add_to_link_mtu() to manipulate frame->link_mtu value
>     rework comments to make more clear what is happening
>
> This reverts commit f95010ad247a8998e0c39e394236251fca316849.
>
>
ACK from me.

Arne

