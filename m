References: <20210825040122.14244-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <87212698-ffd0-3178-8b46-d3f088092eb8@...1227...>
Date: Wed, 25 Aug 2021 16:24:51 +0200
MIME-Version: 1.0
In-Reply-To: <20210825040122.14244-1-selva.nair@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/2] Add remote-count and remote-entry
 query via management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: selva.nair@...277..., "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>  
> +static bool
> +management_callback_remote_entry(void *arg, unsigned *count, char **remote)
> +{
> +    assert(arg);
> +    assert(count);
> +
> +    struct context *c = (struct context *) arg;
> +    struct connection_list *l = c->options.connection_list;
> +    bool ret = true;
> +
> +    if (!remote) /* query is for the count of entries */
> +    {
> +        *count = l->len;
> +    }
> +    else if (*count < l->len) /* the query is for entry with index = count */
> +    {
> +        struct connection_entry *ce = l->array[*count];
> +        const char *proto = proto2ascii(ce->proto, ce->af, false);
> +
> +        /* space for output including 2 commas and a nul */
> +        int len = strlen(ce->remote) + strlen(ce->remote_port) + strlen(proto) + 2 + 1;
> +        char *out = malloc(len);
> +        check_malloc_return(out);
> +
> +        openvpn_snprintf(out, len, "%s,%s,%s", ce->remote, ce->remote_port, proto);
> +        *remote = out;
> +    }
> +    else
> +    {
> +        ret = false;
> +        msg(M_WARN, "Invalid arguments in management query for remote entry: count = %u", *count);
> +    }
> +    return ret;
> +}
> +

I am not sure mixing two related but different functions into one
function has any real advantages. A function that just returns the count
would simplify that function and this function.
> +static void
> +man_remote_entry_count(struct management *man)
> +{
> +    unsigned count = 0;
> +    if (man->persist.callback.remote_entry)
> +    {
> +        (*man->persist.callback.remote_entry)(man->persist.callback.arg, &count, NULL);

The return value is not used here, this might upset some compilers.

> +        msg(M_CLIENT, ">REMOTE-ENTRY-COUNT:%u", count);
> +    }
> +    else
> +    {
> +        msg(M_CLIENT, "ERROR: The remote-entry-count command is not supported by the current daemon mode");
> +    }
> +}

At some point we should do a helper function that does this boilerplate
code that we copy&paste here over and over.


Arne


