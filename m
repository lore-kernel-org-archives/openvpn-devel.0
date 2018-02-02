References: <20180201072731.GU69387@...1296...>
 <20180201154521.7642-1-steffan@...1856...>
 <CAKuzo_jyu-zuJDTXJkB2iV=MQ=Yx74uo_Eo8XN3Sgr5YLR460g@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <b1f23a13-e547-be90-9c7d-690245c86fdd@...1856...>
Date: Fri, 2 Feb 2018 07:32:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jyu-zuJDTXJkB2iV=MQ=Yx74uo_Eo8XN3Sgr5YLR460g@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Enable stricter compiler warnings by
 default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 02-02-18 05:43, Selva Nair wrote:
> On Thu, Feb 1, 2018 at 10:45 AM, Steffan Karger <steffan@...1856...> wrote:
>> [...]
>>
>> +AX_CHECK_COMPILE_FLAG([-Wall], [CFLAGS="-Wall ${CFLAGS}"])
> 
> The three options could have checked together, but this is fine too.
> 
> All said and done, the check is not as useful as I had imagined..
> AX_CHECK_COMPLIE_FLAG only catches errors, not warnings.
> For instance, IBM's xlc, at least on Linux, only warns about unknown options.
> So nothing gained -- in fact 4 warning lines per source file caused by
> these options.
> Hopefully, its still useful on some other never used build envs..
> 
> Anyway, the check protects against probable build failures on some unknown
> systems, and I won't waste any more time dwelling on this.
> 
>> diff --git a/m4/ax_check_compile_flag.m4 b/m4/ax_check_compile_flag.m4
>> new file mode 100644
>> [...]
> 
> This macro is a part of autoconf archive which, I thought, is
> prerequisite for building from the repo. One anyway needs autotools
> installed. Can't we not insist on having these common macros be present
> as well? After all this is for building from git sources, not from a
> dist tarball
> which needs no autotools.
> 
> Also the notes in the macro file says "Please keep this macro in sync with
> AX_CHECK_{PREPROC,LINK}_FLAG." which is easier to do if we use the
> system's installed copy.
> 
> Anyway, if including such m4 macros in the repo is the policy,  this
> is fine.

We previously did not depend on it (I didn't have the archive installed)
and thought we didn't want to pull in another dependency.  Also, the
error when the archive is missing is quite terrible and will cost a lot
of people time to understand.  Autoconf happily continues, then
configure fails with:

./configure: line 17861: syntax error near unexpected token `newline'
./configure: line 17861: `AX_CHECK_COMPILE_FLAG('

That said, if we prefer to not include the macro, it can simply be
removed from the commit.  I could even rewrite then to directly use
AC_COMPILE_IFELSE, which is bulkier and less clear but doesn't need the
include.

> Having done the self-satisfying nitpicking:
> 
> Acked-by: Selva Nair <selva.nair@...277...>

Thanks :)

-Steffan

