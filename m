From: Richard Mueller <mueller@...60...>
Reply-To: Richard Mueller <mueller@...60...>
Message-ID: <52162283631.20021218210311@...60...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Exec scripts at sigusr1 and established tunnel
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Dec 18 11:04:03 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello openvpn-developers,

I needed two more places in openvpn where to exec some scripts
because I wanted to build a "fail-over" solution between two
tuns.


1.) Situation:
  +---------+       tun0 (ISP0)    +---------+
  | BOX 1   +----------------------+ BOX 2   |
  |         |                      |         |
  |         +----------------------+         |
  +---------+       tun1 (ISP1)    +---------+

tun0 is prefered but if tun0 fails tun1 should do
the job.

Linux advanced routing has a usable solution for this:
  Two routing tables with one prefered.

Because of this I needed to add/delete routes at this points:

- After the first "answer" from the peer (add route for tun?)
- At a SIGUSR1 == "peer dead" (del route for tun?)


2.) I used following configs:

[BOX1: tun0]

# interface configuration
dev tun0

# Peer connect configuartion
 remote 172.16.90.4
# float

persist-tun
persist-key
ping 7
ping-restart 21

# 10.255.253.8 is our local  VPN endpoint
# 10.255.253.9 is our remote VPN endpoint
ifconfig 10.255.254.122  10.255.254.121

# TSL-Client
tls-client
ca   /etc/openvpn/certs/ca.crt
cert /etc/openvpn/certs/box1.crt
key  /etc/openvpn/certs/box1.key
tls-verify "/usr/local/sbin/verify-cn box2"

# Routen setzen
peerinit /etc/openvpn/scripts/tun0.up
sigusr1  /etc/openvpn/scripts/tun0.down

lport 5006
rport 5007

comp-lzo
#daemon

reneg-sec 600

verb 5

[BOX1: tun1]

# interface configuration
dev tun1

# Peer connect configuartion
 remote 172.16.90.4
# float

persist-tun
persist-key
ping 7
ping-restart 21

# 10.255.253.8 is our local  VPN endpoint
# 10.255.253.9 is our remote VPN endpoint
ifconfig 10.255.253.122  10.255.253.121

# TSL-Client
tls-client
ca   /etc/openvpn/certs/ca.crt
cert /etc/openvpn/certs/box1.crt
key  /etc/openvpn/certs/box1.key
tls-verify "/usr/local/sbin/verify-cn box2"

# Routen setzen
peerinit /etc/openvpn/scripts/tun1.up
sigusr1  /etc/openvpn/scripts/tun1.down

lport 5506
rport 5507

comp-lzo
#daemon

reneg-sec 600

verb 5

[BOX2: tun0]

# interface configuration
dev tun0

# Peer connect configuartion
 remote 172.16.90.1
# float

persist-tun
persist-key
ping 7
ping-restart 21

ifconfig 10.255.254.121  10.255.254.122

# TSL-Client
tls-client
ca   /etc/openvpn/certs/ca.crt
cert /etc/openvpn/certs/box2.crt
key  /etc/openvpn/certs/box2.key
tls-verify "/usr/local/sbin/verify-cn box1"

# Routen setzen
peerinit /etc/openvpn/scripts/tun0.up
sigusr1  /etc/openvpn/scripts/tun0.down

lport 5007
rport 5006

comp-lzo
#daemon

reneg-sec 600

verb 5

[BOX1: tun1]

# interface configuration
dev tun1

# Peer connect configuartion
 remote 172.16.90.1
# float

persist-tun
persist-key
ping 7
ping-restart 21

ifconfig 10.255.253.121  10.255.253.122

# TSL-Client
tls-client
ca   /etc/openvpn/certs/ca.crt
cert /etc/openvpn/certs/box2.crt
key  /etc/openvpn/certs/box2.key
tls-verify "/usr/local/sbin/verify-cn box1"

peerinit /etc/openvpn/scripts/tun1.up
sigusr1  /etc/openvpn/scripts/tun1.down

lport 5507
rport 5506

comp-lzo
#daemon

reneg-sec 600

verb 5

4.) Here is the patch:

[PATCH START]
diff -u openvpn-1.3.2/openvpn.c openvpn-1.3.2-droute/openvpn.c
--- openvpn-1.3.2/openvpn.c     Mon Oct 21 03:46:52 2002
+++ openvpn-1.3.2-droute/openvpn.c      Wed Dec 18 19:18:12 2002
@@ -341,7 +341,7 @@
                     options->local_port, options->remote_port,
                     options->bind_local, options->remote_float,
                     options->inetd,
-                    udp_socket_addr, options->ipchange,
+                    udp_socket_addr, options->ipchange, options->peerinit_script,
                     options->resolve_retry_seconds);
 
 #ifdef USE_CRYPTO
@@ -1406,6 +1406,15 @@
       run_script (options->down_script, tuntap_actual, MAX_RW_SIZE_TUN (&frame),
                  max_rw_size_udp, options->ifconfig_local, options->ifconfig_remote);
     }
