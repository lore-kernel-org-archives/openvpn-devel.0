MIME-Version: 1.0
References: <CAKuzo_ji71-1Td7XO38MUB3YhdPDYrHcy21XBiSj8L1YZsa2NA@...278...>
 <1540306288-23847-1-git-send-email-lstipakov@...277...>
 <ec38d493-7b31-4f29-6877-bf0af7712e0c@...2181...>
In-Reply-To: <ec38d493-7b31-4f29-6877-bf0af7712e0c@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 24 Oct 2018 08:39:55 -0400
Message-ID: <CAKuzo_iyq0d-WbaXsVks7E9YL1=0_dN_JkBiyWKCs6fyUd9wOQ@...278...>
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

On Wed, Oct 24, 2018 at 6:23 AM Antonio Quartulli <a@...2181...> wrote:
>
> Hi,
>
> On 23/10/18 22:51, Lev Stipakov wrote:
> > From: Lev Stipakov <lev@...515...>
> >
> > Commit 43a5a4f3b4e411419639c195fee8a76495fdc88e added
> > vswprintf() call which turned to me missing in OpenBSD 4.9.
> >
> > Since that call is inside openvpn_swprintf() function which
> > is only used by Windows, wrap that function info #ifdef _WIN32.
> >
> > Signed-off-by: Lev Stipakov <lev@...515...>
>
> This patch introduces another ifdef, but it is enclosing a whole
> function to prevent it from being compiled on non-windows platforms,
> therefore I consider it "acceptable" for the time being.
>
> This patch fixes building openvpn on OpenBSD <= 4.9 (maybe this info
> should be added to the commit message).

Also there is a misplaced and mismatched comment added to
buffer.c that says

+        /* vswprintf is missing in OpenBSD 4.2 */
         len = vswprintf(str, size, format, arglist);

Makes little sense in that context and why 4.2..
That one could be removed.

Otherwise an ACK from me too.

Selva

