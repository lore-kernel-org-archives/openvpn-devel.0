MIME-Version: 1.0
References: <20200309131728.380-1-simon@...2293...>
 <20200309131728.380-11-simon@...2293...>
In-Reply-To: <20200309131728.380-11-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 24 Mar 2020 14:07:35 +0200
Message-ID: <CAGyAFMVAebWYLKohd5LFLC9Z11rxjqbys8jSd3CQun0ogSjWjg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 11/12] openvpnmsica: Merge
 FindTUNTAPAdapters into FindSystemInfo
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Compiled with msvc, smoke-tested with rundll32.

One thing:

> +    set_openvpnserv_state(hInstall);
> +    find_adapters(
> +        hInstall,
> +        TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID),
> +        TEXT("TAPWINDOWS6ADAPTERS"),
> +        TEXT("ACTIVETAPWINDOWS6ADAPTERS"));

Both methods return error codes which we ignore.

