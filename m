Message-ID: <49210C7D.8040509@...41...>
Date: Sun, 16 Nov 2008 23:17:33 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN Version 2.1_rc14 released
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

2008.11.16 -- Version 2.1_rc14

* Added AC_GNU_SOURCE to configure.ac to enable struct ucred,
   with the goal of fixing a build issue on Fedora 9 that was
   introduced in 2.1_rc13.

* Added additional method parameter to --script-security to preserve
   backward compatibility with system() call semantics used in OpenVPN
   2.1_rc8 and earlier.  To preserve backward compatibility use:

     script-security 3 system

* Added additional warning messages about --script-security 2
   or higher being required to execute user-defined scripts or
   executables.

* Windows build system changes:

   Modified Windows domake-win build system to write all openvpn.nsi
   input files to gen, so that gen can be disconnected from
   the rest of the source tree and makensis openvpn.nsi will
   still function correctly.

   Added additional SAMPCONF_(CA|CRT|KEY) macros to settings.in
   (commented out by default).

   Added optional files SAMPCONF_CONF2 (second sample configuration
   file) and SAMPCONF_DH (Diffie-Helman parameters) to Windows
   build system, and may be defined in settings.in.

* Extended Management Interface "bytecount" command
   to work when OpenVPN is running as a server.
   Documented Management Interface "bytecount" command in
   management/management-notes.txt.

* Fixed informational message in ssl.c to properly indicate
   deferred authentication.

* Added server-side --auth-user-pass-optional directive, to allow
   connections by clients that do not specify a username/password, when a
   user-defined authentication script/module is in place (via
   --auth-user-pass-verify, --management-client-auth, or a plugin module).

* Changes to easy-rsa/2.0/pkitool and related openssl.cnf:

   Calling scripts can set the KEY_NAME environmental variable to set
   the "name" X509 subject field in generated certificates.

   Modified pkitool to allow flexibility in separating the Common Name
   convention from the cert/key filename convention.

   For example:

   KEY_CN="James's Laptop" KEY_NAME="james" ./pkitool james

   will create a client certificate/key pair of james.crt/james.key
   having a Common Name of "James's Laptop" and a Name of "james".

* Added --no-name-remapping option to allow Common Name, X509 Subject,
   and username strings to include any printable character including
   space, but excluding control characters such as tab, newline, and
   carriage-return (this is important for compatibility with external
   authentication systems).

   As a related change, added --status-version 3 format (and "status 3"
   in the management interface) which uses the version 2 format except
   that tabs are used as delimiters instead of commas so that there
   is no ambiguity when parsing a Common Name that contains a comma.

   Also, save X509 Subject fields to environment, using the naming
   convention:

   X509_{cert_depth}_{name}={value}

   This is to avoid ambiguities when parsing out the X509 subject string
   since "/" characters could potentially be used in the common name.

* Fixed some ifconfig-pool issues that precluded it from being combined
   with --server directive.

   Now, for example, we can configure thusly:

     server 10.8.0.0 255.255.255.0 nopool
     ifconfig-pool 10.8.0.2 10.8.0.99 255.255.255.0

   to have ifconfig-pool manage only a subset
   of the VPN subnet.

* Added config file option "setenv FORWARD_COMPATIBLE 1" to relax
   config file syntax checking to allow directives for future OpenVPN
   versions to be ignored.

