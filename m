Message-ID: <4C7F4502.4030409@...515...>
Date: Thu, 02 Sep 2010 09:32:34 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <AANLkTinjxHX-3baqYZARRT3SpYae8a-44CXNPkTXBXtC@...278...>
In-Reply-To: <AANLkTinjxHX-3baqYZARRT3SpYae8a-44CXNPkTXBXtC@...278...>
Subject: Re: [Openvpn-devel] Compiling OpenVPN for Windows
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


> Hi All, I'm fairly new to building openvpn for windows (have been
> building on Linux since 2.0),
> I have a small customization that I make to the openvpn sourcecode to
> call external software on initialization, and would like to build a
> Windows build with this in.
>
> I have ZERO experience in building Windows software, and would really
> appreciate any pointers / assistance in this regard.
> I have access to Visual Studio 2008 Standard, or any open source
> software I need.
>=20=20=20
I don't (yet) have any experience with building OpenVPN _on Windows_,
but soon will. We got a Windows build computer now. I've heard from
James that you need "Visual Studio Professional". "Standard" or
"Express"(?) won't cut it. If you want to build the TAP driver you also
need Windows Driver Kit (WDK). Of course you won't be able to sign the
drivers with official OpenVPN key. Anyways, that's the extent of my
knowledge for now. Eventually I'll write instructions on how to compile
OpenVPN on Windows to our wiki:

<https://community.openvpn.net/openvpn/wiki>

This will take some time, so please don't hold your breath :). As Gert
said, you can also cross-compile on *NIX, which I guess is easier for now.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


