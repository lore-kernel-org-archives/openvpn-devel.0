Message-ID: <40c32f7b-b3a5-a09d-5b21-943b4a9ec736@...1227...>
Date: Sat, 13 May 2023 16:28:29 +0200
MIME-Version: 1.0
References: <7072303.gtipl9YmvM@...2731...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <7072303.gtipl9YmvM@...2731...>
Subject: Re: [Openvpn-devel] Automatically restart Linux systemd OpenVPN
 client service on failure
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
To: Melvin Vermeeren <vermeeren@...2730...>, openvpn-devel@lists.sourceforge.net

Am 13.05.23 um 16:24 schrieb Melvin Vermeeren:
> Hi all,
> 
> Today I changed some OpenVPN server configuration and restarted the service,
> thinking all clients will reconnect just fine as usual. Unlike other days
> however, all Linux clients ended up exploding due to unexpected tun-device
> recreation and lack of permission to do so, resulting in fatal exit with
> service failure. Quite a surprise to me, and a bit of a mess to fix!

Can you provide some more detail here? Otherwise this seem a bit 
nebulously to me what exactly explodes and goes wrong.


Arne

