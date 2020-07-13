References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-3-arne@...1227...>
 <20200713112936.GW1431@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0586fadf-2850-c246-597a-89db12a606a7@...2181...>
Date: Mon, 13 Jul 2020 14:16:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200713112936.GW1431@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5 03/14] client-connect: Refactor
 multi_client_connect_source_ccd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 13/07/2020 13:29, Gert Doering wrote:
> instead, maybe this?
> 
>> +        const char *ccd_client = 
>> +             platform_gen_path(mi->context.options.client_config_dir,
>> +                               tls_common_name(mi->context.c2.tls_multi,
>> +                                               false), &gc);
> 

I also like the above.

> or maybe we want to extract "tls_common_name(..., false)" into a temp
> variable here? 
> 
>> +        const char *cn = tls_common_name(mi->context.c2.tls_multi, false);
>> +        const char *ccd_client = 
>> +             platform_gen_path(mi->context.options.client_config_dir, 
>                                   cn, &gc);
> 

Imho this is not prettier than the version above :D so I'd personally go
with the version above instead of this.


Cheers,


-- 
Antonio Quartulli

