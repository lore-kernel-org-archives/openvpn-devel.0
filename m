Date: Wed, 10 Mar 2010 11:39:10 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <9e0cf0bf1003100919l307a653er7c619b5f2fc97dc@...278...>
	(from alon.barlev@...277... on Wed Mar 10 11:19:13 2010)
Message-Id: <1268242750.8679.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE if
 not defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 03/10/2010 11:19:13 AM, Alon Bar-Lev wrote:
> I will try to explain again.
>=20
> You have two roles of environments:
>=20
> 1. Developer/packager workstation.
>=20
> 2. Target environment.
>=20
> For example, 1 would be my computer, and 2 would be the old redhat
> computer.
>=20
> You go to (1) and do:
> $ autoreconf -ivf
> $ ./configure && make dist
>=20
> Now, you transfer the tarball to users, the old redhat computer is=20
> one
> of them. The tarball will work WITHOUT ANY AUTOCONF/AUTOMAKE/LIBTOOL
> installed.
>=20
> I use older environments as (2) such as solaris-8.

And you don't generally want to be running ./configure from within
a rpm specfile, so the same is true of using the rpm tools:

On machine 2 you download the tarball, the specfile, (and
any patches the rpm maintainer wants to include in the
packaged version) and run the rpm build tools on the
spec file to build a binary rpm.=20=20

Note that http://www.rpm.org/max-rpm/s1-rpm-inside-scripts.html
says:=20

"Once the %prep script has gotten everything ready for the build, the %
build script is usually somewhat anti-climactic =E2=80=94 normally invoking=
=20
make, maybe a configuration script, and little else.=20

...

Either the commands required to build the software are simple (such as=20
a single make command), or they are so unique that a macro wouldn't=20
make it easier to write the script. "

In other words ./configure is not expected to be run under normal
circumstances.

The whole point of autoconf is to produce something that can
be made into a tarball that only requires "make; make install"
to compile and install.




Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


