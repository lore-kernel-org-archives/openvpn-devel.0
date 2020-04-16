References: <20200416134925.8848-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <c275eace-650d-8ac2-4e39-e9001e74db6b@...2181...>
Date: Thu, 16 Apr 2020 15:51:31 +0200
MIME-Version: 1.0
In-Reply-To: <20200416134925.8848-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] t_net.sh: use dummy interface instead
 of tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 16/04/2020 15:49, Antonio Quartulli wrote:
> The tun interface has proved to be a bit fragile for basic netlink tests
> as it may introduce delays in switching state, depending on the system
> the test is ran on.
> 
> For this reason, switch to dummy interface type and at the same type
> set its oper-state to up right after creation to avoid hitting the
> no-carrier state later. No-carrier has been problematic in pasts tests
> as it sometimes persists long enough to create a discrepancy between the
> various tests snapshots thus causing a test failure.
> 
> Setting a static MAC addressis also re-enabled to avoid it being
> different and thus causing a test failure when comparing snapshots.
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>
This patch has gone through buildbot a couple of times and I was never
able to trigger the usual failure that we saw until now.

-- 
Antonio Quartulli

