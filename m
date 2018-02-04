MIME-Version: 1.0
In-Reply-To: <20180204180104.GA65347@...1296...>
References: <1517391662-21325-1-git-send-email-arne@...1227...>
 <201802041050.w14Ao3W3061831@...2054...>
 <20180204180104.GA65347@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 4 Feb 2018 13:25:01 -0500
Message-ID: <CAKuzo_i3VH54an0r4dG8qKg=BUUmJaug13JOD6acddtmqAmHKg@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Treat dhcp-option DNS6 and
 DNS identical
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
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Feb 4, 2018 at 1:01 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Sun, Feb 04, 2018 at 11:50:03AM +0100, Gert Doering wrote:
>> I've taken the liberty to change the commit message and mention that it's
>> "v3" here :-)
>>
>> commit 849006bf17bba524e6f3344598adcbe41bedf450 (master)
>> commit 61a72ecd59a57a50d0757b56b16f4ed3ce700f3f (release/2.4)
>> Author: Arne Schwabe
>> Date:   Wed Jan 31 10:41:02 2018 +0100
>>
>>      Treat dhcp-option DNS6 and DNS identical
>
> This is... interesting.  The change is minor, but seems to have pushed the
> endless if/else if/else construction in options.c over an invisible cliff,
> and some buildbots (FreeBSD 7.4, Debian 8.5) now *sometimes* bomb with
> "signal 11" when gcc is compiling options.c ...
>
>   gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../include  -I../../src/compat           -DPLUGIN_LIBDIR=\"/usr/local/lib/openvpn/plugins\"  -g -O2 -std=c99 -MT options.o -MD -MP -MF .deps/options.Tpo -c -o options.o options.c
>   gcc: Internal error: Killed: 9 (program cc1)
>   Please submit a full bug report.
>   See <URL:http://gcc.gnu.org/bugs.html> for instructions.

Interesting indeed. In fact, 2 years ago, we had a report of msvc
failing (literally stack overflow !) on the long if-else chain in
option.c:

quoting from an old thread:

>On Thu, Dec 10, 2015 at 9:47 AM, Selva Nair <selva.nair@...277...> wrote:
>>Hi,
>>
>>On Wed, Dec 9, 2015 at 5:05 PM, Gisle Vanem <gvanem@...2101...> wrote:
>>
>>>While compiling src/openvpn/options.c with MSVC 2015, I got this
>>>
>>>error:
>>>
>>>  src/openvpn/options.c(5944): fatal error C1026: parser stack overflow, program too complex
>>>
>>>As a quick fix you can locally edit options.c to split the large if ..endif block with 300 or so  else-if's into two groups with a couple of goto's. I've no idea how msvc parses code, so this may or may not work.
>>>
>>>I've also seen such error in GeoIP-lib due to all the 'if..else if' statements.
>>>
>>>Can this be written using some kind of a table-lookup code instead?
>>
>>
>>The option parser code using if-else is very standard and the logic easy to follow, so I doubt there is a strong reason for re-writing it.
>>
>>Selva

At that time I had done some tests. from my notes:

"gcc with 100,000 if else
compiles using
~250 MB memory and ~8 minutes on 1 core of an 8 year old athlon.
So apparently there is no limit except for memory exhaustion."

I can't recall what version of gcc I had used. Its a bit surprising
that we now exhaust memory (even on a VM with only 512 MB memory).
Possibly newer gcc versions are approaching msvc efficiency in this
regard?

Selva

