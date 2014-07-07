MIME-Version: 1.0
In-Reply-To: <53BA5E08.7@...1227...>
References: <1402244175-31462-1-git-send-email-steffan@...1856...>
	<1402244175-31462-2-git-send-email-steffan@...1856...>
	<53BA5E08.7@...1227...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 7 Jul 2014 11:19:45 +0200
Message-ID: <CAA1AbxJ0PyOrkcwf0fHXvxXJY=NLg1_COk-YsUUD3O15sAKhyA@...278...>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Mon, Jul 7, 2014 at 10:44 AM, Arne Schwabe <arne@...1227...> wrote:
>
> Am 08.06.14 18:16, schrieb Steffan Karger:
> > Makes OFB/CFB compile time configurable, and fixes output of --show-ciphers
> > to also show OFB/CFB ciphers along the way (becasue crypto.h was not
> > included from crypto_openssl.c).
> >
> >
> ACK. But maybe we should just always enable this mode instead of having
> another configure option.

Thanks. Just to make this clear to others too: OFB/CFB was and after
this still is enabled by default. Still, I'd prefer to have this
option, because it makes my life easier for OpenVPN-NL, where
everything not-CBC is disabled (and I'm the one maintaining this code,
so in the end it is my problem anyway ;-) ).

-Steffan

