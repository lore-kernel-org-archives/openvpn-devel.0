Message-ID: <1431206194.4339.32.camel@...1866...>
From: David Woodhouse <dwmw2@...1866...>
Date: Sat, 09 May 2015 22:16:34 +0100
In-Reply-To: <20150509101724.GQ382@...1296...>
References: <1430518805.21119.82.camel@...1866...>
	<CAOazyz0KoSiUn=DA_0QBf3JXU=eQ1NJGQgtRw0z7DCo+E066Kw@...278...>
	<1430523426.21119.113.camel@...1866...>
	<554D4B33.4060401@...1114...>
	<2a24fe1d092410bcd9082565e92c78b2.squirrel@...2027...>
	<e8658b8ccffc58c2499f792462893012.squirrel@...2027...>
	<20150509101724.GQ382@...1296...>
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
To: Gert Doering <gert@...1296...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

On Sat, 2015-05-09 at 12:17 +0200, Gert Doering wrote:
> Hi,
> 
> On Sat, May 09, 2015 at 07:55:56AM -0000, David Woodhouse wrote:
> > A better approach would probably be to disable the atfork handlers in
> > OpenVPN entirely since I believe we don't need them.
> 
> With the patch to #480 which moves the only "real fork()" (daemon()) to
> "before any crypto stuff happens", we should never do any fork() now which
> will cause crypto operations in the child - so, if these handlers can be
> disabled (or turned into "assume there will be no crypto in the child, so
> just plain FAIL if any is attempted"), this could be a possible avenue 
> out of this mess...

I think that's the best approach, yes.

> I'm not sharing David S.'s concern about vfork() being deprecated, but
> if it is not actually fixing all aspects of the problem, it's not the
> right solution anyway - so, no need to really decide about that :-)

Yeah, I'm not really scared of vfork, although my patch should have
switched to using _exit() instead of exit() if the execve() failed in
the child. I note there *was* no other error handling to worry about in
that case, so my concern about complexity there was unfounded.

Really, it depends on how we solve the other issues. If we kill
openvpn_popen() and make the systemd thing work some other way (via DBus
or whatever), then we have fixed the outright *bug* in OpenVPN. But we
are still left with the issue that some of the *common* PKCS#11
providers have issues with being re-initialised in the child process
after a fork (like when we spawn ifconfig).

As noted above, the best answer is *not* to do that. But I strongly
suspect Alon (who owns pkcs11-helper) won't concur. For reasons I can
understand, if not entirely agree with, he's very keen on requiring
absolute spec compliance from all PKCS#11 provider modules. He doesn't
like the idea of working around bugs in them.

He is right, of course, that we should *fix* them (where they're open
source and we can). But I personally think that OpenVPN should be
tolerant of the known issues *too*. As I said, it's supposed to be a
useful piece of software in *practice*, not just a PKCS#11 test suite.

So if we can't persuade him to give us a mode in pkcs11-helper which
disables this pthread_atfork() behaviour, then using vfork() — just to
avoid *triggering* that unwanted atfork handler — might still be a
relatively attractive proposition.

(There's already the 'safe mode' thing in pkcs11-helper but I don't
think that actually avoids invoking C_Initialize() on the modules.)

-- 
dwmw2



