References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
	<c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
	<20160607075659.GM53051@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <448a7afe-aece-b97b-a6ea-afb8f1b8526e@...515...>
Date: Tue, 7 Jun 2016 11:08:47 +0300
MIME-Version: 1.0
In-Reply-To: <20160607075659.GM53051@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
 framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Tue, Jun 07, 2016 at 10:30:57AM +0300, Samuli Sepp=E4nen wrote:
>> This is probably correct: the codebase is complex enough to cause
>> breakage on many types of changes, no matter how carefully the code is
>> reviewed. This is often because of the sheer number of options and their
>> invisible interplay. A recent example is the recent persist-tun / WFP
>> filtering issue, which slipped through all testing and review.
>>
>> Regression testing using unit tests could possibly help us prevent this
>> type of breakages.
>
> In particular for *that* example: no way unit testing would have found
> that - "full connection testing with multiple remotes and tunnel connecti=
on
> issues on the first tunnel" would have been needed.
>
> Unit testing might have found the issue that on closing of the WFP in
> master, the handle wasn't NULLed, so a second close call would have
> caused a crash - if someone had thought of adding a test case for
> "call close twice!" *and* ran this on windows.
>
> Unit testing is good, but has no chance to find "full program test"
> failures in certain combinations of options and remotes - which is
> what t_client is there for, but even that one wouldn't have caught the
> WFP thing as it's fairly hard to test for that.
>
>>> We already have discussed solutions to this:
>>>
>>> 1) Enable developers to run the ?authoritative? buildslave tests before
>>> submitting patches
>>
>> The buildmaster can trigger manual builds from a different branch (e.g.
>> "staging/somebody"). Access to the buildmaster can be granted
>> selectively to trusted core developers. Non-trivial patches from other
>> people should probably be tested by one of these core developers before
>> pushing them to "master". Or we can just accept the fact that "master"
>> might be broken occasionally and fix the problems promptly.
>
> Haven't we been here before?
>
>  - add testing branches to the github repo for (semi-)trusted developers
>  - teach buildbot to use the github repo
>  - enable (semi-)trusted developers to push their "I want this tested!"
>    code to github/openvpn/testing-<user>/ and have buildbot test it

Yes, exactly, this is what I was describing above in other words :).

> we can't open this to the world, as the t_client tests need sudo
> privileges, so anyone who can push a patch to a testing tree can run
> arbitrary commands on the buildslaves ("just build whatever you want
> into something called 'openvpn' and run that with sudo from t_client") -
> so, (semi-)trusted developers only.

This is not entirely true, because the build steps are hardcoded.=20
However, I would definitely not open this to the world, because there is=20
plenty of room for misuse, and Buildbot might have security issues which=20
could be exploited.

> (This *should* have been discussed last monday, but it slipped off the
> agenda)
>
>
>>> 2) Provide developers tooling to quickly (preferred: locally) run
>>> iterations while developing
>>
>> The Vagrant approach is nice because it will eventually allow developers
>> to run a fairly extensive smoketests on several various operating
>> systems with minimal effort:
>>
>> <https://github.com/OpenVPN/openvpn/pull/45>
>>
>> Right now the OS coverage is fairly minimal, but more variants can be
>> added easily, and we're not limited to Linux/Ubuntu like with Travis.
>
> I'm not seeing who is going to maintain all these VMs so every developer
> can run the full suite across all OSes...
>
> gert

It seems that a summary of how Vagrant operates is in order here.

Vagrant uses pre-built images as a starting point. These images do not=20
(and should not) be built by OpenVPN developers. The only things _we_=20
have to maintain are the Vagrant files, which are basically recipies for=20
configuring the base boxes into an OpenVPN test VMs.

So, when a developer wants to run the integration tests this is what=20
happens:

- Vagrant fetches the pre-built VM images from a remote source
- The image is launched into Virtualbox (or other virtualization system)
- Vagrant runs the initialization scripts in the Vagrantfile
- The system is ready to use and stored for future use

The initialization scripts can automatically run integration tests when=20
the VM launches, or that can be left to the developer.

When the developer wants to rerun the tests, he/she can just launch the=20
VM with "vagrant up" and SSH in with "vagrant ssh". When the Vagrant=20
file has changed significantly, the old box can be nuked and a new one=20
rebuilt in <5 minutes.

Summary: very little maintenance is required for Vagrant. It is not like=20
buildbot, where we actually have to build the VMs from scratch.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

