References: <1448750881-10767-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <565ACDDC.5060205@...1227...>
Date: Sun, 29 Nov 2015 11:05:16 +0100
MIME-Version: 1.0
In-Reply-To: <1448750881-10767-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Fix openssl builds with custom-built
 library: specify most-dependent first
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 28.11.15 um 23:48 schrieb Steffan Karger:
> Libraries should be specified from left-to-right as most-dependent to
> least-dependent.  Thus, -lssl comes first, then -lcrypto.
> 
> (This does not fail when pkg-config finds your libraries for you, since
> we tell it '-lssl needs -lcrypto' and we then end up with
> "-lcrypto -lssl -lcrypto", which is not pretty but does work.)
> 

ACK from me.

Arne


