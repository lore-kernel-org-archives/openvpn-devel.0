Message-ID: <4F476E84.10903@...515...>
Date: Fri, 24 Feb 2012 13:03:32 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
	<4F475356.9020508@...515...>
	<CAOazyz3Qz19ETq-oH2xogaEA0VRBUiDpGd6+ksPM5D6sXm7ZbA@...278...>
In-Reply-To: <CAOazyz3Qz19ETq-oH2xogaEA0VRBUiDpGd6+ksPM5D6sXm7ZbA@...278...>
Subject: Re: [Openvpn-devel] [build] Windows build test
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
To: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> 2012/2/24 Samuli Sepp=C3=A4nen <samuli@...515...>:
>> Hi Alon,
>>
>> I tried building OpenVPN using the "Visual Studio Complete Batch" method:
>>
>> $ cd msvc
>> $ build
>>
>> All went fine until OpenVPN build itself. The error message is here:
>>
>> <http://pastebin.com/2uJM4n3y>
> Oh... you used the tarball and I forgot to distribute the compat.vcproj.
> Now it should be OK.
Hi Alon,

Actually, I cloned the "openvpn-build" Git repository and copied the
directories from there on top OpenVPN sources (yours and official). That
said, I tried the tarball, too:

<https://github.com/downloads/alonbl/openvpn/openvpn-2.3-alpha1.tar.gz>

I documented the basic process (compile from tarball) here:

<https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem=
#MSBuild>

I had some issues getting it to find openssl, lzo and pkcs11-helper
include files. As a stop-gap solution I modified msvc-env.bat's last
lines to look like this:

set OPENVPN_DEPROOT=3DC:\Users\Samuli\openvpn-build
set OPENSSL_HOME=3D"%OPENVPN_DEPROOT%\openssl"
set LZO_HOME=3D"%OPENVPN_DEPROOT%\lzo"
set PKCS11H_HOME=3D"%OPENVPN_DEPROOT%\pkcs11-helper"

That layout is the same I used for the Python-based buildsystem. After
this change OpenVPN built just fine, but it eventually failed due to not
finding pkcs11-helper libs. That's fixable, I just didn't have time to
do it right now. I'll continue tests later today or on Monday.

Personally I won't miss any MSVC builds (pick your flavour) if we decide
to get rid of them ;).

Samuli

