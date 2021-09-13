References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-8-a@...2181...> <YT9F8nPtG1Xh2adu@...1296...>
 <CAEsd45S+QnNQo_aL5JrSSeWxo1v-kJVD9wD3SH4ss7Wt7RApCw@...278...>
 <CAKuzo_hSs54xeU4z0oP5zqysraR8_ghSwGiMPuvjKNxEkv+LUg@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <504f0c45-0090-325d-b80a-73376679e13a@...2181...>
Date: Mon, 13 Sep 2021 21:23:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hSs54xeU4z0oP5zqysraR8_ghSwGiMPuvjKNxEkv+LUg@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 7/7] add message about changing default
 values
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
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, "Jonathan K. Bullard" <jkbullard@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 13/09/2021 18:51, Selva Nair wrote:
> Hi
> 
> On Mon, Sep 13, 2021 at 10:22 AM Jonathan K. Bullard
> <jkbullard@...277... <mailto:jkbullard@...277...>> wrote:
> 
>     Hi,
> 
>     On Mon, Sep 13, 2021 at 8:37 AM Gert Doering <gert@...1296...
>     <mailto:gert@...1296...>> wrote:
>     >
>     > Hi,
>     >
>     > On Sat, Sep 04, 2021 at 11:56:29AM +0200, Antonio Quartulli wrote:
>     > > Add warning at startup to notify users about the change.
>     > [..]
>     > > +    /* Give a general warning at the end of initialisation that
>     defaults
>     > > +     * have changed */
>     > > +    msg(M_WARN, "Note that modernisation of defaults in OpenVPN
>     2.6 limits "
>     > > +                "compatibility with old versions. See
>     Changes.rst and "
>     > > +                "--compat-mode in the manual for details.");
>     > >  }
>     >
>     > I have my doubts if this is a good way forward.
>     >
>     > This warning will be printed on *every single startup* on OpenVPN now.
>     >
>     > Is this useful?  Or will people just ignore it.  Like, "all of a
>     sudden
>     > my Tunnelblick shows some giberrish in red at me, but the VPN is
>     working,
>     > so let's just ignore all warnings now".
> 
>     ( Actually, Tunnelblick will show it in **yellow** : )
> 
>     I don't think the warning will be very useful. Most Tunnelblick users
>     don't look at the log. Those who do usually ignore warnings. Those who
>     look at the log and don't ignore warnings often focus on ones which
>     sound scary but whose benefits usually outweigh the risks or ask why
>     the VPN works even though there are warnings. (Maybe there's less of a
>     distinction between warning and error in other languages than there is
>     in English? Or our translations aren't as clear about the
>     distinction?)
> 
> 
> +1
>  
> 
> 
>     Tunnelblick warnings usually include a "do not warn about this again"
>     option, which the OpenVPN log can't include.
> 
>  
> OpenVPN-GUI for windows will show this in red (I find yellow too hard to
> read on light backgrounds). Looks like we also will have to implement
> this "do not show this again (or ever?)" feature.
> 
> Ideally, this warning should be targeted to cases like a mismatched
> option is detected. But that may be hard. What about printing this only
> when an "old" client connects (on server) or when an "old" server
> responds (on client)? Where "old" = 2.5 or older?
> 

IMHO this warning should just not be added.
It creates noise and confusion.

On top of that, we will need an even longer discussion to figure out
when to remove it, even though we know it is not really benefiting users.

I vote for just dropping this patch.
If somebody feels we should find a smarter way to warn the user about
possibly mismatching settings due to new default, then a new patch can
be sent after this patchset is already in.

my 2 cents.

Cheers,


-- 
Antonio Quartulli

