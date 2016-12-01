References: <1480545687-19365-1-git-send-email-davids@...515...>
	<a2f41141-898c-d317-0481-3ce6ce6a9082@...1227...>
	<20161201123726.GL78624@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <04a27ea3-d3a7-7e69-8098-cdfc7eb99c6e@...1227...>
Date: Thu, 1 Dec 2016 15:33:48 +0100
MIME-Version: 1.0
In-Reply-To: <20161201123726.GL78624@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
 --ifconfig-push have argument mismatch with --topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>



Am 01.12.16 um 13:37 schrieb Gert Doering:
> Hi,
>
> On Thu, Dec 01, 2016 at 01:31:31PM +0100, Arne Schwabe wrote:
>> Am 30.11.16 um 23:41 schrieb David Sommerseth:
>>> This adds a warning to the log file if --topology is configured to use
>>> subnet or net30 and the 'subnet mask' argument of an --ifconfig-push option
>>> is not an subnet mask.  The check done is to ensure the first octet is 0xff (255)
>> But way you actually want to test is
>>
>> if topology == subnet or net30:
>>    if gateway not in net(ip, mask):
>>       print ("Your gw and ip and netmask disagree!)
>>
>> right? And isn't there code that gets executed for the client side that
>> can be disabled by ifconfig-nowarn. Can we reuse that code?
> That is certainly something we should test as well, but the particular
> case I had in mind was
>
>  - someone uses --topology p2p
>  - they have ccd/ files with "ifconfig-push 10.4.0.14 10.4.0.13"
>    (for some clients that need to get a static address)
>  - they change their server.conf to --topology subnet
>  - everything works for "dynamic clients", but the static client now
>    receives "10.4.0.13" and interprets it as a "netmask", which will
>    cause the most interesting things, depending on platform code
>
> so the idea was to help this case by looking at only the "netmask" thing,
> and see if it makes sense (simplified sense: starts with 255.) - and if
> not, log this on the server side right when reading the ccd/ file so
> the admin in question can see "oh, I overlooked *that* special client".
>
> (Since that happened to a friend of mine based on my advice, I know that
> this is not a purely theoretical possibility :-) )
>

You are still very likely to catch this case If you check if in
net30/subnet the netmask is indead valid (e.g. CIDR)

Arne

