Message-ID: <046f2279-a275-aa18-40d9-9808512a6651@...2669...>
Date: Tue, 29 Mar 2022 12:29:14 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <CAAUX2SXb8MStU98ZEsswLkLDUM74zL6MapZC+=xc0_eYXwyEbw@...278...>
From: Timo Rothenpieler <timo@...2669...>
In-Reply-To: <CAAUX2SXb8MStU98ZEsswLkLDUM74zL6MapZC+=xc0_eYXwyEbw@...278...>
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
To: openvpn-devel@lists.sourceforge.net

On 29.03.2022 12:21, Tony He wrote:
> Hi,
> 
> 1. Add option "user nobody" to test ovpn-dco.
> 2. Start openvpn, below is the log. Then we will see tun0 is still
> there after openvpn exit. We must use the command "ip link del tunX"
> to delete. This is not friendly to end user.

I think the dco only working if openvpn is running as root is a general 
issue right now.
Like, clients can't connect either, because it fails to communicate with 
the interface after dropping privileges.

