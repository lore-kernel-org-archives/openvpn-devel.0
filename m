MIME-Version: 1.0
References: <1568724293-5069-1-git-send-email-lstipakov@...277...>
 <CAGyAFMVjqC4mdjy83v+UqgLBnv3yLGwRT5Hg_PAB+_PwEMoDZw@...278...>
 <CAA1Abx+u=ZRaVVfwSfrSJOJYhFdRbX8q-amMt8LV+jL+du+2dw@...278...>
 <CAGyAFMVQy9U09nXkr1Q66qpHrBNoX99b_dF93kd+0w9w4sqC5Q@...278...>
In-Reply-To: <CAGyAFMVQy9U09nXkr1Q66qpHrBNoX99b_dF93kd+0w9w4sqC5Q@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 20 Sep 2019 14:05:58 -0400
Message-ID: <CAKuzo_givujmu0hSZzYhooGDgdYTxRtv_6OqzfkvhSGNLq866Q@...278...>
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
Cc: Steffan Karger <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Fri, Sep 20, 2019 at 1:55 PM Lev Stipakov <lstipakov@...277...> wrote:
>
> Hi Steffan,
>
>> Out of curiosity: does the (signed) driver from wintun.net not work? Of so, why?
>
>
> It does. It is just not usable for openvpn yet because:
>
> 1)  Wintun is distributed as msm module, which is supposed to be integrated into MSI installer.
> Our MSI installer doesn't support wintun yet.
>
> 2) One can install wireguard client, which installs wintun, however it still won't work
> for openvpn out of the box. Wireguard creates tun adapter on demand, and openvpn
> expects it to already exist. So if you try to use openvpn with wintun after installing wireguard
> you'll get error "no tun adapters found" (or something). This is not a problem, since
> we have "tapctl" tool which can create/list/delete tun/tap adapters. It does not work with
> wintun, though, since it has hardcoded "tap0901" hardware id. I plan to make it customizable
> so one could create wintun adapter by running something like "tapctl.exe create --name openvpn-wintun --hwid wintun".
> We could consider creating tun adapter on demand, but this increases connection time by a few seconds.
>

The last time I tried, I could use the driver that comes with
wireguard by "activatin" an adapter from its GUI but not add a
tunnel so that the device remains free. Then the pacthed openvpn
could open it.

How does one install the driver in the zip file you posted -- using
devcon with the hardware id of wintun?


Selva

