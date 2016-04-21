From: Jens <openvpn-devel@...2127...>
Message-Id: <950C8167-A5FF-4F56-9020-C956EED49557@...2127...>
Date: Thu, 21 Apr 2016 09:12:28 +0200
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: [Openvpn-devel] Unit testing in openvpn?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

Hi

I think that adding unit tests would greatly improve the ease of implementi=
ng new features for openvpn.  I have spend a lot of time coding Java (and o=
thers), and unit testing greatly improved my code quality, my throughput, a=
nd last, but not least, my confidence in the code. Indeed I have become ver=
y humble when it comes to the question of =E2=80=98what could possibly go w=
rong with this small change?=E2=80=99

What would be the steps to include unit testing?
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

1) Decide /if/ we want unit tests
2) Decide /how/ we want unit tests (this includes questions like dependency=
 management, and the build system)
3) Decide /which/ framework to use
4) do it

How: Dependency management
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

Adding a test framework would require a way to include & track this depende=
ncy.

I see three possibilities

* Copy-and-forget: Add a copy the upstream testing framework and add it as-=
is to the source code repo.
* Include-dependency-management: Add some kind of dependency management, e.=
g. cmake packages.
* Use-the-SCM: Use git submodules to add the dependency.

I dislike Copy-and-forget because it pollutes the repository, and makes tra=
cking upstream changes very hard.

I have no experience with Makefile based dependency management

But I do know how to handle a git submodule.

I have a very strong preference to using a git submodule for unit testing.=
=20


Poll
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

What are your thoughts? Should we add unit tests at all? What would be your=
 preferred way for dependency management. Please defer discussion on /which=
/ unit testing framework to use until we have an agreement on the /if/ and =
/how/ (just to prevent the =E2=80=98paint the bike shed=E2=80=99 discussion=
).

Cheers, Jens
