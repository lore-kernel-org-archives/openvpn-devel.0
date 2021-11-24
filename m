MIME-Version: 1.0
References: <20210922095756.1929-1-chipitsine@...277...>
 <4654662a-587a-ca90-6678-5c5ff71e9c66@...1227...>
 <CAGyAFMWXBpvo-mxOkNsFrYR9oB9MVRcFEQ6SBs7rP0A6LeNu6Q@...278...>
 <CAFHpkQECg=UVywGzXXBeA1V5R7M5zSr8QkCT=Mj7ThBFB5c+yg@...278...>
In-Reply-To: <CAFHpkQECg=UVywGzXXBeA1V5R7M5zSr8QkCT=Mj7ThBFB5c+yg@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 24 Nov 2021 16:21:38 +0200
Message-ID: <CAGyAFMVXK16xNkBDbsb_VTC9qrYSAWTxnc=iOXOzUBGH_LqPhw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] BUILD: enable CFG and Spectre
 mitigation for MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Since we're preparing the next 2.5 release, let's take this in. The
performance numbers, reported in different thread, look good.

ma 27. syysk. 2021 klo 13.06 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD (chipitsine@...277...) kirjoitti:
>
> I'll setup test stand similar to this one https://community.openvpn.net/o=
penvpn/wiki/PerformanceTestingOpenVPN
> hopefully in next 1-2 weeks
>
> I also believe that spectre mitigation is neglectable, but it is good to =
have numbers
>
> =D0=BF=D0=BD, 27 =D1=81=D0=B5=D0=BD=D1=82. 2021 =D0=B3. =D0=B2 12:58, Lev=
 Stipakov <lstipakov@...277...>:
>>
>> I didn't, but here
>>
>> https://devblogs.microsoft.com/cppblog/spectre-mitigations-in-msvc/
>>
>> it says that
>>
>> "On the MSVC team, we=E2=80=99ve reviewed information in detail and cond=
ucted
>> extensive tests, which showed the performance impact of the new
>> /Qspectre switch to be negligible."
>> --
>> -Lev



--=20
-Lev

