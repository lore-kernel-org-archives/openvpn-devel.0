Message-ID: <43eeed40-b1e6-798b-038c-d69febfbd77e@...2181...>
Date: Tue, 29 Mar 2022 13:50:33 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <CAAUX2SXb8MStU98ZEsswLkLDUM74zL6MapZC+=xc0_eYXwyEbw@...278...>
 <046f2279-a275-aa18-40d9-9808512a6651@...2669...>
 <YkLn9u3YVo5cuiVn@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YkLn9u3YVo5cuiVn@...1296...>
Subject: Re: [Openvpn-devel] [ovpn-dco] can not delete tun interface
 automatically if option "user nobody" is used
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
To: Gert Doering <gert@...1296...>, Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 29/03/2022 13:05, Gert Doering wrote:
> @Antonio, we should really investigate that capability stuff :-)

I think this was already discussed somewhere else in the past. To talk 
to the netlink API the NET_ADMIN capability is required - no need to be 
root.

Therefore, just grant this capability to the binary with:

  setcap cap_net_admin+eip /usr/sbin/openvpn

and then launch it with any user you want (no need to launch as root and 
then drop to user nobody, unless there are other reasons for doing so).

Just tested here a few minutes ago.

Cheers,

-- 
Antonio Quartulli

