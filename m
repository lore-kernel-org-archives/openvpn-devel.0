References: <515a2f96-e50d-3de5-bf54-e6d00834ca01@...515...>
	<CAEsd45RwW+oa8B1er1FSYZ8-B_OxWojNnYB81zd707isPSJM5w@...278...>
	<1e84c3fe-b45f-e739-7ff2-dc9f074a2b4c@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <faa60be2-0495-5853-aaca-e06e4c733e8c@...515...>
Date: Mon, 22 May 2017 10:38:06 +0300
MIME-Version: 1.0
In-Reply-To: <1e84c3fe-b45f-e739-7ff2-dc9f074a2b4c@...2080...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] OpenVPN 2.3.16 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn@...2080...>, "Jonathan K. Bullard" <jkbullard@...277...>

On 19/05/2017 15:37, David Sommerseth wrote:
> On 19/05/17 12:46, Jonathan K. Bullard wrote:
>> On Fri, May 19, 2017 at 5:29 AM, Samuli Sepp=C3=A4nen <samuli@...515...>=
 wrote:
>>>
>>> The OpenVPN community project team is proud to release OpenVPN 2.3.16.
>>> It can be downloaded from here:
>>>
>>> <http://openvpn.net/index.php/open-source/downloads.html>
>>>
>>> This is a minor release that fixes a few bugs. This release was made
>>> primarily because CloudFlare managed to serve obsolete pre-release
>>> OpenVPN 2.3.15 tarballs which lack a fix for CVE-2017-7478:
>>
>> Were all copies of openvpn-2.3.15.tar.gz that were downloaded from the
>> website pre-release versions and not the final versions, or only some?
>>
>> If only some were the pre-release version, is there a way to tell if a
>> tarball was the pre-release version or was the actual version? (The
>> SHA256s of both would be helpful here.)
>=20
> I have asked Samuli to re-upload the real v2.3.15 source tarballs once
> again, just to be on the safe side.  But beware, there are some caching
> proxies in front of our download servers ... so until the caches have
> been properly purged, there will be some confusion.
>=20
> Attached is a list with all the v2.3.15 source tarballs and their SHA256
> checksums.  This file is signed by our new signing key [1].  This is the
> proper v2.3.15 release.
>=20
> Any other checksums for v2.3.15 than the ones in this list are invalid
> and must not be used.
>=20
>=20
> [1] security@...515...
>     F554 A368 7412 CFFE BDEF  E0A3 12F5 F7B4 2F2B 01E7
>     <http://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x12F5F7B42F2B01E7>
>=20

Hi,

I pushed the new 2.3.15 tarballs to our download servers and purged
CloudFlare caches for the matching URLs. I also updated file signatures
documentation here:

<https://openvpn.net/index.php/open-source/documentation/sig.html>

Note that the 2.3.15 Windows installers are still signed with my
personal GPG key (40864578) as documented on the page above. The tar.gz,
tar.xz and zip files have been signed with the security list key
(2F2B01E7). This was a conscious choice to prevent further problems with
the 2.3.15 release.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

