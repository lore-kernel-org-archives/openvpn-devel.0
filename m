Sender: marko@...1042...
References: <483DA4E4.1030308@...1104...>
Date: 28 May 2008 23:52:51 +0300
In-Reply-To: <483DA4E4.1030308@...1104...>
Message-ID: <m3skw240d8.fsf@...1043...>
MIME-Version: 1.0
From: Marko Rauhamaa <marko@...1042...>
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
Content-Transfer-Encoding: 8bit
To: Martin Gadbois <martin.gadbois@...1104...>
Cc: openvpn-devel@lists.sourceforge.net

Martin Gadbois <martin.gadbois@...1104...>:

> Using OpenVPN 2.0.5 and 2.0.9, I notice that an somewhat idle connection
> increases the RSS of the server process linearly with time.
> 
> valgrind says that there are no memory leaks. So where is this memory kept?

You might be suffering from the problem I sent a patch for some months
back. Basically, socket.c, socket_connect() accumulated unlimited
amounts of memory if the server wasn't available. I added a pair of
gc_free()/gc_new() in the middle of the loop.

==Begin pseudo-patch====================================================
       msg (D_LINK_ERRORS | M_ERRNO_SOCK,
            "TCP: connect to %s failed, will try again in %d seconds",
            print_sockaddr (remote, &gc),
            connect_retry_seconds);
 
+      /* avoid accumulating garbage when the server is not available */
+      gc_free (&gc);
+      gc = gc_new ();
       openvpn_close_socket (*sd);
       openvpn_sleep (connect_retry_seconds);
==End pseudo-patch======================================================

It was not garbage because all dynamic memory was kept track of and
would be cleared at the end of the function (gc_free()). However, as
long as a connection couldn't be formed, boundless amounts of memory
were allocated.


Marko

