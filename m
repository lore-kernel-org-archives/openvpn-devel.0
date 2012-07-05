Message-ID: <4FF558F5.8090301@...1114...>
Date: Thu, 05 Jul 2012 11:05:57 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4FF43DD9.3030007@...515...>
	<CAOazyz0BGUXOF7+3YEfq5oE1Kk1x9M1yuZS4YaWOBQr5XrLdtA@...278...>
In-Reply-To: <CAOazyz0BGUXOF7+3YEfq5oE1Kk1x9M1yuZS4YaWOBQr5XrLdtA@...278...>
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/07/12 15:06, Alon Bar-Lev wrote:
[...snip...]
> Please apply the patches for easy-rsa that were deleted by David,
> as in current shape it cannot be installed nor packaged. This
> should be done in the course of the alpha cycle so user may keep
> functionality.

- From what I can see, those patches should be in-place.  I see Eric
added 4 of your patches about a week ago, or are there more patches
lacking?  Anyhow, Eric is the upstream maintainer of easy-rsa now, so
I'll let him be in charge of that if something is missing.

> After doing so, please publish the tarball results of "make dist".

Something wrong here with this one?  (Except of the version string, if
we're nit-picking)
<https://github.com/OpenVPN/easy-rsa/downloads>


kind regards,

David Sommerseth



> On Wed, Jul 4, 2012 at 3:58 PM, Samuli Sepp=C3=A4nen
> <samuli@...515...> wrote:
>> The OpenVPN community project team is proud to release OpenVPN=20
>> 2.3_alpha2. It can be downloaded from here:
>>=20
>> <http://openvpn.net/index.php/open-source/downloads.html>
>>=20
>> The largest change in OpenVPN 2.3_alpha2 is the split into
>> several subprojects (thanks go to Alon Bar-Lev):
>>=20
>> - openvpn (the core project) - tap-windows (Windows TAP-driver) -
>> easy-rsa (PKI management package) - openvpn-build (external
>> buildsystem) - "generic": cross-compile on *NIX platforms (e.g.
>> Linux -> Windows) - "msvc": build using MSVC on Windows -
>> "windows-nsis": generate Windows installers on *NIX
>>=20
>> These changes have resulted in a number of user-visible changes:
>>=20
>> - Separate 32- and 64-bit installers for Windows (see
>> INSTALL-win32.txt) - Old "domake-win" and Python-based
>> buildsystems have been removed - "easy-rsa" and "tap-windows"
>> removed from the OpenVPN Git tree - All Windows executables and
>> libraries cross-compiled with mingw_w64 and signed - Rewrite of
>> the openvpn autotools buildsystem
>>=20
>> In addition, there a number of changes not related to the above:
>>=20
>> - Many bugfixes - Stabilized the PolarSSL support - Enabled IPv6
>> support on OSX - General code cleanup - Improved UTF-8 support in
>> Windows
>>=20
>> Note that a few changes have been made which may affect existing=20
>> installations. A list of new features and the changelog are
>> available here:
>>=20
>> <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn23>
>>=20
>> The changelog is also attached to this email.
>>=20
>> For generic help use these support channels:
>>=20
>> - Official documentation:=20
>> <http://openvpn.net/index.php/open-source/documentation/howto.html>
>>
>>=20
- - Wiki: <https://community.openvpn.net>
>> - Forums: <https://forums.openvpn.net> - User mailing list:
>> <http://sourceforge.net/mail/?group_id=3D48978> - User IRC channel:
>> #openvpn at irc.freenode.net
>>=20
>> Please report bugs and ask development questions here:
>>=20
>> - Bug tracker and Wiki: <https://community.openvpn.net> -
>> Developer mailing list:
>> <http://sourceforge.net/mail/?group_id=3D48978> - Developer IRC
>> channel: #openvpn-devel at irc.freenode.net (requires Freenode
>> registration)
>>=20
>> -- Samuli Sepp=C3=A4nen Community Manager OpenVPN Technologies, Inc
>>=20
>> irc freenode net: mattock
>>=20
>> ------------------------------------------------------------------------=
------
>>
>>=20
Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security
>> and threat landscape has changed and how IT managers can respond.
>> Discussions will include endpoint security, mobile security and
>> the latest in malware threats.
>> http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/=20
>> _______________________________________________ Openvpn-users
>> mailing list Openvpn-users@lists.sourceforge.net=20
>> https://lists.sourceforge.net/lists/listinfo/openvpn-users
>>=20
>=20
> -------------------------------------------------------------------------=
-----
>
>=20
Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and=20
> threat landscape has changed and how IT managers can respond.
> Discussions will include endpoint security, mobile security and the
> latest in malware threats.
> http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/=20
> _______________________________________________ Openvpn-devel
> mailing list Openvpn-devel@lists.sourceforge.net=20
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/1WPIACgkQDC186MBRfrpDpACfaGrTUdyvAQbYQ6LERNA+3ODt
ujcAmwT1UHXC2OLStLxaFCYWGCcxQy3z
=3DRDID
-----END PGP SIGNATURE-----

