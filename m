Message-ID: <54E0BBC5.7030208@...1856...>
Date: Sun, 15 Feb 2015 16:31:17 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1424010266-5910-1-git-send-email-steffan@...1856...>
	<54E0B4A2.5090006@...1227...>
In-Reply-To: <54E0B4A2.5090006@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Disable SSL compression
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 15-02-15 16:00, Arne Schwabe wrote:
> ACK from me. Sounds sensible to me. If do not support 0.9.8 anymore (in
> -master perhaps?) I would like this to be commited without ifdef.

Agreed, but we went from 0.9.6+ in 2.3 to 0.9.8+ in 2.4/master.

I put 0.9.8 explicitly in the comment, so that if we decide to drop
support for 0.9.8, it is easy to spot that we can remove these ifdefs.
(and if we drop 0.9.8, we can probably remove a lot more code :) ).

-Steffan

