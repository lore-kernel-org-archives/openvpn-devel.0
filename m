Message-ID: <4D503C61.5060203@...1194...>
Date: Mon, 7 Feb 2011 10:39:29 -0800
From: Roman Vasilyev <roman@...1194...>
MIME-Version: 1.0
References: <4D34A90F.7080008@...1194...>
In-Reply-To: <4D34A90F.7080008@...1194...>
Subject: Re: [Openvpn-devel] openvpn FreeBSD kqueue
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: Openvpn-devel@lists.sourceforge.net

Hi,

seems like I had email problems, and lost openvpn mail list, just want 
to double check that my patch was sent here.

On 01/17/2011 12:39 PM, Roman Vasilyev wrote:
> Hi,
>
> I want to try FreeBSD with OpenVPN on high load, checked event. found 
> that it can work only with epoll, just want to ask is it possible to 
> use kqueue in openvpn?
> If not, what people thinking if I'll add this support there?


