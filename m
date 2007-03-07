From: "Tom Fanning" <tf-ml@...1002...>
References: <45EE787B.9030706@...41...>
In-Reply-To: <45EE787B.9030706@...41...>
Date: Wed, 7 Mar 2007 09:23:43 -0000
Message-ID: <00e801c7609a$4fb21750$ef1645f0$@com>
MIME-Version: 1.0
Content-Language: en-gb
Subject: Re: [Openvpn-devel] OpenVPN project funding and Windows TAP
	driverlicense
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'James Yonan' <jim@...41...>, openvpn-devel@lists.sourceforge.net

James

I personally support that proposal. It's a necessary evil.

I have another idea for revenue generation too. How's about partnering with
a router OEM to provide a no-fuss soho-broadband router (eg Linksys WRT54G
style box) with an OpenVPN client pre-installed. We for one would be buying
them for our work-at-home staff. So much less fuss than running the
client/GUI on individual boxes, plus that way one can run hardware IP phones
over OpenVPN without crazy routing or a dedicated Linux PC router. 

Yes I'm aware of the various alternative firmwares around for these boxes on
which you can reportedly install/run OpenVPN, but sourcing the correct
models/revisions of hardware and then doing the mod is far too time
consuming and risky. We'd much prefer to just have an off-the-shelf box to
which we can upload the OpenVPN config files and it to "just work", and we'd
pay for it too. The project would get a cut of the revenue.

Tom Fanning


-----Original Message-----
From: openvpn-devel-bounces@lists.sourceforge.net
[mailto:openvpn-devel-bounces@lists.sourceforge.net] On Behalf Of James
Yonan
Sent: 07 March 2007 08:32
To: OpenVPN List; openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] OpenVPN project funding and Windows TAP
driverlicense

As always, it's a challenge to maintain a popular project such as 
OpenVPN on a shoestring, and I'd like to thank everyone who has made a 
contribution thus far.

The Windows TAP driver is becoming more expensive to support, especially 
with the new Vista driver signing requirements.  I plan to jump through 
the hoops so that the Windows TAP driver will be fully signed for Vista, 
however this comes at a recurring cost, and I am considering ways that 
the OpenVPN project can offset these and other costs by increasing its 
sources of revenue.

The Windows TAP driver has always been dual-licensed by OpenVPN 
Solutions LLC, with the GPL license for free usage, and a paid 
commercial license for companies that don't want to be restricted by the 
terms of the GPL, or that want to package the TAP driver in commercial 
software.  One method I'm considering to help increase project revenue, 
but in a way that won't affect the vast majority of OpenVPN users, is to 
change the dual-licensing terms for the 2.1 Windows TAP driver, so that 
the free license would explicitly not allow commercial redistribution.  
This would mean that companies that package the Windows version of 
OpenVPN or the Windows TAP driver into a commercial product or service 
would now need to obtain a paid commercial license.  Keep in mind that 
the terms of the GPL already restrict commercial redistribution of GPL 
and non-GPL code, and most companies that want to do so already must 
obtain a commercial license, however I'm proposing to make the 
delineation between the free and paid licenses more legally precise, and 
centered on whether or not commercial redistribution is occurring.

This is just a proposal at this point, and I would like feedback from 
the community.  Is this a reasonable idea for funding the project?   
Comments appreciated.

James


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel


