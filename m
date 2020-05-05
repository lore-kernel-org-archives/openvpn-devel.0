References: <CAFHpkQEvQkC0NokWG-16x-R_zq9qG=2MyO2JV8m1nvNUhwU3Vw@...278...>
 <0de39489-f2a8-514e-763f-c037ba2afbcb@...515...>
 <CAFHpkQELzeh5AQYXmQeNMP-9CXPjdGc=BM1qVbOCtH5QByO4iA@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <6fadf6ae-bfd9-27ad-6ac6-63f23dcda34b@...515...>
Date: Tue, 5 May 2020 12:12:35 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQELzeh5AQYXmQeNMP-9CXPjdGc=BM1qVbOCtH5QByO4iA@...278...>
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Il 04/05/20 15:14, Илья Шипицин ha scritto:
> 
> 
> пн, 4 мая 2020 г. в 16:41, Samuli Seppänen <samuli@...515...
> <mailto:samuli@...515...>>:
> 
>     Hi,
> 
>     We do have a Fedora 30 buildslave and run fping tests there. It also
>     seems to run t_client IPv6 ping tests.
> 
> 
> can you please run the following
> 
> 
> dnf whatprovides fping6
> 
> ?

On Fedora 30 as well as 31:

$ dnf whatprovides fping6
Error: No Matches found


$ dnf whatprovides fping
fping-4.2-1.fc30.x86_64 : Scriptable, parallelized ping-like utility
Repo        : @System
Matched from:
Provide    : fping = 4.2-1.fc30

fping-4.2-1.fc30.x86_64 : Scriptable, parallelized ping-like utility
Repo        : fedora
Matched from:
Provide    : fping = 4.2-1.fc30




>  
> 
> 
>     Samuli
> 
>     Il 03/05/20 23:02, Илья Шипицин ha scritto:
>     > Hello,
>     >
>     >
>     > t_client.sh requires "fping6" binary, which is not available on
>     Fedora.
>     > on Fedora "fping" is capable of running ipv6 pings.
>     >
>     >
>     > shall we adopt test ?
>     >
>     >
>     > Cheers,
>     > Ilya Shipitcin
>     >
>     >
>     > _______________________________________________
>     > Openvpn-devel mailing list
>     > Openvpn-devel@lists.sourceforge.net
>     <mailto:Openvpn-devel@lists.sourceforge.net>
>     > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>     >
> 


