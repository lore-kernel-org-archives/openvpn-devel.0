Message-ID: <4D591CBC.2050508@...515...>
Date: Mon, 14 Feb 2011 14:14:52 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1297436737-18876-1-git-send-email-samuli@...515...>
	<1962676237.20110211182032@...449...>
In-Reply-To: <1962676237.20110211182032@...449...>
Subject: Re: [Openvpn-devel] [PATCH 00/13] Fix remaining major issues with
 Python-based buildsystem
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
To: =?ISO-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> - embedding manifest files to the executables and DLLs
>>=20=20=20=20=20
>
> could be easily included:
> http://msdn.microsoft.com/en-us/library/ms235591(v=3Dvs.80).aspx
>=20=20=20
True. In fact I plan on modifying the nmake makefiles prior to next
(2.2) release so that embedding is automated. However, the build scripts
in "lzo2" and "libpkcs11-helper" packages will still generate external
manifest files. I'm thinking of patching their makefiles and sending
them upstream, if they're interested. This would save us from a few
nasty hacks and/or manual steps.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


