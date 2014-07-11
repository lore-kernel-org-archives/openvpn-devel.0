Message-ID: <53BFA9A0.3020605@...1147...>
Date: Fri, 11 Jul 2014 11:08:48 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <53BF9998.5020906@...1921...> <53BFA5AA.4070305@...1147...>
	<53BFA759.7060307@...1227...>
In-Reply-To: <53BFA759.7060307@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server
 configuration file
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Arne,

Arne Schwabe wrote:
> Am 11.07.14 10:51, schrieb Jan Just Keijser:
>> On 11/07/14 10:00, Philipp Hagemeister wrote:
>>> On modern systems, topology subnet should always be set, but it's
>>> missing in the configuration file.
>>> Add it with a short explanation.
>>>       
>> NACK
>> There are a few annoying issues with
>>   topology subnet
>> esp when using server side things like
>>   route <remote subnet> <mask>
>>
>> that will *fail* with 'topology subnet' ; until this is fixed this 
>> should NOT be considered the default.
>
> I am confused here, route <remote subnet> <mask> would expand to
>
> route <remote subnet> <mask> remote_gw in p2p, net30 and subnet 
> toplogy. And that should work in all topology modes. What am I missing 
> here?
>

this is a long standing bug, check out the recent thread on the 
openvpn-users mailing list
  Re: [Openvpn-users] ping tests mostly work.  all OK,    except 
Server->Client private IP.  *almost* there!

On Mon, Jul 07, 2014 at 11:41:31AM -0700, pg0706@...1922... wrote:

> > Switching back to `verb 3`, @Server log on server START
> > 
> > (not SUPPOSED to be wrapping, at least it doesn't in the web editor --
> > just in case: http://pastebin.com/KmChijWX )
>   

"Wrapped like hell".  Is there no way to do attachments in the web thingie?

Anyway:


> > there's a suspect problem
> > 
> > 	Mon Jul  7 10:52:42 2014 OpenVPN ROUTE: OpenVPN needs a gateway
> > 	parameter for a --route option and no default was specified by
> > 	either --route-gateway or --ifconfig options
> > 	Mon Jul  7 10:52:42 2014 OpenVPN ROUTE: failed to parse/resolve
> > 	route for host/network: 192.168.1.0
> > 
> > which looks like a possible culprit.
>   

... indeed.  This is, uh, stupid code, and I think we already have a trac
ticket for it...


> > If yes, what's missing in OpenVPN config, and where?
>   

--route 192.168.1.0 255.255.255.0 10.0.0.8

("just any IP address that's inside your tun subnet, and not the first").

This is really not *necessary*, but the way the code does tun & tap and
net30 & subnet, it gets confused about things.  Needs fixing, sorry for
that.



so in some cases a server-side statement
  route 192.168.1.0 255.255.255.0
works fine with 'topology net30' but NOT with 'topology subnet'.

This is a long standing bug that needs to be fixed before we can forcefeed everybody 'topology subnet'.

JJK




