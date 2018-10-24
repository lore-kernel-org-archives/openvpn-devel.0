MIME-Version: 1.0
References: <CAKuzo_ji71-1Td7XO38MUB3YhdPDYrHcy21XBiSj8L1YZsa2NA@...278...>
 <1540306288-23847-1-git-send-email-lstipakov@...277...>
 <ec38d493-7b31-4f29-6877-bf0af7712e0c@...2181...>
 <CAKuzo_iyq0d-WbaXsVks7E9YL1=0_dN_JkBiyWKCs6fyUd9wOQ@...278...>
 <6fb8c277-3819-e266-f125-7bf35d2b3f7a@...2080...>
In-Reply-To: <6fb8c277-3819-e266-f125-7bf35d2b3f7a@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 24 Oct 2018 09:36:51 -0400
Message-ID: <CAKuzo_j7m=ttFQLiDUPyCSc8Ocg7uMCpqdCi=O0RYQNx_460Eg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Wrap openvpn_swprintf into Windows
 define
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

Hi,

On Wed, Oct 24, 2018 at 9:00 AM David Sommerseth
<openvpn@...2080...> wrote:
>
> On 24/10/18 14:39, Selva Nair wrote:
> > On Wed, Oct 24, 2018 at 6:23 AM Antonio Quartulli <a@...2181...> wrote:
> >>
> >> Hi,
> >>
> >
> >
> > Also there is a misplaced and mismatched comment added to
> > buffer.c that says
> >
> > +        /* vswprintf is missing in OpenBSD 4.2 */
> >          len = vswprintf(str, size, format, arglist);
> >
> > Makes little sense in that context and why 4.2..
> > That one could be removed.
> I'd say we should have such a reference in right below the #ifdef _WIN32 a few
> lines higher up.  And it could be slightly more informative (and should
> reference OpenBSD 4.9, which is the distro exploding without this patch.

Yes, that's why I wrote "misplaced" and "mismatched" :)

> I suggest the comment below the #ifdef _WIN32 to be something like:
>
> /*
>  * openvpn_swprintf() is currently only used by Windows code paths
>  * and when enabled for all platforms it will currently break
>  * OpenBSD 4.9 which lacks vswprintf(3) support in its libc.
>  */

Looks good except,  <=4.9, not just 4.9, or whatever version is appropriate.
(As Antonio already pointed out.)

Selva

