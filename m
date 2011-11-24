From: Adriaan de Jong <dejong@...1435...>
Date: Thu, 24 Nov 2011 10:25:59 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B90128A57E9B4@...1436...>
References: <4ECE04B8.3000100@...515...>
In-Reply-To: <4ECE04B8.3000100@...515...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Topics for today's meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Just to put in my 2cents on the build options: there is a tool that support=
s all of those environments (gmake, cygwin, mingw, nmake, visual studio, ec=
lipse, ....), and that's CMake. It's widely used, and has a pretty good tra=
ck record. It can also support automated test environments and packaging.

It has one major disadvantage: the current build system would need to be co=
nverted from an autoconf-based to a new CMake-based system, together with a=
ll of the knowledge contained within it. Further, there is less knowledge o=
f CMake than autoconf within the OpenVPN community.

Disclaimer: I'm not trying to start a holy war here, I know every system ha=
s its own advantages and drawbacks. I just want to get the option on the ta=
ble :). I've had some positive experience with CMake, through PolarSSL and =
some projects at work. I'll try to make it to the meeting this evening for =
the discussion.

Kind Regards,

Adriaan

> -----Original Message-----
> From: Samuli Sepp=E4nen [mailto:samuli@...515...]
> Sent: donderdag 24 november 2011 9:48
> To: openvpn-devel@lists.sourceforge.net
> Subject: [Openvpn-devel] Topics for today's meeting
>=20
> Hi,
>=20
> We're having an IRC meeting today, starting at 18:00 UTC on #openvpn-
> devel@...1422... Current topic list is here:
>=20
> <https://community.openvpn.net/openvpn/wiki/Topics-2011-11-24>
>=20
> If you have any other things you'd like to bring up, respond to this
> mail, send me mail privately or add them to the list yourself.
>=20
> In case you can't attend the meeting, please feel free to make comments
> on the topics by responding to this email or to the summary email sent
> after the meeting.
>=20
> NOTE: It's required to use a registered Freenode IRC nickname to join
> #openvpn-devel - look here for details:
>=20
> <https://community.openvpn.net/openvpn/wiki/GettingHelp#DeveloperIRCcha
> nnel>
>=20
> --
> Samuli Sepp=E4nen
> Community Manager
> OpenVPN Technologies, Inc
>=20
> irc freenode net: mattock
>=20
> -----------------------------------------------------------------------
> -------
> All the data continuously generated in your IT infrastructure contains
> a definitive record of customers, application performance, security
> threats, fraudulent activity, and more. Splunk takes this data and
> makes sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-novd2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

