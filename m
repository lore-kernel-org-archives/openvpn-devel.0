Date: Thu, 9 Dec 2021 14:55:44 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <2037998735.744393.1639058144006@...2642...>
In-Reply-To: <20211207170211.3275837-15-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
 <20211207170211.3275837-15-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 14/21] Add mtu paramter to --fragment
 and change fragment calculation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net



> Arne Schwabe <arne@...1227...> hat am 07.12.2021 18:02 geschrieben:
> diff --git a/Changes.rst b/Changes.rst
> index cf6a2f86d..c673196fa 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -63,10 +63,11 @@ Optional ciphers in ``--data-ciphers``
>      those as optional and only use them if the SSL library supports them.
>  
>  
> -Improved ``--mssfix`` calculation
> -    The ``--mssfix`` option now allows an optional :code:`mtu` parameter to specify
> -    that different overhead for IPv4/IPv6 should taken into account and the resulting
> -    size is specified as the total size of the VPN packets including IP and UDP headers.
> +Improved ``--mssfix`` and ``--fragement`` calculation

Typo, should be "--fragment"

> +    The ``--mssfix`` and ``--fragment`` options now allow an optional :code:`mtu`
> +    parameter to specify that different overhead for IPv4/IPv6 should taken into
> +    account and the resulting size is specified as the total size of the VPN packets
> +    including IP and UDP headers.

Regards,
  Frank

--
Frank Lichtenheld

