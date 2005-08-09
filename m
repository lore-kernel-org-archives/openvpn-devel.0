Message-ID: <2CE3100C50DF6A43ADF9CDD0DFC1403C50D64B@...433...>
From: Ewan Bhamrah Harley <ewan@...432...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C59CCF.A2EDC1AA"
Subject: [Openvpn-devel] PATCH: tcp port binding and others
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Aug  9 17:16:46 2005
To: openvpn-devel@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C59CCF.A2EDC1AA
Content-Type: text/plain;
	charset="iso-8859-1"

James, as requested the attached patch is merged with 2.1alpha3.

The patch:

* Adds a new --bind option to compliment the existing --nobind options.
Implicit bind/nobind defaults are left unchanged.

* enables --local and --lport on tcp-client connections

* fixes a bug with the local_port value passed to scripts/plugins -
previously this was incorrectly set to the default port if nobind was used -
the patch sets it to '0' in this case.

* Also, the patch adds passing of http/socks proxy address and port
information to scripts/plugins.

* Updates to manpage and help to reflect the changes in the patch.

Rgds
Ewan 


------_=_NextPart_000_01C59CCF.A2EDC1AA
Content-Type: application/octet-stream;
	name="tcp_bind.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="tcp_bind.diff"

diff -Naur openvpn-2.1_alpha3/openvpn.8 =
openvpn-2.1_alpha3_patched/openvpn.8=0A=
--- openvpn-2.1_alpha3/openvpn.8	2005-06-12 19:25:48.000000000 +0100=0A=
+++ openvpn-2.1_alpha3_patched/openvpn.8	2005-08-09 10:14:11.771028000 =
+0100=0A=
@@ -187,6 +187,7 @@=0A=
 [\ \fB\-\-nice\fR\ \fIn\fR\ ]=0A=
 [\ \fB\-\-no\-iv\fR\ ]=0A=
 [\ \fB\-\-no\-replay\fR\ ]=0A=
+[\ \fB\-\-bind\fR\ ]=0A=
 [\ \fB\-\-nobind\fR\ ]=0A=
 [\ \fB\-\-ns\-cert\-type\fR\ \fIclient|server\fR\ ]=0A=
 [\ \fB\-\-passtos\fR\ ]=0A=
@@ -430,7 +431,7 @@=0A=
 .\"*********************************************************=0A=
 .TP=0A=
 .B --local host=0A=
-Local host name or IP address.=0A=
+Local host name or IP address for bind.=0A=
 If specified, OpenVPN will bind to this address only.=0A=
 If unspecified, OpenVPN will bind to all interfaces.=0A=
 .\"*********************************************************=0A=
@@ -701,13 +702,23 @@=0A=
 .\"*********************************************************=0A=
 .TP=0A=
 .B --lport port=0A=
-TCP/UDP port number for local.=0A=
+TCP/UDP port number for bind.=0A=
 .\"*********************************************************=0A=
 .TP=0A=
 .B --rport port=0A=
 TCP/UDP port number for remote.=0A=
 .\"*********************************************************=0A=
 .TP=0A=
+.B --bind=0A=
+Bind to local address and port. This is the default unless any of =0A=
+.B --proto tcp-client=0A=
+,=0A=
+.B --http-proxy=0A=
+or=0A=
+.B --socks-proxy=0A=
+are used.=0A=
+.\"*********************************************************=0A=
+.TP=0A=
 .B --nobind=0A=
 Do not bind to local address and port.  The IP stack will allocate=0A=
 a dynamic port for returning packets.  Since the value of the dynamic =
port=0A=
diff -Naur openvpn-2.1_alpha3/options.c =
openvpn-2.1_alpha3_patched/options.c=0A=
--- openvpn-2.1_alpha3/options.c	2005-07-27 21:17:24.000000000 +0100=0A=
+++ openvpn-2.1_alpha3_patched/options.c	2005-08-09 10:14:11.807030000 =
+0100=0A=
@@ -99,7 +99,7 @@=0A=
   "--version       : Show copyright and version information.\n"=0A=
   "\n"=0A=
   "Tunnel Options:\n"=0A=
-  "--local host    : Local host name or ip address.\n"=0A=
+  "--local host    : Local host name or ip address. Implies =
--bind.\n"=0A=
   "--remote host [port] : Remote host name or ip address.\n"=0A=
   "--remote-random : If multiple --remote options specified, choose =
one randomly.\n"=0A=
   "--mode m        : Major mode, m =3D 'p2p' (default, point-to-point) =
or 'server'.\n"=0A=
@@ -139,8 +139,17 @@=0A=
   "--ipchange cmd  : Execute shell command cmd on remote ip address =
initial\n"=0A=
   "                  setting or change -- execute as: cmd ip-address =
port#\n"=0A=
   "--port port     : TCP/UDP port # for both local and remote.\n"=0A=
