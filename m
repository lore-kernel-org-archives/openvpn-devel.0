Message-Id: <200304171216.h3HCGV131379@...41...>
Subject: Re: [Openvpn-devel] Re: New beta available + progress update
From: "James Yonan" <jim@...41...>
In-Reply-To: <20030417105647.GA4239@...33...>
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
Date: Thu Apr 17 05:18:02 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>, openvpn-devel@lists.sourceforge.net

Matthias Andree <ma+ovpnd@...31...> said:

> > http://openvpn.sourceforge.net/beta/openvpn-1.3.2.21.tar.gz (or CVS)
> 
> I have a next round of patches to fix prototypes and types to quench
> compiler warnings and get a more robust source code against changed
> environments, to aid possible later debugging; it also includes GCC
> extensions (only used when GCC is being used) that allow stricter msg()
> and buf_printf() format string vs. argument checking, to avoid printing
> bogus data when type sizes differ (think 64 bit).

Yes, very good ideas.  I will merge.

> 
> One problem remains after applying the patch:
> openvpn.c: In function `openvpn':
> openvpn.c:470: warning: cast discards qualifiers from pointer target type

That's a tricky matter, because the struct options object is const, but it
needs to be passed to a thread, and normally you need to cast something to a
void* if you want to pass it to a thread as an argument, which then causes the
constness to be lost.

> Other than that, we have unused parameter warnings (you said before
> you're not fixing them), shadow parameter warnings (variable names being
> the same as system functions, such as time or nice)

I'm not too worried about the shadow parameters.  I think it's pretty obvious
when something is being used as a variable vs. a function call.

As for the unused parms, they are mostly a result of conditional compilation
making certain variables unnecessary.  OpenVPN has a large conditional
compilation state-space, so I'm not sure that it makes sense to try to
eliminate all such warnings.

> and in particular,
> aggregate (struct) values in function calls and function returns, these
> are inefficient (as the compiler must toss the whole struct on the
> stack, which involves copy overhead), and some of them (buffer.c in
> particular) look pretty suspicious. Is there any C standard that
> guarantees that returning an auto struct works and copies the return
> value?

While I can't quote chapter and verse, being able to manipulate structures in
a value context, such as returning them from functions or passing them on the
stack, has been a part of C for ages, and for a long time compilers have tried
very hard to optimize this usage as much as possible.

For example, when a function returns an automatic structure, most compilers
will optimize this into a zero-copy operation, where the functions's
references to the automatic structure go directly into a variable allocated by
the caller for its return.

My attitude towards optimization has been to optimize the code across the
critical path only, which is essentially the event loop in openvpn.c.  Code
outside the event loop (such as the SSL negotiation) does not need to be
optimized with respect to CPU usage, because it is executed infrequently in
relation to the main event loop and OpenSSL EVP crypto code.

Most of the expensive buffer.[ch] code is only executed on startup, shutdown,
SIGHUP, or when the debug level is high.

[ patch deleted ]

James


