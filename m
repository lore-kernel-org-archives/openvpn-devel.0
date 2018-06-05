MIME-Version: 1.0
In-Reply-To: <20180605143603.GL57262@...1296...>
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...>
 <20180605143603.GL57262@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 5 Jun 2018 11:54:14 -0400
Message-ID: <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
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
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Jun 5, 2018 at 10:36 AM, Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> Prelimiaries: I think this whole series should only go to 2.5, as it
> has the potential to be fairly intrusive and uncover hidden bugs - I've
> discussed this with Antonio already (and we're in agreement) but for
> the sake of the list.
>
>
> On Tue, Jun 05, 2018 at 05:04:17PM +0800, Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@...515...>
> >
> > This change ensures that an interface is properly brought
> > up even when only IPv6 settings are configured.
> >
> > This can be useful on a client that wants to ignore the IPv4
> > settings pushed by the server and configure only IPv6.
> > To achieve the above, a client can use
> > `pull-filter ignore "ifconfig "` (thanks Gert for this hint).
> >
> > Trac: #208
> > Cc: Gert Doering <gert@...1296...>
> > Signed-off-by: Antonio Quartulli <antonio@...515...>
>
> ACK on the feature, but NAK on "we can do this more nicely" reasons :-)
>
> First, I'd leave off the bits about "this can be useful" of the commit
> message - because that's not the point of this patch, you can *ignore*
> the settings already today.    Maybe word this
>
>   "This patch enables the client to run IPv6-only on the tun/tap interface,
>    but will not make it ignore a pushed IPv4 config.  To achieve that, one
>    can use 'pull-filter ignore "ifconfig "' on the client or 'push-filter' on
>    the server".
>
> (if we want to go into this here at all)


I don't think this belongs here and such advice could include other
details like what
to do with routes, redirect gateway etc. Better add it to the howto.

A more serious thing:

- On windows we require that ifconfig is required with --dev tun. This
has to change. Could be tricky as TAP_WIN_IOCTL_CONFIG_TUN requires a
v4 address.

Minor stuff:

- If no v4 address is set but still v4 routes are specified we should at least
print a warning as we do with ipv6.

- redirect-gateway : we may want to force !ipv4 if ifconfig is missing
 or should we mutate it to "ipv6 !ipv4" ?

May be there are more such nuances -- this patch will need some thoroug
testing before being ready for review.

>
> Of course we'll also need to check if typical consumers of the management
> interface explode if you're not giving an IPv4 address to them...
>
> Selva, Jonathan, how will our GUI and Tunnelblick handle that?

Windows GUI uses configured IPs only for logging and display so I
don't think it will complain, let alone explode. If any changes are
needed, likely to be minimal. We have to just keep the format of
reporting configured IPs unchanged even if some elements may be blank.

Selva