-  "--lport port    : TCP/UDP port # for local (default=3D%d).\n"=0A=
+  "--lport port    : TCP/UDP port # for local (default=3D%d). Implies =
--bind.\n"=0A=
   "--rport port    : TCP/UDP port # for remote (default=3D%d).\n"=0A=
+  "--bind          : Bind to local address and port. (This is the =
default unless\n"=0A=
+  "                  --proto tcp-client"=0A=
+#ifdef ENABLE_HTTP_PROXY=0A=
+                   " or --http-proxy"=0A=
+#endif=0A=
+#ifdef ENABLE_SOCKS=0A=
+                   " or --socks-proxy"=0A=
+#endif=0A=
+                   " is used).\n"=0A=
   "--nobind        : Do not bind to local address and port.\n"=0A=
   "--dev tunX|tapX : tun/tap device (X can be omitted for dynamic =
device.\n"=0A=
   "--dev-type dt   : Which device type are we using? (dt =3D tun or =
tap) Use\n"=0A=
@@ -673,6 +682,20 @@=0A=
 	  setenv_int (es, remote_port_string, =
o->remote_list->array[i].port);=0A=
 	}=0A=
     }=0A=
+#ifdef ENABLE_HTTP_PROXY=0A=
+    if (o->http_proxy_options)=0A=
+      {=0A=
+        setenv_str (es, "http_proxy_server", =
o->http_proxy_options->server);=0A=
+        setenv_int (es, "http_proxy_port", =
o->http_proxy_options->port);=0A=
+      }=0A=
+#endif=0A=
+#ifdef ENABLE_SOCKS=0A=
+    if(o->socks_proxy_server)=0A=
+      {=0A=
+        setenv_str (es, "socks_proxy_server", =
o->socks_proxy_server);=0A=
+        setenv_int (es, "socks_proxy_port", o->socks_proxy_port);=0A=
+      }=0A=
+#endif=0A=
 }=0A=
 =0A=
 static in_addr_t=0A=
@@ -998,6 +1021,7 @@=0A=
   SHOW_INT (remote_port);=0A=
   SHOW_BOOL (remote_float);=0A=
   SHOW_STR (ipchange);=0A=
+  SHOW_BOOL (bind_defined);=0A=
   SHOW_BOOL (bind_local);=0A=
   SHOW_STR (dev);=0A=
   SHOW_STR (dev_type);=0A=
