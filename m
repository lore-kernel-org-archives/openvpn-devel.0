Date: Wed, 9 Mar 2011 08:56:56 -0300
From: Federico Heinz <fheinz@...277...>
Message-ID: <20110309085656.18e0e796@...1451...>
In-Reply-To: <20110309084745.GN9835@...1296...>
References: <20110308185252.301d0a1d@...1451...>
	<20110309084745.GN9835@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/Cc5QDMGyHHD3SRmXjPUB4E0";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/Cc5QDMGyHHD3SRmXjPUB4E0
Content-Type: multipart/mixed; boundary="MP_/ZAmBSV8RHvD1QqudZYp931V"

--MP_/ZAmBSV8RHvD1QqudZYp931V
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 09/03/2011, Gert Doering wrote:
> I can understand why this feature is desirable - there are a couple
> of problems with the implementation, though.=20=20
>  - From a code modularity point of view, socket stuff should not go=20
>    to options.c, but to socket.c

I understand that with "socket stuff" you probably mean "socket
operations". Actually, my first implementation of this feature
(attached) was entirely confined to socket.c, amd simply accepted an
interface name as a possible value. The reason I didn't like it was
because because I couldn't easily identify a spot in socket.c that
would confine this behaviour to just the local interface.

>  - your code is likely to work on Linux and *BSD, but will it work
>    "as is" on Solaris and Windows?  I don't expect it to, so
>    additional #ifdef's are needed --> and that's why it should go to
>    one of the more system-dependent (and already #ifdef-filled)
>    source files

I'll need help from people with access to those systems to place the
appropriate #ifdefs...

> In general, I wonder why binding to the interface is really needed
> - what happens if you don't specify "local" at all?  It should pick
> the proper source address automatically.

It does, unless you have more than one interface, and you need
OpenVPN to bind to only one of them.

	Fede

--MP_/ZAmBSV8RHvD1QqudZYp931V
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=bind-to-interface.patch

diff -r 66ad68054f67 socket.c
--- a/socket.c	Tue Mar 01 10:21:42 2011 +0100
+++ b/socket.c	Wed Mar 09 08:49:20 2011 -0300
@@ -32,6 +32,7 @@
 #include "ps.h"
 #include "manage.h"
 #include "misc.h"
+#include <net/if.h>
=20
 #include "memdbg.h"
=20
@@ -129,6 +130,24 @@
=20
   status =3D openvpn_inet_aton (hostname, &ia); /* parse ascii IP address =
*/
=20
+  if (status !=3D OIA_IP)		/* Attempt to parse as interface name */
+    {
+      int fd;
+      struct ifreq ifr;
+
+      ifr.ifr_addr.sa_family =3D AF_INET;
+      strncpy(ifr.ifr_name, hostname, IFNAMSIZ-1);
+      if ((fd =3D socket(AF_INET, SOCK_DGRAM, 0))>=3D 0)
+	{
+	  if (ioctl(fd, SIOCGIFADDR, &ifr) >=3D 0)
+	    {
+	      ia =3D ((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr;
+	      status =3D OIA_IP;
+	    }
+	  close(fd);
+	}
+    }
+
   if (status !=3D OIA_IP) /* parse as IP address failed? */
     {
       const int fail_wait_interval =3D 5; /* seconds */

--MP_/ZAmBSV8RHvD1QqudZYp931V--

--Sig_/Cc5QDMGyHHD3SRmXjPUB4E0
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFNd2sIbPULDL0CxuARAobzAKCZSyd7WIIzUWKjRDahAijhuOHONwCg9yMt
yYGWzbUmbbKT0eFf14xqNRE=
=/eE3
-----END PGP SIGNATURE-----

--Sig_/Cc5QDMGyHHD3SRmXjPUB4E0--

