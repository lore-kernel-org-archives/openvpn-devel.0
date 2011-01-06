Message-ID: <4D2647FB.4070302@...68...>
Date: Thu, 06 Jan 2011 23:53:47 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1294334039-28892-1-git-send-email-matthias.andree@...68...>
	<4D263917.80908@...1114...>
In-Reply-To: <4D263917.80908@...1114...>
Subject: Re: [Openvpn-devel] beta2.2: automake support for plugin build
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 06.01.2011 22:50, schrieb David Sommerseth:
> On 06/01/11 18:13, Matthias Andree wrote:
> | Greetings,
> |
> | this is the beta2.2 patch pair for hooking the auth-pam and down-root
> | plugins to the build.
> |
> | The bugfix2.1 patch pair has been sent earlier.
> |
> | Looking for review, ACK and NAK.
> |
> 
> Hi Matthias,
> 
> And thanks a lot for your patches.  Just one question.  I see you try to do
> all the Makefile generation in the main/root Makefile.am.  That is for sure a
> fast-track to get started.  But I'm concerned if that might backfire in the
> long run.

Yes, but in my experience with autotools, the fewer SUBDIRS you have the better
it works, the faster and more reliably everything builds.  SUBDIRS should only
be used as a last resort.

> Why not to use the SUBDIRS variable in the root Makefile.am, and then have
> separate Makefile.am per plugin?  That way, each plug-in can more easily
> control the build independently.

SUBDIRS is one of the worst ideas I've seen in autotools, and I try to avoid
that wherever reasonable.  SUBDIRS breaks dependencies because you run multiple
"make" processes that all only have a partial view. It is inefficient, leads to
autotools bloat, and other reasons are given in "Recursive make considered
harmful" by Peter Miller of "cook" fame (URL below).  Old as it may seem its
points still stand.

Automake allows for per-target build control through _LDADD, _DEPENDENCIES and
all sorts of options, and if that fails you can still hand-code the build rules,
automake passes them through.

http://miller.emu.id.au/pmiller/books/rmch/


-- 
Matthias Andree

