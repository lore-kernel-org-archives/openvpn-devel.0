References: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
	<1463822525-2532-2-git-send-email-openvpn-devel@...2127...>
	<20160521095424.GQ53051@...1296...>
	<BF0BE230-3DDA-4CF6-A8DB-CABBE0825CF4@...2127...>
	<20160521111016.GS53051@...1296...>
	<9715E28C-0B26-4EAE-907A-B8A326BF98A7@...2127...>
	<20160522124546.GA53051@...1296...> <5742C2E1.2060407@...515...>
	<53A330A9-AA2C-4545-A854-0EF7A9B79A1C@...2127...>
	<20160523160426.GL53051@...1296...> <57455384.2020007@...515...>
	<F7A2C190-9AB4-4527-8570-10F62E86E56E@...2127...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5746E723.4060705@...515...>
Date: Thu, 26 May 2016 15:08:03 +0300
MIME-Version: 1.0
In-Reply-To: <F7A2C190-9AB4-4527-8570-10F62E86E56E@...2127...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Refactor t_client.sh
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
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: openvpn-devel@lists.sourceforge.net


>
> ...
>>
>> The buildmaster part is not documented anywhere. I have shared the maste=
r config once when someone requested it - there is nothing inherently priva=
te in there, once the passwords are removed. Setting up buildmaster + build=
slaves could definitely be automated, but it would be a rather massive task.
>
> Samuli, could you send me the scripts? I=92d like to have a look. Maybe t=
here is something that can be replicated. This is something I=92d try to ad=
d to the scripted integration tests (Vagrant) already in the pipeline.

I published the Windows "buildslave" script here, along with some basic=20
documentation:

<https://github.com/mattock/openvpn-windows-buildtest>

I also cleaned up the buildmaster configuration and will publish it=20
later. However, there will be several hacks in there to accommodate=20
quirks in our current buildslaves (e.g. NetBSD), so making it fully=20
generic would require some refactoring.

>> Could we use Travis CI with a huge combination of operating systems and =
build flags? Or does this kind of use go outside its scope? Right now each =
commit triggers something like 150 builds on the buildslaves (in total).
>>
>
>  From what I know, this is not possible. 150 build? Whoah, thats quite a =
few. I=92d expect 2-3 per supported OS. Is this a case of combinatoric expl=
osion?

Yeah. we trigger at least 16 builds per buildslave/OS, can't check the=20
exact number right now. This is because of the large number of configure=20
flags we need to support.

It seems that basic smoke testing with Travis CI before pushing anything=20
to the repository makes sense, but it's not a full buildbot replacement.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

