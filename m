Message-ID: <423077E2.9090301@...355...>
From: TomWalsh <tomw-junk01@...355...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] RPM build of 2.0-rc16 fails on MandrakeSoft
References: <4220EC61.1000005@...355...> <422BC993.5040206@...355...> <Pine.LNX.4.58.0503070841070.1122@...41...>
In-Reply-To: <Pine.LNX.4.58.0503070841070.1122@...41...>
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
Date: Thu Mar 10 08:38:23 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

James Yonan wrote:
> On Sun, 6 Mar 2005, TomWalsh wrote:
> 
> 
>>As long as we are on the subject of "Requires" in the openvpn.spec file, 
>>shouldn't there also be a:
>>
>>Requires:  bridge-utils >= 0.9.7
> 
> 
> Why is this required?  What if you are not bridging?
> 
> James
> 

Ok, my view on an RPM is that the package is there to provide some level 
of convenience to the end-installer.  All aspects of the package are 
incorporated into the RPM: config, init.d scripts, binaries, additional 
packages, etc.  The bridge utils only comprise 60K of drivespace.

When I first installed the openvpn package, it took me some research to 
learn that I needed the bridge-utils to create a tap / tun device.  The 
first installation of openvpn was from a source package, so I expected 
to have to do some detail work.  I've built a lot from source and have 
learned the value of "README".

Why would an RPM end-user have to do that work to determine that they 
need an additional package to make their VPN work in a bridge setup? 
I'd say that if you want "lean + mean", build from source, if you want a 
dead simple installation then use an RPM. Therefore, include the 
Requires for the  bridge-utils.

Learning the concepts to setup a bridged network is confusing enough 
without running into problems ensuring that you have the additional 
software installed to setup a simple bridge device?

If the additional space is that much more valuable, then you would be 
building from source anyway.


Regards,

TomW


-- 
Tom Walsh - WN3L - Embedded Systems Consultant
email at http://openhardware.net?file=emailcomment.php
any ReplyTo direct email will disappear (blackhole).
----------------------------------------------------


