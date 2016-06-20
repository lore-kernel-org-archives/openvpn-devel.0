References: <CAFHpkQEVSSivEEYUaodCHSS-oYz11=7uzTq4JmQhZ4YsA9EE4Q@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <3119257f-3040-efae-fcf0-b04de0e1d9a9@...515...>
Date: Mon, 20 Jun 2016 14:01:31 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEVSSivEEYUaodCHSS-oYz11=7uzTq4JmQhZ4YsA9EE4Q@...278...>
Subject: Re: [Openvpn-devel] openvpn/openvpn-build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

> Hello,
>
> I see issues are closed at https://github.com/openvpn/openvpn-build
> what is preffered way of reporting bugs ?

I'm open to opening the issues again. If nobody objects, that's what=20
I'll do.

> somehow, I managed to run it on cygwin without wget installed (I
> installed curl),
> so I see 'curl' branch is broken, curl does not follow redirects
>
> do we really need both wget and curl there ?
>
> I'd remove curl at all, it will make scripts more readable and
> predictible. Or, ok, remove wget.
>
> actually, we can fix it. and even I'll expand travis-ci matrix for
> curl/wget, but I do not really understand why do we need both wget and
> curl there.
>
> Cheers,
> Ilya Shipitsin
>

I don't think we need both. Curl is just more likely to be present out=20
of the box. For example, on RHEL/CentOS 7 wget is not installed by=20
default. However, the users have to install tons of build dependencies=20
anyways, so I don't see a big problem with requiring wget.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

