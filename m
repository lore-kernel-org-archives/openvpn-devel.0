From: Arne Schwabe <arne@...1227...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
	<1441985627-14822-10-git-send-email-gert@...1296...>
Message-ID: <55FA7FCB.9050008@...1227...>
Date: Thu, 17 Sep 2015 09:54:35 +0100
MIME-Version: 1.0
In-Reply-To: <1441985627-14822-10-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 09/10] Fix IPv6 host routes to LAN
 gateway on OpenSolaris
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



Am 11.09.15 um 16:33 schrieb Gert Doering:
> The tun/tap routes need to be set with "metric 0", while this will
> prevent routes to LAN gateways from being installed.  So, set metric 0
> only if no other interface is requested...
>
> (Note: OpenSolaris can not specify host+interface gateways, so we just
> use the GW addresses - it seems to still work for fe80:: addresses,
> however it is done internally.  NUD maybe?)

ACK. You could also copy the commit message to the comment in the code
to make it more clear what is going on there.

Arne

