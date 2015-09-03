References: <1440541753-9172-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <55E7E5A3.4030604@...1227...>
Date: Thu, 3 Sep 2015 08:16:03 +0200
MIME-Version: 1.0
In-Reply-To: <1440541753-9172-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Add missing strdup() return value checks
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

Am 26.08.15 um 00:29 schrieb Steffan Karger:
> As reported by Bill Parker in trac #600, strdup() return values are not
> always correctly checked for failed allocations.  This patch adds missing
> checks.
>
> Note that in misc.c and options.c, the check is after the dirname() or
> basename() call, because these can deal with NULL params and we need to
> keep MSVC happy with its ancient no-declaration-after-statement policy.
>
>
ACK from me.

Arne

