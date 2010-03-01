Message-ID: <4B8BB647.2020804@...1114...>
Date: Mon, 01 Mar 2010 13:42:47 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <6c75f86b.6552e8f7.4b8bad61.2e7bd@...1309...>
In-Reply-To: <6c75f86b.6552e8f7.4b8bad61.2e7bd@...1309...>
Subject: Re: [Openvpn-devel] Openvpn 2.1.1 bad tcp performance but good ping
 when -l 1472 (with packet size = MTU)
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
To: booyakasha <booyakasha@...1309...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users <openvpn-users@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/03/10 13:04, booyakasha wrote:
> Hello,
> there are so many complains about openvpn performance in proto tcp mode
> that it is almost unbelievable that nobody took care of it. I am using two 20/20 MB connections and openvpn
> tunnel in tcp mode. without vpn my ping is about 10ms but with vpn it jumps to 520ms. What is most interesting when i use ping -l 1472 which is maximum packet size for MTU 1500 ping is OK and about 13ms. Any other size than 1472 (which means 1500 = 1472 + 28 overhead) causes ping to take values about 500-600ms.  And it is not acceptable to use UDP for me because of my company policy. I think that it is very common problem and not yet answered. I am taking wild guess that everything works OK with proper packet size = MTU but when packet is smaller or larger (with fragmentation) it causes lags. Looking forward to your answers.
>

Could this be related to this?

<http://sites.inka.de/~bigred/devel/tcp-tcp.html>

And in the moment you exceed the MTU size (1500) in your ping requests,
you will produce more TCP packets.  You might even hit some issues with
the Nagle algorithm as well? (have you tried with --socket-flags
TCP_NODELAY ?) ... As you have a strict firewall policy, could it be
that this causes some issues?

Or it might be that you need some tuning on the --link-mtu, --tun-mtu or
- --tun-mtu-extra?  Have you tried running an OpenVPN client with
--mtu-test?

Providing more information about your configuration and what you have
tried so far would also be helpful, and not just a rather nasty
accusation.  In many cases, what you complain about here are often
connected to configuration issues.  Even though, TCP will never ever be
as efficient as UDP.

You also don't state if you are using TUN or TAP mode (again,
configuration file would help), where TUN is known for having better
performance and less overhead than TAP.

So, to sum it up ... you don't provide much information for us to work
on ... and to be frankly, this discussion sounds to more belong to the
openvpn-users@lists.sourceforge.net list and not the development list,
at this point.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuLtkQACgkQDC186MBRfrqaCQCgjHzVkAtIc0cESk5m3ZH0kVoP
29kAn3RB5l08St31BlZSMQb0xdVKVpD4
=uU94
-----END PGP SIGNATURE-----

