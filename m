MIME-Version: 1.0
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-22-a@...2181...>
In-Reply-To: <20220624083809.23487-22-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 4 Aug 2022 14:49:41 +0300
Message-ID: <CAGyAFMV3ZpoDRbwSGWLkPeNNNaP2+Rn87D2Mafa91bEde856cw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 21/25] do_open_tun: restyle "can
 preserve TUN" check
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> +static bool
> +can_preserve_tun(struct tuntap *tt)
> +{
> +#ifdef TARGET_ANDROID
> +    return false;
> +#elif _WIN32
> +    return tt && tt->dco.real_tun_init;

Looks like dco.real_tun_init has been added in the very next patch, 22/25.

