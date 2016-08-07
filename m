MIME-Version: 1.0
In-Reply-To: <CAKuzo_gsjEjhCZ7eczDtGb2XOrjXwKh4LroL4ULZrc96Jy8Lhg@...278...>
References: <1470368394-2722-1-git-send-email-selva.nair@...277...>
	<20160805061418.GO78279@...1296...>
	<CAA1AbxJ8G5ztG1mgdkbvg7S9yqYuTwtq76SCkksUkrpVi8SjxA@...278...>
	<CAKuzo_gsjEjhCZ7eczDtGb2XOrjXwKh4LroL4ULZrc96Jy8Lhg@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 7 Aug 2016 16:04:08 +0200
Message-ID: <CAA1Abx+CTuRmnZJEJB9zCVjAv6bMNicsPiRg6wNdtac+fKF4gQ@...278...>
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 5 August 2016 at 15:09, Selva Nair <selva.nair@...277...> wrote:
> On Fri, Aug 5, 2016 at 3:32 AM, Steffan Karger <steffan@...1856...> wrote:
>> On Fri, Aug 5, 2016 at 8:14 AM, Gert Doering <gert@...1296...> wrote:
>> > On Thu, Aug 04, 2016 at 11:39:54PM -0400, Selva Nair wrote:
>> >> -  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %zu
>> >> bytes",
>> >> -      __func__, crypto_overhead);
>> >> +  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %d
>> >> bytes",
>> >> +      __func__, (int) crypto_overhead);
>> >
>> > Just for clarification: how does this break windows?  mingw builds, or
>> > msvc builds?  Will it print "nothing" ("zu bytes") or wrong values?
>
> mingw (my version is gcc 4.6.3)  prints zu bytes. I think this could be also
> fixed by defining  __USE_MINGW_ANSI_STDIO=1

I looked into this a bit, and it should indeed fix the printing of %zu
on Windows.  I would prefer to teach autotools to include this flag on
Windows builds, instead of the suggested casts in the code.  (But if
you both prefer the casts, just ignore my rambling.)

-Steffan

