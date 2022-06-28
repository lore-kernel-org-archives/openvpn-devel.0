Message-ID: <cc107d25-d188-76ed-6f33-9f8ea41d4cfd@...1227...>
Date: Tue, 28 Jun 2022 16:29:21 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-12-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220624083809.23487-12-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 11/25] dco: split option parsing routines
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 24.06.22 um 10:37 schrieb Antonio Quartulli:
> +        if (!finish_options(c))
> +        {
> +            msg(D_TLS_ERRORS, "ERROR: Failed to finish option processing");
> +            return false;
> +        }

This error is a bit too generic for my taste. Can we make it more 
specific? Like "Failed to apply options when finalising tun setup" or 
something?

Arne

