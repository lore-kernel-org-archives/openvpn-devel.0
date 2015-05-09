Message-ID: <e8658b8ccffc58c2499f792462893012.squirrel@...2027...>
In-Reply-To: <2a24fe1d092410bcd9082565e92c78b2.squirrel@...2027...>
References: <1430518805.21119.82.camel@...1866...>
	<CAOazyz0KoSiUn=DA_0QBf3JXU=eQ1NJGQgtRw0z7DCo+E066Kw@...278...>
	<1430523426.21119.113.camel@...1866...>
	<554D4B33.4060401@...1114...>
	<2a24fe1d092410bcd9082565e92c78b2.squirrel@...2027...>
Date: Sat, 9 May 2015 07:55:56 -0000
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
To: David Woodhouse <dwmw2@...1866...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, David Woodhouse <dwmw2@...1866...>, openvpn-devel@lists.sourceforge.net


>
>> I've spent my evening reading more about vfork() and fork().  I've based
>> my trust this time in two books [1] on Linux system programming.
>>
>> Both books are really clear that vfork() should be avoided, and even
>> claiming it was a mistake by introducing that syscall in Linux.  Its
>> semantic can in many cases cause other issues, such as the execve()'d
>> process not using _exit() but exit().  This can cause plenty of mess in
>> regards to flushing of buffers and other file descriptors.
>
> That's mostly a concern if you only action in the child isn't to call
> execve().
>
> On vfork() the parent stops until the child (sharing its VM) either exits
> or calls execve().
>
> It is the case the the child process directly exits that you have most
> fun. We weren't doing that.

Looking back at this with the benefit of a (slightly) larger screen, about
a pint of coffee, and an absence of small children, I find I was not at my
most coherent. Let me try that bit again...

The interesting caveats of vfork should not bother us when all we do in
the child is exec. Everything is thrown away then anyway. However my patch
*would* need to be careful in the case where the exec fails, including
calling _exit at you say. And any logging or error reporting it does in
the child would also be "fun" with the vfork restrictions.

That in itself is probably sufficient reason to drop the idea.

It was only a cheap hack that seemed useful. As noted, it wasn't even a
panacea because we couldn't use it in openvpn_popen() and thus it didn't
address the systemd thing.

A better approach would probably be to disable the atfork handlers in
OpenVPN entirely since I believe we don't need them.

-- 
dwmw2


