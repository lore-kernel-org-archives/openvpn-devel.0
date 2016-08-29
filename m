MIME-Version: 1.0
In-Reply-To: <CAKuzo_g_RUmJJWqhALAzGc3x=2qrf=DLMNMOgdvxZ9r_zkXFyA@...278...>
References: <1472413323-21723-1-git-send-email-steffan@...1856...>
	<CAA1AbxLe+Gj3JDz=yhO-L63sqhojOtXd6ZMEiP+61E7=7rnVwA@...278...>
	<CAKuzo_g_RUmJJWqhALAzGc3x=2qrf=DLMNMOgdvxZ9r_zkXFyA@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 29 Aug 2016 23:25:58 +0200
Message-ID: <CAA1AbxKEyx9x0fUOFU0GS50NQd4s86M9YNhpHL58XADdi-Eqbg@...278...>
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 29 August 2016 at 21:29, Selva Nair <selva.nair@...277...> wrote:
>
> On Sun, Aug 28, 2016 at 3:46 PM, Steffan Karger <steffan@...1856...> wrote:
>>
>> On 28 August 2016 at 21:42, Steffan Karger <steffan@...1856...> wrote:
>> > Previously, we would use the compiler's default C version, which
>> > defaults
>> > to gnu89 for GCC < 5, gnu11 for GCC > 5, and c11 for clang, but might
>> > even
>> > differ per distro.
>> >
>> > One of the reasons to accept the gnu89 default of GCC < 4.9, was that
>> > MSVC
>> > didn't support c99.  But in MSVC 2015, MS finanally fixed that.
>> >
>> > Having to support c89 in the codebase occasionally forces us to write
>> > less
>> > readable code, for example by forcing all declaration to be at the
>> > starting
>> > of a block (which includes 'for loop initial declarations').
>> >
>> > Let's be clear about what standard we obey, and stop punishing ourselves
>> > with c89/gnu89.  Let's switch the master branch to c99.
>>
>> To be clear:  I'm aware we never really decided to switch to c99, so
>> this patch is partly meant to start discussion.  Anyone who cares for
>> gnu89 support, please speak up :)
>
> I have been all along wishing for this switch to C99 and the demise of dated
> MSVC support. But we also have to keep in mind that mingw-w64 (and mingw)
> targets a least common denominator of Windows runtime (runtime version 6.0
> ?). That is not going to change as the very spirit of mingw is to make
> executables that run with stock windows libraries. That means features of
> C99 requiring run-time support (stdio is an example) cannot be supported by
> mingw by default as it requires statically linking in additional code.
>
> For example,  __USE_MINGW_ANSI_STDIO has to be defined to support some of
> the printf format specs and that adds about 50K to the binary. That also
> invalidates windows-specific format specifiers such as %I64u which is used
> in a couple places in the code. Last time I suggested this Gert was opposed
> to it on grounds of the extra define, need for code changes, increased
> binary size etc..

Yes I'm aware of this.  Even so, just compile-time c99 support is
valuable in itself.

> My personal preference: go for -std=c99, add the above define for mingw and
> get rid of %I64.. (a only a couple of instances). That said, I do not know
> how complete is the C99 support in mingw-w64, and whether there are other
> issues that need work around. I suppose we can handle them, if any, as they
> come..

That would be my preference too.  Definitely c99, maybe
__USE_MINGW_ANSI_STDIO__ too.  I don't care too much for 50 kB extra
in Windows binaries.  I'd be much more worried about 50 kB in linux
binaries, as that would hurt quite some embedded platforms.

-Steffan

On 29 August 2016 at 21:29, Selva Nair <selva.nair@...277...> wrote:
>
> On Sun, Aug 28, 2016 at 3:46 PM, Steffan Karger <steffan@...1856...> wrote:
>>
>> On 28 August 2016 at 21:42, Steffan Karger <steffan@...1856...> wrote:
>> > Previously, we would use the compiler's default C version, which
>> > defaults
>> > to gnu89 for GCC < 5, gnu11 for GCC > 5, and c11 for clang, but might
>> > even
>> > differ per distro.
>> >
>> > One of the reasons to accept the gnu89 default of GCC < 4.9, was that
>> > MSVC
>> > didn't support c99.  But in MSVC 2015, MS finanally fixed that.
>> >
>> > Having to support c89 in the codebase occasionally forces us to write
>> > less
>> > readable code, for example by forcing all declaration to be at the
>> > starting
>> > of a block (which includes 'for loop initial declarations').
>> >
>> > Let's be clear about what standard we obey, and stop punishing ourselves
>> > with c89/gnu89.  Let's switch the master branch to c99.
>>
>> To be clear:  I'm aware we never really decided to switch to c99, so
>> this patch is partly meant to start discussion.  Anyone who cares for
>> gnu89 support, please speak up :)
>
>
> I have been all along wishing for this switch to C99 and the demise of dated
> MSVC support. But we also have to keep in mind that mingw-w64 (and mingw)
> targets a least common denominator of Windows runtime (runtime version 6.0
> ?). That is not going to change as the very spirit of mingw is to make
> executables that run with stock windows libraries. That means features of
> C99 requiring run-time support (stdio is an example) cannot be supported by
> mingw by default as it requires statically linking in additional code.
>
> For example,  __USE_MINGW_ANSI_STDIO has to be defined to support some of
> the printf format specs and that adds about 50K to the binary. That also
> invalidates windows-specific format specifiers such as %I64u which is used
> in a couple places in the code. Last time I suggested this Gert was opposed
> to it on grounds of the extra define, need for code changes, increased
> binary size etc..
>
> My personal preference: go for -std=c99, add the above define for mingw and
> get rid of %I64.. (a only a couple of instances). That said, I do not know
> how complete is the C99 support in mingw-w64, and whether there are other
> issues that need work around. I suppose we can handle them, if any, as they
> come..
>
> Selva

