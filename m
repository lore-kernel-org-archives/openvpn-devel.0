Message-ID: <50dc29cf-3a9e-579e-a030-4d185c8612cb@...2181...>
Date: Wed, 30 Mar 2022 14:16:18 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220329192934.1415-1-timo@...2669...>
 <0886f123-9243-f7df-347c-68b62c469675@...2080...>
 <1a4c7f58-16fb-b909-0b40-41f20390179b@...2080...>
 <8b9722eb-3282-dc1b-abbe-91cc37083af3@...2669...>
 <YkRFk80glGw62CWy@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YkRFk80glGw62CWy@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Retain CAP_NET_ADMIN when dropping
 privileges
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
To: Gert Doering <gert@...1296...>, Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 30/03/2022 13:57, Gert Doering wrote:
> Hi,
> 
> On Wed, Mar 30, 2022 at 01:31:24PM +0200, Timo Rothenpieler wrote:
>>> It is possible to argue that sitnl does low-level calls to the kernel as
>>> well.  But potential libraries had an API which was making everything
>>> far more complex on the OpenVPN side.  For libcap-ng at least, that is
>>> not the case; as the API it provides is pretty simple.
>>
>> Shouldn't caps support also be enabled when sitnl is in use?
>> Given it also needs CAP_NET_ADMIN.
> 
> That was a misunderstanding.  David explained why we are not using a
> library but directly talk to the netlink socket for SITNL.
> 
> And yes, we want CAP_NET_ADMIN for sitnl+--user as well ;-)

One detail: using SITNL is a compile time decision, while using DCO is a 
runtime decision (assuming it was compiled in)

Thanks!

-- 
Antonio Quartulli

