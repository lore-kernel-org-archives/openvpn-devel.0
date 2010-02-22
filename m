Message-ID: <4B82FDC9.7000101@...1114...>
Date: Mon, 22 Feb 2010 22:57:29 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B82F647.5050405@...1305...>
In-Reply-To: <4B82F647.5050405@...1305...>
Subject: Re: [Openvpn-devel] segfault issue
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
To: mark <mark.co-dyre@...1305...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/02/10 22:25, mark wrote:
> Hello all!
> 
> I'm using the openvpn-client with connmand (Redhat Moblin connection 
> manager) and everything seems to be working fine although once every 
> hour, like perfect clockwork, I get a segfault although there are no 
> noticeable issues, crashes, exits.  Everything just keeps chuggin along.
> 
> -----sys.log: issue------
> Feb 22 19:45:33 A5-20713 kernel: [54562.275481] bash[21933]: segfault at 
> bf186ff8 ip b7f66da9 sp bf186ffc error 6 in libc-2.10.1.so[b7ef5000+16a000]
> Feb 22 19:45:43 A5-20713 kernel: [54572.379778] bash[21974]: segfault at 
> bf3bbffc ip 0807e845 sp bf3bc000 error 6 in bash[8048000+d4000]
> 
> Feb 22 20:45:33 A5-20713 kernel: [58161.946736] bash[1605]: segfault at 
> bf4dffcc ip 08064809 sp bf4dffc0 error 6 in bash[8048000+d4000]
> Feb 22 20:45:43 A5-20713 kernel: [58172.320628] bash[1646]: segfault at 
> bf405ffc ip 0807d1f6 sp bf405ee0 error 6 in bash[8048000+d4000]
> 
> ---------
> 
> The segfault disappears if I stop the openvpn-client and or the connman 
> software although returns when both are running.
> I sense it has something to do with each of the two pieces of software 
> managing the connections.  Although I'm not quiet sure how to go about 
> debugging it.  Would anyone have any words of wisdom or advice to share 
> with me to go about debugging this issue.  Or know of something the 
> client manages on an hourly cycle that can be a starting point to my 
> investigations.  I imagine one or the other is trying to use memory that 
> it shouldn't be although I'm currently a novice at debugging this 
> because I've never debugged this type of issue before.   So any help 
> would be greatly appreciated.  I've included some info below that might 
> be able to help with the challenge I currently face.
> 
> BTW... using a 2.6.30 kernel.

Would you mind installing the openvpn-debug package and then run openvpn
via gdb?   Then you should be able to get a backtrace of the crash.  It
might be you need to install gdb as well.

Quick crash course to gdb ... just in case this is not familiar to you.

gdb /usr/sbin/openvpn
[gdb info message...blablabla...]
(gdb) run --config <your config file> [--other-arguments-you-might-pass]
[wait for the crash]
(gdb) bt
[full backtrace should appear]

If you're having troubles, you can grab me on IRC (FreeNode,
chat.freenode.net) on the #openvpn-devel channel.  We're a few people
there most of the daytime (UTC+1).


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuC/ckACgkQDC186MBRfrrktgCggiyiwxI/+EtoI4R8zpzzI1Ce
3B4AnjNqn61Vtip5ZHweNE3Vf0RNWYMm
=fqW1
-----END PGP SIGNATURE-----

