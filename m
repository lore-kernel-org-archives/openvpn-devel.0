MIME-Version: 1.0
In-Reply-To: <4D716245.6040500@...1114...>
References: <4D713CD3.3000606@...515...>
	<AANLkTin4QkZ36mi7qHyB9R+i1FdQJi66mi6nhhvYMWmN@...278...>
	<4D716245.6040500@...1114...>
Date: Sat, 5 Mar 2011 00:16:44 +0200
Message-ID: <AANLkTik3D2gtpwwiKGNpDr60UpQ3n64z_P9C-p2ErY9c@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN 2.2-RC released
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Thanks.
I gave a reference of build environment that actually automates the
openvpn build [2] using a cross compile to any target. mingw win32 and
win64 are subsets.

Alon.

On Sat, Mar 5, 2011 at 12:05 AM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 04/03/11 22:14, Alon Bar-Lev wrote:
>> Hello,
>>
>> Any reason why the windows cross compile fix we discussed [1] did not
>> made it into mainline?
>>
>> This is trivial patch, which resume the ability to build openvpn using
>> cross compiler and autotools.
>>
>> Please apply so we don't need to maintain this out of tree.
>> You can test build at [2].
>
> I'm sorry, that patch has slipped my patch queue. =C2=A0The patch applies=
 pretty
> cleanly to the beta2.2 branch (just some offset values which are wrong).
> So I am willing to include that into the final 2.2 release.
>
> However, I do not have any configuration available to cross compile with
> mingw32 available. =C2=A0So if someone can please review and test this pa=
tch on
> such a platform, I'll include as soon as I get an ACK.
>
> Thanks for the heads-up!
>
>
> kind regards,
>
> David Sommerseth
>
>
>> [1] http://permalink.gmane.org/gmane.network.openvpn.devel/3991
>> [2] https://www.opensc-project.org/opensc/wiki/build
>>
>> 2011/3/4 Samuli Sepp=C3=A4nen <samuli@...515...>
>>>
>>> The OpenVPN community project team is proud to release OpenVPN 2.2-RC.
>>> It can be downloaded from here:
>>>
>>> =C2=A0* http://openvpn.net/index.php/open-source/downloads.html
>>>
>>> Changes include:
>>>
>>> =C2=A0 =C2=A0* Windows installer built and packaged with the new Python=
-based
>>> buildsystem that utilizes the Visual Studio 2008 toolchain
>>> =C2=A0 =C2=A0* Lots of enhancements and fixes to the Python-based Windo=
ws
>>> buildsystem (see Changelog for details)
>>> =C2=A0 =C2=A0* Make the --x509-username-field feature an opt-in feature
>>>
>>> A more comprehensive list of changes is available here:
>>>
>>> =C2=A0*
>>> http://openvpn.net/index.php/open-source/documentation/change-log/425-c=
hangelog-for-openvpn-22.html
>>>
>>> If you find a bug in this release, please file a bug report to our Trac
>>> bug tracker. In uncertain cases please contact our developers first,
>>> either using the openvpn-devel mailinglist or the developer IRC channel
>>> (#openvpn-devel at irc.freenode.net).
>>>
>>> NOTE: In production environments you should use the latest stable
>>> release, not this release candidate build.
>>>
>>> --
>>> Samuli Sepp=C3=A4nen
>>> Community Manager
>>> OpenVPN Technologies, Inc
>>>
>>> irc freenode net: mattock
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk1xYkUACgkQDC186MBRfrp8dQCeIM5tmvlhABhn5G1jOiKbW+xE
> QKsAoJ5C86CwVDnDfWBussOSmaLq22/t
> =3DQdOu
> -----END PGP SIGNATURE-----
>

