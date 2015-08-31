References: <CABgPX1maNQDV9XzTi8E8NCYSPPvAXgX2=-mza7j=1tQTUgEcXw@...278...>
	<55E432F8.5040204@...1147...>
	<CABgPX1ke6bhi0oMDQ1NCbwh0ob9HJo9wDiwRvR4gRGWdZ1bCQA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <55E439ED.1020706@...1227...>
Date: Mon, 31 Aug 2015 13:26:37 +0200
MIME-Version: 1.0
In-Reply-To: <CABgPX1ke6bhi0oMDQ1NCbwh0ob9HJo9wDiwRvR4gRGWdZ1bCQA@...278...>
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
To: Valentin Sawadski <valentin@...2062...>, Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net



Am 31.08.15 um 13:17 schrieb Valentin Sawadski:
> Hello Julian,
>
> thanks for your quick response. I know about --cipher none options in
> P2P mode, but for testing with multiple clients I need --mode server.
>
> As for the --tls-cipher option, NONE is not working for me. --show-tls
> also lists no other "non encrypted" cipher I could use.
> Besides it still seems to do the TLS handshake right?
Current TLS libraries (OpenSSl, PolarSSL) might not allow NONE as
ciphersuite in default setting, you may need to recompile OpenSSL for that.
>
> Is there any way I can have the unencrypted P2P communication with
> multiple connected clients (without having OpenVPN running in
> parallel)?
>
No. Current implementation requires TLS handshake for that. And only the
handshake is encrypted, not the communication itself.

Arne

