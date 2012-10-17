Message-ID: <507E7822.1070006@...1114...>
Date: Wed, 17 Oct 2012 11:19:30 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6296AD41E717B7C749ADF42C"
Subject: [Openvpn-devel] RFC - Usage of --script-security with the 'system'
	flag
Reply-To: openvpn-users@lists.sourceforge.net,
	"openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn <Openvpn-users@lists.sourceforge.net>, James Yonan <james@...515...>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6296AD41E717B7C749ADF42C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


Hi all,

I've been reviewing a bug reported to the v2.3 code base.  We're in the=20
beta phase currently, and this is a bug I'd like to get fixed before=20
we're moving on further.  The bug is related to the use of the 'system'=20
flag in --script-security.

<https://community.openvpn.net/openvpn/ticket/228>

The use of the 'system' flag has been deprecated for a long time.  And=20
it is really a potential security issue to use it, due to shell=20
expansions which might happen.  The preferred (and default way) is to=20
use execve(), which is far safer and does not do the shell expansions=20
while executing the script or binary.

The fix I'm currently considering is to remove support for the system()=20
call completely.  This support was introduced in 2.1_rc9 (Nov 17, 2008).

Does anyone depend on --script-security where the 'system' flag is=20
required?  If you need this feature, can you please elaborate why this=20
support is needed and why you cannot use the preferred default with=20
execve?

The main differences between execve() and system() calls are:

system() loads a shell before executing the script or binary, which
also provides all system environment variables defined by
/etc/profile etc.  On top of that, all the OpenVPN configured
environment variables are added.

execve() will load and execute the script or binary directly, which
will only provide the environment variables provided by OpenVPN by
default.  Example:

   -------------------------------------
   #!/bin/bash

   printenv
   -------------------------------------

Using this with '--script-security 2' will dump this out:

   -------------------------------------
   dev_type=3Dtap
   ifconfig_local=3D192.168.100.1
   proto_1=3Dudp
   tun_mtu=3D1500
   ifconfig_netmask=3D255.255.255.0
   script_type=3Dup
   verb=3D4
   local_port_1=3D10443
   dev=3Dtap0
   remote_port_1=3D10443
   PWD=3D/home/test/openvpn
   daemon=3D0
   ifconfig_broadcast=3D192.168.100.255
   SHLVL=3D1
   script_context=3Dinit
   daemon_start_time=3D1350465187
   daemon_pid=3D19045
   daemon_log_redirect=3D0
   link_mtu=3D1573
   -------------------------------------

If you need system variables as well with execve, you can either modify
the #!/bin/bash line to add --login, or you can source /etc/profile in
your script.

If you modify the --script-security to look like
'--script-security 2 system', printenv will dump a rather massive list
with environment variables.



* Technical details regarding a possible fix:

The reason this is hard to fix, is that it will require a massive work=20
to avoid memory leaks.  An first example:

   --------------------------------------------------------------------
     char *envvar =3D malloc(100);

     snprintf(envvar, 30, "TESTVAL=3Dabc");
     putenv(envvar);     /* NOTE: We only do putenv() here */
     system("/bin/sh");  /* echo $TESTVAL returns 'abc' */

     snprintf(envvar, 30, "TESTVAL=3D123456");  /* A simple change */
     system("/bin/sh");  /* echo $TESTVAL returns '123456' */

     free(e);
     system("/bin/sh");  /* echo $TESTVAL is not set */
   --------------------------------------------------------------------

The current implementation will clean up the environment variables too=20
early when using 'system'.  When using 'execve', OpenVPN provides a the=20
environment variables via a completely different mechanism which cleans=20
up the memory properly at the right time.

The result is that with 'system', we're seeing assertion issues as it=20
is now.  Trying to fix this, leads easily to other fun memory=20
corruption issues.  And fixing this requires a more massive amount of=20
adding proper gc_arena garbage collection higher up in the call paths.=20=20
This is needed to let the system() call have all the environment=20
variables set by OpenVPN untouched while running and first clean them=20
up afterwards.

Considering that using system() is less safer than execve(), I would=20
prefer to remove support for system(); instead of passing around a lot=20
more gc_arena pointers to get the memory management correct for=20
system() to function properly.

My first hackish attempt (without cleaning it up) gives this change stat:

 $ git diff --stat
 src/openvpn/misc.c     |   65 ++++++++++++++++++++++++++++++++++++++++++--=
---------------------
 src/openvpn/misc.h     |    6 ++++--
 src/openvpn/platform.c |    6 +++---
 src/openvpn/platform.h |    2 +-
 4 files changed, 50 insertions(+), 29 deletions(-)

I personally find that a bit too much to make a deprecated feature work.
Unless there are some strong arguments why we really do need system()

Any thoughts, ideas or suggestions are most welcome!


kind regards,

David Sommerseth


--------------enig6296AD41E717B7C749ADF42C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlB+eCYACgkQDC186MBRfrpOIQCfVMfyDZSp3CaXYP+1NYKE8SLS
mkYAoLA6UOeRnggoiut1QjMpKuPuhEez
=DROS
-----END PGP SIGNATURE-----

--------------enig6296AD41E717B7C749ADF42C--

