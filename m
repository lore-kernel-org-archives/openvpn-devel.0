Message-ID: <55376474.3070306@...1227...>
Date: Wed, 22 Apr 2015 11:05:56 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1429649352-21034-1-git-send-email-gert@...1296...>
In-Reply-To: <1429649352-21034-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix leftover 'if (false) ;' statements
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



Am 21.04.15 um 22:49 schrieb Gert Doering:
> Commit a4b8f653ee5be9c2292c removed the #ifdefs for ENABLE_HTTP_PROXY and
> ENABLE_SOCKS, thus making this "if (false) ; else if (...)" construct
> superfluous.  Spotted by David Sommerseth.
ACK. I should have removed with my patch in the first place.

Arne

