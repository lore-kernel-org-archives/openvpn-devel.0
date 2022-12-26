Message-ID: <9cf2eb34-aaac-a836-81d9-a8ae45d16a36@...1227...>
Date: Mon, 26 Dec 2022 20:31:58 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20210825040122.14244-1-selva.nair@...277...>
 <20210825210232.22509-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20210825210232.22509-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Add remote-count and
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

First sorry for completely forgetting about this patch series.

Am 25.08.21 um 23:02 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> Selecting the remote host via the management iterface

Typo in interface

> +
> +static bool
> +management_callback_remote_entry_get(void *arg, unsigned int index, char **remote)
> +{
> +    assert(arg);
> +    assert(remote);
> +
> +    struct context *c = (struct context *) arg;
> +    struct connection_list *l = c->options.connection_list;
> +    bool ret = true;
> +
> +    if (index < l->len)
> +    {
> +        struct connection_entry *ce = l->array[index];
> +        const char *proto = proto2ascii(ce->proto, ce->af, false);
> +
> +        /* space for output including 2 commas and a nul */
> +        int len = strlen(ce->remote) + strlen(ce->remote_port) + strlen(proto) + 2 + 1;
> +        char *out = malloc(len);
> +        check_malloc_return(out);

Not sure that we need to exit the program here instead of of return 
false but the error is so seldom that it does not really matter. Using 
gc_arena would have been also a bit nicer but not too problematic.

> +
> +        openvpn_snprintf(out, len, "%s,%s,%s", ce->remote, ce->remote_port, proto);
> +        *remote = out;
> +    }
> +    else
> +    {
> +        ret = false;
> +        msg(M_WARN, "Out of bounds index in management query for remote entry: index = %u", index);
> +    }
> +
> +    return ret;

I feel we could eliminate ret variable here and just do return true and 
return false from the true branches of the if.

There are minor things that could be improved but the current state is 
still acceptable.

Acked-By: Arne Schwabe <arne@...1227...>


