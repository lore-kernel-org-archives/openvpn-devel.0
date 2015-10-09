References: <1425319111-21291-1-git-send-email-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5617EB19.7080000@...1227...>
Date: Fri, 9 Oct 2015 18:28:09 +0200
MIME-Version: 1.0
In-Reply-To: <1425319111-21291-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fast recovery when host is in
 unreachable network
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

Am 02.03.15 um 18:58 schrieb Lev Stipakov:
> When client connects to the server which is in unreachable network (for
> example hostname got resolved into ipv6 address and client has no ipv6),
> throw SIGUSR1 and connect to the next server without waiting 60 seconds
> for "TLS key negotiation failed".


ACK. It works for me and code looks good.

Arne

