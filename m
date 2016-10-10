References: <1476035934-5055-1-git-send-email-lstipakov@...277...>
	<1476111286-27602-1-git-send-email-lstipakov@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3021529e-5ddb-581a-11f6-ef1cdcf76221@...1856...>
Date: Mon, 10 Oct 2016 21:35:51 +0200
MIME-Version: 1.0
In-Reply-To: <1476111286-27602-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] Use separate list for per-client
 push options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 10-10-16 16:54, Lev Stipakov wrote:
> Move client-specific push options (currently peer-id and cipher) to
> separate list, which is deallocated after push_reply
> has been send. This makes sure that options fit into buf,
> not duplicated nor leak memory on renegotiation.

Feature-ACK.  Very needed refactoring.

But some very minor comments:

> - * @param o		The current connection's options
> - * @param msglevel	The message level to use when printing errors
> + * @param gc		GC arena where options are allocated
> + * @param push_list Push list containing options
> + * @param msglevel  The message level to use when printing errors
>   * @param fmt		Format string for the option

Some whitespace inconsistencies here (looks funny with ts=8).

> +prepare_push_reply (struct context *c, struct gc_arena *gc, struct push_list *push_list)

> +  if (c->c2.push_ifconfig_defined && c->c2.push_ifconfig_local && c->c2.push_ifconfig_remote_netmask)

> +	  push_option_fmt(gc, push_list, M_USAGE, "peer-id %d", tls_multi->peer_id);

These lines exceed 80 chars (and won't get much harder to read from
wrapping), so please wrap them.

I ran some smoke tests, but my jenkins broke down do didn't test very
thoroughly.  Still, the code looks very reasonable and smoke tests
succeed, so ACK if the above nitpicks are taken care of.

-Steffan

