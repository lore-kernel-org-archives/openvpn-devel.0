From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 1 Apr 2014 11:27:11 +0200
Message-ID: <1549051.GdQZOEKbS3@...1526...>
In-Reply-To: <5339EFFC.6090908@...1856...>
References: <1395017376-24554-1-git-send-email-james@...515...>
	<1443881.kcztAJWLkP@...1526...> <5339EFFC.6090908@...1856...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
	context for OpenSSL builds,
	to disable TLS stateless session resumption.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

On Tuesday 01 April 2014 00:45:16 Steffan Karger wrote:
> The attached patch fixes your problem, but if there is someone around
> with a better idea (and, preferrably, patch) to fix it, I'm all ears!

ACK, fixes the problem indeed, without introducing a new set of flags even.

Thanks
Heiko

