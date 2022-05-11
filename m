Date: Wed, 11 May 2022 13:27:03 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1691013115.649356.1652268423735@...2642...>
In-Reply-To: <20220511110810.1944975-1-arne@...1227...>
References: <20220422142953.3805364-17-arne@...1227...>
 <20220511110810.1944975-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3 26/28] Allow setting control channel
 packet size with tls-mtu
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



> Arne Schwabe <arne@...1227...> hat am 11.05.2022 13:08 geschrieben:
> 
>  
> Currently control packet size is controlled by tun-mtu in a very
> non-obvious way since the control overhead is not taken into account
> and control channel packet will end up with a different size than
> data channel packet.
> 
> Instead we decouple this and introduce tls-mtu which defaults to
> 1250.
> 
> Patch v2: rebase on latest patch set
> Patch v3: Introduce TLS_CHANNEL_MTU_MIN define and give explaination
>           of its value.

"explanation"

> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst                       |  8 ++++++++
>  doc/man-sections/link-options.rst |  7 +++++++
>  src/openvpn/common.h              | 10 ++++++++++
>  src/openvpn/init.c                |  8 ++++++--
>  src/openvpn/mtu.h                 |  5 +++++
>  src/openvpn/options.c             | 14 ++++++++++++++
>  src/openvpn/options.h             |  1 +
>  src/openvpn/ssl.c                 | 25 +++++++++++++------------
>  src/openvpn/ssl.h                 |  8 +++-----
>  9 files changed, 67 insertions(+), 19 deletions(-)
> 
[...]
> diff --git a/src/openvpn/common.h b/src/openvpn/common.h
> index b94680885..056c25438 100644
> --- a/src/openvpn/common.h
> +++ b/src/openvpn/common.h
> @@ -68,6 +68,16 @@ typedef unsigned long ptr_type;
>   */
>  #define TLS_CHANNEL_BUF_SIZE 2048
>  
> +/* TLS control buffer minimum size, this size is not actually inherent to
> + * the protocol but. Our current sending window is 6 and the receive window

Maybe "the protocol. However, our" ?

> + * is 8 or 12 depending on the OpenVPN version. We need to be able to send
> + * a TLS record of size TLS_CHANNEL_BUF_SIZE. Splitting this into more than
> + * 6 packets (with overhead) would complicate our sending logic a lot more, so
> + * we settle here for a "round" number that allow with overhead of ~100 bytes

remove "allow"

> + * to be larger than TLS_CHANNEL_BUF_SIZE. E.g. 6x ~400 > 2048.

"to be" -> "is"

> + * */
> +#define TLS_CHANNEL_MTU_MIN 512
> +
>  /*
>   * This parameter controls the maximum size of a bundle
>   * of pushed options.
[...]

Regards,
--
Frank Lichtenheld

