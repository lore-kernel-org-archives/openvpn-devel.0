Message-ID: <50F743AF.5020500@...68...>
Date: Thu, 17 Jan 2013 01:19:59 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <CABT9mj_oAJ6sRy0_TKrWBVdN5OeTBVwC+-GmAkHbUPmpi=j5HQ@...278...>
	<20130116101123.GU22465@...1296...>
In-Reply-To: <20130116101123.GU22465@...1296...>
Subject: Re: [Openvpn-devel] compiling with visual studio
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 16.01.2013 11:11, schrieb Gert Doering:
> Hi,
> 
> On Tue, Jan 15, 2013 at 09:03:07PM +0200, Athanasios Douitsis wrote:
>> Trying to compile 2.3 with visual studio 2010. I am getting the following
>> error:
>>
>> init.c(186): error C2143: syntax error : missing ';' before 'type'
>> [C:\openvpn4\openvpn-build\msvc\build.tmp\openvpn-2.3_master\src\openvpn\openvpn.vcxproj]
>>
>> (after that there are many many more errors, but you get the idea)
> 
> Oh well, we've done it again...

User reply follows, Developer reply after next quote:

Arguably, Visual Studio is broken if it does not accept the then-current
version of ISO 9899, which would have been C99 for anything except
VS2012 that should support C11, but reality differs, and
<http://stackoverflow.com/questions/146381/visual-studio-support-for-new-c-c-standards>
contains a few links to official info.

If something has really failed to catch on with many commercial
compilers, then I fear C99 is to carry this red light. :-(

If the code is really type-safe and -clean in C++ terms, you may have
some success with convincing VS to compile in C++ mode - but this needs
typecasts for virtually everything that deals with void * - but there
are some things in C99 that are incompatible with (at least the most
widely implemented pre-C++11 variants of) C++, such as variable-length C
arrays.

>   if (management)
>     {
>       gc = gc_new ();
>       struct buffer out = alloc_buf_gc (256, &gc);
> 
> ... this is not allowed in visual studio (having a variable declaration
> after "non-declaration" code), but gcc doesn't complain, so we usually
> don't notice.



You can make gcc complain, -pedantic -std=c89 should do it, or if you
are not enabling additional compiler warnings, -pedantic-errors.
  And it possibly causes tons of other warnings because it nukes system
extensions from the compilation environment.

What I personally usually do is to test with various different compilers
and configurations:

1. do not configure the source directory (or call "make distclean")

2. mkdir _build _build-c89 _build-clang _build-icc

3. for each $DIR of these new directories, do:

    3a. cd $DIR

    3b. ../configure CC="gcc"
(or CC="gcc -std=c89 -pedantic" or "clang" or "icc" or... you name it) -
you can also add CFLAGS, LDFLAGS, CPPFLAGS as you see fit, stuff -m32 to
compile 32-bit code on 64-bit systems that support it (some Linux
distributions would work - if they offer you i686 packages to install on
your x86_64, they are usually ready; such as: Debian if you stay away
from aptitude, and Fedora, for instance).

    3c. make -sj4 check (use higher numbers for machines with more than
4 CPU cores)

where
 - icc is Intel's compiler package that keeps changing names more often
than I chase new versions
 - clang is Apple's LLVM-based free-and-open-source compiler which gives
decent and useful hints, but defaults to C99 mode

Best regards,
Matthias

