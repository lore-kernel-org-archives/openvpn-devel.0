MIME-Version: 1.0
In-Reply-To: <4F9A501E.4000409@...515...>
References: <CAOazyz3Z3Mr=wBnjZ=PmRV8cMWezzqv6ZgJrNXcxkfj73jUyvA@...278...>
	<4F9A501E.4000409@...515...>
Date: Fri, 27 Apr 2012 11:06:50 +0300
Message-ID: <CAOazyz17=zbrB91E87p0W4UrrsBRme0wDAsvbBvmiFzXxhG=_A@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] tap-windows - release
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

2012/4/27 Samuli Sepp=C3=A4nen <samuli@...515...>:
>
>> Hello Samuli,
>>
>> The tap-windows project unlikely to be changed, I think we should releas=
e it.
> Yep, that probably makes sense.
>
>> I already created public repository[1], completed the separate build,
>> signing and packaging.
>>
>> All we need is a signed build.
>>
>> Something like:
>> set CODESIGN_PKCS12=3D<key location in PKCS#12 format>
>> set CODESIGN_PASS=3D>password>
>> configure
>> build
> James has built and signed our TAP-drivers so far, and I don't have the
> signing keys. I'll forward this to him.

Great.
BTW: Apart from me, I don't think anyone actually tried to use the new
tap-windows installer...

>
>> I had only software signing certificate (not driver), so I could not
>> test this all the way. But it should be OK.
>>
>> If you need help converting the Microsoft proprietary format into
>> standard PKCS#12 format, please tell me.
>>
>> Alon.
>>
>> [1] https://github.com/OpenVPN/tap-windows
> Samuli
>

