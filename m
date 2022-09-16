From: Heiko Hund <heiko@...2662...>
Date: Fri, 16 Sep 2022 02:47:59 +0200
Message-ID: <2553370.Lt9SDvczpP@...2664...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

This patch need to be rebased again, does not apply to master anymore:
checking file src/openvpn/ssl.c
Hunk #1 succeeded at 297 (offset 1 line).
Hunk #2 FAILED at 321.
Hunk #3 succeeded at 1256 (offset -42 lines).

On Mittwoch, 11. Mai 2022 13:08:10 CEST Arne Schwabe wrote:
> @@ -141,6 +147,8 @@ User-visible Changes
> +- control channel packet maximum size is no longer influenced by ``--link-
mtu``/``--tun-mtu``
> +  and must be set by ``--tls-mtu`` now.

Must it or is there still some cc-mtu derivation in place in case it is not 
given? If not, wouldn't it make sense to at least catch obvious breakage. 
Usually link/tun-mtu is lowered for that reason. Further down in the patch 
there are min/max_int() calls in tls_init_control_channel_frame_parameters(), 
do they do what I suggested here already?

> diff --git a/doc/man-sections/link-options.rst
> +--tls-mtu size

Is --tls-mtu the best name for the option we can come up with? From my outside 
perspective (can hardly spell mtu right) the "tls" part is somewhat misnamed, 
as this is an SSL VPN after all. When you know that the framing for the data 
channel is not TLS you can make sense of it, but who does.

> +  The maximum packet size includes encapsulation overhead like UDP
> and IP. 
> \ No newline at end of file

^ this

> +    int tls_mtu;         /* Maximum MTU for the
> control channel messages */

The "M" already stands for "Maximum".



