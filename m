References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-9-simon@...2293...> <20171105192019.GM958@...1296...>
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
From: Gisle Vanem <gisle.vanem@...277...>
Message-ID: <21d0b41e-6665-a27b-a8a1-596f34a000cf@...277...>
Date: Thu, 7 Dec 2017 18:32:31 +0100
MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1085B4D703@...2294...>
Content-Language: en-GB
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
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Simon Rozman wrote:

> However, I did stare-review your code:
> - It does not introduce any new Windows API calls it has not used before.
> - It compiles fine.
It also builds fine here with cl v19.11.
But using clang-cl v5, I'm getting:
   In file included from src/openvpn/argv.c:36:
   ./src/openvpn/syshead.h(368,13) :  error: typedef redefinition with different types ('int' vs 'enum MIB_TCP_STATE')
   typedef int MIB_TCP_STATE;
               ^
   f:\ProgramFiler-x86\WindowsKits\Include\10.0.15063.0\shared\tcpmib.h(56,3) :  note: previous definition is here
   } MIB_TCP_STATE;
     ^
   1 error generated.

I fail to why I don't get this error with MSVC.
But the lines in syshead.h should simply not assume
MinGW is the only compiler on Windows. Line 365:

   #ifdef _WIN32
   /* Missing declarations for old-school MinGW32 or MinGW-w64 v1.x.
    */
   #if defined(__MINGW32__) && !(defined(__MINGW64_VERSION_MAJOR) && __MINGW64_VERSION_MAJOR < 2)
   typedef int MIB_TCP_STATE;
   #endif


-- 
--gv

