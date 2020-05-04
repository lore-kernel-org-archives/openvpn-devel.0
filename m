References: <CAFHpkQEvQkC0NokWG-16x-R_zq9qG=2MyO2JV8m1nvNUhwU3Vw@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <0de39489-f2a8-514e-763f-c037ba2afbcb@...515...>
Date: Mon, 4 May 2020 14:41:37 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEvQkC0NokWG-16x-R_zq9qG=2MyO2JV8m1nvNUhwU3Vw@...278...>
Content-Language: en-US
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
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

We do have a Fedora 30 buildslave and run fping tests there. It also
seems to run t_client IPv6 ping tests.

Samuli

Il 03/05/20 23:02, Илья Шипицин ha scritto:
> Hello,
> 
> 
> t_client.sh requires "fping6" binary, which is not available on Fedora.
> on Fedora "fping" is capable of running ipv6 pings.
> 
> 
> shall we adopt test ?
> 
> 
> Cheers,
> Ilya Shipitcin
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 


