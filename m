MIME-Version: 1.0
In-Reply-To: <564BA6DB.4070703@...2070...>
References: <56307DAA.30700@...2070...> <564BA6DB.4070703@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 17 Nov 2015 20:47:50 -0500
Message-ID: <CAKuzo_jf-P5bhHr_-dD-XugHO9WN5_SR1LJOZxt8f1XhGFZVsg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns').
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

I couldn't apply the patch (its not against master? )

Also it looks like the memory leak not properly fixed (see below).
But before making a new version please see the general comment in the
following mail too.

in win32.c

> +}
> +
> +bool
> +win_wfp_uninit()
> +{
> +    dmsg (D_LOW, "Uninitializing WFP");
> +    DWORD dwFwAPiRetCode = ERROR_BAD_COMMAND;

unused variable ?

> +
> +bool
> +win_wfp_block_dns (const NET_IFINDEX index)
> +{
> +    dmsg (D_LOW, "Blocking DNS using WFP");
> +    NET_LUID tapluid;
> +    NETIO_STATUS ret;

unused variable ?

> +    DWORD dwFwAPiRetCode = ERROR_BAD_COMMAND;

unused variable?  I feel like a compiler

[..]
> +    dmsg (D_LOW, "Filter (Permit IPv6 DNS queries from TAP) added with ID=%I64d", filterid);
> +

You need another free(openvpnblob) here, isn't it?

> +    return true;
> +
> +    err:
> +        free(openvpnblob);
> +        return false;
> +}
> +

in win32.h

> +bool win_wfp_add_filter (HANDLE engineHandle,
> +                        const FWPM_FILTER0 *filter,
> +                        PSECURITY_DESCRIPTOR sd,
> +                        UINT64 *id);

No need to expose this --- could be made static in win32.c and removed
from here...

Thanks,

Selva

