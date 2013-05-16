From: Josh Cepek <josh.cepek@...1085...>
Date: Thu, 16 May 2013 11:30:23 -0500
Message-ID: <kn31ir$7t9$1@...1062...>
References: <1367608404-2257-1-git-send-email-gert@...1296...>
Mime-Version: 1.0
In-Reply-To: <1367608404-2257-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix NULL-pointer crash in
	route_list_add_vpn_gateway().
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 5/3/2013 14:13, Gert Doering wrote:
> Add ASSERT() check to route_list_add_vpn_gateway() to ensure that *rl
> is valid (and if not, crash with a somewhat more meaningful message than
> "segmentation violation").  For the actual bugfix, change init code to
> always allocate a "struct route_list" for IPv4, even if no --route options
> have been seen in the config.
> 
> Fix trac#281 and trac#258.
> 
> Signed-off-by: Gert Doering <gert@...1296...>

ACK to the fix.

As briefly discussed online, in the long-term the
route_list_add_vpn_gateway() call in forward.c should probably be moved
to a better location; it sounds like that's already in the works for a
future changeset (and not required to fix this crash.)

--
Josh Cepek


