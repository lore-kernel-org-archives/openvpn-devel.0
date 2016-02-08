References: <1454874438-5081-1-git-send-email-steffan@...1856...>
	<1454874438-5081-10-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56B8BC53.40805@...1227...>
Date: Mon, 8 Feb 2016 17:03:31 +0100
MIME-Version: 1.0
In-Reply-To: <1454874438-5081-10-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 09/10] Add cipher name translation for
 OpenSSL.
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
> This keeps naming consistent. For example, instead of id-aes128-GCM use
> AES-128-GCM, which is more like AES-128-CBC.
>
> +
> +  if (NULL == pair)
> +    return cipher_name;
> +
I like the pair == NULL style more.

Otherwise ACK from me.

arne


