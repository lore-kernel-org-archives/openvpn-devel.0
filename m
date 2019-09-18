MIME-Version: 1.0
References: <1568724293-5069-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1568724293-5069-1-git-send-email-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 18 Sep 2019 10:38:25 -0400
Message-ID: <CAKuzo_jdwhEhy6f2N0uXcQOyjoCMQ41Ja3Pg0LwBww7UYmY2zA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/7] Visual Studio: upgrade project
 files to VS2019
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Sep 17, 2019 at 8:45 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> From: Lev Stipakov <lev@...515...>
>
> This set of patches adds support of wintun kernel driver (https://www.wintun.net) to OpenVPN.
>
> While wintun is in beta, it performs significantly faster comparison to tap-windows6.
>
> Here are some performance numbers (download bandwidth):
>
> Server - community openvpn2
>
> mingw, tap-windows6   - 340Mbit/s
> mingw, wintun         - 675Mbit/s
> VS2019, tap-windows6  - 425Mbit/s
> VS2019, wintun        - 750Mbit/s
>
> Server - propietary openvpn3 with kernel acceleration (in development)
>
> mingw, tap-windows6   - 360Mbit/s
> mingw, wintun         - 840Mbit/s
> VS2019, tap-windows6  - 430Mbit/s
> VS2019, wintun        - 1,14Gbit/s
>
> And for the reference
> openvpn3 test client, VS2019, wintun - 1,71Gbit/s

No doubt this is interesting and surprising given mingw (unlike
cygwin) uses stock Windows runtime. Does the VS build target a more
recent Windows runtime than the legacy one (msvcrt.dll) that mingw
would link against?

With some effort it may be possible to make mingw use a newer CRT (say
mscrt110.dll) and test whether that helps. Also, do we have to
distribute a recent CRT with this executable?

Even if we manage to change the release process to support building on
Windows, it will have to remain a hybrid process for a while at least.
OpenVPN-GUI doesn't build with visual studio and making it do so will
need some work -- especially with the resource file formats. Nothing
complicated but cumbersome. Unless someone volunteers.


Selva

