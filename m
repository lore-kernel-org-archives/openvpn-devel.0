MIME-Version: 1.0
In-Reply-To: <4FF43DD9.3030007@...515...>
References: <4FF43DD9.3030007@...515...>
Date: Wed, 4 Jul 2012 16:06:58 +0300
Message-ID: <CAOazyz0BGUXOF7+3YEfq5oE1Kk1x9M1yuZS4YaWOBQr5XrLdtA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3_alpha2 released
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello Samuli,

Please publish the tap installer as standalone download so other
projects such as colinux, tinc, vpnc will be able to use it.

Please apply the patches for easy-rsa that were deleted by David, as
in current shape it cannot be installed nor packaged. This should be
done in the course of the alpha cycle so user may keep functionality.
After doing so, please publish the tarball results of "make dist".

Thanks,
Alon

On Wed, Jul 4, 2012 at 3:58 PM, Samuli Sepp=C3=A4nen <samuli@...515...> wro=
te:
> The OpenVPN community project team is proud to release OpenVPN
> 2.3_alpha2. It can be downloaded from here:
>
> <http://openvpn.net/index.php/open-source/downloads.html>
>
> The largest change in OpenVPN 2.3_alpha2 is the split into several
> subprojects (thanks go to Alon Bar-Lev):
>
> - openvpn (the core project)
> - tap-windows (Windows TAP-driver)
> - easy-rsa (PKI management package)
> - openvpn-build (external buildsystem)
>   - "generic": cross-compile on *NIX platforms (e.g. Linux -> Windows)
>   - "msvc": build using MSVC on Windows
>   - "windows-nsis": generate Windows installers on *NIX
>
> These changes have resulted in a number of user-visible changes:
>
> - Separate 32- and 64-bit installers for Windows (see INSTALL-win32.txt)
> - Old "domake-win" and Python-based buildsystems have been removed
> - "easy-rsa" and "tap-windows" removed from the OpenVPN Git tree
> - All Windows executables and libraries cross-compiled with mingw_w64
> and signed
> - Rewrite of the openvpn autotools buildsystem
>
> In addition, there a number of changes not related to the above:
>
> - Many bugfixes
> - Stabilized the PolarSSL support
> - Enabled IPv6 support on OSX
> - General code cleanup
> - Improved UTF-8 support in Windows
>
> Note that a few changes have been made which may affect existing
> installations. A list of new features and the changelog are available her=
e:
>
> <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn23>
>
> The changelog is also attached to this email.
>
> For generic help use these support channels:
>
> - Official documentation:
> <http://openvpn.net/index.php/open-source/documentation/howto.html>
> - Wiki: <https://community.openvpn.net>
> - Forums: <https://forums.openvpn.net>
> - User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
> - User IRC channel: #openvpn at irc.freenode.net
>
> Please report bugs and ask development questions here:
>
> - Bug tracker and Wiki: <https://community.openvpn.net>
> - Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
> - Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
>   Freenode registration)
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-users mailing list
> Openvpn-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-users
>

