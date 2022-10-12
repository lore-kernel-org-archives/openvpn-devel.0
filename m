Message-ID: <97c6cc41-72dc-15f0-7504-ea0a42992513@...1227...>
Date: Wed, 12 Oct 2022 15:32:34 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220925221713.2450-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220925221713.2450-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v5] push-peer-info: rearrange function
 generating peer info
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


> -    }
> -    else
> -    {
> -        if (!write_empty_string(buf)) /* no peer info */
> -        {
> +        /* invalid value configured */
> +        default:
> +            msg(M_WARN, "Invalid peer-info-detail level %d", session->opt->push_peer_info_detail);
>               goto error;

This should probably be an ASSERT or fatal error as the user cannot set 
the push_peer_info_detail variable directly. So if we end up here this 
is a bug.

Arne


