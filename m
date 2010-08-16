Date: Mon, 16 Aug 2010 16:34:54 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Message-ID: <20100816133454.GN2804@...1281...>
References: <4C6869BA.3010309@...41...> <20100816132917.GM2804@...1281...>
MIME-Version: 1.0
In-Reply-To: <20100816132917.GM2804@...1281...>
Subject: Re: [Openvpn-devel] OpenVPN version 2.1.2 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net, OpenVpn-Users <openvpn-users@lists.sourceforge.net>

On Mon, Aug 16, 2010 at 04:29:17PM +0300, Pasi K=E4rkk=E4inen wrote:
>=20
> Hello,
>=20
> When running the openvpn 2.1.2 installer on Windows 7 (x64) I noticed thi=
s error:
> http://pasik.reaktio.net/openvpn212-setup-error-opening-file-for-writing.=
jpg
>=20
> ie. the installer cannot overwrite the existing files from openvpn 2.1.1 =
installation.
> I get that error for the following files:
>=20
> C:\Program Files (x86)\OpenVPN\bin\openvpn-gui-1.0.3.exe
> C:\Program Files (x86)\OpenVPN\bin\libeay32.dll
>=20
> And after finishing the installation windows "Program Combatibility Assis=
tant" pops up,
> and asks if the program installed correctly, or if I wanted to "Reinstall=
 using recommended settings".
>=20
> http://pasik.reaktio.net/openvpn212-setup-might-not-have-installed-correc=
tly.jpg
>=20
> I chose it installed OK and then rebooted the machine.
>=20
> After reboot I noticed the TAP network device is missing from Windows,
> and thus openvpn connections cannot be started..
>=20
> Running the "Add a new TAP virtual ethernet adapter" doesn't seem to work=
 either..
>=20

And here's a screenshot of the failing tapinstall.exe:
http://pasik.reaktio.net/openvpn212-tapinstall-failed.jpg

-- Pasi

>=20
>=20
> On Sun, Aug 15, 2010 at 04:27:06PM -0600, James Yonan wrote:
> > 2010.08.09 -- Version 2.1.2
> >=20
> > * Windows security issue:
> >    Fixed potential local privilege escalation vulnerability in
> >    Windows service. The Windows service did not properly quote the
> >    executable filename passed to CreateService.  A local attacker
> >    with write access to the root directory C:\ could create an
> >    executable that would be run with the same privilege level as
> >    the OpenVPN Windows service.  However, since non-Administrative
> >    users normally lack write permission on C:\, this vulnerability
> >    is generally not exploitable except on older versions of Windows
> >    (such as Win2K) where the default permissions on C:\ would allow
> >    any user to create files there.
> >    Credit:  Scott Laurie, MWR InfoSecurity
> >=20
> > * Added Python-based based alternative build system for Windows using
> >    Visual Studio 2008 (in win directory).
> >=20
> > * When aborting in a non-graceful way, try to execute do_close_tun in
> >    init.c prior to daemon exit to ensure that the tun/tap interface is
> >    closed and any added routes are deleted.
> >=20
> > * Fixed an issue where AUTH_FAILED was not being properly delivered
> >    to the client when a bad password is given for mid-session reauth,
> >    causing the connection to fail without an error indication.
> >=20
> > * Don't advance to the next connection profile on AUTH_FAILED errors.
> >=20
> > * Fixed an issue in the Management Interface that could cause
> >    a process hang with 100% CPU utilization in --management-client
> >    mode if the management interface client disconnected at the
> >    point where credentials are queried.
> >=20
> > * Fixed an issue where if reneg-sec was set to 0 on the client,
> >    so that the server-side value would take precedence,
> >    the auth_deferred_expire_window function would incorrectly
> >    return a window period of 0 seconds.  In this case, the
> >    correct window period should be the handshake window
> >    period.
> >=20
> > * Modified ">PASSWORD:Verification Failed" management interface
> >    notification to include a client reason string:
> >=20
> >      >PASSWORD:Verification Failed: 'AUTH_TYPE' ['REASON_STRING']
> >=20
> > * Enable exponential backoff in reliability layer
> >    retransmits.
> >=20
> > * Set socket buffers (SO_SNDBUF and SO_RCVBUF) immediately after
> >    socket is created rather than waiting until after connect/listen.
> >=20
> > * Management interface performance optimizations:
> >=20
> >    1. Added env-filter MI command to perform filtering on env vars
> >       passed through as a part of --management-client-auth
> >=20
> >    2. man_write will now try to aggregate output into larger blocks
> >       (up to 1024 bytes) for more efficient i/o
> >=20
> > * Fixed minor issue in Windows TAP driver DEBUG builds
> >    where non-null-terminated unicode strings were being
> >    printed incorrectly.
> >=20
> > * Fixed issue on Windows with MSVC compiler, where TCP_NODELAY support
> >    was not being compiled in.
> >=20
> > * Proxy improvements:
> >=20
> >    Improved the ability of http-auth "auto" flag to dynamically detect
> >    the auth method required by the proxy.
> >=20
> >    Added http-auth "auto-nct" flag to reject weak proxy auth methods.
> >=20
> >    Added HTTP proxy digest authentication method.
> >=20
> >    Removed extraneous openvpn_sleep calls from proxy.c.
> >=20
> > * Implemented http-proxy-override and http-proxy-fallback directives to=
=20
> > make it
> >    easier for OpenVPN client UIs to start a pre-existing client config=
=20
> > file with
> >    proxy options, or to adaptively fall back to a proxy connection if a=
=20
> > direct
> >    connection fails.
> >=20
> > * Implemented a key/value auth channel from client to server.
> >=20
> > * Fixed issue where bad creds provided by the management interface
> >    for HTTP Proxy Basic Authentication would go into an infinite
> >    retry-fail loop instead of requerying the management interface for
> >    new creds.
> >=20
> > * Added support for MSVC debugging of openvpn.exe in settings.in:
> >=20
> >    # Build debugging version of openvpn.exe
> >    !define PRODUCT_OPENVPN_DEBUG
> >=20
> > * Implemented multi-address DNS expansion on the network field of route
> >    commands.
> >=20
> >    When only a single IP address is desired from a multi-address DNS
> >    expansion, use the first address rather than a random selection.
> >=20
> > * Added --register-dns option for Windows.
> >=20
> >    Fixed some issues on Windows with --log, subprocess creation
> >    for command execution, and stdout/stderr redirection.
> >=20
> > * Fixed an issue where application payload transmissions on the
> >    TLS control channel (such as AUTH_FAILED) that occur during
> >    or immediately after a TLS renegotiation might be dropped.
> >=20
> > * Added warning about tls-remote option in man page.
> >=20
> > -----------------------------------------------------------------------=
-------
> > This SF.net email is sponsored by=20
> >=20
> > Make an app they can't live without
> > Enter the BlackBerry Developer Challenge
> > http://p.sf.net/sfu/RIM-dev2dev=20
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
> -------------------------------------------------------------------------=
-----
> This SF.net email is sponsored by=20
>=20
> Make an app they can't live without
> Enter the BlackBerry Developer Challenge
> http://p.sf.net/sfu/RIM-dev2dev=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

