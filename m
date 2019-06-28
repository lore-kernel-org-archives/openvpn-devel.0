MIME-Version: 1.0
References: <CAKuzo_j6F2+_JxosdVF3iB4kzWsR7Wq2FT8Vgi9Cg3yvT_A1JQ@...278...>
 <20190628210334.GU1097@...1296...>
In-Reply-To: <20190628210334.GU1097@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 28 Jun 2019 17:43:13 -0400
Message-ID: <CAKuzo_ji9qNyc1vtQRhuuuYXgmpb6Qey2+L7GRqbhLNqbSwx9A@...278...>
Subject: Re: [Openvpn-devel] Using AllowNonAdmin in the advanced options of
 tap adapter
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Fri, Jun 28, 2019 at 5:03 PM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Fri, Jun 28, 2019 at 04:51:47PM -0400, Selva Nair wrote:
> > Would that mean we can assume that always allowing all users access to
> > the tap (say, using the service to open it) would not be a regression?
> > Or are there folks who use local builds of the driver and expect
> > openvpn.exe to respect that setting?
>
> The whole permission model for openvpn on Windows has been funky at
> best "forever" - open tap device and setup IPv4 address by means of
> DHCP could be done "by everyone", while installing routes or setting
> up IPv6 then failed for non-Admin accounts...
>
> I'm not exactly sure what you are proposing, but aligning this with
> wintun and using the service to get access to tap6-windows sounds
> like a reasonable plan.

That's what lev's patch would do, but it wont respect the registry key
which is "supposed" to toggle non-admin access to tap-windows6
adapters on and off.

> With a registry key to re-enable "full
> access as today", for compat reasons.

For some reason that registry key appears to be doing nothing in
current versions of tap-windows6. I know this is confusing...

Selva

