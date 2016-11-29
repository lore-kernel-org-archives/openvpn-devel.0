References: <68d50540-ec71-5564-99a7-7bb24ae05d17@...1856...>
	<1480371252-3880-1-git-send-email-steffan@...1856...>
	<CA+0EDdBLaPxX3u07yfg=S-xnVEnFRP7oD=2BnpONtjw7EEkPeQ@...278...>
	<331bcfe6-0373-1542-cdfc-50f360b7ceaa@...1435...>
	<2ebb29c2-6cbf-e770-2f31-5e08fa2f0e9f@...1227...>
	<20161129101812.GE1013@...1296...>
	<769188a1-74c7-a6f9-443c-6bfd8103921c@...1227...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <ada0390c-76ae-3468-7680-f763d5dfdbcd@...1435...>
Date: Tue, 29 Nov 2016 14:20:18 +0100
MIME-Version: 1.0
In-Reply-To: <769188a1-74c7-a6f9-443c-6bfd8103921c@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Introduce and use secure_memzero()
 to erase secrets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 29-11-16 11:28, Arne Schwabe wrote:
>=20
>=20
> Am 29.11.16 um 11:18 schrieb Gert Doering:
>> Hi,
>>
>> On Tue, Nov 29, 2016 at 11:07:12AM +0100, Arne Schwabe wrote:
>>> I think we should prefer memset_s if available since it is a C11 standa=
rd.
>> Since we're currently compiling against C99, we can't rely on it being
>> there (in my OS Zoo, only MacOS seems to have it, at least "have a manpa=
ge
>> for it" - not even FreeBSD 11 or "gentoo current") - but then, configure=
=20
>> could check that for us...
> I wouldn't add a configure test for that. According to
> http://en.cppreference.com/w/c/string/byte/memset:
>=20
> As all bounds-checked functions, |memset_s| is only guaranteed to be
> available if __STDC_LIB_EXT1__ is defined by the implementation and if
> the user defines __STDC_WANT_LIB_EXT1__ to the integer constant 1 before
> including |string.h|.
>=20
> so preprocessor magic can check that.

This is indeed how it should be done (and almost how the new version of
Yang et al does it).  However, memset_s() is part of the *optional*
annex K of C11, and there seems to be no agreement on whether it is a
good idea to implemented at all[0].

Given that Windows has SecureZeroMemory() and the memory barrier
approach works fine on the unixes, I don't see much gain in adding
support for memset_s().  Even so, I won't object to a patch adding it,
and will send a v3 if there are more people who want it.

-Steffan

[0] http://comments.gmane.org/gmane.comp.lib.glibc.alpha/44430


