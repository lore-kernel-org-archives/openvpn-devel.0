Message-ID: <4F4B402F.70507@...515...>
Date: Mon, 27 Feb 2012 10:34:55 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz2Rr6JgnmojZ3Naht6eybdq1KnooEAbARSS=3ZM-iLVJg@...278...>
In-Reply-To: <CAOazyz2Rr6JgnmojZ3Naht6eybdq1KnooEAbARSS=3ZM-iLVJg@...278...>
Subject: Re: [Openvpn-devel] openvpn windows gui
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> Hello,
>
> A stupid question....
> Which GUI is embedded in the installer?
> What is GUI and what is XGUI?
> All I found is[1].
>
In 2.2.x installers the GUI is the old one from here, just signed:

<http://openvpn.se>

In 2.3-alpha1 we use the latest snapshot from here:

<http://sourceforge.net/projects/openvpn-gui>

XGUI is obsolete, it can be ignored. I removed all of the XGUI-related
stuff from the Python-based buildsystem, but it's still lurking in the
old "domake-win" buildscripts/.nsi files.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


