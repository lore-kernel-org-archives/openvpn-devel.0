Message-ID: <1b584ae7-3772-d9d1-7aa5-53ed87b92b8e@...2669...>
Date: Tue, 29 Mar 2022 21:36:02 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <CAAUX2SXb8MStU98ZEsswLkLDUM74zL6MapZC+=xc0_eYXwyEbw@...278...>
 <YkLkGj7WrC6ej0yR@...1296...>
From: Timo Rothenpieler <timo@...2669...>
In-Reply-To: <YkLkGj7WrC6ej0yR@...1296...>
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Antonio Quartulli <antonio@...515...>, Gert Doering <gert@...1296...>

On 29.03.2022 12:48, Gert Doering wrote:
> Hi,
> 
> On Tue, Mar 29, 2022 at 06:21:37PM +0800, Tony He wrote:
>> 1. Add option "user nobody" to test ovpn-dco.
>> 2. Start openvpn, below is the log. Then we will see tun0 is still
>> there after openvpn exit. We must use the command "ip link del tunX"
>> to delete. This is not friendly to end user.
> 
> Yes.  This is currently unsolved - if you tell openvpn to give up its
> privileges, it will give up its privileges, and then it lacks privileges
> to tear down the interface again.
> 
> This should be doable with linux net capabilities, but right now, we
> have not investigated this option further.  So, for now, do not
> use "user" together with DCO.

I just sent a patch ("Retain CAP_NET_ADMIN when dropping privileges") 
that solves this for me.
It retains the CAP_NET_ADMIN capability while switching user.

Patch sits on top of the dco branch, since it uses functions from it.

I'm not seeing the patch yet, but my mail server claims it got delivered.

The patch is also on Github, on top of the dco branch in my fork:
https://github.com/BtbN/openvpn/tree/dco

