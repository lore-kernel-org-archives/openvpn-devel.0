MIME-Version: 1.0
References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-8-a@...2181...>
 <YT9F8nPtG1Xh2adu@...1296...>
In-Reply-To: <YT9F8nPtG1Xh2adu@...1296...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 13 Sep 2021 10:20:13 -0400
Message-ID: <CAEsd45S+QnNQo_aL5JrSSeWxo1v-kJVD9wD3SH4ss7Wt7RApCw@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Sep 13, 2021 at 8:37 AM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Sat, Sep 04, 2021 at 11:56:29AM +0200, Antonio Quartulli wrote:
> > Add warning at startup to notify users about the change.
> [..]
> > +    /* Give a general warning at the end of initialisation that defaults
> > +     * have changed */
> > +    msg(M_WARN, "Note that modernisation of defaults in OpenVPN 2.6 limits "
> > +                "compatibility with old versions. See Changes.rst and "
> > +                "--compat-mode in the manual for details.");
> >  }
>
> I have my doubts if this is a good way forward.
>
> This warning will be printed on *every single startup* on OpenVPN now.
>
> Is this useful?  Or will people just ignore it.  Like, "all of a sudden
> my Tunnelblick shows some giberrish in red at me, but the VPN is working,
> so let's just ignore all warnings now".

( Actually, Tunnelblick will show it in **yellow** : )

I don't think the warning will be very useful. Most Tunnelblick users
don't look at the log. Those who do usually ignore warnings. Those who
look at the log and don't ignore warnings often focus on ones which
sound scary but whose benefits usually outweigh the risks or ask why
the VPN works even though there are warnings. (Maybe there's less of a
distinction between warning and error in other languages than there is
in English? Or our translations aren't as clear about the
distinction?)

Tunnelblick warnings usually include a "do not warn about this again"
option, which the OpenVPN log can't include.