@@ -1414,12 +1438,29 @@=0A=
   if (string_defined_equal (options->ifconfig_local, =
options->ifconfig_remote_netmask))=0A=
     msg (M_USAGE, "local and remote/netmask --ifconfig addresses must =
be different");=0A=
 =0A=
+  if (options->bind_defined && !options->bind_local)=0A=
+    msg (M_USAGE, "--bind and --nobind can't be used together");=0A=
+=0A=
+  if (options->local && !options->bind_local)=0A=
+    msg (M_USAGE, "--local and --nobind don't make sense when used =
together");=0A=
+=0A=
   if (options->local_port_defined && !options->bind_local)=0A=
     msg (M_USAGE, "--lport and --nobind don't make sense when used =
together");=0A=
 =0A=
   if (!options->remote_list && !options->bind_local)=0A=
     msg (M_USAGE, "--nobind doesn't make sense unless used with =
--remote");=0A=
 =0A=
+  if (options->proto =3D=3D PROTO_TCPv4_CLIENT && !options->local && =
!options->local_port_defined && !options->bind_defined)=0A=
+    options->bind_local =3D false;=0A=
+=0A=
+#ifdef ENABLE_SOCKS=0A=
+  if (options->proto =3D=3D PROTO_UDPv4 && options->socks_proxy_server =
&& !options->local && !options->local_port_defined && =
!options->bind_defined)=0A=
+    options->bind_local =3D false;=0A=
+#endif=0A=
+=0A=
+  if (!options->bind_local)=0A=
+    options->local_port =3D 0;=0A=
+=0A=
   /*=0A=
    * Check for consistency of management options=0A=
    */=0A=
@@ -3323,6 +3364,11 @@=0A=
       options->port_option_used =3D true;=0A=
       options->remote_port =3D port;=0A=
     }=0A=
+  else if (streq (p[0], "bind"))=0A=
+    {=0A=
+      VERIFY_PERMISSION (OPT_P_GENERAL);=0A=
+      options->bind_defined =3D true;=0A=
+    }=0A=
   else if (streq (p[0], "nobind"))=0A=
     {=0A=
       VERIFY_PERMISSION (OPT_P_GENERAL);=0A=
diff -Naur openvpn-2.1_alpha3/options.h =
openvpn-2.1_alpha3_patched/options.h=0A=
--- openvpn-2.1_alpha3/options.h	2005-07-26 16:10:52.000000000 +0100=0A=
+++ openvpn-2.1_alpha3_patched/options.h	2005-08-09 10:14:11.822034000 =
+0100=0A=
@@ -120,6 +120,7 @@=0A=
   struct remote_list *remote_list;=0A=
   bool remote_random;=0A=
   const char *ipchange;=0A=
+  bool bind_defined;=0A=
   bool bind_local;=0A=
   const char *dev;=0A=
   const char *dev_type;=0A=
diff -Naur openvpn-2.1_alpha3/socket.c =
openvpn-2.1_alpha3_patched/socket.c=0A=
--- openvpn-2.1_alpha3/socket.c	2005-07-25 03:38:38.000000000 +0100=0A=
+++ openvpn-2.1_alpha3_patched/socket.c	2005-08-09 10:35:49.048864000 =
+0100=0A=
@@ -704,7 +704,26 @@=0A=
 }=0A=
 =0A=
 static void=0A=
+socket_bind (socket_descriptor_t sd,=0A=
+             struct openvpn_sockaddr *local)=0A=
+{=0A=
+  struct gc_arena gc =3D gc_new ();=0A=
+=0A=
+  if (bind (sd, (struct sockaddr *) local,=0A=
+                sizeof (struct openvpn_sockaddr)))=0A=
+    {=0A=
+      const int errnum =3D openvpn_errno_socket ();=0A=
+      msg (M_FATAL, "TCP/UDP: Socket bind failed on local address %s: =
%s",=0A=
+           print_sockaddr (local, &gc),=0A=
+           strerror_ts (errnum, &gc));=0A=
+    }=0A=
+  gc_free (&gc);=0A=
+}=0A=
+=0A=
+static void=0A=
 socket_connect (socket_descriptor_t *sd,=0A=
+                struct openvpn_sockaddr *local,=0A=
+                bool bind_local,=0A=
 		struct openvpn_sockaddr *remote,=0A=
 		struct remote_list *remote_list,=0A=
 		const char *remote_dynamic,=0A=
@@ -747,6 +766,8 @@=0A=
 	}=0A=
 =0A=
       *sd =3D create_socket_tcp ();=0A=
+      if (bind_local)=0A=
+        socket_bind (*sd, local);=0A=
       update_remote (remote_dynamic, remote, remote_changed);=0A=
       break;=0A=
 default:=0A=
@@ -858,13 +879,13 @@=0A=
   /* bind to local address/port */=0A=
   if (sock->bind_local)=0A=
     {=0A=
-      if (bind (sock->sd,  &sock->info.lsa->local.addr.sa, =
addrlen))=0A=
-	{=0A=
-	  const int errnum =3D openvpn_errno_socket ();=0A=
-	  msg (M_FATAL, "TCP/UDP: Socket bind failed on local address %s: =
%s",=0A=
-	       print_sockaddr (&sock->info.lsa->local, &gc),=0A=
-	       strerror_ts (errnum, &gc));=0A=
-	}=0A=
+#ifdef ENABLE_SOCKS=0A=
+      if (sock->socks_proxy && sock->info.proto =3D=3D PROTO_UDPv4)=0A=
+          socket_bind (sock->ctrl_sd, &sock->info.lsa->local);=0A=
+      else=0A=
+#endif=0A=
+          socket_bind (sock->sd, &sock->info.lsa->local);=0A=
+=0A=
     }=0A=
   gc_free (&gc);=0A=
 }=0A=
@@ -1163,10 +1184,6 @@=0A=
       else=0A=
 	sock->bind_local =3D true;=0A=
     }=0A=
-  else if (sock->info.proto =3D=3D PROTO_TCPv4_CLIENT)=0A=
-    {=0A=
-      sock->bind_local =3D false;=0A=
-    }=0A=
 =0A=
   /* were we started by inetd or xinetd? */=0A=
   if (sock->inetd)=0A=
@@ -1269,6 +1286,8 @@=0A=
       else if (sock->info.proto =3D=3D PROTO_TCPv4_CLIENT || =
sock->info.proto =3D=3D PROTO_TCPv6_CLIENT)=0A=
 	{=0A=
 	  socket_connect (&sock->sd,=0A=
+                          &sock->info.lsa->local,=0A=
+                          sock->bind_local,=0A=
 			  &sock->info.lsa->actual,=0A=
 			  sock->remote_list,=0A=
 			  remote_dynamic,=0A=
@@ -1307,6 +1326,8 @@=0A=
       else if (sock->info.proto =3D=3D PROTO_UDPv4 && =
sock->socks_proxy)=0A=
 	{=0A=
 	  socket_connect (&sock->ctrl_sd,=0A=
+                          &sock->info.lsa->local,=0A=
+                          sock->bind_local,=0A=
 			  &sock->info.lsa->actual,=0A=
 			  NULL,=0A=
 			  remote_dynamic,=0A=

------_=_NextPart_000_01C59CCF.A2EDC1AA--

