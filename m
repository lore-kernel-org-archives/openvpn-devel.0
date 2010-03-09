Message-ID: <4B964BEC.3040504@...1114...>
Date: Tue, 09 Mar 2010 14:23:56 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B950E0B.1030908@...41...>
In-Reply-To: <4B950E0B.1030908@...41...>
Subject: Re: [Openvpn-devel] Linux tun/tap performance issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/03/10 15:47, James Yonan wrote:
> I believe this has been discussed before, but I noticed recently that a 
> Linux-based OpenVPN client (Linux 2.6.24, OpenVPN 2.1.1) spends a lot 
> more CPU time in kernel space than in user space.  This is surprising, 
> given the fact that all of the CPU-intensive cryptographic operations 
> are being done in user space.
> 
> Using the 'time' utility on the OpenVPN client, while a wget of a 50MB 
> file was done over the VPN, I found that 80% of the CPU time was taken 
> by the kernel, and 20% by user space (I should add that the Linux client 
> was running as a VM on VMWare Fusion).
> 
> I'm wondering if anyone with kernel background has any insights on this. 
>   Are there performance bottlenecks in the tun/tap driver?

I'm not a hardcore kernel developer, but I'm interested in the to

James, would you mind trying to run a test on the 2.6.33 kernel?  That's
the newest stable kernel available, just to see if your observations are
visible there as well, and if they are better or worse.

And when you say earlier kernels did not use so much time in kernel
space, which kernels did you compare against?  It would be interesting
to look through the changelog from the "good" kernel version to 2.6.24,
to see what was changed in tun.c.

In this case, it would be easier to try to nail down where such a
behavioural change happened.  And after all, 2.6.24 was released about 2
years ago (Jan 24 14:58:37 2008) ... and the drivers/net/tun.c has been
changed 72 times, as far as I can see.  It's a big job going on getting
rid of the BKL (big kernel lock, blocking all apps while kernel is doing
something) ... so it's difficult to say now just what could have been
the reason for what you observe.

James, if you have a "test script" with configuration files, I can setup
a test environment and run some tests and also enable ftrace [1], which
could also pin-point more where the kernel spends its time doing things.


kind regards,

David Sommerseth


[1] <http://www.wireshark.org/lists/wireshark-dev/200911/msg00260.html>


[ ---------
For the curious mind - checking changelog for a specific file in the
kernel tree:
* git clone
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
* cd linux-2.6
* only commit messages:
     git log --follow v2.6.24..v2.6.33 -- drivers/net/tun.c
* with full diff:
     git log -p --follow v2.6.24..v2.6.33 -- drivers/net/tun.c
 ---------- ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuWS+kACgkQDC186MBRfroKbwCdE5hVcQGREOaa7P+eASb6FVmC
9usAmgIYhhykLsIf6NPpe1os8kk1tTsq
=qlB9
-----END PGP SIGNATURE-----

