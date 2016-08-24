From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <d7fde34c-2244-aed1-6ecc-9f5c5d9d9b3b@...515...>
Date: Wed, 24 Aug 2016 12:26:20 +0300
MIME-Version: 1.0
Subject: [Openvpn-devel] Combined Windows installers
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

Right now we have four different Windows installers:

1) tap-windows (NDIS5) + 32-bit OpenVPN
2) tap-windows (NDIS5) + 64-bit OpenVPN
3) tap-windows6 (NDIS6) + 32-bit OpenVPN
4) tap-windows6 (NDIS6) + 32-bit OpenVPN

Installers 1-2 are aimed at Windows XP, and installers 3-4 to Windows=20
Vista and later. We could probably clean up this situation a bit by=20
making combined installers. Here are a few options that come to mind:

1) Bundle tap-windows and tap-windows6 in one installer

This means we'd have two installers:

- NDIS5 + NDIS6 + openvpn i686
- NDIS5 + NDIS6 + openvpn x86_64

So the bitness of the computer alone would determine which installer to use.


2) Bundle 32-bit and 64-bit OpenVPN in one installer

Here one would select the installer based on OS (XP or Vista+), but=20
bitness would not matter:

- NDIS5 + openvpn i686 + openvpn x86_64
- NDIS6 + openvpn i686 + openvpn x86_64)


3) Bundle everything together

- NDIS5 + NDIS6 + openvpn i686 + openvpn x86_64)

---

We discussed this a bit on #openvpn-devel, and option 2 had the most=20
votes. The problem with options 1 and 3 is that they'd require changes=20
to openvpn-build, which would have to be scrapped when Windows XP and=20
tap-windows (NDIS 5) support is dropped. And that is going to happen=20
fairly soon.

The 32/64-bit divide, on the other hand, is not disappearing in the near=20
future, so having a 32/64-bit combined installer makes sense.

Thoughts?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

