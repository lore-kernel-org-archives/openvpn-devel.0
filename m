Message-ID: <53BFFAC3.9060505@...1147...>
Date: Fri, 11 Jul 2014 16:54:59 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <53BF9998.5020906@...1921...> <53BFA5AA.4070305@...1147...>
	<20140711123541.GG1118@...1296...>
In-Reply-To: <20140711123541.GG1118@...1296...>
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

Gert Doering wrote:
> On Fri, Jul 11, 2014 at 10:51:54AM +0200, Jan Just Keijser wrote:
>   
>> On 11/07/14 10:00, Philipp Hagemeister wrote:
>>     
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
>>     
>
> Well, it's on the roadmap, and Arne has already sent a patch.
>
> So, what other issues exist?  This is the only one I'm aware of... 
> (and the recent trac ticket about "topology subnet not working on
> FreeBSD 10" turned out to be local confusion...)
>
>
>   
hmm I thought I had a TRAC ticket on this but I cannot find it anymore...
I recall some  minor annoyances all having to do with needing to 
explictly add a gateway for the server-side routes. I'm 99.9% confident 
that Arne's one-liner will have fixed them.

With those annoyances gone I'd even be in favor of making 'topology 
subnet' the default for the 2.4 release :)

cheers,

JJK





