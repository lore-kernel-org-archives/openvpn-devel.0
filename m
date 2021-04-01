From: Arne Schwabe <arne@...1227...>
References: <20210401131337.3684-1-arne@...1227...>
 <20210401131337.3684-12-arne@...1227...>
Message-ID: <644fbcbe-a8a8-29c8-4627-52a4b68a60ab@...1227...>
Date: Thu, 1 Apr 2021 19:27:43 +0200
MIME-Version: 1.0
In-Reply-To: <20210401131337.3684-12-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 11/14] Remove P2MP mode and check for
 gettimeofday
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 01.04.21 um 15:13 schrieb Arne Schwabe:
> Using OpenVPN without P2MP support (pull, TLS) is unrealistic and
> building a binary without it is not something we realistically want
> to support anyway.

>      }
> +    /* Check if we have forbidding options in the current mode */
> +    if (dco_enabled( &mi->context.options)

Ignore this patch for now. Rebasing worked without conflicts but somehow
still pull dco bits into it (rebase is sometimes magic ....)

Arne

