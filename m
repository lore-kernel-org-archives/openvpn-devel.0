From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Pre-1.3.3 beta available for testing
In-Reply-To: <20030219181048.GA21087@...33...>
Message-ID: <Pine.LNX.4.44.0302191128560.12503-100000@...41...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Feb 19 10:53:16 2003
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>
Cc: openvpn-devel@lists.sourceforge.net

> There were more warnings that I haven't reported because I think they
> didn't warrant fixes at this time, some "unused parameter" warnings. Try
> 
> make clean
> make CFLAGS="-W -Wall"
> 
> to see more warnings :-)

Yes, also ./configure --enable-strict does something like this.

Most of the warnings that are left (such as unused function call 
parameters, unused static functions, etc.) would create more obfuscation 
if they were fixed.  In principle, warnings should direct your attention 
to possible bugs or things that need to be cleaned up, but I don't believe 
in making the code harder to read just to fix a warning.  For example, I 
wouldn't bracket a static function with a complex #if just to 
eliminate warnings about its non-use (as in tun.c).

> I have no profiles, sorry, neither of the function call overhead
> incurred or avoided, nor of the compilers.
> 
> Hum. <BRAINSTORMING>
> 
> ## idea #1:
> One thing commonly used to hide prototypes away from compilers that
> don't support them is enclosing the whole function call in a macro, say:
> 
> #ifdef SUPPORT_PROTOS
> #define D(p) p
> #else
> #define D(p) ()
> #endif
> 
> void myfunc D((int name, char name2));
> 
> The important thing is that you pass double parentheses here.
> 
> However, the "flags" you use probably prevents us from using this approach.
> 
> 
> ## idea #2:
> Convert the msg macro that you have now to an __inline
> function and compile with -finline-functions or -O3 and let the global
> optimizer inline the if (debuglevel high enough) checks. I fear though
> that the varargs breaks this as well and prevents inlining.
> 
> 
> ## idea #3:
> Use a fixed-argument msg macro big enough to hold all arguments and fill
> the unused with NULL (rather than doing a dozen macros on your own).
> 
> 
> ## idea #4:
> profile if calling the function really slows down things that much.
> 
> </BRAINSTORMING>

How about we add a new configure option such as --no-vararg-macros that
makes msg() into a function (as you do in your patch) to pacify older
compilers?

Even better, is there an autoconf macro which will automatically test 
whether or not vararg macros are supported?

Then we only take the msg-as-function route if we need to.

James


