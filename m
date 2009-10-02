Message-ID: <4AC5C604.3010908@...41...>
Date: Fri, 02 Oct 2009 03:21:08 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1_rc20 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: OpenVpn-Users <openvpn-users@lists.sourceforge.net>, Openvpn-devel@lists.sourceforge.net

2009.10.01 -- Version 2.1_rc20

* Fixed a bug introduced in 2.1_rc17 (svn r4436) where using the
   redirect-gateway option by itself, without any extra parameters,
   would cause the option to be ignored.

* Fixed build problem when ./configure --disable-server is used.

* Fixed ifconfig command for "topology subnet" on FreeBSD (Stefan Bethke).

* Added --remote-random-hostname option.

* Added "load-stats" management interface command to get global server
   load statistics.

* Added new ./configure flags:

   --disable-def-auth      Disable deferred authentication
   --disable-pf            Disable internal packet filter

* Added "setcon" directive for interoperability with SELinux (Sebastien
   Raveau).

* Optimized PUSH_REQUEST handshake sequence to shave several seconds
   off of a typical client connection initiation.

* The maximum number of "route" directives (specified in the config
   file or pulled from a server) can now be configured via the new
   "max-routes" directive.

* Eliminated the limitation on the number of options that can be pushed
   to clients, including routes.  Previously, all pushed options needed
   to fit within a 1024 byte options string.

* Added --server-poll-timeout option : when polling possible remote
   servers to connect to in a round-robin fashion, spend no more than
   n seconds waiting for a response before trying the next server.

* Added the ability for the server to provide a custom reason string
   when an AUTH_FAILED message is returned to the client.  This
   string can be set by the server-side managment interface and read
   by the client-side management interface.

* client-kill management interface command, when issued on server, will
   now send a RESTART message to client.
   This feature is intended to make UDP clients respond the same as TCP
   clients in the case where the server issues a RESTART message in
   order to force the client to reconnect and pull a new options/route
   list.

