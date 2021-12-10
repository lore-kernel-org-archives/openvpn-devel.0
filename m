Date: Fri, 10 Dec 2021 17:57:19 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <2099273909.853173.1639155439409@...2642...>
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
> 
> diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
> index f41c0c4f1..b71656e0b 100644
> --- a/doc/man-sections/link-options.rst
> +++ b/doc/man-sections/link-options.rst
> @@ -24,13 +24,18 @@ the local and the remote host.
>    from any address, not only the address which was specified in the
>    ``--remote`` option.
>  
> ---fragment max
> +--fragment max [mtu]
>    Enable internal datagram fragmentation so that no UDP datagrams are sent
>    which are larger than ``max`` bytes.
>  
> -  The ``max`` parameter is interpreted in the same way as the
> -  ``--link-mtu`` parameter, i.e. the UDP packet size after encapsulation
> -  overhead has been added in, but not including the UDP header itself.
> +  If the :code:`mtu` parameter is present the ``max`` parameter is
> +  interpreted to include IP and UDP encapsulation overhead. The
> +  :code:`mtu` parameter is introduced in OpenVPN version 2.6.0.
> +
> +  If the :code:`mtu` parameter is absent, the ``max`` parameter is
> +  interpreted in the same way as the ``--link-mtu`` parameter, i.e.
> +  the UDP packet size after encapsulation overhead has been added in,
> +  but not including the UDP header itself.

The same comment as for mssfix applies here: "--fragment max [mtu]" is not valid rst syntax.
Even "--fragment max mtu" is invalid. You need to do something like

--fragment args
  Valid syntaxes::

     fragment max
     fragment max mtu

Like we do for other parameters.

Regards,
--
Frank Lichtenheld

