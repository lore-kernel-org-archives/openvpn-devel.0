Message-ID: <4FFA9359.5040604@...515...>
Date: Mon, 09 Jul 2012 11:16:25 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1341526768953611500@...1315...>
In-Reply-To: <1341526768953611500@...1315...>
Subject: Re: [Openvpn-devel] GUI Issue / Bug
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
To: Russell Morris <openvpn@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> Just an FYI, but if the first time you run the GUI you don't run it as ad=
ministrator - you get an error message about registry access (failing), and=
 then the program exiting.
>
> If the GUI has to be run as Administrator, it would be good to configure =
it that way.
Interesting... I wonder if the GUI should have it's own minimal
installer that takes care of editing the registry. Then, during runtime,
the user would only need privileges to modify network interfaces, routes
and such.

For the time being, a "I must run as an administrator or I will bail
out" flag in the executable would be nice, if one exists.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


