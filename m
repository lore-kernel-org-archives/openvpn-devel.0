References: <CAFHpkQEa1yNXoXWqsTsz5SygEqZ5+C2A_gzrKxLexTPfcCFn8Q@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <cfd250ae-d476-1737-61b8-fc41f268e55f@...515...>
Date: Wed, 24 Aug 2016 10:12:57 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEa1yNXoXWqsTsz5SygEqZ5+C2A_gzrKxLexTPfcCFn8Q@...278...>
Subject: Re: [Openvpn-devel] what is "enable_distonly" for ?
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hello,
>
> I'm going to clean up currently unused nsis code in openvpn-gui.

The openvpn-gui.nsi file can be scrapped altogether, as it serves no=20
purpose. It was created in the time before the Interactive Service and=20
Selva's latest changes to OpenVPN-GUI.

> Also, I noticed "enable_distonly" configure option.
>
> what's that for ?

It allows creating the source tarballs on *NIX platforms. In other=20
words, very useful :).

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

