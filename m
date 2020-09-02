MIME-Version: 1.0
References: <20200902133755.308-1-lstipakov@...277...>
 <CAKuzo_hmoG=MfxsuefwJ5CUMHvXAYCH-n5A-DP4JsJsWBPr-qg@...278...>
 <CAGyAFMVpyJ2tgwopvArJrteJcPCF2bE80ezbGXVgotpJQBsBYQ@...278...>
 <CAKuzo_j1iQ=M1mKnnCvUcUxS5HfER_2OTmxooaORS1z684_Hew@...278...>
In-Reply-To: <CAKuzo_j1iQ=M1mKnnCvUcUxS5HfER_2OTmxooaORS1z684_Hew@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 2 Sep 2020 17:53:14 +0300
Message-ID: <CAGyAFMX4nscyEfT0GGX8dNYVV8j_uLcO=k0XxZf8D1hqowD1wA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpnmsica: make adapter renaming
 non-fatal
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

>> Warning is printed inside tap_delete_adapter().
>
> tap_delete_adapter() is not called here.

Right, I managed to mistype tap_set_adapter_name().

> I was suggesting that if we do check the return value, let us also print a warning
> that renaming failed. That can't be done anywhere except just before converting the error
> to SUCCESS.

I realized that warning inside tap_set_adapter_name() also
displays a messagebox, which we probably don't want to show.

I'll send a v2 which prints warning and doesn't display a messagebox.

-- 
-Lev

