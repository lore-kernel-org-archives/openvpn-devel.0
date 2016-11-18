From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <35b9d93f-0682-9457-49f6-cf96507fc59f@...515...>
Date: Fri, 18 Nov 2016 15:29:11 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] Combined 32/64-bit OpenVPN 2.4_beta1 installer
	available for testing
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

Hi,

OpenVPN 2.4_rc1[1] will be bundled as a combined installer[2] that works=20
on both 32-bit and 64-bit Windows versions (Vista and above). A preview=20
installer based on 2.4_beta1 is available here:

<https://build.openvpn.net/downloads/snapshots/openvpn-install-2.4_beta1-I9=
01.exe>

The installer also contains an updated openvpnserv2 (OpenVPNService),=20
which attempts to shut down OpenVPN instances cleanly instead of just=20
killing them on service stop or restart[3].

I already ran the Powershells tests[4] on it, and chipitsine has done=20
independent testing. However, more testing would be welcome. In particular:

- Ensure that by default the files are places to correct directory, that=20
is, C:\Program Files\OpenVPN on both 32-bit and 64-bit Windows
- Test silent install with default settings
- Test silent install to a non-standard directory
- Ensure that registry keys go to the correct (32-bit or 64-bit) registry
- Test that uninstall works as expected

If you manage to the break the installer let me know by Monday. At that=20
point we'd like to get the combined installer patch and the exit-event=20
fix merge.

Thanks!

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1] Due to be released in <2 weeks
[2] See <https://github.com/OpenVPN/openvpn-build/pull/44>
[3] See <https://github.com/OpenVPN/openvpnserv2/pull/2>
[4] See <https://github.com/OpenVPN/openvpn-windows-test>

