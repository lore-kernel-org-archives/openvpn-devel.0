References: <950C8167-A5FF-4F56-9020-C956EED49557@...2127...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5718879E.8050007@...1227...>
Date: Thu, 21 Apr 2016 09:56:14 +0200
MIME-Version: 1.0
In-Reply-To: <950C8167-A5FF-4F56-9020-C956EED49557@...2127...>
Subject: Re: [Openvpn-devel] Unit testing in openvpn?
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
To: Jens <openvpn-devel@...2127...>, openvpn-devel <Openvpn-devel@lists.sourceforge.net>



Am 21.04.16 um 09:12 schrieb Jens:
> Hi
>
> I think that adding unit tests would greatly improve the ease of implemen=
ting new features for openvpn.  I have spend a lot of time coding Java (and=
 others), and unit testing greatly improved my code quality, my throughput,=
 and last, but not least, my confidence in the code. Indeed I have become v=
ery humble when it comes to the question of =E2=80=98what could possibly go=
 wrong with this small change?=E2=80=99
>
> What would be the steps to include unit testing?
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>
> 1) Decide /if/ we want unit tests
> 2) Decide /how/ we want unit tests (this includes questions like dependen=
cy management, and the build system)
> 3) Decide /which/ framework to use
> 4) do it
The problem with unit tests and existing software is that, if the
software hasn't been written with testing in mind, it is often hard
without major refactoring to do the small java style unit tests. Also
someone has to write these unit tests and free time is currently sparse
among the OpenVPN developers.

A more realistic first step for OpenVPN is a automated testing suite
that goes beyond what we have at the moment in shell scripts. Setting up
a mininet for example and automatically cofingure client and server, and
see if everything works as expected as an example.
> How: Dependency management
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>
> Adding a test framework would require a way to include & track this depen=
dency.
>
> I see three possibilities
>
> * Copy-and-forget: Add a copy the upstream testing framework and add it a=
s-is to the source code repo.
> * Include-dependency-management: Add some kind of dependency management, =
e.g. cmake packages.
cmake vs autoconf/automake is somehwat heated discussion. At the moment
the project is using autoconf/automake since it has always been using that.
> * Use-the-SCM: Use git submodules to add the dependency.
>
> I dislike Copy-and-forget because it pollutes the repository, and makes t=
racking upstream changes very hard.
>
> I have no experience with Makefile based dependency management
>
> But I do know how to handle a git submodule.
>
> I have a very strong preference to using a git submodule for unit testing=
.=20
>
I think how to put a testing framework into git is secondary. If unit
tests are useful in the current state, we can discuss about how to
include them.

Arne


