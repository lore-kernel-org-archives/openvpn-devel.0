Message-ID: <9fc2869a-a42d-cbb2-9242-48d4972b02d3@...2080...>
Date: Thu, 23 Jun 2022 14:43:14 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20210930113308.815777-1-mkh199740@...450...>
 <CAKuzo_iWaTiKSeiTVrqkLfbPLp+ScvGm_m8stEUNOzunobXVUg@...278...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <CAKuzo_iWaTiKSeiTVrqkLfbPLp+ScvGm_m8stEUNOzunobXVUg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add ability to specify initialize flags
 for pkcs11 provider
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>, Petr Mikhalicin <mkh199740@...450...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 19/06/2022 19:28, Selva Nair wrote:
> Hi,
> 
> On Thu, Sep 30, 2021 at 7:34 AM Petr Mikhalicin via Openvpn-devel 
> <openvpn-devel@lists.sourceforge.net 
> <mailto:openvpn-devel@lists.sourceforge.net>> wrote:
> 
>     New pkcs11-helper interface allows to setup pkcs11 provider via
>     properties:
>     https://github.com/alonbl/pkcs11-helper/commit/b78d21c7e26041746aa4ae3d08b95469e1714a85
>     <https://github.com/alonbl/pkcs11-helper/commit/b78d21c7e26041746aa4ae3d08b95469e1714a85>
> 
>     Also pkcs11-helper added ability to setup init args for pkcs11 provider:
>     https://github.com/alonbl/pkcs11-helper/commit/133f893e30856eba1de715ecd6fe176722eb3097
>     <https://github.com/alonbl/pkcs11-helper/commit/133f893e30856eba1de715ecd6fe176722eb3097>
> 
>     Signed-off-by: Petr Mikhalicin <mkh199740@...450...
>     <mailto:mkh199740@...450...>>
> 
> 
> Sorry for the long delay in getting back on this. I somehow also missed 
> the related discussion on Trac 
> (https://community.openvpn.net/openvpn/ticket/1453 
> <https://community.openvpn.net/openvpn/ticket/1453>)
> 
> I don't quite understand the need for exposing "init-args" to the user. 
> The only two supported flags in the cryptoki docs are related to the use 
> of threads. But we are the application and we should know what flags to 
> pass --- not the user --- isn't it? If CKF_OS_LOCKING_OK is required, 
> can't we just set it unconditionally?
> 
> That said, OpenVPN2 is single threaded, so why is there a "bug in 
> openvpn" related to the use of pkcs11 library from multiple threads 
> referred to in the trac ticket?

I haven't dug too deep into the matter this time; and it depends also on 
the OS you are on.  But there has been some issues with pkcs11-helper on 
hosts with systemd, due to some intricacies with openvpn doing a fork to 
kick off the password query mechanism with systemd colliding with some 
pkcs11-helper implementation details.  For the systemd case, we added a 
workaround which made most people happy.

For more details:
<https://community.openvpn.net/openvpn/ticket/538>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


