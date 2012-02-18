Message-ID: <4F403B58.5060803@...1114...>
Date: Sun, 19 Feb 2012 00:59:20 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz3S2GAFu+TN0s7482ovQBdWJYUxALVfOEiF6UGHR0oW0Q@...278...>
In-Reply-To: <CAOazyz3S2GAFu+TN0s7482ovQBdWJYUxALVfOEiF6UGHR0oW0Q@...278...>
Subject: Re: [Openvpn-devel] [DEVELOPER REQUESTED] Repackage TAP-Win32
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
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>
Cc: Alon Bar-Lev <alon.barlev@...277...>, =?ISO-8859-1?Q?Samuli_Sepp=E4?=

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/02/12 16:05, Alon Bar-Lev wrote:
> Hello,
>=20
> We have a go to rewrite the OpenvPN build system. I started to work at
> core product [1].
>=20
> As part of the re-write we split out the TAP-Win32 out of OpenVPN code
> base.
>=20
> To make things go faster we may try to parallelize the effort.
>=20
> Here are the tasks to perform: 1. Create a GIT repository of the
> master TAP-Win32 sources with all history, to ease our work, please
> use github. 2. Detach the TAP-Win32 build from the OpenVPN build. It
> should be a simpler build as it now only use the DDK. 3. Rename the
> TAP-Win32 to TAP-Windows as we do not need the legacy "Win32" any
> more. 4. Rename the TAP common.h into tap-windows.h. 5. Sync
> tap-windows.h symbols per [2], I added prefix and removed the "32",
> add another header for version information. 6. Create tap nsis
> installation (based on current openvpn nsis), the msi must be silent
> installation mode enabled. 7. Within installation, add a group "SDK"
> or similar to nsis to install the tap-windows.h as well. 8. Create
> build script to build and optionally sign the driver and the msi. 9.
> Output of build system would be [at least] (msi, tarball) for (win32,
> win64). Why tarball? To enable people to fetch files without hacking
> the msi (example: cross compile).
>=20
> Anyone interested? Need someone experienced with courage!


First of all, yes, we are doing some steps now to clean up the source
tree and split out the pieces of the OpenVPN source tree which is not
strictly purely OpenVPN.  The Windows TUN/TAP driver is a generic driver,
which OpenVPN needs.  But it's not something other platforms than Windows
need (they have their own TUN/TAP drivers) and the TUN/TAP driver is
useful for other projects.

Alon has stepped up and is willing to help with this job.  He has on this
mailing list shown knowledge about the autotools tool chain and Windows
development.  I personally am very much thankful that Alon has said
himself willing to look into cleaning up these parts of OpenVPN.  And I'm
looking forward to start reviewing the changes he is suggesting.

However, it might be a potential misunderstanding which I will now
attempt to straighten up.  The TUN/TAP driver *will not* be moved out of
the OpenVPN project itself.  It will stay in the OpenVPN project as a
separate sub-project in its own git tree.  The OpenVPN community which I
dare to speak on behalf on now, will be in charge also for the Windows
TUN/TAP driver.

And Alon is right, the OpenVPN project needs more resources with the
right knowledge and/or strong willingness to learn that.  That/those
person(s) will need to be involved with the OpenVPN community as everyone
else.  And it is the same expectations of anyone who wants to contribute,
that all changes will be sent to the mailing list for review.  The
mailing list is where we share knowledge and learn each others new
things.  For more information, see the developer pages in the OpenVPN
Community wiki [A].

I will make sure that during the next week the pieces Alon moves out gets
into new official git trees.

If there are any queries regarding to the OpenVPN project, please contact
Samuli Sepp=E4nen <samuli@...515...> or me (dazo@...384...)
and we will answer as best as we can.


Kind regards,

David Sommerseth


> [1] https://github.com/alonbl/openvpn branch build. [2]
> https://github.com/alonbl/openvpn/blob/build/include/tap-windows.h
[A] <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9AO1UACgkQDC186MBRfrpfFwCgp4ZXExr/cY3yUxdkJiTMR5XO
Nb4AoKvmTAW7xnua6LW1qvnc0SFd0CUi
=3Df74C
-----END PGP SIGNATURE-----

