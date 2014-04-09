Message-ID: <53453C16.1060307@...515...>
Date: Wed, 09 Apr 2014 15:24:54 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010708030305080003030103"
Subject: [Openvpn-devel] OpenVPN 2.3.3 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-announce@lists.sourceforge.net" <openvpn-announce@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010708030305080003030103
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.3.3. It
can be downloaded from here:

<http://openvpn.net/index.php/open-source/downloads.html>

This release contains a number of bug fixes, small enhancements and
changes aimed at improving long-term compatibility with newer OpenVPN
versions. In addition, the Windows installer is bundled with an updated
OpenVPN-GUI and more importantly includes OpenSSL 1.0.0g that fixes the
very serious heartbleed vulnerability:

<http://heartbleed.com/>
<https://community.openvpn.net/openvpn/wiki/heartbleed>

All Windows users of OpenVPN 2.3-rc2-I001 through OpenVPN 2.3.2-I003
should upgrade their installations immediately.

A full list of changes is available here:

<https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn23>

The changelog is also attached to this email.

For generic help use these support channels:

- Official documentation:
<http://openvpn.net/index.php/open-source/documentation/howto.html>
- Wiki: <https://community.openvpn.net>
- Forums: <https://forums.openvpn.net>
- User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
- User IRC channel: #openvpn at irc.freenode.net

Please report bugs and ask development questions here:

- Bug tracker and Wiki: <https://community.openvpn.net>
- Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
- Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
  Freenode registration)

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------010708030305080003030103
Content-Type: text/plain; charset=UTF-8;
 name="openvpn-2.3.3-changelog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="openvpn-2.3.3-changelog"

Alon Bar-Lev (1):
      pkcs11: use generic evp key instead of rsa

Arne Schwabe (8):
      Add support of utun devices under Mac OS X
      Add support to ignore specific options.
      Add a note what setenv opt does for OpenVPN < 2.3.3
      Add reporting of UI version to basic push-peer-info set.
      Fix compile error in ssl_openssl introduced by polar external-management patch
      Fix assertion when SIGUSR1 is received while getaddrinfo is successful
      Add warning for using connection block variables after connection blocks
      Introduce safety check for http proxy options

David Sommerseth (5):
      man page: Update man page about the tls_digest_{n} environment variable
      Remove the --disable-eurephia configure option
      plugin: Extend the plug-in v3 API to identify the SSL implementation used
      autoconf: Fix typo
      Fix file checks when --chroot is being used

Davide Brini (1):
      Document authfile for socks server

Gert Doering (9):
      Fix IPv6 examples in t_client.rc-sample
      Fix slow memory drain on each client renegotiation.
      t_client.sh: ignore fields from "ip -6 route show" output that distort results.
      Make code and documentation for --remote-random-hostname consistent.
      Reduce IV_OPENVPN_GUI_VERSION= to IV_GUI_VER=
      Document issue with --chroot, /dev/urandom and PolarSSL.
      Rename 'struct route' to 'struct route_ipv4'
      Replace copied structure elements with including <net/route.h>
      Workaround missing SSL_OP_NO_TICKET in earlier OpenSSL versions

Heikki Hannikainen (1):
      Always load intermediate certificates from a PKCS#12 file

Heiko Hund (2):
      Support non-ASCII TAP adapter names on Windows
      Support non-ASCII characters in Windows tmp path

James Yonan (3):

      TLS version negotiation
      Added "setenv opt" directive prefix.
      Set SSL_OP_NO_TICKET flag in SSL context for OpenSSL builds, to disable TLS stateless session resumption.

Jens Wagner (1):
      Fix spurious ignoring of pushed config options (trac#349).

Joachim Schipper (3):
      Refactor tls_ctx_use_external_private_key()
      --management-external-key for PolarSSL
      external_pkcs1_sign: Support non-RSA_SIG_RAW hash_ids

Josh Cepek (2):
      Correct error text when no Windows TAP device is present
      Require a 1.2.x PolarSSL version

Klee Dienes (1):
      tls_ctx_load_ca: Improve certificate error messages

Max Muster (1):
      Remove duplicate cipher entries from TLS translation table.

Peter Sagerson (1):
      Fix configure interaction with static OpenSSL libraries

Steffan Karger (7):
      Do not pass struct tls_session* as void* in key_state_ssl_init().
      Require polarssl >= 1.2.10 for polarssl-builds, which fixes CVE-2013-5915.
      Use RSA_generate_key_ex() instead of deprecated, RSA_generate_key()
      Also update TLSv1_method() calls in support code to SSLv23_method() calls.
      Update TLSv1 error messages to SSLv23 to reflect changes from commit 4b67f98
      If --tls-cipher is supplied, make --show-tls parse the list.
      Add openssl-specific common cipher list names to ssl.c.

Tamas TEVESZ (1):
      Add support for client-cert-not-required for PolarSSL.

Thomas Veerman (1):
      Fix "." in description of utun.


--------------010708030305080003030103--

