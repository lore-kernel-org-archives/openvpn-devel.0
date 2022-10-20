Date: Thu, 20 Oct 2022 12:21:42 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y1EhNvMo29gDQuny@...2685...>
References: <20220921104930.3452270-1-arne@...1227...>
 <20221020100546.3023025-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20221020100546.3023025-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 2/3] Allow setting control channel
 packet size with max-packet-size
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

On Thu, Oct 20, 2022 at 12:05:46PM +0200, Arne Schwabe wrote:
> Currently control packet size is controlled by tun-mtu in a very
> non-obvious way since the control overhead is not taken into account
> and control channel packet will end up with a different size than
> data channel packet.
> 
> Instead we decouple this and introduce max-packet-size. Control packet size
> defaults to 1250 if max-packet-size is not set.
> 
> Patch v2: rebase on latest patch set
> Patch v3: Introduce TLS_CHANNEL_MTU_MIN define and give explaination
>           of its value.
> Patch v4: introduce max-packet-size instead of tls-mtu
> Patch v5: improve documentation

Thanks. Documentation is much improved now, indeed. There is always more
that could be improved but let's not do that in this patch.

Acked-By: Frank Lichtenheld <frank@...2641...>

Two tiny nit-picks noted below which could be applied on merge, or not.

> diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
> index eb098a0f8..6a7f48a59 100644
> --- a/doc/man-sections/link-options.rst
> +++ b/doc/man-sections/link-options.rst
> @@ -172,9 +172,9 @@ the local and the remote host.
>    the first place, and if big packets come through anyhow (from protocols
>    other than TCP), ``--fragment`` will internally fragment them.
>  
> -  Both ``--fragment`` and ``--mssfix`` are designed to work around cases
> -  where Path MTU discovery is broken on the network path between OpenVPN
> -  peers.
> +  ``max-packet-size``, ``--fragment`` and ``--mssfix`` are designed to work

I'm a big fan of the Oxford comma, so "``--fragment``, ". But I'm not sure
what we usually do.

> +  around cases where Path MTU discovery is broken on the network path
> +  between OpenVPN peers.
>  
>    The usual symptom of such a breakdown is an OpenVPN connection which
>    successfully starts, but then stalls during active usage.
> @@ -189,6 +189,10 @@ the local and the remote host.
>  
>       --tun-mtu 1500 --fragment 1300 --mssfix
>  
> +  If the ``max-packet-size size`` option is used in the configuration
> +  it will also act as if ``mssfix size mtu`` was specified in the
> +  configuration.
> +
>  --mtu-disc type
>    Should we do Path MTU discovery on TCP/UDP channel? Only supported on
>    OSes such as Linux that supports the necessary system call to set.
> @@ -465,3 +469,27 @@ the local and the remote host.
>       if mode server:
>           socket-flags TCP_NODELAY
>           push "socket-flags TCP_NODELAY"
> +
> +--max-packet-size size
> +  This option will instruct OpenVPN to try to limit the maximum on-write packet
> +  size by restricting the control channel packet size and setting ``--mssfix``.
> +
> +  OpenVPN will try to keep its control channel messages below this size but
> +  due to some constraints in the protocol this is not always possible. If the
> +  option is not set, the control packet maximum size defaults to 1250.
> +  The control channel packet size will be restricted to values between
> +  512 and 2048. The maximum packet size includes encapsulation overhead like
> +  UDP and IP.
> +
> +  In terms of ``--mssfix`` it will expand to:
> +  ::
> +
> +      mssfix size mtu
> +
> +  If you need to set ``--mssfix`` for data channel and control channel maximum
> +  packet size independently, use ``--max-packet-size`` first, followed by a
> +  ``--mssfix`` in the configuration.
> +
> +  In general the default size of 1250 should work almost universally apart
> +  from specific corner cases, especially since IPv6 requires a MTU of 1280
> +  or larger.
> diff --git a/src/openvpn/common.h b/src/openvpn/common.h
> index b94680885..dce6fd01d 100644
> --- a/src/openvpn/common.h
> +++ b/src/openvpn/common.h
> @@ -68,6 +68,19 @@ typedef unsigned long ptr_type;
>   */
>  #define TLS_CHANNEL_BUF_SIZE 2048
>  
> +/* TLS control buffer minimum size. This size is not actually inherent to
> + * the OpenVPN protocol. But with our current sending window being 6 and the
> + * receive window being 8 or 12 depending on the OpenVPN version, the biggest
> + * payload we can send is 6 * min_size. And we need to support to send payloads
> + * of TLS_CHANNEL_BUF_SIZE. Splitting this into more than
> + * 6 packets (with overhead) would complicate our sending logic a lot more.
> + * Diving TLS_CHANNEL_BUF_SIZE (2048) by 6 gets us ~342 byte. Allowing for
> + * ~100 bytes of overhead (in OpenVPN headers + IP headers) and rounding
> + * up to the next "nice" number gives use 512.

"use" -> "us"

> + *
> + * */
> +#define TLS_CHANNEL_MTU_MIN 512
> +
>  /*
>   * This parameter controls the maximum size of a bundle
>   * of pushed options.

Regards,
-- 
  Frank Lichtenheld

