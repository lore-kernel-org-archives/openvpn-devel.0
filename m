References: <950C8167-A5FF-4F56-9020-C956EED49557@...2127...>
	<5718879E.8050007@...1227...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <57189BF4.7040400@...515...>
Date: Thu, 21 Apr 2016 12:23:00 +0300
MIME-Version: 1.0
In-Reply-To: <5718879E.8050007@...1227...>
Subject: Re: [Openvpn-devel] Unit testing in openvpn?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>, Jens <openvpn-devel@...2127...>, openvpn-devel <Openvpn-devel@lists.sourceforge.net>


>> Adding a test framework would require a way to include & track this depe=
ndency.
>>
>> I see three possibilities
>>
>> * Copy-and-forget: Add a copy the upstream testing framework and add it =
as-is to the source code repo.
>> * Include-dependency-management: Add some kind of dependency management,=
 e.g. cmake packages.
> cmake vs autoconf/automake is somehwat heated discussion. At the moment
> the project is using autoconf/automake since it has always been using tha=
t.
>> * Use-the-SCM: Use git submodules to add the dependency.
>>
>> I dislike Copy-and-forget because it pollutes the repository, and makes =
tracking upstream changes very hard.
>>
>> I have no experience with Makefile based dependency management
>>
>> But I do know how to handle a git submodule.
>>
>> I have a very strong preference to using a git submodule for unit testin=
g.
>>
> I think how to put a testing framework into git is secondary. If unit
> tests are useful in the current state, we can discuss about how to
> include them.
>
> Arne

I think the first step would be to identify the places where unit tests=20
could be implemented easily (if any), and where they would do most good.=20
If something falls to both of these categories then writing a unit test=20
there would probably make sense.

Then there's the other codebase (3.x) which, when publicly released,=20
might be a good/better candidate for writing unit tests.

If we end up writing unit tests, I too would prefer the Git submodule=20
approach.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

