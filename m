Message-ID: <56B9C5B0.2010908@...1147...>
Date: Tue, 09 Feb 2016 11:55:44 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <20160208213929.GA20623@...2120...>	<20160209092821.GH24952@...1296...>	<20160209101533.GJ3102@...2121...>
	<20160209104625.GL24952@...1296...>
In-Reply-To: <20160209104625.GL24952@...1296...>
Subject: Re: [Openvpn-devel] route / route-ipv6 can not be used in ccd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Samuel Thibault <samuel.thibault@...1817...>, openvpn-devel@lists.sourceforge.net

Hi,

On 09/02/16 11:46, Gert Doering wrote:
> On Tue, Feb 09, 2016 at 11:15:33AM +0100, Samuel Thibault wrote:
>> Gert Doering, on Tue 09 Feb 2016 10:28:21 +0100, wrote:
>>> On Mon, Feb 08, 2016 at 10:39:29PM +0100, Samuel Thibault wrote:
>>>> Is there a reason for not being allowed to set route / route-ipv6
>>>> options in the ccd?
>>> "Nobody has implemented it yet" - plain and simple...
>> Ok :)
> Could you test and report whether --learn-address does the job for you?
>
> I think this would be a useful result to have in the list archives :-)
>
>
a 'learn-address' script is an entirely different beast than a 
'client-connect' script: you cannot write out new openvpn directives in 
a 'learn-address' script. In both a 'client-connect' script (not a CCD 
file) and in a 'learn-address' script you can add routes to the system 
routing table provided that you're not running with "user nobody" - it's 
just that you cannot use the "normal" openvpn stuff for this.

JJK



