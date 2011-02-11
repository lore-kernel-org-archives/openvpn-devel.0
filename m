Message-ID: <4D54F653.4040809@...515...>
Date: Fri, 11 Feb 2011 10:41:55 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4D53FD4B.8050302@...515...> <4D540B3B.5040602@...1147...>
In-Reply-To: <4D540B3B.5040602@...1147...>
Subject: Re: [Openvpn-devel] OpenVPN 2.2-rc Windows installer ready
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
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>


> hi Samuli,
>
> Samuli Sepp=E4nen wrote:
>=20=20=20
>> Hi all,
>>
>> The (hopefully) final preview of the OpenVPN 2.2-rc installer for
>> Windows is available here:
>>
>> <http://build.openvpn.net/downloads/releases/openvpn-2.2-rc-install-prev=
iew-5.exe>
>>
>> The main reason for this preview installer is our use of the new,
>> relatively untested Python-based buildsystem which uses VS 2008 tools.
>> Note that the new buildsystem is not replacing the old autotools-based
>> one. This installer and the included binaries have been tested on the
>> following platforms:
>>
>> - Windows XP 32-bit
>> - Windows XP 64-bit
>> - Windows 7 64-bit
>>
>> The plan is to get James to sign the installer during today's IRC
>> meeting (#openvpn-devel at irc.freenode.net) at 18:00 UTC. If you want
>> help make sure that 2.2-rc is a solid release, please test the installer
>> and let us know if there are any issues - or if it works perfectly.
>>
>>=20=20=20
>>=20=20=20=20=20
> just FYI: this installers runs on Windows 2000 (grin), if  you choose to=
=20
> not install the TAP-Win32 driver. the executables work, but OpenVPN=20
> refuses to start as the tap-win32 driver needs to be version 9.7 and I=20
> only have 9.6 - is this new version *really* necessary? what is new in it?
>
> Tomorrow I will test it on a Windows XP VM (which I don't have here=20
> right now) and on Win7 64bit.
>
> cheers,
>
> JJK
>
>=20=20=20
Hi JJK,

The older TAP driver probably works fine for the 2.2 branch. However, it
won't work properly in 2.3, which will contain IPv6 support. Anyways, in
one of the IRC meetings it was decided to drop Windows 2000 support
mainly because MS does not support it anymore, either. Also, supporting
it would have added significant amount of complexity because the Win2k
driver needs to be built separately.

On a related note... originally the installer script contained a list of
"known good" Windows versions and would refuse to install on any other
platforms. When Windows 7 came out, that code was commented out - I'd
assume NSIS at that point could not detect Win7 correctly. Anyways,  a
few days back I removed that code altogether. However, I think
blacklisting would make sense to prevent installation on platforms where
OpenVPN would not work properly anyways.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


