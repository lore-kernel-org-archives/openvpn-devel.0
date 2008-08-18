Message-ID: <48A92CE6.4000506@...1030...>
Date: Mon, 18 Aug 2008 10:03:50 +0200
From: Marcus <adesperateuser@...1030...>
MIME-Version: 1.0
References: <200808171000.09879.noamr@...117...>
In-Reply-To: <200808171000.09879.noamr@...117...>
Subject: Re: [Openvpn-devel] OpenVPN bandwidth restrictions (wishlist)
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
To: Noam Rathaus <noamr@...117...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Noam Rathaus schrieb:
> Hi,
> 
> Is there a plan or someone that knows how to make OpenVPN limit the mount of 
> traffic it sends per user?
> 
> I know of 'shaper' functionality but I can't use it, as apparently I cannot do 
> this on the server only on the clients?
>   Options error: --shaper cannot be used with --mode server
> 
> I don't want my clients to have the ability to control how much outgoing 
> traffic my server sends, rather I want to control it in the server.
> 


Maybe you can achieve your goal by using iptables, token bucket, etc.

Have a look here:
http://seclists.org/firewall-wizards/2003/Mar/0030.html

Greetz,
 Marcus
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIqSzm+qVaNRZYOakRAsN3AKCnOA9Bco8ej82afTfurprGPh/dFACfWD+x
pTsvcrZjJEc/BhbTPa9rKwM=
=I4RI
-----END PGP SIGNATURE-----

