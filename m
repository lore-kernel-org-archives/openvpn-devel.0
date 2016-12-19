References: <CAFHpkQEKrJqNB2ZmhAwKGebVb6SB75HpnWcrw_niSaALL_S4mA@...278...>
	<CAA1AbxJZL70qY=ivMvskeUapj0V_+z_LVnM2Zp2LxAJT4t62vA@...278...>
	<CAFHpkQEnATPgCyxsLW6bpC5Qr-Cdh=+4X4MRXxgUD+orKpq+EQ@...278...>
	<20161121174953.GM28918@...1296...>
	<CAFHpkQFZD+hYzq_FW075wQt5AopcyCP20BEDzLsTx5Vq6uko3Q@...278...>
	<d48609b7-43df-80d5-a57f-e96e85ad4389@...2080...>
	<CAFHpkQHxVWvHSFK2hS7CV8ytUnxUHi5ZfjSOiuLBfWdufzMrCQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <9048486e-03d9-7aa1-74f8-892a9cc7c1ee@...515...>
Date: Mon, 19 Dec 2016 11:11:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHxVWvHSFK2hS7CV8ytUnxUHi5ZfjSOiuLBfWdufzMrCQ@...278...>
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 19/12/2016 10:22, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>
> 2016-11-27 4:29 GMT+05:00 David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>>:
>
>     On 26/11/16 12:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
>     >
>     >
>     > 2016-11-21 22:49 GMT+05:00 Gert Doering <gert@...1296... <mailto:ge=
rt@...1296...>
>     > <mailto:gert@...1296... <mailto:gert@...1296...>>>:
>     >
>     >     Hi,
>     >
>     >     On Mon, Nov 21, 2016 at 10:31:45PM +0500, ???????? ????????????=
?? wrote:
>     >     > this line
>     >     >
>     >     > https://github.com/OpenVPN/openvpn/blob/master/tests/unit_tes=
ts/openvpn/Makefile.am#L17
>     <https://github.com/OpenVPN/openvpn/blob/master/tests/unit_tests/open=
vpn/Makefile.am#L17>
>     >     <https://github.com/OpenVPN/openvpn/blob/master/tests/unit_test=
s/openvpn/Makefile.am#L17
>     <https://github.com/OpenVPN/openvpn/blob/master/tests/unit_tests/open=
vpn/Makefile.am#L17>>
>     >     >
>     >     > causes an error
>     >
>     >     GNU LD manpage says this is a trick to make it link "another fu=
nction"
>     >     "--wrap parse_line" would make it link __wrap_parse_line() inst=
ead -
>     >     most likely because @d12fk provided a stub function that mocks =
the
>     >     result (or whatever).
>     >
>     >     Have not looked into this in more detail.
>     >
>     >
>     > http://www.mockator.com/projects/mockator/wiki/Wrap_Functions
>     <http://www.mockator.com/projects/mockator/wiki/Wrap_Functions>
>     >
>     > "Alas, this feature is *only available with the GNU tool chain on
>     > Linux*. GCC for Mac OS X does not offer the linker flag |-wrap|. "
>     >
>     > should we skip those tests on osx ? or someone will rewrite them ?
>
>     I'd hold back a little bit.  I know Arne, Heiko and some people from
>     #cmocka on FreeNode had a discussion about this issue earlier this we=
ek.
>      I don't know what they agreed on, but there was a discussion where t=
hey
>     looked at a few alternatives at least.
>
>
>
> any news on that ?
>

We discussed this in previous IRC meeting, and there is still no real fix:

<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13558.=
html>

The easiest "fix" would be to just disable cmocka unit tests for MacOS X=20
in .travis.yml. I believe the unit tests behave exactly the same on=20
every platform(?), so removing MacOS X would not have any negative=20
impact on code quality.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

