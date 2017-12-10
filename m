MIME-Version: 1.0
In-Reply-To: <21d0b41e-6665-a27b-a8a1-596f34a000cf@...277...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-9-simon@...2293...>
 <20171105192019.GM958@...1296...>
 <99D61A626FDA8A4B90A270669121BE108587DA0D@...2294...>
 <CAKuzo_hTnJVcEuCqCQ-ZR3swbkio7CWZgy3z5C0fWVJ-E0PCvQ@...278...>
 <99D61A626FDA8A4B90A270669121BE108587DF29@...2294...>
 <CAKuzo_jFp86anFk6mgavBoYhmCCHUeJ_EQpb6Z05PTNJxBYWWw@...278...>
 <99D61A626FDA8A4B90A270669121BE10858830C4@...2294...>
 <20171204192515.GA69387@...1296...>
 <99D61A626FDA8A4B90A270669121BE1085B4AC9A@...2294...>
 <CAKuzo_hJdNEMMmUqa4d=n4k9vZXoYtkC9CFcvAkW9cDgzT2wCA@...278...>
 <99D61A626FDA8A4B90A270669121BE1085B4CA4D@...2294...>
 <CAKuzo_iAJxP9AmGvApNXno7yw5q_rn5jQko+bUePmdXqUXgmgQ@...278...>
 <99D61A626FDA8A4B90A270669121BE1085B4D703@...2294...>
 <21d0b41e-6665-a27b-a8a1-596f34a000cf@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 9 Dec 2017 20:17:15 -0500
Message-ID: <CAKuzo_hp_cLUQ-R6njmPxsbtC_nXgpud5F5YqW7Ubsq2SxtvZA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 09/13] Signed/unsigned warnings of MSVC
 resolved
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
To: Gisle Vanem <gisle.vanem@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Dec 7, 2017 at 12:32 PM, Gisle Vanem <gisle.vanem@...277...> wrote:
> Simon Rozman wrote:
>
>> However, I did stare-review your code:
>> - It does not introduce any new Windows API calls it has not used before.
>> - It compiles fine.
>
> It also builds fine here with cl v19.11.
> But using clang-cl v5, I'm getting:
>   In file included from src/openvpn/argv.c:36:
>   ./src/openvpn/syshead.h(368,13) :  error: typedef redefinition with
> different types ('int' vs 'enum MIB_TCP_STATE')
>   typedef int MIB_TCP_STATE;
>               ^
>   f:\ProgramFiler-x86\WindowsKits\Include\10.0.15063.0\shared\tcpmib.h(56,3)
> :  note: previous definition is here
>   } MIB_TCP_STATE;
>     ^
>   1 error generated.
>
> I fail to why I don't get this error with MSVC.
> But the lines in syshead.h should simply not assume
> MinGW is the only compiler on Windows. Line 365:
>
>   #ifdef _WIN32
>   /* Missing declarations for old-school MinGW32 or MinGW-w64 v1.x.
>    */
>   #if defined(__MINGW32__) && !(defined(__MINGW64_VERSION_MAJOR) &&
> __MINGW64_VERSION_MAJOR < 2)
>   typedef int MIB_TCP_STATE;
>   #endif

Are you referring to the patch under discussion or something else?

The code you quote above is not in current master nor in 2.4. In fact that
!(defined(__MINGW64_VERSION_MAJOR) &&__MINGW64_VERSION_MAJOR < 2
even contradicts the comment above it. Its likely not from the
official codebase.

Anyway, MIB_TCP_STATE is typedef-ed to int in syshead.h whenever
 _WIN32 is defined. We may not need it anymore, but it hasn't so
far interfered with any builds.

Indeed its an enum as per MSDN (vista+ addition?). If clang doesn't
like passing an int as enum and is using Microsoft's headers, it could
trip there even if MSVC allows it. Such a combination has never been
tested before, I suppose.

Selva

