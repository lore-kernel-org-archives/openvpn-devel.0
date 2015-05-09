Message-ID: <2a24fe1d092410bcd9082565e92c78b2.squirrel@...2027...>
In-Reply-To: <554D4B33.4060401@...1114...>
References: <1430518805.21119.82.camel@...1866...>
	<CAOazyz0KoSiUn=DA_0QBf3JXU=eQ1NJGQgtRw0z7DCo+E066Kw@...278...>
	<1430523426.21119.113.camel@...1866...>
	<554D4B33.4060401@...1114...>
Date: Sat, 9 May 2015 05:50:53 -0000
From: "David Woodhouse" <dwmw2@...1866...>
MIME-Version: 1.0
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
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>, David Woodhouse <dwmw2@...1866...>


> I've spent my evening reading more about vfork() and fork().  I've based
> my trust this time in two books [1] on Linux system programming.
>
> Both books are really clear that vfork() should be avoided, and even
> claiming it was a mistake by introducing that syscall in Linux.  Its
> semantic can in many cases cause other issues, such as the execve()'d
> process not using _exit() but exit().  This can cause plenty of mess in
> regards to flushing of buffers and other file descriptors.

That's mostly a concern if you only action in the child isn't to call
execve().

On vfork() the parent stops until the child (sharing its VM) either exits
or calls execve().

It is the case the the child process directly exits that you have most
fun. We weren't doing that.

> The reason I believe vfork() "works" and fork() "does not work" is
> simply due to the fact that fork() does a copy-on-write-copy to the
> child, which includes the inheritance of the atexit() handlers.

No, the child just execs something else, so *everything* about the parent
is lost. The reason it works is that *during* the fork, the pthread_atfork
handlers (which call C_Initialize on PKCS#11 modules in the child right
before it's all going to be thrown away on exec anyway) are not called for
a real fork() but not vfork()

It is calling C_Initialize() "again" which breaks things (for buggy
providers).

> Then regarding to standards and portability.  SUSv3/POSIX.1-2001 lists
> vfork() as deprecated, and SUSv4/POSIX.1-2008 doesn't even include
> vfork().

Well that's a better reason to NAK it than an assertion that PKCS#11
provider modules must all be perfect and we don't want to tolerate
anything less :)

> As a temporarily hack, I could maybe accept it if we can contain the
> fork() to vfork() change to a scenario where ENABLE_SYSTEMD in addition
> to HAVE_VFORK_H/HAVE_WORKING_VFORK; I'll have to sleep on that for a
> couple of days first.  But this may just as well get NAK from the other
> developers.

Those are separate issues; my vfork patch has nothing to do with systemd.

Using vfork stops breakage, even without systemd, when we later fork to
run stuff like ifconfig. In this case it is *only* working around
misbehaving providers.

For the systemd thing, the only workaround we have for now is just to
disable it. We can't uss vfork() in openvpn_popen() because there we *do*
do something else between the fork and the exec.

> Anyone got better ideas?

Well, since we know we never will use PKCS#11 from a child after fork() it
would be quite nice to have a way to get pkcs11-helper *not* to do the
atfork thing. Using vfork() was just a cheap hack to avoid that.

This *is* supposed to be usable software, rather than a test/torture suite
for PKCS#11 providers, after all :)

-- 
dwmw2


