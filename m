References: <CAFHpkQFzZRLQhOTqoOakUuwUURo4=-Jf-FPiYfi-de86=6Q1Pw@...278...>
	<4bf6ce6c-ab68-d5b1-cd79-fb6e0dad2ffd@...1856...>
	<CAFHpkQGC8kRpVLE=2vBAYpEMkh+=VTqy_VTqfbWdhsOOr-GGUA@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <f077c965-a063-5f11-f298-2fd551ae4f95@...1856...>
Date: Sat, 5 Nov 2016 11:53:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQGC8kRpVLE=2vBAYpEMkh+=VTqy_VTqfbWdhsOOr-GGUA@...278...>
Subject: Re: [Openvpn-devel] any reason to not adding tap-windows.h to
 https://github.com/OpenVPN/openvpn/tree/master/include ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 05-11-16 11:34, Илья Шипицин wrote:
> 
> 2016-11-05 13:08 GMT+05:00 Steffan Karger <steffan@...1856...
> <mailto:steffan@...1856...>>:
> 
>     On 05-11-16 06:52, Илья Шипицин wrote:
>     > I'm geting "build only" travis-ci mingw cross compile config
>     > and I came to idea that I do not understand why "tap-windows.h" must be
>     > downloaded separately
>     >
>     > 1) if we use some functions, we should include prototypes. it is not
>     > very common to download prototypes from different location
> 
>     When using external dependencies it is *not* a best practice to include
>     the headers of that dependency (or even worse, binaries) into your own
>     project repository.  I haven't seen any decent C project do that.  We
>     wouldn't include the OpenSSL, mbed TLS or even libc headers either,
>     would we?
> 
> we include cmocka as git submodule.
> if such an approach is acceptable, we can use another submodule (to
> tap-windows repo)

Yes, which I'm still wondering about whether that was the right choice.
Using configure might have made more sense.

Either way, although I don't agree with your suggested approach, I do
see that building (and particularly, cross compiling) isn't easy, and
that it would be nice to improve on that.

A different approach (which I use internally for OpenVPN-NL) is to
create a build repository with build scripts and all the required
dependencies as submodules.  It might make sense to do something like
that for openvpn-build?  (This works nicely for us internally, but I'm
not so sure that would work as well for openvpn-build.)

-Steffan

