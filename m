References: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
	<1463822525-2532-2-git-send-email-openvpn-devel@...2127...>
	<20160521095424.GQ53051@...1296...>
	<BF0BE230-3DDA-4CF6-A8DB-CABBE0825CF4@...2127...>
	<20160521111016.GS53051@...1296...>
	<9715E28C-0B26-4EAE-907A-B8A326BF98A7@...2127...>
	<20160522124546.GA53051@...1296...> <5742C2E1.2060407@...515...>
	<53A330A9-AA2C-4545-A854-0EF7A9B79A1C@...2127...>
	<20160523160426.GL53051@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <57455384.2020007@...515...>
Date: Wed, 25 May 2016 10:25:56 +0300
MIME-Version: 1.0
In-Reply-To: <20160523160426.GL53051@...1296...>
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
To: Gert Doering <gert@...1296...>, Jens Neuhalfen <openvpn-devel@...2127...>
Cc: openvpn-devel@lists.sourceforge.net


> Hi,
>
> On Mon, May 23, 2016 at 05:43:58PM +0200, Jens Neuhalfen wrote:
>>> I'd prefer to keep the actual buildslave infrastructure private, with a=
ccess granted to only a select few. We already get email notifications to a=
 public list for each build failure.
>>
>> Is there some kind of instruction to ?reproduce? the build infrastructur=
e? Some kind of document or - even better - something executable (Vagrant/D=
ocker/Salt/Puppet/..)?
>
> https://community.openvpn.net/openvpn/wiki/SettingUpBuildslave
>
> is what we currently have, but it only describes the slaves (talking to
> Samuli's build master) - not sure if the master is documented anywhere.

The buildmaster part is not documented anywhere. I have shared the=20
master config once when someone requested it - there is nothing=20
inherently private in there, once the passwords are removed. Setting up=20
buildmaster + buildslaves could definitely be automated, but it would be=20
a rather massive task.

I would suggest extending Travis CI instead of trying to create a=20
private buildbot infrastructure. If *BSD is not supported by Travis,=20
then we obviously can't get rid of buildbot entirely anytime soon. Plus=20
we need the Windows "buildslave" (=3Dcustom scropt) for full cross-compile=
=20
tests and for publishing snapshot installers thus produced.

Could we use Travis CI with a huge combination of operating systems and=20
build flags? Or does this kind of use go outside its scope? Right now=20
each commit triggers something like 150 builds on the buildslaves (in=20
total).

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

