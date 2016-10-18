References: <1475060898-21462-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <f85a1f74-01fa-c760-66d6-c797f4ad034d@...1227...>
Date: Tue, 18 Oct 2016 13:46:26 +0200
MIME-Version: 1.0
In-Reply-To: <1475060898-21462-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Don't deference type-punned pointers
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



Am 28.09.16 um 13:08 schrieb Steffan Karger:
> Fixes compiler warnings (undefined behavior) by making the copy explicit
> to comply to strict aliasing rules.  With newer GCC the old code could
> actually lead to undefined behaviour.
>
I always considered this to be legal C. But if the spec says otherwise,
we should change this. The code does the same thing. So reluctant ACK.

Arne

