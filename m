References: <cea658fa-201f-59d3-d66b-93e35f4f2ee2@...515...>
 <DM5PR2101MB11120F4EE0B7761BA1273B08B0420@...2412...>
 <CAFHpkQFv5KVDzck1Z-Xtx7a9AZ7ZNvRVbA9yEUc5UR_++2sNRQ@...278...>
 <DM5PR2101MB11126374B900460BE5FE16AEB0420@...2412...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <42840e6c-c133-6b91-afa2-149235a471bf@...515...>
Date: Tue, 3 Jul 2018 21:22:41 +0300
MIME-Version: 1.0
In-Reply-To: <DM5PR2101MB11126374B900460BE5FE16AEB0420@...2412...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Topics for the community meeting (Wed,
 13th June 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jon Kunkee <jkunkee@...2393...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0Lg=?= =?UTF-8?B?0YbQuNC9?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Jon,

Do you know if Kevin (or his manager/team) plans to push his work
upstream (i.e. to us) at some point?

-- 
Samuli Seppänen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


Il 03/07/2018 20:55, Jon Kunkee ha scritto:
> Yes, I am aware of that. Note that it’s not tap-windows6, but openvpn.
> 
>  
> 
> I talked to the primary contributor to that fork, Kevin Kane, a few days
> ago. When I asked if his team had done anything with signing the driver
> or doing the HLK work, he said his team uses tap-windows6 as-shipped,
> complete with signatures. His work is on the usermode daemon’s crypto
> engine, if I understood the commit messages right, so any changes he
> makes aren’t related to the driver.
> 
>  
> 
> *From:* Илья Шипицин <chipitsine@...277...>
> *Sent:* Tuesday, July 3, 2018 10:50 AM
> *To:* Jon Kunkee <jkunkee@...2393...>
> *Cc:* Samuli Seppänen <samuli@...515...>; openvpn-devel
> <openvpn-devel@lists.sourceforge.net>
> *Subject:* Re: [Openvpn-devel] Topics for the community meeting (Wed,
> 13th June 2018)
> 
>  
> 
> Hello, Jon.
> 
>  
> 
> do you know this activity https://github.com/Microsoft/openvpn/
> <https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FMicrosoft%2Fopenvpn%2F&data=02%7C01%7Cjkunkee%40microsoft.com%7Cd379e0c4e8c949d3d5f408d5e10d61e6%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636662369998711232&sdata=%2FrYPhxiAOCTYikpq3uIV1X3VUTR%2Fn2bz5G%2Fu9TA11vI%3D&reserved=0>
> ?
> 
> there are interesting things
> 
>  
> 
> вт, 3 июл. 2018 г. в 22:43, Jon Kunkee via Openvpn-devel
> <openvpn-devel@lists.sourceforge.net
> <mailto:openvpn-devel@lists.sourceforge.net>>:
> 
>     Hi,
> 
>     2. Tap-windows6 patches, building and testing
> 
>     In order to get the tap-windows6 driver signed properly for Windows
>     Server 2016, it needs to pass the Windows Hardware Certification
>     Program subset of the Windows Hardware Logo Kit (HLK) tests. Samuli
>     has the tests running in EC2, but there are some failures.
> 
>     Some of the failures are basically paperwork, like the Static
>     Verification logs test. Some reflect needed tweaks in the
>     environment, like the Running on Server Core test. Others reflect
>     possible code bugs, and since I have significant experience doing
>     Windows kernel debugging I'm investigating those.
> 
>     I spent yesterday setting up a local HLK-based test environment with
>     kernel debugging. Today I'm trying to get two OpenVPN clients to be
>     able to talk to each other over a VPN so I can start reproducing and
>     investigating the failures. (I will be sending a mail to
>     openvpn-users asking for help since it would be quite noisy to
>     explain  on IRC.)
> 
>     Cheers,
>     Jon Kunkee
>     Software Developer
>     Microsoft
> 
>     -----Original Message-----
>     From: Samuli Seppänen <samuli@...515... <mailto:samuli@...515...>>
>     Sent: Tuesday, July 3, 2018 10:30 AM
>     To: openvpn-devel@lists.sourceforge.net
>     <mailto:openvpn-devel@lists.sourceforge.net>
>     Subject: [Openvpn-devel] Topics for the community meeting (Wed, 13th
>     June 2018)
> 
>     Hi,
> 
>     We're going to have an IRC meeting starting at 11:30 CET
>     (9:30 UTC) on #openvpn-meeting <at> irc.freenode.net
>     <https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Firc.freenode.net&data=02%7C01%7Cjkunkee%40microsoft.com%7Cd379e0c4e8c949d3d5f408d5e10d61e6%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636662369998721242&sdata=LnnttQ15YIIZw4RlJayIaohhI31So32ha0s7WFp1HnA%3D&reserved=0>.
>     You do not have to be logged in to Freenode to join the channel.
> 
>     Current topic list along with basic information is here:
> 
>     <https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcommunity.openvpn.net%2Fopenvpn%2Fwiki%2FTopics-2018-06-13&amp;data=02%7C01%7Cjkunkee%40microsoft.com%7C2ff5949944a34864919b08d5e10aa0b2%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636662358125323471&amp;sdata=E2tnMk95DPL%2BFpUNM8td0lQd0PTMmfZ8ZAXUsGBES%2FA%3D&amp;reserved=0
>     <https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcommunity.openvpn.net%2Fopenvpn%2Fwiki%2FTopics-2018-06-13&data=02%7C01%7Cjkunkee%40microsoft.com%7Cd379e0c4e8c949d3d5f408d5e10d61e6%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636662369998721242&sdata=GpumX24oaDchDyBWaT%2FfX%2BNUYrBdVqNO3xWy3C44IGc%3D&reserved=0>>
> 
>     If you have any other things you'd like to bring up, respond to this
>     mail, send me mail privately or add them to the list yourself.
> 
>     In case you can't attend the meeting, please feel free to make
>     comments on the topics by responding to this email or to the summary
>     email sent after the meeting. Whenever possible, we'll also respond
>     to existing, related email threads.
> 
>     --
>     Samuli Seppänen
>     Community Manager
>     OpenVPN Technologies, Inc
> 
>     irc freenode net: mattock
> 
> 
> 
> 
>     ------------------------------------------------------------------------------
>     Check out the vibrant tech community on one of the world's most
>     engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>     <https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fsdm.link%2Fslashdot&data=02%7C01%7Cjkunkee%40microsoft.com%7Cd379e0c4e8c949d3d5f408d5e10d61e6%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636662369998731251&sdata=fGrHkwJMZ8ML170y94azaNJ1udr1q02JJdjyQkWyt5Y%3D&reserved=0>
>     _______________________________________________
>     Openvpn-devel mailing list
>     Openvpn-devel@lists.sourceforge.net
>     <mailto:Openvpn-devel@lists.sourceforge.net>
>     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>     <https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.sourceforge.net%2Flists%2Flistinfo%2Fopenvpn-devel&data=02%7C01%7Cjkunkee%40microsoft.com%7Cd379e0c4e8c949d3d5f408d5e10d61e6%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636662369998731251&sdata=exmdKCDh6gLvOrNx%2FuYoJi3kkrYsTPrPqU6wntYuhKQ%3D&reserved=0>
> 


