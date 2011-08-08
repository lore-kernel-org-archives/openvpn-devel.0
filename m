Message-ID: <4E3F99EF.7060608@...515...>
Date: Mon, 08 Aug 2011 11:10:23 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <1312714757-10317-1-git-send-email-beber@...1472...>	<430b86c89889b28e473dfed2fc3ae817@...1492...>	<20110807175142.GS8496@...1296...>	<20110807175624.GW12223@...1474...>	<20110807181103.GV8496@...1296...>
	<20110807182019.GX12223@...1474...>
In-Reply-To: <20110807182019.GX12223@...1474...>
Subject: Re: [Openvpn-devel] Allow to fill Details tab for exe files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Bertrand Jacquin <beber@...1472...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Looking to install-win32/makeopenvpn, it run autotools and configure,
> this may need some tweak :
>
> *inux)
> + export WINDRES=3Di586-mingw32msvc-windres
>
> Is there a windres equivalent for msvc ?
There certainly a way to do the same thing using msvc or Python code
that runs after the build. Does windres simply convert the resource file
to another format? Or does it also embed it to the executable? Looks to
me as if embedding/linking is triggered by the new linker flags
(openvpn_LDADD), but then again my automake-fu is _very_ limited.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


