From: Jon Kunkee <jkunkee@...2393...>
Date: Tue, 3 Jul 2018 17:42:51 +0000
Message-ID: <DM5PR2101MB11120F4EE0B7761BA1273B08B0420@...2412...>
References: <cea658fa-201f-59d3-d66b-93e35f4f2ee2@...515...>
In-Reply-To: <cea658fa-201f-59d3-d66b-93e35f4f2ee2@...515...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Topics for the community meeting (Wed,
 13th June 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

2. Tap-windows6 patches, building and testing

In order to get the tap-windows6 driver signed properly for Windows Server =
2016, it needs to pass the Windows Hardware Certification Program subset of=
 the Windows Hardware Logo Kit (HLK) tests. Samuli has the tests running in=
 EC2, but there are some failures.

Some of the failures are basically paperwork, like the Static Verification =
logs test. Some reflect needed tweaks in the environment, like the Running =
on Server Core test. Others reflect possible code bugs, and since I have si=
gnificant experience doing Windows kernel debugging I'm investigating those.

I spent yesterday setting up a local HLK-based test environment with kernel=
 debugging. Today I'm trying to get two OpenVPN clients to be able to talk =
to each other over a VPN so I can start reproducing and investigating the f=
ailures. (I will be sending a mail to openvpn-users asking for help since i=
t would be quite noisy to explain  on IRC.)

Cheers,
Jon Kunkee
Software Developer
Microsoft

-----Original Message-----
From: Samuli Sepp=E4nen <samuli@...515...>=20
Sent: Tuesday, July 3, 2018 10:30 AM
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] Topics for the community meeting (Wed, 13th June 2=
018)

Hi,

We're going to have an IRC meeting starting at 11:30 CET
(9:30 UTC) on #openvpn-meeting <at> irc.freenode.net. You do not have to be=
 logged in to Freenode to join the channel.

Current topic list along with basic information is here:

<https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fcommuni=
ty.openvpn.net%2Fopenvpn%2Fwiki%2FTopics-2018-06-13&amp;data=3D02%7C01%7Cjk=
unkee%40microsoft.com%7C2ff5949944a34864919b08d5e10aa0b2%7C72f988bf86f141af=
91ab2d7cd011db47%7C1%7C0%7C636662358125323471&amp;sdata=3DE2tnMk95DPL%2BFpU=
NM8td0lQd0PTMmfZ8ZAXUsGBES%2FA%3D&amp;reserved=3D0>

If you have any other things you'd like to bring up, respond to this mail, =
send me mail privately or add them to the list yourself.

In case you can't attend the meeting, please feel free to make comments on =
the topics by responding to this email or to the summary email sent after t=
he meeting. Whenever possible, we'll also respond to existing, related emai=
l threads.

--
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




