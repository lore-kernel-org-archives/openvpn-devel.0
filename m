Message-ID: <535900AC.1090707@...515...>
Date: Thu, 24 Apr 2014 15:16:44 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <53572C4E.7010701@...1901...>
	<20140423081058.GJ16637@...1296...>	<53579C5D.5000902@...1435...>
	<5357DDFC.2010401@...1901...>	<53581D43.6060501@...1856...>
	<53584B0C.8020209@...1901...>	<20140424070116.GN16637@...1296...>
	<5358C5C0.6090007@...1901...>	<20140424081727.GO16637@...1296...>
	<5358FCD1.9070202@...1901...>
In-Reply-To: <5358FCD1.9070202@...1901...>
Subject: Re: [Openvpn-devel] Progress on Version negotiation
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
To: Timothe Litt <litt@...1901...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>
> I use interactive debuggers when I can, and I find that debugging=20
> windows on windows and linux on linux works best for me.  The M$ tools=20
> have their flaws, but they do have excellent links to API documentation=20
> & system RTL's sources.  For debugging the cryptoapi interface, that=20
> would have been useful.
>
The "openvpn-build" subproject actually contains two separate buildsystems:

"generic" (which "windows-nsis" uses)
"msvc"

What most people use is "generic", which is for cross-compiling for
Windows on Linux (or *NIX).

A few people have tried using "msvc" in recent times and we know it will
not work without some fixes. However, if someone wants to take over the
maintenance of the "msvc" build system we're more than happy to grant
him/her the privilege :).

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


