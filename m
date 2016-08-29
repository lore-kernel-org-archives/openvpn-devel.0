MIME-Version: 1.0
In-Reply-To: <22844900-214f-b69f-ef15-ace77cf56bbe@...2080...>
References: <1472413323-21723-1-git-send-email-steffan@...1856...>
	<5109e5e1-bdc9-4920-fe3e-72461a3ed546@...2080...>
	<22844900-214f-b69f-ef15-ace77cf56bbe@...2080...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 29 Aug 2016 23:32:28 +0200
Message-ID: <CAA1AbxJ_e+7Jjk=FNsgGzPNOrrTXdyf7VGyicOJpSxTbVdi7dA@...278...>
Subject: Re: [Openvpn-devel] [PATCH (master)] Drop gnu89/c89 support,
 switch to c99
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

HI,

On 29 August 2016 at 23:03, David Sommerseth
<openvpn@...2080...> wrote:
> On 29/08/16 22:45, David Sommerseth wrote:
>> On 28/08/16 21:42, Steffan Karger wrote:
>>> Previously, we would use the compiler's default C version, which
>>> defaults to gnu89 for GCC < 5, gnu11 for GCC > 5, and c11 for
>>> clang, but might even differ per distro.
>>
>>> One of the reasons to accept the gnu89 default of GCC < 4.9, was
>>> that MSVC didn't support c99.  But in MSVC 2015, MS finanally
>>> fixed that.
>>
>>> Having to support c89 in the codebase occasionally forces us to
>>> write less readable code, for example by forcing all declaration
>>> to be at the starting of a block (which includes 'for loop
>>> initial declarations').
>>
>>> Let's be clear about what standard we obey, and stop punishing
>>> ourselves with c89/gnu89.  Let's switch the master branch to
>>> c99.
>>
>>> Signed-off-by: Steffan Karger <steffan@...1856...> ---
>>> configure.ac | 1 + 1 file changed, 1 insertion(+)
>>
>>> diff --git a/configure.ac b/configure.ac index 9189c94..16cab19
>>> 100644 --- a/configure.ac +++ b/configure.ac @@ -1125,6 +1125,7
>>> @@ if test "${enable_pkcs11}" = "yes"; then ) fi
>>
>>> +CFLAGS="${CFLAGS} -std=c99" if test "${enable_pedantic}" =
>>> "yes"; then enable_strict="yes" CFLAGS="${CFLAGS} -pedantic"
>>
>>
>> I so much wants to give this an ACK.  But this breaks CentOS 5
>> builds very badly.  The glibc-headers isn't prepared for C99 on
>> that distro.
>>
>> I took the latest git master where I could do a successful build.
>> Then I applied just this patch, and here is the explosion:
>> <http://paste.fedoraproject.org/417049/14725031/>
>>
>> To move towards C99, we need to add some tricks which makes this
>> not requiring users to overwrite C99 with C89.  That should happen
>> automatically.
>>
>> Some CentOS 5.11 details: glibc-2.5-123.el5_11.3
>> glibc-headers-2.5-123.el5_11.3 gcc-4.1.2-55.el5
>> openssl-0.9.8e-40.el5_11 lzo-2.02-2.el5.1
>
> Did a bit more testing.
>
>  -std=gnu89, -std=gnu99
>    Works very fine (compiles without errors).
>
>  -std=c99
>    Makes glibc-headers explode, as already described
>
>  -std=c89
>    Makes the LZ4 library we're shipping explode.

Hm, that's too bad.  But I think we should still go for c99, rather
than gnu99.  That should actually result in *more* portable code on
our side.  The CentOS package maintainer can then easily patch
configure.ac (or configure) to use gnu99 for arcane platforms.

-Steffan

