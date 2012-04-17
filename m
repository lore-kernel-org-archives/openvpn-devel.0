MIME-Version: 1.0
In-Reply-To: <4F8D149D.4010808@...515...>
References: <4F882970.4080302@...515...>
	<CAOazyz2G_6FugO43_Vsc5GLW4oZpEkGDRkujsOAbw9Qdd3ftfQ@...278...>
	<4F8D149D.4010808@...515...>
Date: Tue, 17 Apr 2012 12:00:38 +0300
Message-ID: <CAOazyz0Boe=o0fU534zsc3dBLhFfao_o-ejJkhDE1RZXestYLQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Build tests using "generic" buildsystem and Git
	"master"!
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

2012/4/17 Samuli Sepp=C3=A4nen <samuli@...515...>:
>
>> 2012/4/13 Samuli Sepp=C3=A4nen <samuli@...515...>:
>>> Hi all,
>>>
>>> I also ran some build tests with the "generic" buildsystem[1], OpenVPN
>>> Git "master"[2] and an Ubuntu 11.10 amd64 workstation. As the Git
>>> "master" does not yet seem to include the "generic" buildsystem,
>> I don't understand what you mean... please explain what is "include"...?
> Hi,
>
> It means I could not find "build" or "build.vars" from official
> openvpn.git. Are those not needed for cross-compilation?
>

There is some confusion.... :)

We have two separate projects:

openvpn - standard open source project, autotool based build system,
like any other project its build system only builds it-self.

openvpn-build - a separate project to build openvpn in various of
configurations. This project is divided into the following components:

- generic - a generic build using cross compiler, included the
complete dependencies.

- msvc - a MSVC build using Microsoft specific msbuild system, I hope
this will die eventually.

- windows-nsis - the windows installer generator, it uses the generic
component to build using mingw cross compiler, then package the output
using nsis.

The separation between these project is healthy as a change in openssl
version due to security issue at windows installer should not modify
openvpn version, same for a change in windows installer, or tap
version or any other change that is not directly related to openvpn
code base.

It also allows a separate maintainer to maintain these various of
build environments.

Does it answer your question?

Alon

