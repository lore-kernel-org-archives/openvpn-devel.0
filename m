Message-ID: <8c17e977-98b8-64f7-56fa-42fc2cb5f787@...2669...>
Date: Thu, 31 Mar 2022 13:29:28 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220329192934.1415-1-timo@...2669...>
 <20220330205536.139-1-timo@...2669...>
 <9564ba11-d626-4e60-fa2f-979c114b95c2@...277...>
 <d18f61d5-3f4d-b6b1-2a57-d2b2ff9b7a25@...2080...>
 <YkWKTthhlLISLXbl@...1296...>
From: Timo Rothenpieler <timo@...2669...>
In-Reply-To: <YkWKTthhlLISLXbl@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Retain CAP_NET_ADMIN when dropping
 privileges
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
To: Gert Doering <gert@...1296...>, David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

On 31.03.2022 13:02, Gert Doering wrote:
> Hi,
> 
> On Thu, Mar 31, 2022 at 12:06:06PM +0200, David Sommerseth wrote:
>> There is however another related challenge in OpenVPN 2.x, which became
>> even clearer than be fore with the sitnl implementation we switched over
>> to on Linux by default with v2.5.  When using --user/--group without
>> --persist-tun, a reconnect would tear down the interface but could not
>> recover again and the connection dies.  Using --persist-tun, it could
>> work a bit better *unless* it needs to change the IP address of the tun
>> interface.  I'm not sure how well, OpenVPN 2.x works if new routes are
>> being pushed (OpenVPN 3 supports that as well).  This challenge is also
>> resolved by granting the process CAP_NET_ADMIN capabilities.
> 
> For most non-trivial stuff, OpenVPN with --user will run into problems,
> be it route teardown, installing of new routes at renegotiation time,
> ...
> 
> So most people today just run 2.x as root, not getting any security
> benefits.
> 
>> For now, my opinion is that it is currently acceptable to have
>> CAP_NET_ADMIN available when running with ovpn-dco; to have a smooth
>> user experience.  OpenVPN is after all a network related process.
> 
> I'd even go for "keep CAP_NET_ADMIN for DCO and sitnl" - because it
> means "all the route/interface manipulation *and cleanup* stuff can
> be done properly, without having to carry root privileges".

That's exactly what the patch does.
Only difference is that for sitnl, to avoid breaking existing setups, it 
will fall back to the old approach of switching user if the capability 
retaining approach failed.

