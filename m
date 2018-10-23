MIME-Version: 1.0
References: <1540203571-17646-1-git-send-email-lstipakov@...277...>
 <201810221837.w9MIbEKK048744@...2054...>
In-Reply-To: <201810221837.w9MIbEKK048744@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 23 Oct 2018 10:10:05 -0400
Message-ID: <CAKuzo_ji71-1Td7XO38MUB3YhdPDYrHcy21XBiSj8L1YZsa2NA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Introduce
 openvpn_swprintf() with nul termination guarantee
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
Cc: lev@...515..., openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Mon, Oct 22, 2018 at 2:38 PM Gert Doering <gert@...1296...> wrote:
>
> Your patch has been applied to the master branch.
>
> I'm not sure I totally like the change to buffer.c/tun.c - for the
> single instance where this is called inside openvpn/tun.c, on WIN32,
> we now carry around a new function in buffer.c which is compiled
> everywhere... possibly breaking older systems that have C99 compliant
> C compilers but no full C99 library - like my oldest OpenBSD
> buildslave (our mantra on that is "if it breaks for good reasons,
> it will be retired, but we shouldn't carelessly break things").

Good point. We should never need (v)swprintf on non-windows
platforms as keeping strings in utf8 should be the preferred way.

Enclosing  this inside #ifdef _WIN32 sounds good. My bad to be too
much fixated on Windows during review..

Selva

