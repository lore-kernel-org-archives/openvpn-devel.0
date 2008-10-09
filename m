Message-ID: <48EDBFC7.9040301@...41...>
Date: Thu, 09 Oct 2008 02:24:39 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1_rc13 released
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
To: Openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

OpenVPN OpenVPN 2.1_rc13 has been released.  Download from the usual place:

http://openvpn.net/download.html

Also, I've had many requests for prebuilt and Windows TAP debug 
versions, so I've added:

http://openvpn.net/debug/

and

http://openvpn.net/prebuilt/

The debug directory contains a special version of the Windows installer 
that has a TAP driver built with debugging enabled.  This lets you view 
TAP driver debug messages with --verb set to 6 or higher.

The prebuilt .tbz files contain helper binaries for constructing a 
custom Windows installer without needing to build all dependencies from 
scratch.  Read about it more in the ./domake-win file.

Changelog:

2008.10.07 -- Version 2.1_rc13

* Bundled OpenSSL 0.9.8i with Windows installer.

* Management interface can now listen on a unix
   domain socket, for example:

     management /tmp/openvpn unix

   Also added management-client-user and management-client-group
   directives to control which processes are allowed to connect
   to the socket.

* Copyright change to OpenVPN Technologies, Inc.


James

