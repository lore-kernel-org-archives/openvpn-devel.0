Message-ID: <50586F7E.80201@...1114...>
Date: Tue, 18 Sep 2012 14:56:30 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <009101cd9591$aec40190$0c4c04b0$@ciglb.com>
	<50586944.6090307@...1114...>
	<009f01cd959b$0f2b0700$2d811500$@ciglb.com>
In-Reply-To: <009f01cd959b$0f2b0700$2d811500$@ciglb.com>
Subject: Re: [Openvpn-devel] [Openvpn-users] site to site vpn
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
To: "C.I.G IT SUPPORT" <itsupport@...1761...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/09/12 14:42, C.I.G IT SUPPORT wrote:
> Hello David,

Hi,

First of all, support goes in the public.  No private posting,
otherwise other people can't learn and it looks like nobody gets help
on the mailing list.

> What does it mean ?

It means: read the documentation

> Listen dude, I'll explain you more about my Network
> infrastructure..
> 
> Server side: LAN ---> ISA Server----> router----> WAN. LAN:
> 192.168.0.x ISA: internal NIC 192.168.0.8, External NIC
> 192.168.2.50 Router: 192.168.2.100

> Client Side: LAN ---> ISA Server----> router----> WAN. LAN:
> 192.168.0.x ISA: internal NIC 192.168.0.7, External NIC
> 192.168.1.250 Router: 192.168.1.100

I presume you have the OpenVPN client and servers on the LAN side, as
you didn't say anything else.  The client or server side LAN needs to
change IP addresses to a separate segment.  F.ex. client side to
become 192.168.10.0/24 ... this is to avoid routing issues later on.

Then configure a OpenVPN client/server setup, with a a separate
segment (say, 10.8.0.0/24) ... and then you add routes for
192.168.0.0/24 and 192.168.100.0/24 in the OpenVPN configs.  And
that's it.

> Please refer to me if am doing anything wrong.. am able to connect
> client to server but not Network to Network.

You most likely are missing proper routes, network segment conflicts
(192.168.0.0/24 on both client and server side LAN), firewalling
issues on the OpenVPN servers (not allowing traffic to be forwarded
between LAN and VPN) or that IP forwarding in general haven't been
enabled (in Linux or BSD: sysctl net.ipv4._ip_forward).

You might also find this info relevant:

<https://community.openvpn.net/openvpn/wiki/BridgingAndRouting#Usingrouting>


kind regards,

David Sommerseth



> -----Original Message----- From: David Sommerseth
> [mailto:openvpn.list@...1114...] Sent: Tuesday, September 18,
> 2012 3:30 PM To: C.I.G IT SUPPORT Cc:
> openvpn-users@lists.sourceforge.net Subject: Re: [Openvpn-users]
> site to site vpn
> 
> On 18/09/12 13:35, C.I.G IT SUPPORT wrote:
>> Hello Everybody,
> 
> 
> 
>> Can anybody assist me to create a site to site ovpn..
> 
> 
> You got a pretty good starting point when you asked last time:
> 
> <http://thread.gmane.org/gmane.network.openvpn.user/33533>
> 
> It's pretty much the same approach.  Other than that, learning how
> to configure OpenVPN will pretty much save you a lot of time later
> on. Start here:
> 
> 
> <http://openvpn.net/index.php/open-source/documentation/miscellaneous/static
>
> 
- -key-mini-howto.html>
> 
> And then continue here to add PKI (SSL certificates)
> 
> <http://openvpn.net/index.php/open-source/documentation/howto.html#pki>
>
>  And read the man page, which is also available here:
> 
> <http://openvpn.net/index.php/open-source/documentation/manuals/>
> 
> It describes quite well most of the options you need to set up a 
> site-to-site tunnel.
> 
> Other than that ... try to make use of TUN devices (not TAP) and
> UDP for transport,  that will give you the best performance on the
> tunnel.
> 
> 
> 
> kind regards,
> 
> David Sommerseth
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlBYb3YACgkQDC186MBRfrruvQCfaK+fUKzsprtQJzKNcPDgh8Ih
vBgAoIV7m4JePrHTauAMhlUMp+R+HDnJ
=dNT+
-----END PGP SIGNATURE-----

