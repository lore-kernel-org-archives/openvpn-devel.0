Message-ID: <d18f61d5-3f4d-b6b1-2a57-d2b2ff9b7a25@...2080...>
Date: Thu, 31 Mar 2022 12:06:06 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220329192934.1415-1-timo@...2669...>
 <20220330205536.139-1-timo@...2669...>
 <9564ba11-d626-4e60-fa2f-979c114b95c2@...277...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <9564ba11-d626-4e60-fa2f-979c114b95c2@...277...>
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Jan Just Keijser <jan.just.keijser@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 31/03/2022 08:53, Jan Just Keijser wrote:
> Hi,
> 
> On 30/03/22 22:55, Timo Rothenpieler wrote:
>> ---
>> Using libcap-ng now
> sorry to butt in late, but I've got a nasty feeling about this... the 
> whole purpose of using
>    --user
> is, according to the man page
>         --user user
>                Change the user ID of the OpenVPN process to user after 
> initialization,  dropping  privileges  in  the
>                process.  This  option is useful to protect the system in 
> the event that some hostile party was able to
>                gain control of an OpenVPN session. Though OpenVPN's 
> security features make this unlikely, it  is  pro‐
>                vided as a second line of defense.
> 
>                By  setting  user  to  nobody or somebody similarly 
> unprivileged, the hostile party would be limited in
>                what damage they could cause. Of course once you take 
> away privileges, you cannot  return  them  to an
>                OpenVPN  session.  This  means, for example, that if you 
> want to reset an OpenVPN daemon with a SIGUSR1
>                signal (for example in response to a DHCP reset), you 
> should make use of one or more of  the  --persist
>                options  to  ensure  that OpenVPN doesn't need to execute 
> any privileged operations in order to restart
>                (such as re-reading key files or running ifconfig on the 
> TUN device).
> 
> yet with this patch, the openvpn process remains capable of
> 
>         CAP_NET_ADMIN
>                Perform various network-related operations:
>                * interface configuration;
>                * administration of IP firewall, masquerading, and
>                  accounting;
>                * modify routing tables;
>                * bind to any address for transparent proxying;
>                * set type-of-service (TOS);
>                * clear driver statistics;
>                * set promiscuous mode;
>                * enabling multicasting;
>                * use setsockopt(2) to set the following socket options:
>                  SO_DEBUG, SO_MARK, SO_PRIORITY (for a priority outside
>                  the range 0 to 6), SO_RCVBUFFORCE, and SO_SNDBUFFORCE.
> 
> so this "second line of defense" it getting *VERY* leaky in my opinion 
> (and warrants a manpage update, at the very least).
> 
> The proper solution would be to have openvpn fork on itself, keep a 
> "barebones" process running as root, but with the actual control and 
> data channels running in the forked process using truly minimal privileges.

Hi,

You have some valid points about locking down OpenVPN.  However, without 
this change and having OpenVPN run completely without privileges it will 
not work well in certain situations with ovpn-dco.  Because it will not 
have the capabilities needed to interact with the kernel module. 
CAP_NET_ADMIN does give this possibility.

In regards to man-page update, I agree.  And we should do that as a 
additional patch.

And when it comes to this patch, currently it only use the capabilities 
feature when DCO is available on the system and not disabled in the 
configuration.  This in options.c which calls 
dco_check_option_conflict(), which is implemented in dco.c.

There is however another related challenge in OpenVPN 2.x, which became 
even clearer than be fore with the sitnl implementation we switched over 
to on Linux by default with v2.5.  When using --user/--group without 
--persist-tun, a reconnect would tear down the interface but could not 
recover again and the connection dies.  Using --persist-tun, it could 
work a bit better *unless* it needs to change the IP address of the tun 
interface.  I'm not sure how well, OpenVPN 2.x works if new routes are 
being pushed (OpenVPN 3 supports that as well).  This challenge is also 
resolved by granting the process CAP_NET_ADMIN capabilities.

For now, my opinion is that it is currently acceptable to have 
CAP_NET_ADMIN available when running with ovpn-dco; to have a smooth 
user experience.  OpenVPN is after all a network related process.



As a way forward after this, the aspect of how much to trust, 
capabilities and privileges you put into a single process needs to be 
better defined.  OpenVPN 2.x has a monolithic design, and the 
architecture of privilege separation is lacking at best.

We have not done any attempts improving this, as this will not be a 
trivial refactoring.  With ovpn-dco, the data-channel handling is 
already handled outside of the master OpenVPN process; so here there is 
some improvements indirectly.  Now the control-channel handling + 
network configuration (with CAP_NET_ADMIN) runs in the same process scope.

Arne and I discussed a while back to look into if the Network 
Configuration service (openvpn3-service-netcfg) from OpenVPN 3 Linux can 
be implemented in a way where it can be used by OpenVPN 2.x as well. 
Theoretically, this is possible but not trivial.

In OpenVPN 3 Linux, privilege separation is part of the design.  The 
client process (openvpn3-serivce-client) runs completely unprivileged, 
but gets its tun/ovpn-dco interface created by openvpn3-service-netcfg 
and the client passes VPN IP address, routes and DNS settings to this 
netcfg service which applies these changes.  The netcfg service runs as 
openvpn:openvpn with CAP_NET_ADMIN (and a few optional other ones, 
depending on the system setup) and can only be approached by 
openvpn3-service-client processes.  The rest of the OpenVPN 3 Linux 
stack runs completely unprivileged.  On systems with SELinux enabled, 
both openvpn3-service-client and openvpn3-service-netcfg runs confined 
in their own separate SELinux contexts, with a strict policy what each 
of them can do.

I am willing to work on making the netcfg service even less "OpenVPN 3 
centric", and it has a potential to grow towards a generic VPN API on 
Linux.  The current D-Bus interface it uses is highly inspired by the 
Android VPN API.  But this won't happen in a short time and not in time 
for the OpenVPN 2.6 release.  This is probably something which is more 
realistic for OpenVPN 2.8.  But this needs to be discussed more 
thoroughly (next hackathon?).


-- 
kind regards,

David Sommerseth
OpenVPN Inc


