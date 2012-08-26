Message-ID: <503A8633.5090308@...1114...>
Date: Sun, 26 Aug 2012 22:25:23 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1345727389.42365.YahooMailNeo@...1744...>
	<50364E1E.7000109@...1114...>
	<1345828643.55420.YahooMailNeo@...1750...>
In-Reply-To: <1345828643.55420.YahooMailNeo@...1750...>
Subject: Re: [Openvpn-devel] patch for 2.2.2 to include --script-dir
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
To: Amm Vpn <ammdispose-vpn@...109...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


NAK again.  This still does not belong in the core OpenVPN, IMO.  If you want 
to have this feature, you need to enforce this in your front-end where you 
sanitise the config *before* OpenVPN is started.  Which was my conclusion from 
the last time as well.

Having this as a runtime configuration does not add any restriction in 
reality.  You must presume the user have the possibility to tweak the config 
somehow.  And the user is fully capable of discovering a way how to execute 
your configs directly, skipping the --scripts-dir.  So you cannot trust the 
client config.  So the front-end must protect the OpenVPN executable so it is 
the only one who can start an OpenVPN connection.

Another scenario, if your front-end does not protect the OpenVPN binary, a 
user can also download an earlier OpenVPN and circumvent this behaviour with 
your own front-end.  So the OpenVPN executable must be protected no matter 
what, and your front-end is the only thing which the user should be able to 
use.  And then this front-end is the only one which truly can protect you, by 
sanitising the config *before* the OpenVPN executable is started - where your 
front-end is the only binary which should have access to the OpenVPN binary.

So bottom line is:  This approach does not make sense to apply to the OpenVPN 
executable.  You need to ensure the configs are trustful with a completely 
different approach.


kind regards,

David Sommerseth


On 08/24/2012 07:17 PM, Amm Vpn wrote:
> Hello all,
>
> I am attaching a new patch which takes care of few things discussed yesterday.
>
> Summary of patch:
> 1) Add new option --script-dir which restricts any user defined script to run only from specific directory
>
> 2) Backward compatible. If script-dir is not specified then it allows script from any directory.
>
>
> 3) Adds compile time configure option --with-script-dir=/some/path/
> If this option is used then script-dir becomes hard-coded and CAN NOT be changed from config file or command line.
>
>
> This allows flexibility to anyone (people like me) who wants to compile the code on their own making sure that script-dir can not be changed at all.
>
>
> 4) If it is not enabled at compile time then first script-dir has preference.
> a) if script-dir is specified on command line, it is given the priority
>
> b) if script-dir is specified twice (either in same config file or included config file) then only 1st occurrence is accepted and warning is logged for the rest of the occurrences.
>
>
> This allows, easy binary distribution (by not hard-coding the script-dir) and then user can decide on their own script-dir.
>
> Root user can then call OpenVPN with script-dir either on command line or inside parent config file. Parent config file can then call child config (config child.conf). And then "freely" give access to child.conf to other lower admins without worrying about them running any random script.
>
> Even if lower admins specify script-dir, it will be ignored.
>
>
>
> Hope that this patch now satisfy everyone in devel group and makes much more sense to be implemented.
>
> Security in my opinion should be prime concern especially when we know that there is a way to run any random script. And hence atleast for such insecure options, sanity checks has to be there in program itself instead of trusting the frontend.
>
>
>
>
> Patch is clean and simple and just about 25 lines of real code addition.
>
> Patch eliminates danger of openvpn running any script blindly.
>
> So please review it and consider to merge in source tree.
>
> Thank you
>
> AMM.
>
>
>
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


