MIME-Version: 1.0
In-Reply-To: <20160805061418.GO78279@...1296...>
References: <1470368394-2722-1-git-send-email-selva.nair@...277...>
	<20160805061418.GO78279@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Fri, 5 Aug 2016 09:32:35 +0200
Message-ID: <CAA1AbxJ8G5ztG1mgdkbvg7S9yqYuTwtq76SCkksUkrpVi8SjxA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid format specifier %zu for Windows
	compatibility
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

Hi,

On Fri, Aug 5, 2016 at 8:14 AM, Gert Doering <gert@...1296...> wrote:
> On Thu, Aug 04, 2016 at 11:39:54PM -0400, Selva Nair wrote:
>> -  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %zu bytes",
>> -      __func__, crypto_overhead);
>> +  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %d bytes",
>> +      __func__, (int) crypto_overhead);
>
> Just for clarification: how does this break windows?  mingw builds, or
> msvc builds?  Will it print "nothing" ("zu bytes") or wrong values?
>
> I had the suspicion that %zu wasn't as portable as Steffan hoped (and I
> seem to remember we've been there before :) ) but was too lazy to
> actually go out and research it.
>
> (Going to apply later today, so "ACK!", just curious)

MSVC 2015 claims to support C99 now (took them 16 years!), and it
should at least support %zu (which is part of C99).  Shouldn't we just
move (at least the master branch) to C99?  Or are there good reasons
to keep punishing ourselves with having to support C89?

-Steffan

