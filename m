MIME-Version: 1.0
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-24-a@...2181...>
In-Reply-To: <20220624083809.23487-24-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 28 Jun 2022 11:46:28 +0300
Message-ID: <CAGyAFMWO0uBdXXpCv2UAmAFmOHvPTtROojNUjz5_h4buQTJTWw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 23/25] dco-win: implement ovpn-dco
 support in P2P Windows code path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

I did some testing and found out that this breaks when establishing
TCP connection to a server which cannot be reached:

> +    *tt = dco_create_socket(sock->info.lsa->current_remote,
> +                            sock->bind_local,
> +                            sock->info.lsa->bind_local,
> +                            c->options.dev_node,
> +                            &c->gc,
> +                            get_server_poll_remaining_time(sock->server_poll_timeout),
> +                            signal_received);
> +    if (*signal_received)
> +    {
> +        return;
> +    }
> +    c->c1.tuntap = tt;
> +    sock->info.dco_installed = true;

If TCP server cannot be reached, the kernel reports it to userspace
which triggers a signal. Signal handler calls
teardown code which accesses c->c1.tuntap, which is not set (since
return is above the assignment), causing access violation.

dco_installed flag should also be moved above return, since if not
set, c->c1.tuntap won't be cleared
which triggers this assert after reconnect:

    /* In this case persist-tun is enabled, which we don't support yet */
    ASSERT(!c->c1.tuntap);

I suggest to change code like this:

    /* This state is used by signal handler which does teardown,
     * so it has to be set before return */
    c->c1.tuntap = tt;
    sock->info.dco_installed = true;

    if (*signal_received)
    {
        return;
    }

Again, we discussed this in chat and suggested changes are already
pushed to the dco branch.

-Lev

