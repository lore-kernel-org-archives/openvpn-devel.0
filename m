From: Heiko Hund <heiko.hund@...1489...>
Date: Sat, 25 Jun 2016 09:45:15 +0200
Message-ID: <24448974.0y5P2VU2rm@...1526...>
In-Reply-To: <20160624173713.GZ79504@...1296...>
References: <1466784101-20655-1-git-send-email-heiko.hund@...1489...>
	<20160624173713.GZ79504@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Windows: do_ifconfig() after open_tun()
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Freitag, 24. Juni 2016 19:37:13 CEST Gert Doering wrote:
> This patch changes the order to IFCONFIG_AFTER_TUN_OPEN, moves some
> initialization code to init_tun, where it belongs, and removes duplicate
> code that is now no longer needed.

Yeah, I was skeptic at first, too. But it seems to work. That said, I've only 
tested with the interactive service in place. It's the only option how to run 
Openvpn in a sane manner on Windows anyways. =)

Cheers
Heiko


