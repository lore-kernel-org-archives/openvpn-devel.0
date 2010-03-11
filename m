Message-ID: <4B991541.3060603@...1147...>
Date: Thu, 11 Mar 2010 17:07:29 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4B9515FF.6000704@...41...>	<20100308174321.GA25238@...1296...>
	<4B966A98.4000206@...41...>
	<jwvsk87dlhk.fsf-monnier+inbox@...1269...>
In-Reply-To: <jwvsk87dlhk.fsf-monnier+inbox@...1269...>
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Stefan Monnier <monnier@...1268...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Stefan Monnier wrote:
>> Implementing a DHCP client within OpenVPN tends to make this a more
>> self-contained problem.
>>     
>
> I don't think OpenVPN should get into the DHCP business.
> Especially because this is not a problem specific to OpenVPN: the same
> problem of refreshing DHCP info happens with ethernet and with wifi when
> you disconnect and reconnect.
>
> Various solutions to this problem already exist: a tool (e.g. ifplugd)
> can monitor the interface's status, or OpenVPN can be instructed (via
> its script hooks) to run commands upon (re|dis)connection.
>
> These existing solutions are better because they profit from the general
> infrastructure and will hence blend in much better.  E.g. they will
> automatically adopt the global DHCP customizations.
>
>   
I tend to agree with Stefan here:

it would be useful if the package builder or system engineer has more 
control over how a tun or tap device is configured but why re-invent the 
wheel ? I'd more than happy if the /sbin/ip command (as determined by 
./configure) became scriptable so that a package maintainer can 
determine which script/program to use to bring the interface up and 
down. I do most of my work on RedHat based systems so I'd replace 
/sbin/ifup with a script which writes out
 /etc/sysconfig/networking-scripts/ifup-tap
and then simply call
 /sbin/ifup tap0
or something like that... On Ubuntu the package maintainer can choose to 
write his or her favourite /etc/network script, etc etc. Adding your own 
DHCP code is more than likely only going to interfere with system 
package which are already in place (NetworkManager, ifplugd, etc etc).

Let's not add more complexity to openvpn itself, I'd be much happier if 
the complexity is separated as much as possible (heck, why am I even 
stuck using a tun or tap adapter? It'd be nice/fun to be able to use a 
ppp adapter as well, provided that I provide the right interface between 
what openvpn expects and what ppp expects)

JM2CW,

JJK / Jan Just Keijser


