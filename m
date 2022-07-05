From: Heiko Hund <heiko@...2662...>
Date: Tue, 05 Jul 2022 14:36:15 +0200
Message-ID: <6059357.uOSKjd3mqY@...2664...>
In-Reply-To: <20220624083809.23487-3-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-3-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 02/25] dco: add helper function to
 detect if DCO is enabled or not
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

On Freitag, 24. Juni 2022 10:37:46 CEST Antonio Quartulli wrote:
> +/**
> + * Returns whether the current configuration has dco enabled.
> + */
> +static inline bool
> +dco_enabled(const struct options *o)
> +{
> +    return !o->tuntap_options.disable_dco;
> +}

I think it would be beneficial if this took a tun_options* instead, as it 
could be used more widely and replace the many "!tt->options.disable_dco" 
occurrences and alike.



