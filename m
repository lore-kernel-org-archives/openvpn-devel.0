Message-ID: <846444.89317.qm@...1374...>
References: <311164.26909.qm@...1373...>
	<4C050722.60602@...1114...>
Date: Tue, 1 Jun 2010 07:42:32 -0700 (PDT)
From: ja nein <reg9009@...360...>
In-Reply-To: <4C050722.60602@...1114...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] first Alpha patch /dynamic iroutes
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

Hi David,

ok, I will do. It may be screwed a bit as I copied patch inline, instead of=
 attaching a file. Anyway, I'll try to correct the issues.

But hey, last C programming was 10 years ago, please turn a blind eye... ;)=
 The merits go to a colleague of mine, btw.

Regards,
Sebastian


----- Urspr=FCngliche Mail ----
Von: David Sommerseth <openvpn.list@...1114...>
An: ja nein <reg9009@...360...>
CC: openvpn-devel@lists.sourceforge.net
Gesendet: Dienstag, den 1. Juni 2010, 15:12:02 Uhr
Betreff: Re: [Openvpn-devel] first Alpha patch /dynamic iroutes

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/06/10 14:35, ja nein wrote:
> Hi all,
>=20
> please find attached the first attempt to dynamically update iroute table=
. Diff is against OpenVPN 2.1.1 source.
>=20
> There are some caveats, though:
>=20
> - Only tested (and probably only works) with linux based systems, yet.
>=20
> - It only works with "topology subnet". The problem is that only "topolog=
y subnet" ensures the correct determination of the gateway behind the kerne=
l route in iroute table.
>=20
> - We filter for zebra routing messages. Therefore a running quagga daemon=
 is needed. For testing purposes, one can manually add routes through zebra.
>=20
> Any comments and thoughts are welcome.

Thank you very much!

A few quick comments though, before starting the real review.  I don't
mean to be overly hard and rejective, but most of your patch seems to be
lacking a decent C based coding style.  Much can be said about the
current coding style in OpenVPN, but try to align your style closer to
what can be found in init.c for example.  To make it easier to maintain
the code base, we want to have as few coding styles as possible - and
not indenting the code like you do in dynroute.h is not a good practice.

Please do not write more C function than absolutely needed in
dynroute.h.  Rather move that code into a dynroute.c file instead.
You'll need to add dynroute.c to Makefile.am then.

Please also make use of #ifdef to enable this feature via ./configure.
You'll need to have autotools installed and configure.ac needs to be
modified.  Search for PASSWORD_SAVE in configure.ac for a simple
example.  Also search for ENABLE_PASSWORD_SAVE in the code for more
hints.  You probably want to do something like the following lines in
Makefile.am then:

    if ENABLE_DYNROUTE
    openvpn_SOURCES +=3D dynroute.c
    endif

That way, this file will only be compiled and included if dynroute is
enabled via ./configure.

When you've updated configure.ac and Makefile.am, you can run autoreconf
- -vi in the source tree.

To be considered for inclusion these things must be fixed.  In addition
there are one section where each line seems to be prefixed with '+',
which looks odd to me (that section is commented out,

Could you please check out the git tree, fix up those issues and
generate a patch with git?

# Get a copy of the source repository
$ git clone
git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn-testing.git

# Create a working branch for you
$ git checkout -b work

# <hack hack hack>

# Commit your changes to your working branch
$ git add <files added and/or modified>
$ git commit -s

# Prepare patches for submission
$ git format-patch HEAD^1

See the Developer documentation and the git crash course if you're new
to git:
<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>
<https://community.openvpn.net/openvpn/wiki/GitCrashCourse>

If something is unclear, don't hesitate to ask!  There are people also
available on IRC: #openvpn-devel @ chat.freenode.net.

Once again, thank you very much for your time and effort with this
patch!  And if we can get these basic things sorted out, I think this is
getting ready for a more thoroughly review as well :)


Kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwFBx8ACgkQDC186MBRfrpSWgCeMHnNRFHHaxnZD6ExiURLMwz1
lTYAn1+julBGjHv6WIw5JJxYn1YzJtHJ
=3D0cBh
-----END PGP SIGNATURE-----




