Message-ID: <3bc3d283-6cdf-d7fd-e1d5-037589eb904e@...1227...>
Date: Sun, 14 May 2023 14:38:06 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <7072303.gtipl9YmvM@...2731...>
 <40c32f7b-b3a5-a09d-5b21-943b4a9ec736@...1227...>
 <5431695.haC6HkEk0m@...2731...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <5431695.haC6HkEk0m@...2731...>
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

Am 13.05.23 um 16:47 schrieb Melvin Vermeeren:
> Hi Arne,
> 
> On Saturday, 13 May 2023 16:28:29 CEST Arne Schwabe wrote:
>> Can you provide some more detail here? Otherwise this seem a bit
>> nebulously to me what exactly explodes and goes wrong.
> 
> I changed the --keepalive setting on the server, lowering the timeout from 120
> to 60 seconds to make things somewhat more responsive. Figured a small push
> change like this wouldn't really cause trouble.
> 
> This triggered a TUN device close/reopen, which makes sense in hindsight.
> Clients are configured to drop privilege with --user and --group after
> connecting, so they could not make the change needed.
> 
>> NOTE: Pulled options changed on restart, will need to close and reopen
>> TUN/TAP device.
>> ...
>> ERROR: Cannot ioctl TUNSETIFF tun_vpn: Operation not permitted (errno=1)
>> Exiting due to fatal error
> 
> This is not the only case though, I also had some problems with DCO on a
> Debian testing client recently, resulting in failure after network was offline
> for quite a while. Official Debian package DCO 0.0+git20230324-1.
> 

Yes the option we ignore to check if we have to reopen the tun device is 
quite short. We should probably turn this into a positive list instead 
of assuming that all options need to trigger to a tun reopen/close.

Arne


