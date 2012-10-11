Mime-Version: 1.0 (Mac OS X Mail 6.1 \(1498\))
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <20121011152135.GW4969@...1330...>
Date: Thu, 11 Oct 2012 10:59:21 -0500
Message-Id: <F1F985EB-77D2-458C-AB7C-65E7258AE846@...1286...>
References: <20121011152135.GW4969@...1330...>
Subject: Re: [Openvpn-devel] Using --mlock and --user makes openvpn "run out
	of memory"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alberto Gonzalez Iniesta <agi@...64...>
Cc: openvpn-devel@lists.sourceforge.net

If this is of importance to you, there are two courses of action.  First, p=
lease create a ticket on the OpenVPN community trac.  Please be as detailed=
 as possible.  Another option is to fix this in the source tree, based of g=
it-master, and submit a working patch.  This second option is going to be t=
he quickest way to get a resolution.

Cheers
-----
Eric F Crist



On Oct 11, 2012, at 10:21:35, Alberto Gonzalez Iniesta <agi@...64...> wrote:

> Hi,
>=20
> There's an open bug in Debian [1] since 2007, that seems to be quite
> documented right now. To sum up, when you run openvpn with --mlock and
> --user, the daemon will die with "out of memory", possibly due to
> mlock(2):
>=20
> BUGS
> Since  kernel  2.6.9, if a privileged process calls mlockall(MCL_FUTURE)
> and later drops privileges (loses the CAP_IPC_LOCK capability by, for
> example,  setting  its effective  UID  to  a  nonzero  value),  then
> subsequent memory allocations (e.g., mmap(2), brk(2)) will fail if the
> RLIMIT_MEMLOCK resource limit is encountered.
>=20
> The bug report contains a workaround (editing PAM limits) and a plea to
> document this behaviour. I guess it's better to document this (after
> verification of the facts) in OpenVPN's man page rather than just
> Debian's package.
>=20
> Regards,
>=20
> Alberto
>=20
>=20
> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D406895
> --=20
> Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cn=
ico
> agi@(inittab.org|debian.org)| en GNU/Linux y software libre
> Encrypted mail preferred    | http://inittab.com
>=20
> Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3
>=20
> -------------------------------------------------------------------------=
-----
> Don't let slow site performance ruin your business. Deploy New Relic APM
> Deploy New Relic app performance management and know exactly
> what is happening inside your Ruby, Python, PHP, Java, and .NET app
> Try New Relic at no cost today and get our sweet Data Nerd shirt too!
> http://p.sf.net/sfu/newrelic-dev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


