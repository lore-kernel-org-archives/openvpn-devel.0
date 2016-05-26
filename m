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
	<5746E723.4060705@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5746F1B5.8030501@...515...>
Date: Thu, 26 May 2016 15:53:09 +0300
MIME-Version: 1.0
In-Reply-To: <5746E723.4060705@...515...>
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
>>
>> ...
>>>
>>> The buildmaster part is not documented anywhere. I have shared the mast=
er config once when someone requested it - there is nothing inherently priv=
ate in there, once the passwords are removed. Setting up buildmaster + buil=
dslaves could definitely be automated, but it would be a rather massive tas=
k.
>>
>> Samuli, could you send me the scripts? I=92d like to have a look. Maybe =
there is something that can be replicated. This is something I=92d try to a=
dd to the scripted integration tests (Vagrant) already in the pipeline.
>
> I published the Windows "buildslave" script here, along with some basic
> documentation:
>
> <https://github.com/mattock/openvpn-windows-buildtest>
>
> I also cleaned up the buildmaster configuration and will publish it
> later. However, there will be several hacks in there to accommodate
> quirks in our current buildslaves (e.g. NetBSD), so making it fully
> generic would require some refactoring.
>

A cleaned up buildmaster configuration file is now here:

<https://github.com/mattock/openvpn-buildbot>

It could become genuinely useful outside the current buildbot=20
infrastructure if the URLs, passwords and emails were be fetched from a=20
separate file.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

