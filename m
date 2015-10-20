From: Arne Schwabe <arne@...1227...>
References: <1445277979-21591-1-git-send-email-gert@...1296...>
Message-ID: <5625FF9E.4080407@...1227...>
Date: Tue, 20 Oct 2015 10:47:26 +0200
MIME-Version: 1.0
In-Reply-To: <1445277979-21591-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add option --push-suppress-ipv6 to stop
 sending IPv6 info to clients.
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



Am 19.10.15 um 20:06 schrieb Gert Doering:
> Workaround option for servers that have IPv6 working just fine, but
> need to turn it off for individual clients - in that case, set this
> option in the --client-config-dir file for a particular user, or
> via --client-connect script/plugin hook for a particular platform
> (like IOS 9.0.2)
>
ACK from me. Patch looks good and is small enough not to cause
headaches. Ideally, this would be solved on the client (not accepting
these variables). The client still complain about other options like
redirect-gateway ipv6 but since this is a workaround anyway, it should
be fine.

Arne

