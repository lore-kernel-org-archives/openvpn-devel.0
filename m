MIME-Version: 1.0
References: <1599177404-29996-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1599177404-29996-1-git-send-email-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 4 Sep 2020 12:38:44 +0300
Message-ID: <CAGyAFMW2nmLLONgoT7XL9CjVHThjro4LuiHSWv=+uy3oeWTf+g@...278...>
Subject: Re: [Openvpn-devel] [PATCH] In tap.c use DiInstallDevice to install
 the driver on a new adapter
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

Hi,

> +    HMODULE libnewdev = NULL;

I think we are moving to C99 so this could be defined closer to actual usage.

Tested with MSVC and mingw - compiled, built installer - installed -
tested that tapctl creates
adapters which then can be used by non-admin users.

Acked-by: Lev Stipakov <lstipakov@...277...>

--
-Lev

