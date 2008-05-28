Message-ID: <483DC794.3090302@...1104...>
Date: Wed, 28 May 2008 16:59:00 -0400
From: Martin Gadbois <martin.gadbois@...1104...>
MIME-Version: 1.0
References: <483DA4E4.1030308@...1104...> <m3skw240d8.fsf@...1043...>
In-Reply-To: <m3skw240d8.fsf@...1043...>
Subject: Re: [Openvpn-devel] Memory of server keeps increasing with
	key	negotiations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Marko Rauhamaa <marko@...1042...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marko Rauhamaa wrote:
> You might be suffering from the problem I sent a patch for some months
> back. Basically, socket.c, socket_connect() accumulated unlimited
> amounts of memory if the server wasn't available. I added a pair of
> gc_free()/gc_new() in the middle of the loop.

I saw your patch, but I do not think your situation fits mine, as my
server is connected with exactly one client. It must be something like
this though...

I've looked at the code (Yeah! Open Source) and could not see any lists,
or code that accumulates data, apart from gc_*().

Maybe I should look into gc_*() closer...

(Or I could add debug code that logs when a gc() gets bigger than a
particular threshold... mmmm...)

Thanks Marko.

- --
==============         +---------------------------------------------+
Martin Gadbois         |    You are            -- J. Steakley,       |
Sr. SW Designer        |    What you do             Armor, 1984      |
Colubris Networks Inc. |    When it counts.                          |
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIPceUMPkSU9icdA0RAqJMAKCcrXVCYepo2whovuCRZ1puK1se0QCfXfbN
QIPPcBRXHxa/SAbzl/oA6fM=
=yCR3
-----END PGP SIGNATURE-----

