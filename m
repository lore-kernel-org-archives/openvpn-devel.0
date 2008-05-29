Message-ID: <483EC431.7040305@...1104...>
Date: Thu, 29 May 2008 10:56:49 -0400
From: Martin Gadbois <martin.gadbois@...1104...>
MIME-Version: 1.0
References: <483DA4E4.1030308@...1104...>	<m3skw240d8.fsf@...1043...>
	<483DC794.3090302@...1104...> <m3od6q3xdh.fsf@...1043...>
In-Reply-To: <m3od6q3xdh.fsf@...1043...>
Subject: Re: [Openvpn-devel] Memory of server keeps increasing
	with	key	negotiations
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
> Martin Gadbois <martin.gadbois@...1104...>:
> 
>> I've looked at the code (Yeah! Open Source) and could not see any
>> lists, or code that accumulates data, apart from gc_*().
> 
> There's this weird scheme by which you prepare a memory pool with
> gc_new(). Memory keeps on accumulating in the pool with alloc_buf_gc()
> (in print_sockaddr_ex(), for example). The memory is not freed until the
> whole pool is destroyed with gc_free().

Yep. It seems that whenever env_set_add() is called, context->c2.gc is
used to allocate stuff using gc*() functions at every key renegotiation.

The environement list is kept up-to-date, but all elements from this
list is allocated using context->c2.gc, and never freed.

Now, I need to fix that without breaking anything...


- --
==============         +---------------------------------------------+
Martin Gadbois         |    You are            -- J. Steakley,       |
Sr. SW Designer        |    What you do             Armor, 1984      |
Colubris Networks Inc. |    When it counts.                          |
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIPsQxMPkSU9icdA0RAmHYAJ4yA+7Vw3SVY7X/Q+pH5icLkwlu/ACcDubu
Y6+Q9emSaFl2kbwkOmInPCc=
=ZRWI
-----END PGP SIGNATURE-----

