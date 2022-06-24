Date: Fri, 24 Jun 2022 14:18:23 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YrWrj87UHMlpGt4S@...2678...>
References: <20220624111318.3219982-1-arne@...1227...>
 <20220624111318.3219982-2-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20220624111318.3219982-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/4] Implement a function to
 calculate the default MTU
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Jun 24, 2022 at 01:13:16PM +0200, Arne Schwabe wrote:
> We could also just hardcode this value to 1420 but this approach does
> not add much (complicated) code and it is a bit better than to have
> a magic number to just be there.
> 
[...]
> +/**
> + * Function to calculate the default MTU for Layer 3 VPNs. The function
> + * assumes that UDP packets should be a maximum of \c MTU_ENCAP_DEFAULT (1492)
> + * with a AEAD cipher. This default comes out to be 1420.
> + */

The result of the function is not always 1420.
E.g. if options.ce.fragment == true.

> +int
> +frame_calculate_default_mtu(struct options *o);
> +
> +
>  /*
>   * EXTENDED_SOCKET_ERROR_CAPABILITY functions -- print extra error info
>   * on socket errors, such as PMTU size.  As of 2003.05.11, only works

