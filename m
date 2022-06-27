Message-ID: <5f11fefe-6f62-7b6b-72ed-0d76debbb0f7@...1227...>
Date: Mon, 27 Jun 2022 13:47:27 +0200
MIME-Version: 1.0
From: Arne Schwabe <arne@...1227...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-6-a@...2181...>
Content-Language: en-GB
In-Reply-To: <20220624083809.23487-6-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 05/25] dco: let open_tun_generic handle
 the DCO case
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 24.06.22 um 10:37 schrieb Antonio Quartulli:
> +                int ret = open_tun_dco(tt, ctx, dynamic_name);
> +                if (ret == -EEXIST)
> +                {
> +                    msg(M_INFO, "TUN/TAP device %s exists previously, keep at program end",
> +                        dynamic_name);
> +                    tt->persistent_if = true;
> +                }


I think here the error message is really confusing. What does "keep at 
program end" mean? And if we fail at opening DCO tun device why do we 
talk about a TUN/TAP device and not about DCO?

Arne

