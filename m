Date: Sun, 30 Oct 2016 14:48:25 +0100
From: Maximilian Wilhelm <max@...1047...>
Message-ID: <20161030134825.GB1791@...2038...>
References: <20161021154630.GT25148@...2038...>
	<20161021165926.GV25148@...2038...>
MIME-Version: 1.0
In-Reply-To: <20161021165926.GV25148@...2038...>
Subject: [Openvpn-devel] [PATCH] Allow to specify bind interface for
 outbound/inbound connections
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Anno domini 2016 Maximilian Wilhelm scripsit:

> Anno domini 2016 Maximilian Wilhelm scripsit:
> 
> Hi again,
> 
> > I'm rolling out Linux VRFs[0] in my network and pushed all my external
> > connections in a VRF, so nothing bad[tm] can happen.
> > 
> > Doing so broke my OpenVPN connections between network nodes, as I kind
> > of expected.
> > 
> > I tried using the --bind option to let OpenVPN bind to the external IP
> > for make a connection, but that doesn't work as the IP isn't
> > resolvable via the main kernel routing table, as it's only visible
> > within the VRFs routing table.
> > 
> > So I tried pushing the OpenVPN socket into the VRF and that worked
> > fine.
> > 
> > I massaged that into a --outer-vrf option where a user could specify
> > the VRF device. This can be found in
> > 
> >   https://github.com/OpenVPN/openvpn/pull/64
> 
> I just learned that it would be easy to make this more generic and
> that the socket option isn't only used/useful for VRFs and created a
> new PR for this.
> 
>   See https://github.com/OpenVPN/openvpn/pull/65
> 
> This basicly does the same thing - specify the bind-device and allows
> implementing this for more platforms. I added code for FreeBSD but I
> couldn't test this as I don't have a BSD machine available.
> 
> > The rational why the option is called outer-vrf is that, one might
> > want to add one for the inner-vrf, when the tun/tap interface should
> > be part of a VRF. As this could be easily done in an ifup-script I
> > didn't bother adding this for now.
> > 
> > I'd be glad if this would be accepted.

This has been in production use for some time now and there don't seem
to be any problems :)

Can I motivate anyone on commenting on or applying this? :)

Best
Max


commit 1baa7e6782b39ed664eedb9b006728d31e22c07e
Author: Maximilian Wilhelm <max@...1047...>
Date:   Fri Oct 21 17:05:25 2016 +0200

    Add --bind-dev option.

      This options allows the user to specify a network device the OpenVPN process
      should use when making a connection or binding to an address. This translates
      in setting the SO_BINDTODEVICE option to the corresponding socket (on Linux).

      When for example using VRFs on Linux [0] this allows making connections using
      the non-default VRF and having the tun/tap interface in the default VRF.

      It seems FreeBSD does not support the SO_BINDTODEVICE socket option, but has
      a similar one called IP_SENDIF. As I don't have any BSD running, this part is
      untested.

      Thanks to David Ahern (Cumulus Networks) for insights on this.

      [0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/vrf.txt

    Signed-off-by: Maximilian Wilhelm <max@...1047...>

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 73f8c6d..57b1423 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2856,7 +2856,8 @@ do_init_socket_1 (struct context *c, const int mode)
 			   c->options.sndbuf,
 			   c->options.mark,
 			   &c->c2.server_poll_interval,
-			   sockflags);
+			   sockflags,
+			   c->options.bind_dev);
 }
 
 /*
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 281ef0b..58dd298 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -167,6 +167,8 @@ static const char usage_message[] =
                    " or --socks-proxy"
                    " is used).\n"
   "--nobind        : Do not bind to local address and port.\n"
+  "--bind-dev dev  : Bind to the given device when making connection to a peer or\n"
+  "                  listening for connections\n"
   "--dev tunX|tapX : tun/tap device (X can be omitted for dynamic device.\n"
   "--dev-type dt   : Which device type are we using? (dt = tun or tap) Use\n"
   "                  this option only if the tun/tap device used with --dev\n"
@@ -5128,6 +5130,13 @@ add_option (struct options *options,
 	    msg (msglevel, "unknown socket flag: %s", p[j]);	    
 	}
     }
+#ifdef TARGET_LINUX
+  else if (streq (p[0], "bind-dev") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_SOCKFLAGS);
+      options->bind_dev = p[1];
+    }
+#endif
   else if (streq (p[0], "txqueuelen") && p[1] && !p[2])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b7453a0..3ce4550 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -325,6 +325,7 @@ struct options
 
   /* socket flags */
   unsigned int sockflags;
+  char *bind_dev;
 
   /* route management */
   const char *route_script;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 184c7ad..b345de2 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -868,6 +868,15 @@ create_socket (struct link_socket* sock, struct addrinfo* addr)
     /* set socket to --mark packets with given value */
     socket_set_mark (sock->sd, sock->mark);
 
+  if (sock->bind_dev)
+    {
+#if defined(TARGET_LINUX)
+      setsockopt (sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev, strlen (sock->bind_dev) + 1);
+#elif defined(TARGET_FREEBSD)
+      setsockopt(fd, SOL_SOCKET, IP_SENDIF, sock->bind_dev, strlen (sock->bind_dev) + 1);
+#endif
+    }
+
     bind_local (sock, addr->ai_family);
 }
 
@@ -1525,7 +1534,8 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 int sndbuf,
 			 int mark,
 			 struct event_timeout* server_poll_timeout,
-			 unsigned int sockflags)
+			 unsigned int sockflags,
+			 const char *bind_dev)
 {
   ASSERT (sock);
 
@@ -1550,6 +1560,7 @@ link_socket_init_phase1 (struct link_socket *sock,
 
   sock->sockflags = sockflags;
   sock->mark = mark;
+  sock->bind_dev = bind_dev;
 
   sock->info.proto = proto;
   sock->info.af = af;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index e1607f4..8a0a5c7 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -213,6 +213,7 @@ struct link_socket
 # define SF_GETADDRINFO_DGRAM (1<<4)
   unsigned int sockflags;
   int mark;
+  char *bind_dev;
 
   /* for stream sockets */
   struct stream_buf stream_buf;
@@ -327,7 +328,8 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 int sndbuf,
 			 int mark,
 			 struct event_timeout* server_poll_timeout,
-			 unsigned int sockflags);
+			 unsigned int sockflags,
+			 const char *bind_dev);
 
 void link_socket_init_phase2 (struct link_socket *sock,
 			      const struct frame *frame,

-- 
 "First they ignore you,
  then they laugh at you,
  then they fight you,
  then you win."         -- Mahatma Gandhi

