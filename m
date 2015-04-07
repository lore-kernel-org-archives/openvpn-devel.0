Message-ID: <5524059A.3020705@...68...>
Date: Tue, 07 Apr 2015 18:28:10 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <5519B242.2020009@...1856...>	<20150330210636.GF21893@...1296...>	<551AA3A2.5000300@...1800...>	<20150331142352.GI21893@...1296...>	<551AAF8F.7010502@...1800...>
	<20150331171938.GK21893@...1296...>
In-Reply-To: <20150331171938.GK21893@...1296...>
Subject: Re: [Openvpn-devel] [Openvpn-users] FreeBSD+cryptodev testers wanted
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
To: openvpn-devel@lists.sourceforge.net

Am 31.03.2015 um 19:19 schrieb Gert Doering:
> Hi,
> 
> On Tue, Mar 31, 2015 at 10:30:39AM -0400, Mike Tancsa wrote:
>> On 3/31/2015 10:23 AM, Gert Doering wrote:
>>> On Tue, Mar 31, 2015 at 09:39:46AM -0400, Mike Tancsa wrote:
>>>> I am not able to reproduce this.
>>>
>>> You need to use --daemon to make openvpn fork().  Otherwise, it will
>>> "just work", but after forking, the cryptodev file descriptor is no
>>> longer valid -> boom.  Steffan's patch should fix that.
>>
>> Hi,
>> 	Is having in the config
>>
>> daemon openvpn-hq
>>
>> not the same as --daemon from the arguments ?
> 
> It is, sorry, did not look closely enough.
> 
> The fact that this just works for you is... surprising.  So maybe it's a 
> different FreeBSD version, or different openssl, or whatnot...  unfortunately,
> the original bug report
> 
>   https://redmine.pfsense.org/issues/3966
> 
> does not list FreeBSD version or OpenSSL version, only pfsense version
> (2.2) - which does seem to be FreeBSD 10.1-p4, though...

So the feedback of the original reporter arrived,
<https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=195004#c7>

and Steffan Karger also chimed in there, and there's a new patch for
testing up on
<https://community.openvpn.net/openvpn/raw-attachment/ticket/480/150406-Reload-OpenSSL-engines-after-forking-v2.patch>
in OpenVPN's ticket #480.

