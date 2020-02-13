From: Arne Schwabe <arne@...1227...>
References: <20191117181243.28919-1-arne@...1227...>
 <20191117181243.28919-2-arne@...1227...>
 <CAGyAFMX0MMWHC3GTpfoP1VOvvenNkzdrpZj_5N5RMNa8LphGYw@...278...>
Message-ID: <1791ea6f-68da-43f5-e261-0d3b8cf63972@...1227...>
Date: Thu, 13 Feb 2020 15:14:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAGyAFMX0MMWHC3GTpfoP1VOvvenNkzdrpZj_5N5RMNa8LphGYw@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH 2/4] Implement dynamic NCP negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 13.02.20 um 12:45 schrieb Lev Stipakov:
> Hi,
> 
> su 17. marrask. 2019 klo 20.13 Arne Schwabe (arne@...1227...
> <mailto:arne@...1227...>) kirjoitti:
> 
>> +#include "ssl_ncp.h"
> 
> this file is missing from this patch.
> 
>> +    const char *token = strsep(&tmp_ciphers, ":");
> 
> This breaks on Windows.
> 
> Could you send v2 with strsep-compat and removed header (which is
> introduced in v3) ?
>
Patch 6 takes cares of fixing Windows compatibility.

Arne

