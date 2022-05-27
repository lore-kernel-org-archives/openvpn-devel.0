From: Heiko Hund <heiko@...2662...>
Date: Fri, 27 May 2022 13:51:42 +0200
Message-ID: <2187538.hfE9mN57os@...2664...>
In-Reply-To: <YpC4yTOjnZr2EGvF@...1296...>
References: <20220527113411.1846837-1-heiko@...2662...>
 <YpC4yTOjnZr2EGvF@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] include unistd.h for _exit(2)
 declaration
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Gert

On Freitag, 27. Mai 2022 13:40:57 CEST Gert Doering wrote:
> <unistd.h> is included by "syshead.h" already today, with a nice
> HAVE_UNISTD_H wraper (thus, not depending on a "if it's not WIN32,
> it surely must have unistd.h" assumption).
> 
> So I wonder what issue this fixes?  I see no compile time warnings about
> _exit() either.

I get "Implicit declaration of function '_exit' is invalid in C99 [-Wimplicit-
function-declaration]" complaints from my semantic analyzer, but it's because 
it didn't pick up the -DHAVE_CONFIG_H. So I think that can be ignored indeed.
Apologies for the noise.

Heiko




