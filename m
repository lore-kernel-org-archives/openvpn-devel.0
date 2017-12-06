MIME-Version: 1.0
In-Reply-To: <CAFHpkQF2UWhycTjrG2ZXsN3ySM=RxacYdvadKLDV1M5gfvP49A@...278...>
References: <1509903249-10979-1-git-send-email-selva.nair@...277...>
 <1509930876-30728-1-git-send-email-selva.nair@...277...>
 <CAFHpkQF2UWhycTjrG2ZXsN3ySM=RxacYdvadKLDV1M5gfvP49A@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 6 Dec 2017 10:01:58 -0500
Message-ID: <CAKuzo_h2gNDO2weVPkg7=XzjRHc=ZmDiYsX=cOo01Ujhi88G=w@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use lowest metric interface when
 multiple interfaces match a route
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Dec 6, 2017 at 8:28 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
>
>
> 2017-11-06 6:14 GMT+05:00 <selva.nair@...277...>:
>>
>>
..
>> +/**
>> + * Given an interface index return the interface metric.
>> + *
>> + * Arguments:
>> + *   index         : The index of the interface
>> + *   family        : AF_INET for IPv4 or AF_INET6 for IPv6
>> + * On error returns -1
>> + */
>> +
>> +/* function signature missing in mingw iphlpapi.h */
>
>
> that definition apparently present in mingw since 2015
>
> https://sourceforge.net/p/mingw-w64/mingw-w64/ci/ea95d55e3387353e453d6ae8=
fc5cb8f7503947c2/tree/mingw-w64-headers/include/netioapi.h
>
>
>>
>> +VOID NETIOAPI_API_
>> +InitializeIpInterfaceEntry(PMIB_IPINTERFACE_ROW Row);
>>

2015 may sound old,  but we are targeting ubuntu 16.04 which has mingw 3.1.0
from mid 2014.

Selva

