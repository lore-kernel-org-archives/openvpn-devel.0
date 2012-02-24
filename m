Message-ID: <4F478964.5010704@...515...>
Date: Fri, 24 Feb 2012 14:58:12 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
	<4F475356.9020508@...515...>
	<CAOazyz3Qz19ETq-oH2xogaEA0VRBUiDpGd6+ksPM5D6sXm7ZbA@...278...>
	<4F476E84.10903@...515...>
	<CAOazyz2uHGe-3WvvscTH05+Cev2TDQ4yCt-LcxKVXpay=U0dJQ@...278...>
In-Reply-To: <CAOazyz2uHGe-3WvvscTH05+Cev2TDQ4yCt-LcxKVXpay=U0dJQ@...278...>
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> 2012/2/24 Samuli Sepp=C3=A4nen <samuli@...515...>:
>> Actually, I cloned the "openvpn-build" Git repository and copied the
>> directories from there on top OpenVPN sources (yours and official). That
>> said, I tried the tarball, too:
>>
>> <https://github.com/downloads/alonbl/openvpn/openvpn-2.3-alpha1.tar.gz>
>>
>> I documented the basic process (compile from tarball) here:
>>
>> <https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsys=
tem#MSBuild>
>>
>> I had some issues getting it to find openssl, lzo and pkcs11-helper
>> include files. As a stop-gap solution I modified msvc-env.bat's last
>> lines to look like this:
> <snip>
>
> I don't understand.
> It should be so simple.
> Just tried this again...
>
>> git clone https://github.com/alonbl/openvpn-build.git
>> cd openvpn-build/msvc
>> build
> No extra command is needed, no file modifications.
> All you need is working perl and visual studio 2008 or above.
>
> Alon.
Hmm, interesting... It does work after all. I think my mistake was to
assume the directories inside the "openvpn-build" repository need to be
copied (cp -r) on top of an OpenVPN source tree. That somehow messed up
my first builds.

I'm very impressed with the new buildsystem. Thanks, Alon!

Samuli

