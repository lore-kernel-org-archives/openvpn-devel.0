References: <CAFHpkQFkm-6FUUs8DN63UKKHCPHZBmLDK1fk60xaycUk3K5GSQ@...278...>
	<CAFHpkQEjE6vmRm3-Mq_9i3A2w5TrcJ4rasxoZwf00W+sPh3DDQ@...278...>
	<CAFHpkQEt1tH5yPY-9=G6YRuardSBM7CtsDLOHd71JHHUQBtOwQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <45ec7635-8bb5-f811-9b8b-4713091d79ee@...515...>
Date: Tue, 7 Jun 2016 17:33:07 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEt1tH5yPY-9=G6YRuardSBM7CtsDLOHd71JHHUQBtOwQ@...278...>
Subject: Re: [Openvpn-devel] Valgring findings
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net


> Hello,
>
> I played with valgrind a bit
>
> https://travis-ci.org/chipitsine/openvpn/jobs/135869065
>
> Looks like there are leaks in openssl code, should we suppress it?

I can't comment on the leaks themselves, but I wonder if it would make=20
sense to run OpenVPN under Valgrind in "make check". For example, when=20
using the Vagrant test VMs the loss of performance would not be a big=20
deal - the tests would just run quite a bit longer.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

