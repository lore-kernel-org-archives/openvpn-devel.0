MIME-Version: 1.0
In-Reply-To: <20161217100520.GR78624@...1296...>
References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
	<dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
	<44d2e307-1954-de7f-9979-68728de900b3@...1926...>
	<20161217100520.GR78624@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Sat, 17 Dec 2016 11:16:10 +0100
Message-ID: <CAA1AbxJ+noz-HNHXS0Zrq3mScHJBRH7fQgSBP9F-b9J2LjKRPg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
 compiler supports them
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 17 December 2016 at 11:05, Gert Doering <gert@...1296...> wrote:
> On Fri, Dec 16, 2016 at 11:16:08PM +0100, Julien Muchembled wrote:
>> BTW, instead of failing on these 3 specific warnings, we could go the opposite way, since -Wall is quite silent. I suggest:
>>
>>   -Wall -Wno-unused -Wno-pointer-sign -Werror -Wno-error=strict-aliasing -Werror=format-security
>
> NAK to "-Wall -Werror", unless you've tested that this does not break
> compilation on any of the supported platforms.

Sure, but I think we should help out with that.  Such as, do a test
build on the supported platforms and see what fixes / extra flags we
need to make it work.  (I say we, because although I don't have access
to the build systems, I am willing to help out with fixing fallout.)

I'm willing to invest in this, because I think using the compiler as a
sanity checker more will save us time in the long run.

-Steffan

