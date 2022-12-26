Message-ID: <0366748c-832f-2704-9693-ef6842489977@...1227...>
Date: Mon, 26 Dec 2022 20:45:19 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20210825210232.22509-1-selva.nair@...277...>
 <20210907223126.8440-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20210907223126.8440-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/3] Add remote-count and
 remote-entry query via management
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 08.09.21 um 00:31 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> Selecting the remote host via the management iterface

*sigh* I reviewed the v2 instead of the v3 but the typo is still here :P

> +static void
> +man_remote_entry_count(struct management *man)
> +{
> +    unsigned count = 0;
> +    if (man->persist.callback.remote_entry_count)
> +    {
> +        count = (*man->persist.callback.remote_entry_count)(man->persist.callback.arg);

We could use C99 style here.

> +        msg(M_CLIENT, "%u", count);
> +        msg(M_CLIENT, "END");
> +    }
> +    else
> +    {
> +        msg(M_CLIENT, "ERROR: The remote-entry-count command is not supported by the current daemon mode");
> +    }
> +}
> +
> +#define min(a,b) ((a) < (b) ? (a) : (b))

We already have min_int and min_uint in integer.h. For consistency I 
would prefer using those instead of adding a macro.


> +
> +static void
> +man_remote_entry_get(struct management *man, const char *p1, const char *p2)
> +{
> +    ASSERT(p1);
> +
> +    if (man->persist.callback.remote_entry_get
> +        && man->persist.callback.remote_entry_count)
> +    {
> +        bool res;
> +        unsigned int from, to;
> +        unsigned int count = (*man->persist.callback.remote_entry_count)(man->persist.callback.arg);
> +
> +        from = (unsigned int) atoi(p1);
> +        to = p2? (unsigned int) atoi(p2) : from + 1;
> +

We probably want a space after p2.

I know this has been very long and we are very close to 2.6 so

Acked-By: Arne Schwabe <arne@...1227...>

Maybe we can do a follow up patch to fix the mentioned small issues.

