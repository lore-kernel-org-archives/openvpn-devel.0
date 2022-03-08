From: Kristof Provost <kprovost@...2661...>
Date: Tue, 08 Mar 2022 15:29:15 +0100
Message-ID: <DED07A0F-3068-494D-BECA-B043BD97D49B@...2661...>
In-Reply-To: <f4d55b82-4a9d-fd09-a8d9-f4ec6a8692d1@...2181...>
References: <20220224165557.22060-1-kprovost@...2661...>
 <20220224165557.22060-3-kprovost@...2661...>
 <f4d55b82-4a9d-fd09-a8d9-f4ec6a8692d1@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 2/2] ovpn-dco: introduce FreeBSD
 data-channel offload support
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 8 Mar 2022, at 15:16, Antonio Quartulli wrote:
> Hi Kristof,
>
> A quick question for you, see below
>
> On 24/02/2022 17:55, Kristof Provost via Openvpn-devel wrote:
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -787,7 +787,20 @@ dnl
>>   			AC_DEFINE(ENABLE_DCO, 1, [Enable data channel offload for Linux])
>>   			AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
>>   		;;
>> -
>> +		*-*-freebsd*)
>> +			DCO_CFLAGS=3D"-I${DCO_SOURCEDIR}"
>> +			saved_CFLAGS=3D"${CFLAGS}"
>> +			CFLAGS=3D"${CFLAGS} ${DCO_CFLAGS}"
>> +			AC_CHECK_HEADERS(
>> +					 [if_ovpn.h],
>> +					 ,
>> +					 [AC_MSG_ERROR([if_ovpn.h is missing (use DCO_SOURCEDIR to set pat=
h to it, CFLAGS=3D${CFLAGS})])]
>> +					 )
>> +			CFLAGS=3D${saved_CFLAGS}
>> +			LIBS=3D"${LIBS} -lnv"
>> +			AC_DEFINE(ENABLE_DCO, 1, [Enable data channel offload for FreeBSD])
>> +			AC_MSG_NOTICE([Enabled ovpn-dco support for FreeBSD])
>> +		;;
>
> If you double check the latest dco branch, you will see that I have dropp=
ed the DCO_SOURCEDIR variable and I have rather switched to "let's include =
the kernel API header in the openvpn repository all the time and be happy w=
ith it".
>
> The idea is that the kernel API will always be backwards compatible, ther=
efore having a stale header will never be a problem. It can be updated when=
 a new feature is implemented in openvpn itself. (a similar approach is tak=
en by hostapd or iw on Linux, where they ship a copy of nl80211.h)
>
> On the other hand, we drastically simplify the configure logic and avoid =
having to deal with this variable which may have different pitfalls on diff=
erent platforms.
>
> Do you have any opinion about the above? or shipping a copy of the header=
 with openvpn source code is fine with you?
>
It=E2=80=99s not really too relevant either way for FreeBSD, because the he=
ader contains very little information. It=E2=80=99s mostly only the ioctl n=
umbers. There are no structures shared between the kernel and user land. In=
stead we use nvlists (name/value pair serialisation).

Theoretically I=E2=80=99d prefer to use the OS header, but I can certainly =
see the upside of not having that dependency. We=E2=80=99ll always have to =
do the runtime check (dco_available()) anyway, so I can certainly live with=
 that.

> p.s. as a side note, the rest of the code contains some "code style" issu=
es. Nothing major, but wanted to mention it (we can discuss on IRC if you w=
ant).
>
I=E2=80=99m happy to fix that. Do you have a rough list of what=E2=80=99s w=
rong?
https://community.openvpn.net/openvpn/wiki/CodeStyle is the authoritative s=
tyle guide, right?

Best regards,
Kristof

