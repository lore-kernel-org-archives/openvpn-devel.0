Message-ID: <746476ea-982d-149b-fcba-482436515787@...2181...>
Date: Tue, 29 Mar 2022 13:52:04 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <CAAUX2SXb8MStU98ZEsswLkLDUM74zL6MapZC+=xc0_eYXwyEbw@...278...>
 <YkLkGj7WrC6ej0yR@...1296...>
From: Antonio Quartulli <a@...2181...>
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
To: Gert Doering <gert@...1296...>, Tony He <huangya90@...277...>
Cc: Antonio Quartulli <antonio@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 29/03/2022 12:48, Gert Doering wrote:
> @Antonio: can we make DCO interfaces auto-disappear if the OpenVPN
> process closes the last FD?

Originally we did not want to do that because we wanted ovpn-dco to 
survive a userspace crash or reload/restart (more likely) without losing 
state or client connections. Not something that can work now, but we 
wanted to be able to get there.

This said, as highlighted by Timo, the NET_ADMIN capa is required anyway 
for other operations (openvpn talks to DCO via netlink API).

Cheers,

-- 
Antonio Quartulli

