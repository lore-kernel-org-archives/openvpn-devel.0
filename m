Date: Mon, 15 Nov 2021 14:11:18 +0100
From: Ruben Herold <ruben@...1302...>
Message-ID: <20211115131118.GC29441@...2643...>
References: <20211115115309.GA29441@...2643...>
 <CAGyAFMWRiAKE_P-9CKkGqma2Br27Xv5eC+eS9OeVy-VfGxVn+w@...278...>
MIME-Version: 1.0
In-Reply-To: <CAGyAFMWRiAKE_P-9CKkGqma2Br27Xv5eC+eS9OeVy-VfGxVn+w@...278...>
Subject: Re: [Openvpn-devel] Start openvpn gui before windows login
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Mon, Nov 15, 2021 at 02:45:53PM +0200, Lev Stipakov wrote:
 Hi,
 
 
> Things might have changed since then, but our priorities now are
> releasing 2.6 with the new dco/dco-win drivers, which significantly
> improve performance. We might have a look at UWP VPN after that again.

Cause from the screenshoots it looks like they have found a way to start
their own gui during login so that the user can use MFA and so on. Or do
they really do all their vpn stuff via UWP?

I'm not very deep in this Windows stuff, so it can be that I'm on the
complete wrong way.

 
> Are you sure your problem cannot be solved with openvpn service?
> 
> See, for example,
> https://openvpn.net/community-resources/running-openvpn-as-a-windows-service/
> Also this discussion might be relevant:
> https://github.com/OpenVPN/openvpn-gui/issues/77
> 
We are using user/pass auth against AD and MFA so this is not possible. 

            Ruben
-- 
Ruben Herold 
ruben@...1302...

