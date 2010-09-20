Message-ID: <4C970FB8.8060304@...515...>
Date: Mon, 20 Sep 2010 10:39:36 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <AANLkTin2N8TOJ9H+kDFVojiTaaG+AxM+dNc9xFM9XpuF@...278...>	<20100913182543.12172.qmail@...1287...>	<AANLkTi=a+_88TDwR_8soAkY6EKqzn8u3Kd2rsq8Oc9S2@...278...>
	<4C96158E.4010201@...1114...>
In-Reply-To: <4C96158E.4010201@...1114...>
Subject: Re: [Openvpn-devel] Windows build was messed up!
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi David and Alon,
> My suggestion is that we first move those parts related to the Windows
> TAP driver, Windows installer and easy-rsa into separate git trees.
> Next, the Windows building scripts needs to be split up, so that there's
> a separate building process for Windows TAP driver and the OpenVPN
> binary.  As those processes *are* different, it should actually simplify
> the building process in the long run.  Then we need to come up with a
> better Windows installer process, which f.ex. can require a pre-compiled
> TAP and OpenVPN binary.
Makes perfect sense to me. There's little advantage in keeping these in
the same tree, and we've definitely seen the disadvantages.
> The time frame I imagine for this is when OpenVPN 2.2 is released.
> That's a reasonable time to think this through and we need to do some
> other improvements to the git tree when we release OpenVPN 2.2.  As a
> side-note, I hope we will be able to get 2.2 released within this year.
Do you consider the build system / git tree organization a new feature?
Or could the first non-beta/rc 2.2 release use the separated build systems?
> Alon, when it comes to your patch, I've looked at it, and it looks sane
> to me.  But as I'm neither a Windows developer nor an autotools expert,
> I'll wait for an ACK from someone who can understand it better.  But
> I'll try to remember to bring it up on Thursday's developments meeting,
> unless someone ACKs it earlier.
I added Alon's patch and this build system modularization to next
meeting's topic list:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-09-23>

James probably has some insights about the issues with our current build
system. I'm also sure he can ACK Alon's patch if nobody else does it first.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


