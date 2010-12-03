Message-ID: <4CF90B25.3010104@...515...>
Date: Fri, 03 Dec 2010 17:22:13 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Error C2010 in openvpnserv.c during VS2008 build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

I've managed to extend the Python build system so that it now tries to
build the Windows service wrapper, "openvpnserv.exe", after building
"openvpn.exe". However, the Visual Studio 2008 C compiler gives these
errors:

   openvpnserv.c(87): error C2010: '.' : unexpected in macro formal
parameter list
   openvpnserv.c(101): error C2010: '.' : unexpected in macro formal
parameter list

The offending lines with context (in beta2.2 branch) are these:

   #define mysnprintf(out, args...) \
   ...
   #define MSG(flags, args...) \

The C2010 error is described (very briefly) here:

<http://msdn.microsoft.com/en-us/library/64sxk83h.aspx>

Any ideas how to fix this issue?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


