References: <56C32BCD.1050407@...515...>
	<4C31798F36DC4AEAB6F32F82028081C3@...2089...>
	<56C47948.5070804@...1227...>
	<4238F97DC8AD402F9E672DAF68C8A98A@...2089...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56C48EC5.8070908@...515...>
Date: Wed, 17 Feb 2016 17:16:21 +0200
MIME-Version: 1.0
In-Reply-To: <4238F97DC8AD402F9E672DAF68C8A98A@...2089...>
Subject: Re: [Openvpn-devel] Handling bitness (32/64) for OpenVPN
 Windowsinstallers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: debbie10t@...277..., openvpn-devel@lists.sourceforge.net, Arne Schwabe <arne@...1227...>

Hi,

> In 4 years I have not seen a single complaint on the forum
> nor can remember a single complaint on the mailing list
> referring to downloading the wrong bitness installer.
> Or that the download page is misleading in this way.

This is actually rather surprising. That said, I can't recall any=20
incidents, either. Perhaps this is an exception to the rule "people=20
don't read what is written on a webpage" :).

> On top of that, as 32b it phased out by retail, it is likely
> that anybody who still requires 32b will have the intelligence
> to follow a separate link to 32b installers.

I don't think there are many (any?) 32-bit Windows operating systems=20
being bundled with new computers. The reason why Microsoft backpedaled=20
on dropping 32-bit support in Windows 10 seemed to be their free upgrade=20
program: they wanted the 32-bit operating systems to be upgradeable too.

I suggest that for OpenVPN 2.4* releases we emphasize the 64-bit=20
installer links. For example:


Source tarball (gzip)  openvpn-2.4.0.tar.gz                   GPG sig
Source tarball (xz)    openvpn-2.4.0.tar.xz                   GPG sig
Source zip             openvpn-2.4.0.zip                      GPG sig
Installer (64-bit)     openvpn-install-2.4.0-I601-x64_64.exe  GPG sig

A 32-bit installer is available (<- link). You should only use it on=20
32-bit systems.

... followed by the rest of the release notes/comments...

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

