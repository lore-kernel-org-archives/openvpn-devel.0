MIME-Version: 1.0
In-Reply-To: <20180618184046.GG57262@...1296...>
References: <20180608052017.6696-3-a@...2181...>
 <20180613141213.5962-1-a@...2181...>
 <20180618184046.GG57262@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 18 Jun 2018 14:52:21 -0400
Message-ID: <CAKuzo_hkWPzT9wKo+UB-wUM_wSEjBJtZMdjw0yt2uCyAkm8RKA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
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

On Mon, Jun 18, 2018 at 2:40 PM, Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Wed, Jun 13, 2018 at 10:12:13PM +0800, Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@...515...>
> >
> > This patch ensures that the TAP driver on a windows host is still
> > configured, even though no IPv4 has been provided.
> >
> > In this case the TAP driver ioctl will be invoked with a fake
> > 0.0.0.0/0.0.0.0 IPv4 which will simply start the interface and
> > get it to a working state.
> >
> > Trac: #208
> > Signed-off-by: Antonio Quartulli <antonio@...515...>
>
> I think this is good enough, though I haven't tested it yet (compile
> and run).  Will do that tomorrow, before I merge & push.
>
> Before I go ahead with it - Selva, are you fine with this version?

I believe this is the same as the gitlab version I had tested and
commented on. I only had some opinionated remarks (nothing critical),
so this should be good to merge.

Selva

