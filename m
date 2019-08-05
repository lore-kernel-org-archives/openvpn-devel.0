From: Antonio Quartulli <a@...2181...>
References: <20190805092529.9467-1-a@...2181...>
 <20190805092529.9467-2-a@...2181...>
 <201908050933.x759XIuU001220@...2300...>
Message-ID: <ab105e57-1b1c-e4da-9b68-dbc84e2fe8db@...2181...>
Date: Mon, 5 Aug 2019 11:47:53 +0200
MIME-Version: 1.0
In-Reply-To: <201908050933.x759XIuU001220@...2300...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/6] sitnl: harden strncpy() by forcing
 arguments to have the same length
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Casper.Dik@...2299...
Cc: openvpn-devel@lists.sourceforge.net

Hi and thanks for your review,

On 05/08/2019 11:33, Casper.Dik@...2299... wrote:
> 
> 
>> For this reason, force both strings to use IFNAMSIZ as size and, since
>> this constant may not exist on every platform, ensure it is always
>> defined.
> 
> A problem with this patch misght be that strncpy() does NOT NUL terminates the
> copied string.  (It writes EXACTLY IFNAMSIZ bytes but only when the string 
> is shorter, it will writes NUL bytes in the reminder of the char array[].)


the assumption behind this patch is that now both source and destination
buffer have exactly the same size (IFNAMSIZ) and the source is NULL
terminated. Therefore the problem you mentioned should not appear here,
I think.

> 
> You could use strlcpy() but I'm not sure if that is available in Windows.

This code is currently used only on Linux - it is not expected to ever
run on Windows.

Cheers,

> 
> 
>>
>>     /* save result in output variables */
>>     memcpy(best_gw, &res.gw, res.addr_size);
> -    strcpy(best_iface, res.iface);
>> +    strncpy(best_iface, res.iface, IFNAMSIZ);
> 
> Casper
> 

-- 
Antonio Quartulli
OpenVPN Inc.

-- 
Antonio Quartulli

