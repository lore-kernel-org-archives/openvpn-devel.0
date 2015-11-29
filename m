References: <1448456220-2042-1-git-send-email-heiko.hund@...1489...>
	<1448740717-60914-1-git-send-email-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <565AD7F7.4020700@...1227...>
Date: Sun, 29 Nov 2015 11:48:23 +0100
MIME-Version: 1.0
In-Reply-To: <1448740717-60914-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Un-break compilation on *BSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 28.11.15 um 20:58 schrieb Gert Doering:
> Commit 2191c47165 introduced code to handle IP address query on
> multihoming hosts for IP_PKTINFO-supporting OSes, but all the BSDs
> need the "#elsif IP_RECVDSTADDR" variant... add code equivalent
> to what we have in socket.c/print_link_socket_actual_ex()
> 


ACK code looks sane.

Arne

