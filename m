From: Heiko Hund <heiko@...2662...>
Date: Mon, 10 Oct 2022 16:24:05 +0200
Message-ID: <23297311.EfDdHjke4D@...2664...>
In-Reply-To: <20220625234150.3398864-3-arne@...1227...>
References: <20220625234150.3398864-1-arne@...1227...>
 <20220625234150.3398864-3-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3 3/5] Push server mtu to client when
 support and support occ mtu
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

On Sonntag, 26. Juni 2022 01:41:48 CEST Arne Schwabe wrote:
> To maximise compatibility allow to  lie our MTU in the default OCC
> message.
> 
> Patch v2: improve documentation
> Patch v3: split changing default MTU into its own patch

Doesn't apply to master anymore. From what I have seen, besides the small typo 
below:
Acked-by: Heiko Hund <heiko@...2662...>

> +  Starting with OpenVPN 2.6  when running server mode (``--mode server``,
> +  ``--server``, or ``-server-ipv6`` options present in the configuration),

Should be ``--server-ipv6``



