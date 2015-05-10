Message-ID: <1431254380.23276.113.camel@...1866...>
From: David Woodhouse <dwmw2@...1866...>
Date: Sun, 10 May 2015 11:39:40 +0100
In-Reply-To: <CAOazyz3Gse_yi8cteVCOThUXvLF2F6VZoBtEB9PM=DxZw2e2ug@...278...>
References: <1430518805.21119.82.camel@...1866...>
	<CAOazyz0KoSiUn=DA_0QBf3JXU=eQ1NJGQgtRw0z7DCo+E066Kw@...278...>
	<1430523426.21119.113.camel@...1866...>
	<554D4B33.4060401@...1114...>
	<2a24fe1d092410bcd9082565e92c78b2.squirrel@...2027...>
	<e8658b8ccffc58c2499f792462893012.squirrel@...2027...>
	<20150509101724.GQ382@...1296...>
	<1431206194.4339.32.camel@...1866...>
	<CAOazyz3Gse_yi8cteVCOThUXvLF2F6VZoBtEB9PM=DxZw2e2ug@...278...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Use vfork() in openvpn_execve() instead
 of fork()
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Sun, 2015-05-10 at 00:57 +0300, Alon Bar-Lev wrote:
> http://lists.gnu.org/archive/html/gnutls-devel/2011-10/msg00058.html

That thread is interesting; thanks for the reference.

In it, Stef pointed out¹ that the behaviour of automatically calling
C_Initialize() from the atfork child handler is forbidden by POSIX and
triggers undefined behaviour.

So I'm quite happy to drop the 'test suite' vs. 'real program' argument,
as you requested. It's not just a subjective quality-of-implementation
issue; what pkcs11-helper is currently doing, when it does it from a
multi-threaded application, is just plain wrong. :)

The pthread_atfork() documentation² says:

 "It is suggested that programs that use fork() call an exec function
  very soon afterwards in the child process, thus resetting all states.
  In the meantime, only a short list of async-signal-safe library
  routines are promised to be available."

It then goes on to explain why pthread_atfork() doesn't really work for
its original intended purpose, before concluding more forcefully and
using the word 'requires' instead of 'suggested':

 "As explained, there is no suitable solution for functionality which
  requires non-atomic operations to be protected through mutexes and
  locks. This is why the POSIX.1 standard since the 1996 release
  requires that the child process after fork() in a multi-threaded
  process only calls async-signal-safe interfaces."

The fork() documentation³ does indeed say that, as well as:

 "When the application calls fork() from a signal handler and any of the
  fork handlers registered by pthread_atfork() calls a function that is
  not async-signal-safe, the behavior is undefined."

The "short list of async-signal-safe library functions" is indeed
short⁴.

It certainly doesn't seem to be the case that C_Initialize() is
guaranteed to call only functions on that short list. So calling
C_Initialize() from within the atfork child handler would appear to
trigger undefined behaviour according to POSIX.

Might it be better to simply set a flag to indicate that the state is
invalid, and then re-initialize the module *if* a further call would
need to be made into a PKCS#11 provider?

In most cases no such call is going to happen, so calling C_Initialize()
immediately is at best a gratuitous performance hit, and at worst it's
triggering more serious issues.

-- 
dwmw2

¹ http://lists.gnu.org/archive/html/gnutls-devel/2011-10/msg00115.html
² http://pubs.opengroup.org/onlinepubs/9699919799/functions/pthread_atfork.html
³ http://pubs.opengroup.org/onlinepubs/9699919799/functions/fork.html
⁴ http://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_04_03



