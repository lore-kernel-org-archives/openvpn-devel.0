MIME-Version: 1.0
References: <20221229182739.1477336-1-selva.nair@...277...>
In-Reply-To: <20221229182739.1477336-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 30 Dec 2022 16:32:20 +0200
Message-ID: <CAGyAFMWsHj9YQ5huaZ_N=R2VK7_BnpWN-MnDP95s2qSmwZPAhA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Use undo_lists for saving
 ring-buffer handles in interactive service
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

Hi,

> HandleRegisterRingBuffers() in interactive.c did not follow the
> the original API of HandleMessage()

Indeed, my bad. I was so thrilled when I made it work so I didn't pay
attention to existing patterns (undo_list).

 >  /* Use an always-true match_fn to get the head of the list */
>  static BOOL
> -CmpEngine(LPVOID item, LPVOID any)
> +CmpAny(LPVOID item, LPVOID any)

I wonder why it was called CmpEngine in the first place?

Code looks good, tested with wintun and dco driver (latter is not affected
by the change, but just to make sure).

Acked-by: Lev Stipakov <lstipakov@...277...>

