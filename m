Message-ID: <4A13BBB4.8020101@...41...>
Date: Wed, 20 May 2009 02:13:40 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1_rc16 released
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

We are very close to 2.1.  I know there's been some discussion about the 
Windows client GUI, whether it deserves to live in 2.1.  We do have a 
new client GUI that we've developed as a part of our Access Server 
product and we are open to releasing it with 2.1, however doing so would 
probably add more RC cycles to the 2.1 release.

The other option is to just release what we have now, pending a week or 
so of testing on rc16, and get the new Windows client GUI into a 
post-2.1 release.

Thoughts?

2009.05.17 -- Version 2.1_rc16

* Windows installer changes:

   1. ifdefed out the check Windows version code which is causing
   problems on Windows 7

   2. don't define SF_SELECTED if it is already defined

   3. Use LZMA instead of BZIP2 compression for better compression

   4. Upgraded OpenSSL to 0.9.8k

* Added the ability to read the configuration file
   from stdin, when "stdin" is given as the config
   file name.

* Allow "management-client" directive to be used
   with unix domain sockets.

* Added errors-to-stderr option.  When enabled, fatal errors
   that result in the termination of the daemon will be written
   to stderr.

* Added optional "nogw" (no gateway) flag to --server-bridge
   to inhibit the pushing of the route-gateway parameter to
   clients.

* Added new management interface command "pid" to show the
   process ID of the current OpenVPN process (Angelo Laub).

* Fixed issue where SIGUSR1 restarts would fail if private
   key was specified as an inline file.

* Added daemon_start_time and daemon_pid environmental variables.

* In management interface, added new ">CLIENT:ESTABLISHED" notification.

* Build fixes:

   1. Fixed some issues with C++ style comments that leaked into the code.

   2. Updated configure.ac to work on MinGW64.

   3. Updated common.h types for _WIN64.

   4. Fixed issue involving an #ifdef in a macro reference that breaks 
early gcc
      compilers.

   5. In cryptoapi.c, renamed CryptAcquireCertificatePrivateKey to
      OpenVPNCryptAcquireCertificatePrivateKey to work around
      a symbol conflict in MinGW-5.1.4.

