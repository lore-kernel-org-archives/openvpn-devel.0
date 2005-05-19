From: Ralf =?UTF-8?B?TMO8YmJlbg==?= <ralfluebben@...68...>
Message-ID: <d6j0lb$b8e$1@...165...>
References: <200504291033.00667.ralfluebben@...68...> <Pine.LNX.4.58.0504300118280.24107@...41...> <Pine.LNX.4.58.0504301334040.25603@...41...> <200505031348.25263.ralfluebben@...68...> <Pine.LNX.4.58.0505031000150.1970@...41...> <d6ck1r$3b9$1@...165...> <1116334849.14388.43.camel@...23...> <Pine.LNX.4.58.0505170713570.2777@...41...> <1116337185.14388.71.camel@...23...> <Pine.LNX.4.58.0505171009060.2777@...41...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: Re: Radius support (Authentification, Authorization and Accounting)
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu May 19 14:39:43 2005
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello,

the authentication is already working. The Framed IP Address and the Framed
Routes can be set by the radius server about the
auth-user-pass-verif-plugin. And every user gets a unique NAS-Port.
The easiest way to do the accounting process is to start it in the
auth-user-pass-verif-plugin and to add the user for accounting in the 
auth-user-pass-verif-plugin-function, maybe the better place is the
client-connect-plugin.
Is there a differnce if a add a user to the accounting process in the
auth-user-pass-verif-plugin after the authentication was successful or if
I add the user at the client-connect--plugin.
Can there happen anything between the successful authentication and the
client connect plugin is called? 

For the time the user is authenticated the whole OpenVpn process waits
on the authentication and no traffic can pass through the VPN? Is that
right? Maybe the auhtentication needs some seconds. So it will be very
important that authentication is timeout in a short time.

Grettings
Ralf 



James Yonan wrote:

> 
> 
> On Tue, 17 May 2005, Torge Szczepanek wrote:
> 
>> Am Dienstag, den 17.05.2005, 07:18 -0600 schrieb James Yonan:
>> 
>> > It's more like the opposite:  1.x supported a specific tunx interface
>> > and
>> > port for each client.  2.0 was rewritten to allow all clients to share
>> > a
>> > single tun/tap interface and TCP/UDP port.  The 2.0 approach tends to
>> > be preferred because it scales better and is easier to manage.
>> 
>> I know this. I am using OpenVPN quite some time now. (And I am quite
>> happy with it! ;-))
>> 
>> You are right. Using just one Port (and one OpenVPN process) for all
>> clients has many advantages over the 1.x behaviour.
>> 
>> The only disadvantage is that one cannot disentangle different users by
>> the device (only useful for tun (aka ptp devices)). The major advantage
>> of this approach is that one can apply queuing disciplines for a user to
>> a network device rather than to use tun0 and specify the users IP
>> address. The queing discipline automatically gets removed, when the user
>> disconnects and the device goes down.
>> Another advantage would be that one can use the device number in Radius
>> Authentication for having a unique NAS-Port.
>> 
>> Is there an easy way to have a single OpenVPN process, running on just
>> one port for multiple clients and assign each client a seperate
>> tun-Device? Or would that patch be very long?
> 
> I think the patch could be done, but it would have some disadvantages such
> as (a) you would need to run OpenVPN as root (without dropping privileges)
> because the daemon would need to dynamically open and close tun/tap
> devices, (b) you have all the scalability problems of dealing with a large
> number of network interfaces -- for example, on Windows, it's not even
> practical to handle more than a relatively small number of TAP-Win32
> adapters, and they can't easily be created and destroyed programmatically.
> 
> James
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click



