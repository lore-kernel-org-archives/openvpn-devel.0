MIME-Version: 1.0
References: <20200205124615.15758-1-domagoj@...2540...>
 <20200205124615.15758-3-domagoj@...2540...>
 <20200205130511.GM1431@...1296...> <20200205131828.GA16251@...2540...>
 <CAKuzo_h2XNEm+UnGEvcoF5g2rwDdsTMTjtA-p0uHdsMu7HGP2w@...278...>
In-Reply-To: <CAKuzo_h2XNEm+UnGEvcoF5g2rwDdsTMTjtA-p0uHdsMu7HGP2w@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 5 Feb 2020 10:28:38 -0500
Message-ID: <CAKuzo_i3-3xXYP+f+GAJKtDVOajD5iE+vg9fa2XrHUbg1PFzSg@...278...>
Subject: [Openvpn-devel] Fwd:  [PATCH 2/2] Fix linking issues on MinGW
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

---------- Forwarded message ---------
From: Selva Nair <selva.nair@...277...>
Date: Wed, Feb 5, 2020 at 10:16 AM
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix linking issues on MinGW
To: Domagoj Pensa <domagoj@...2540...>
Cc: Gert Doering <gert@...1296...>


Hi,

On Wed, Feb 5, 2020 at 8:31 AM Domagoj Pensa <domagoj@...2540...> wrote:
>
> Hi!
>
> On Wed, Feb 05, 2020 at 02:05:11PM +0100, Gert Doering wrote:
> > Hi,
> >
> > On Wed, Feb 05, 2020 at 01:46:15PM +0100, Domagoj Pensa wrote:
> > > MinGW linking fails for several files due to a missing "static"
> > > declaration in functions tuntap_is_wintun() and tuntap_ring_empty().
> >
> >


Are you building without optimization? Please try using the latest
openvpn-build (or just add -O2 to complier options).

I suspect this is caused by the fact that gcc does not inline when
optimization is not on, but also not generating exported code in that
case. Inline implementation in gcc has so many subtleties, so not sure
whether this is a compiler bug or "feature".

Adding a static appears to be not a bad solution as gcc will emit
external code for static inline functions only if necessary.

Selva

