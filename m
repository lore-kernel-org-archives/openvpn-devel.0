MIME-Version: 1.0
References: <20200924064452.1001-1-simon@...2293...>
In-Reply-To: <20200924064452.1001-1-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 24 Sep 2020 11:08:46 +0300
Message-ID: <CAGyAFMV1V==WKEd0YPz0ieX+hJYogf5s+CBJD5=BsEEpSWMr4g@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] netsh: Specify interfaces by index
 rather than name
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

Good old "name vs index" thing.

According to "man" of netsh, index indeed could be used for "set
address" and "add route":

> interface         - Interface name or index.

> +        DWORD adapter_index;
>          if (r6->adapter_index)          /* vpn server special route */
>          {
> -            buf_printf(&out, "interface=%lu", r6->adapter_index );
> +            adapter_index = r6->adapter_index;
>              gateway_needed = true;
>          }
>          else
>          {
> -            buf_printf(&out, "interface=%lu", tt->adapter_index );
> +            adapter_index = tt->adapter_index;
>          }

Here I would do something like

  DWORD adapter_index = tt->adapter_index;
  if (r6->adapter_index)
  {
      adapter_index = r6->adapter_index;
      gateway_needed = true;
  }

to make code more concise, but I am fine with current implementation too.

Stared at the code, built and tested on MSVC/Win10. Works as expected.

Acked-by: Lev Stipakov <lstipakov@...277...>

