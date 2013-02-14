Message-ID: <511CEE07.9040307@...515...>
Date: Thu, 14 Feb 2013 16:00:39 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] WIndows NSI installer generating help files
	dynamically
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

Two of the Windows help files are generated dynamically from within
openvpn-build/windows-nsis/openvpn.nsi:

    FileOpen $R0 "$INSTDIR\config\README.txt" w
    FileWrite $R0 "This directory should contain ${PACKAGE_NAME}
configuration files$\r$\n"
    FileWrite $R0 "each having an extension of .${OPENVPN_CONFIG_EXT}$\r$\n"
    FileWrite $R0 "$\r$\n"
    FileWrite $R0 "When ${PACKAGE_NAME} is started as a service, a
separate ${PACKAGE_NAME}$\r$\n"
    FileWrite $R0 "process will be instantiated for each configuration
file.$\r$\n"
    FileClose $R0

--- snip ---

    FileOpen $R0 "$INSTDIR\log\README.txt" w
    FileWrite $R0 "This directory will contain the log files for
${PACKAGE_NAME}$\r$\n"
    FileWrite $R0 "sessions which are being run as a service.$\r$\n"
    FileClose $R0

I don't particularly like this approach - primarily because it hides
part of the OpenVPN documentation inside an installer script. It also
makes it harder to maintain a localized versions of the documentation,
and there could be issues with non-ascii characters.

Anyways, I think these help files are semi-useful at best, a bit like
the "tls-remote" warning. I think we could safely move their contents to
openvpn/INSTALL-win32.txt, or put them into static files under openvpn/doc.

Any opinions?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


