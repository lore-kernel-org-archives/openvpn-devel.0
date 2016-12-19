References: <CAFHpkQEKrJqNB2ZmhAwKGebVb6SB75HpnWcrw_niSaALL_S4mA@...278...>
	<CAA1AbxJZL70qY=ivMvskeUapj0V_+z_LVnM2Zp2LxAJT4t62vA@...278...>
	<CAFHpkQEnATPgCyxsLW6bpC5Qr-Cdh=+4X4MRXxgUD+orKpq+EQ@...278...>
	<20161121174953.GM28918@...1296...>
	<CAFHpkQFZD+hYzq_FW075wQt5AopcyCP20BEDzLsTx5Vq6uko3Q@...278...>
	<d48609b7-43df-80d5-a57f-e96e85ad4389@...2080...>
	<CAFHpkQHxVWvHSFK2hS7CV8ytUnxUHi5ZfjSOiuLBfWdufzMrCQ@...278...>
	<9048486e-03d9-7aa1-74f8-892a9cc7c1ee@...515...>
	<CAFHpkQHtPm2gPfHYEngJoMymUxt8iOFA7L0z+p54oVSNEmEPFQ@...278...>
	<4ea0b775-5681-b908-f06d-9251d28e8c8a@...515...>
	<c41ad01c-d1a2-cf2c-4876-c22954ae90a9@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <e93e0d67-963a-d677-7d67-323b46e6c3c7@...515...>
Date: Mon, 19 Dec 2016 15:49:50 +0200
MIME-Version: 1.0
In-Reply-To: <c41ad01c-d1a2-cf2c-4876-c22954ae90a9@...2080...>
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0Lg=?= =?UTF-8?B?0YbQuNC9?= <chipitsine@...277...>

Il 19/12/2016 15:44, David Sommerseth ha scritto:
> On 19/12/16 11:01, Samuli Sepp=C3=A4nen wrote:
> [...snip...]
>> Right now cmocka tests are skipped if
>>
>> a) cmocka Git submodule is not initialized
>> b) CMake is not installed
>>
>> See commit 45f6e7991cf for details.
>>
>> Travis logs say this:
>>
>> $ git clone --depth=3D50 --branch=3Dmaster
>> https://github.com/OpenVPN/openvpn.git OpenVPN/openvpn
>> $ git submodule update --init --recursive
>>
>> Which means that cmocka Git submodule gets sucked in automatically. So
>> that leaves us with the following options afaics:
>>
>> 1) Remove the cmocka directory after the fact (rather nasty)
>
> In deed nasty.  Why not rather detect if it os OSX and skip the 'git
> submodule' step?

Yes, this would suck much less.

Chipitsine: could you have a look how this could be done? Basically we'd=20
need to different Git command than the above if MacOS X is detected.


>
>
>> 2) Ensure that CMake is not installed on MacOS X (does mbedTLS require
>> this?)
>
> If mbedTLS is built from source, then I believe CMake is needed.
>
>
>> 3) Allow the user to select if cmocka tests are run or not
>
> Try to avoid adding more options ... rather try to have some reasonable
> defaults which is auto-detected based on reasonable triggers (such as
> distro/platform)
>
>

