Message-ID: <26881bbe-5560-1f63-c150-52cccb42c704@...1227...>
Date: Tue, 24 Jan 2023 15:32:03 +0100
MIME-Version: 1.0
References: <20230124142316.441-1-lstipakov@...277...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230124142316.441-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] openvpnmsica: fix adapters discovery
 logic for DCO
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>


> 
> The ultimate solution to this would be moving adapter creation to MSM,
> a shared component which adds/removes the DCO driver. However this change
> is not trivial and requires a lot of work. For the time being we apply
> this band-aid by excluding Connect-created adapters from enumerations in
> "FindSystemInfo" custom action. This makes sure that OpenVPN-GUI won't
> rely on adapter created by Connnect (which is deleted on Connect uninstall)
> and ensures that additional DCO adapters won't be created on upgrade
> if user decides to rename adapter.
> 

Isn't allowing a user to add/remove adapters from UI a better approach?

Arne