+   /*
+    * Execute sigusr1 script 
+    */
+  if ( !(signal_received == SIGUSR1 && !options->sigusr1_script ) )
+    {
+     msg (M_INFO, "Executing sigusr1 script %s",options->sigusr1_script);
+     system_check (options->sigusr1_script, "sigusr1 command failed", false);
+    }
+
  done:
   /* pop our garbage collection level */
   gc_free_level (gc_level);
diff -u openvpn-1.3.2/options.c openvpn-1.3.2-droute/options.c
--- openvpn-1.3.2/options.c     Sat Oct 19 23:26:11 2002
+++ openvpn-1.3.2-droute/options.c      Wed Dec 18 18:52:24 2002
@@ -316,6 +316,9 @@
   SHOW_STR (writepid);
   SHOW_STR (up_script);
   SHOW_STR (down_script);
+  SHOW_STR (peerinit_script);
+  SHOW_STR (sigusr1_script);
+  SHOW_STR (down_script);
   SHOW_BOOL (daemon);
   SHOW_BOOL (inetd);
   SHOW_INT (nice);
@@ -726,6 +729,16 @@
     {
       ++i;
       options->down_script = p2;
+    }
+  else if (streq(p1, "peerinit") && p2) 
+    {
+      ++i;
+      options->peerinit_script = p2;
+    }
+  else if (streq(p1, "sigusr1") && p2) 
+    {
+      ++i;
+      options->sigusr1_script = p2;
     }
   else if (streq (p1, "daemon"))
     {
diff -u openvpn-1.3.2/options.h openvpn-1.3.2-droute/options.h
--- openvpn-1.3.2/options.h     Sat Oct 19 22:25:46 2002
+++ openvpn-1.3.2-droute/options.h      Wed Dec 18 18:25:46 2002
@@ -87,6 +87,8 @@
   const char *writepid;
   const char *up_script;
   const char *down_script;
+  const char *peerinit_script;
+  const char *sigusr1_script;
   bool daemon;
   bool inetd;
   int nice;
diff -u openvpn-1.3.2/socket.c openvpn-1.3.2-droute/socket.c
--- openvpn-1.3.2/socket.c      Sat Oct 19 23:23:19 2002
+++ openvpn-1.3.2-droute/socket.c       Wed Dec 18 18:56:18 2002
@@ -105,6 +105,7 @@
                 bool inetd,
                 struct udp_socket_addr *usa,
                 const char *ipchange_command,
+                const char *peerinit_command,
                 int resolve_retry_seconds)
 {
   CLEAR (*sock);
@@ -112,6 +113,7 @@
   sock->remote_float = remote_float;
   sock->addr = usa;
   sock->ipchange_command = ipchange_command;
+  sock->peerinit_command = peerinit_command;
 
   /* were we started by inetd or xinetd? */
   if (inetd)
@@ -190,6 +192,22 @@
          sock->set_outgoing_initial = true;
          mutex_unlock (L_SOCK);
          msg (M_INFO, "Peer Connection Initiated with %s", print_sockaddr (&usa->actual));
+
+         if (sock->peerinit_command) 
+           {
+             char command[256];
+             struct buffer out;
+
+             msg (M_INFO, "Executing peerinit_script %s",sock->peerinit_command);
+
+             buf_set_write (&out, command, sizeof (command));
+             buf_printf (&out, "%s %s",
+                         sock->peerinit_command,
+                         print_sockaddr_ex (&usa->actual, true, " "));
+             msg (D_TLS_DEBUG, "executing ip-change command: %s", command);
+             system_check (command, "peerinit command failed", false);
+            }
+
          if (sock->ipchange_command)
            {
              char command[256];
diff -u openvpn-1.3.2/socket.h openvpn-1.3.2-droute/socket.h
--- openvpn-1.3.2/socket.h      Sat Oct 19 23:26:10 2002
+++ openvpn-1.3.2-droute/socket.h       Wed Dec 18 18:49:01 2002
@@ -42,6 +42,7 @@
   bool remote_float;
   struct udp_socket_addr *addr;
   const char *ipchange_command;
+  const char *peerinit_command;
   int sd;                      /* file descriptor for socket */
 };
 
@@ -56,6 +57,7 @@
                 bool inetd,
                 struct udp_socket_addr *addr,
                 const char *ipchange_command,
+                 const char *peerinit_command,
                 int resolve_retry_seconds);
 
 void
[PATCH START]

5.) If it is interesting for you, James, you are free to clean the
    code and fix the documentation and merge it in your branch.
    Just write a Creditline in the changelog. ;-)

6.) Feel free to ask, if you have some questions.

bye
richard

-- 
Richard Mueller     mailto:mueller@...60...  Fon: +49 9171 896287
Teamix GmbH         http://www.teamix.de       Fax: +49 9171 896286

PGP Public Key      http://www.teamix.net/pgp/rm_public_key_2048
Fingerprint:        ea 50 21 6c a5 39 e9 03 a6 59 af e3 c5 1f 63 8e

Networks - Consulting - Training - Software Development - eCommerce


