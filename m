References: <1454874438-5081-1-git-send-email-steffan@...1856...>
	<1454874438-5081-4-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56B8B3AF.3070401@...1227...>
Date: Mon, 8 Feb 2016 16:26:39 +0100
MIME-Version: 1.0
In-Reply-To: <1454874438-5081-4-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 03/10] Move crypto_options into
 key_state and stop using context in SSL-mode.
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



Am 07.02.16 um 20:47 schrieb Steffan Karger:
> Moving crypto_options into key_state enables us to stop using the global
> context for each packet encrypt/decrypt operation. Decoupling the crypto
> from the global context removes the need to copy the relevant parts of
> crypto_options for each processed packet, but instead enables us to just
> pass along a pointer to the related crypto_options.
>
> This paves the way for an efficient GCM cipher mode implementation, but is
> probably fruitful too for threading and/or cipher negotiation.

ACK from me.

Arne


