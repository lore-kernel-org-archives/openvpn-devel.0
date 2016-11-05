References: <CAFHpkQFzZRLQhOTqoOakUuwUURo4=-Jf-FPiYfi-de86=6Q1Pw@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <4bf6ce6c-ab68-d5b1-cd79-fb6e0dad2ffd@...1856...>
Date: Sat, 5 Nov 2016 09:08:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFzZRLQhOTqoOakUuwUURo4=-Jf-FPiYfi-de86=6Q1Pw@...278...>
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 05-11-16 06:52, Илья Шипицин wrote:
> I'm geting "build only" travis-ci mingw cross compile config
> and I came to idea that I do not understand why "tap-windows.h" must be
> downloaded separately
> 
> 1) if we use some functions, we should include prototypes. it is not
> very common to download prototypes from different location

When using external dependencies it is *not* a best practice to include
the headers of that dependency (or even worse, binaries) into your own
project repository.  I haven't seen any decent C project do that.  We
wouldn't include the OpenSSL, mbed TLS or even libc headers either,
would we?

> 2) such way requires also complicated things like configure checks
> (which in turn may be avoided if we include tap-windows.h)

configure checks are there to help you simplify dependency management.
Our configure.ac might be a bit convoluted, so surely qualified for
improvement, but setting a few paths isn't that hard, is it?

> so, I guess, there're might be legal issue ?
> if not, I vote for adding tap-windows.h into openvpn repo.
> it will simplify things a lot

I do not believe there are legal issues, but for the reasons above I
vote against including the tap-windows headers into the core openvpn
repo.  So, Feature-NAK.

-Steffan

