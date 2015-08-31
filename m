References: <CABgPX1maNQDV9XzTi8E8NCYSPPvAXgX2=-mza7j=1tQTUgEcXw@...278...>
	<55E432F8.5040204@...1147...>
	<CABgPX1ke6bhi0oMDQ1NCbwh0ob9HJo9wDiwRvR4gRGWdZ1bCQA@...278...>
	<55E439ED.1020706@...1227...>
	<CABgPX1nGoy2L9n_v=Y6YM362rg2s_gvvwx=WacxZSDJ5yYWEFg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <55E44482.4030400@...1227...>
Date: Mon, 31 Aug 2015 14:11:46 +0200
MIME-Version: 1.0
In-Reply-To: <CABgPX1nGoy2L9n_v=Y6YM362rg2s_gvvwx=WacxZSDJ5yYWEFg@...278...>
Subject: Re: [Openvpn-devel] Disable TLS for mode server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Valentin Sawadski <valentin@...2062...>
Cc: openvpn-devel@lists.sourceforge.net



Am 31.08.15 um 13:33 schrieb Valentin Sawadski:
> Hi Arne,
>
> thanks for the explanation on --tls-cipher NONE.
>
> I know that TLS is only used for Authentication. But the other peer
> still would have to do a TLS handshake, which is undesired in my case
> as well.
>
> Assuming I want to remove the TLS handshake as well, would patching
> options.c enough or where else should I start looking?
>
It requires patching much more than only options.c I am afraid. The
whole logic of the p2mp server assumes a TLS connection. When you remove
the tls connection you also remove pull/push support without major
rewriting.

Arne

