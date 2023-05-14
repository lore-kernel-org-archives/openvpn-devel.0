Message-ID: <683dac5b-4bfb-d359-4382-1f09cf57820f@...2108...>
Date: Sun, 14 May 2023 21:12:08 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <7072303.gtipl9YmvM@...2731...>
 <40c32f7b-b3a5-a09d-5b21-943b4a9ec736@...1227...>
 <5431695.haC6HkEk0m@...2731...>
 <3bc3d283-6cdf-d7fd-e1d5-037589eb904e@...1227...>
 <ZGDXETofVi68X7Ah@...1296...>
From: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <ZGDXETofVi68X7Ah@...1296...>
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
To: openvpn-devel@lists.sourceforge.net, Melvin Vermeeren <vermeeren@...2730...>
Cc: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>

On 14/05/2023 14:41, Gert Doering wrote:
> Hi,
> 
> On Sun, May 14, 2023 at 02:38:06PM +0200, Arne Schwabe wrote:
>> Yes the option we ignore to check if we have to reopen the tun device is
>> quite short. We should probably turn this into a positive list instead
>> of assuming that all options need to trigger to a tun reopen/close.
> 
> True, but even so - shouldn't the systemd unit file just restart the
> openvpn client anyway?
> 
> (I see myself having to restart the OpenSolaris Community VPN client
> ever so often...)

We had this discussion back in the days when we added the automatic 
restart on servers.  In the unit file for openvpn-server@...1685... we added:

      RestartSec=5s
      Restart=on-failure

We ended up only enabling this on the server config by default, as it 
was some good points (which I don't recall right now) about not 
restarting the client configs automatically.  It might have been due to 
avoid DDoS the server in larger deployments, if a bad option would be 
pushed to all clients or something like that.

This is anyhow very easily added on a per-config bases using a systemd 
feature:

     # systemctl edit openvpn-client@...2732...

In the file opened in the editor, just add "[Service]" and those two 
lines mentioned earlier.  You might want to have a bit longer "Restart" 
timer, but that's up to the local sysadmin to judge best.


-- 
kind regards,

David Sommerseth
OpenVPN Inc



