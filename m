Message-ID: <40ee3e318f8fbb18b8e11126659eaa59.squirrel@...2556...>
In-Reply-To: <CAFHpkQELzeh5AQYXmQeNMP-9CXPjdGc=BM1qVbOCtH5QByO4iA@...278...>
References: <CAFHpkQEvQkC0NokWG-16x-R_zq9qG=2MyO2JV8m1nvNUhwU3Vw@...278...>
 <0de39489-f2a8-514e-763f-c037ba2afbcb@...515...>
 <CAFHpkQELzeh5AQYXmQeNMP-9CXPjdGc=BM1qVbOCtH5QByO4iA@...278...>
Date: Mon, 4 May 2020 15:59:32 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] is anybody running tests on Fedora ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?B?ItCY0LvRjNGPINCo0LjQv9C40YbQuNC9Ig==?= <chipitsine@...277...>
Cc: =?utf-8?B?IlNhbXVsaSBTZXBww6RuZW4i?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

> =D0=BF=D0=BD, 4 =D0=BC=D0=B0=D1=8F 2020 =D0=B3. =D0=B2 16:41, Samuli Sepp=
=C3=A4nen <samuli@...515...>:
>
>> Hi,
>>
>> We do have a Fedora 30 buildslave and run fping tests there. It also
>> seems to run t_client IPv6 ping tests.
>>
>
> can you please run the following
>
>
> dnf whatprovides fping6

I don't know about the EPEL packages but with recent fping builds, there
is no such thing like an fping6 - it's gone.

Regards,
Simon


