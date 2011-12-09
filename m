Message-ID: <4EE2747A.1080100@...1114...>
Date: Fri, 09 Dec 2011 21:50:02 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1323301588-29815-1-git-send-email-davids@...1347...>
	<1323357860-2506-1-git-send-email-davids@...1347...>
	<20111209080212.GC18948@...1296...>
	<4EE2289D.3090507@...1114...>
	<CAOazyz1Y8cXmm1py=V-6+N2tBQx1OS42Hq5buVSH4UJYxRHQYg@...278...>
In-Reply-To: <CAOazyz1Y8cXmm1py=V-6+N2tBQx1OS42Hq5buVSH4UJYxRHQYg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Move away from openvpn_basename()
 over to platform provided basename()
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
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/12/11 19:19, Alon Bar-Lev wrote:
> On Fri, Dec 9, 2011 at 5:26 PM, David Sommerseth 
> <openvpn.list@...1114...> wrote:
>>> So I'd propose to keep openvpn_basename() - it's simple and short 
>>> enough, and has well-defined semantics that can be relied upon.
>> 
>> The original openvpn_basename() is based upon the GNU basename()
>> which is not modifying any arguments, so this is definitely
>> cleaner.
> 
> In my opinion, in order to avoid confusion there can be two options:
> 
> 1. Use library functions as much as possible, providing the minimum 
> common ground in compatibility layer if missing. This ensure applying
> fixes and functionality from various upstreams.
> 
> 2. Use own implementation everywhere, taking responsibility and 
> control over the implementation and maintenance.
> 
> Mix is only confusing, and leads to even more errors.
> 
> This also applied to related functions such as dirname/basename in 
> this case, choosing own implementation of basename yield confusing as
> you do not expect that dirname taken from different implementation.

I've been pondering on this a lot today as well, after also having had an
IRC chat with Gert.  And I'm leaning towards what Alon says here.  Even
though, in 1) the drawback here is that compat functions will be less
tested than in 2).

However, in this case, the base/dirname functions are taken straight out
of glibc, and should have been more than well tested.  The code has also
not been modified in several years.  This speaks for alternative 1).

I'm also seriously concerned about the / and \ parsing, as that will,
naturally, be different from *nix and Windows platforms.  But the current
implementation in compat.[ch] tackles both automatically.  So if the code
base doesn't have its own base/dirname functions, a more flexible and
gracious feature will be available.  Otherwise, you're dependent on the
libc library the running platform gives you.  And this speaks for
alternative 2).

I agree that mixing is unfortunate, however, we need to draw a line
somewhere.  Otherwise we're ending up implementing a unified libc,
blending all supported platforms.  We can't do that, that's just insane.
 So we need to fix what's needed to fix.  Which speaks more for 1).

Then there's the next problem.  Vague specifications and different
platforms interpreting standards and specifications differently.  Sometimes
you really wonder what POSIX people were smoking when deciding on
standards.  And base/dirname() is one of those ... the vast majority of
man pages I've read lately states this:

       Both  dirname()  and  basename()  may  modify the contents of
       path, so it may be desirable to pass a copy when calling  one
       of these functions.

       These  functions  may return pointers to statically allocated
       memory which may be overwritten by subsequent calls.   Alter‐
       natively,  they may return a pointer to some part of path, so
       that the string referred to by path should not be modified or
       freed until the pointer returned by the function is no longer
       required.

How the he** is it possible for a developer to predict what different
platforms will do, when these functions *may* modify the input or *may*
or may not return pointers to static memory buffers?  (They had to be
smoking /something/).  Anyway, this speaks in favour of 2).

And we can go on like this forever and ever and ever ... it will always
be one argument which kills the other, both ways.  So the conclusion?  We
really need to draw a line _somewhere_.

So ... Since the rest of the world are able to tackle such ambiguities
like base/dirname() already, so should we.  Seriously.  We're a small
project (in active people), but with a broad range of users - and
amazingly many users and use cases.  OpenVPN basically runs on everything
which can run Linux - which means from simple embedded systems to
powerful servers, and more.  And as we're not that many developers
involved, having less code to carry is way better in my eyes.  Copying
compat code from safe code bases, like glibc, will then not be such a big
issue for those exceptions we might hit - the maintenance burden should
be somewhat lower.

To be able to support the lower end, code size matters.  Reducing the
number of code we ship, reduces the footprint OpenVPN takes.  In this
case, it's not much at all, but in other cases this might be way bigger.
 This matters more for me right now.  The more we can depend on external
code, the cleaner our code can become.  But we need a compat approach to
support the broadness of our platforms.  And then the needed compat code
only is activated where absolutely needed.

My conclusion is that we need to choose 1) here.  So that's my pragmatic
long-term point of view on this.


In regards to this current patch.  I have done valgrind tests, I even
tried to free() the strdup()ed string in init_options_dev() ... and glibc
complained instantly about double freed memory.  So somehow, there are
some clever memory management involved.  Which seems to be covered by the
gc_*() calls on the options buffer.  I therefore don't see any immediate
risks here, but I also don't say it is fail-safe as I don't see how this
gc_*() magic really works.  But initial tests looks very promising.


I will refrain from implementing the current patch in the current shape
until after the weekend, so that more people may have their say.  We may
even ask James for an explicit opinion on this topic as well.  But for
now, I consider the patch ACKed (accepted) by Alon and NACKed (rejected)
by Gert.

We haven't had any democratic system on the ACKs earlier, and I don't
have any strong reasons to start with that now.  But unless there are
more people NACKing this code, it will be applied as-is during next week.

Any objections?


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7idHgACgkQDC186MBRfrqtMgCfRiLjhNgx5gTifGHOpX3/SV85
HLAAnRFBO2+B94ABOG8fskxKEaAI4FPy
=3HIB
-----END PGP SIGNATURE-----

