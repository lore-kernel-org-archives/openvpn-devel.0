MIME-Version: 1.0
References: <20210522033232.20548-3-selva.nair@...277...>
 <20210525173838.3969-1-selva.nair@...277...>
In-Reply-To: <20210525173838.3969-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 27 May 2021 10:05:47 +0300
Message-ID: <CAGyAFMX2FHcdAoVgMXViQtqokYKp-dNhcBLpC7r_ZYakMWb4hA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 3/3 v2] Print format spec changes for
 tapctl and openvpnmscia
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
To: Selva <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

> -    _stprintf_s(szTitle, _countof(szTitle), TEXT("%s v%s"), szFunctionName, TEXT(PACKAGE_VERSION));
> +    _stprintf_s(szTitle, _countof(szTitle), TEXT("%") TEXT(PRIsLPTSTR) TEXT("v%") TEXT(PRIsLPTSTR),

Just a note that a whitespace is (still) missing before "v%", but it
is fixed in subsequent patch ("Replace TEXT(__FUNCTION__) by
__FUNCTION__ in openvpnmscia.c").

Looks good - compared with v1, compiled/tested with MSVC.

Acked-by: Lev Stipakov <lstipakov@...277...>

