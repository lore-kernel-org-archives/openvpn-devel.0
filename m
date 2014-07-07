Message-ID: <53BA5E08.7@...1227...>
Date: Mon, 07 Jul 2014 10:44:56 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1402244175-31462-1-git-send-email-steffan@...1856...>
	<1402244175-31462-2-git-send-email-steffan@...1856...>
In-Reply-To: <1402244175-31462-2-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] Rename ALLOW_NON_CBC_CIPHERS to
 ENABLE_OFB_CFB_MODE, and add to configure.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 08.06.14 18:16, schrieb Steffan Karger:
> Makes OFB/CFB compile time configurable, and fixes output of --show-ciphers
> to also show OFB/CFB ciphers along the way (becasue crypto.h was not
> included from crypto_openssl.c).
>
>
ACK. But maybe we should just always enable this mode instead of having
another configure option.

Arne

