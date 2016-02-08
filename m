References: <1454874438-5081-1-git-send-email-steffan@...1856...>
	<1454874438-5081-5-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56B8B4F9.8040308@...1227...>
Date: Mon, 8 Feb 2016 16:32:09 +0100
MIME-Version: 1.0
In-Reply-To: <1454874438-5081-5-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 04/10] Move key_ctx_bi into
	crypto_options
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
> The encrypt and decrypt routines use struct crypto_options as their main
> information source.  A struct crypto_options would have a pointer to a
> struct key_ctx_bi, which had to be updated at the correct moments to keep
> them correct.  Instead of doing this administration, just put the struct
> key_ctx_bi inside crypto_options.  Makes the code a little simpler too.

ACK. I like simpler code :)

Arne


