Message-ID: <4B21A4D8.40507@...41...>
Date: Thu, 10 Dec 2009 18:48:08 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <1256844344.7529.43.camel@...1272...>	<4AFBEE55.5070202@...515...>
	<1258050832.4308.3.camel@...1272...>
	<4AFC56CC.8080307@...1114...>
In-Reply-To: <4AFC56CC.8080307@...1114...>
Subject: Re: [Openvpn-devel] 2.1 rc20 and multiple interfaces problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 12/11/09 19:33, Olaf Fraczyk wrote:
>> Hello,
>>
>> No, I wasn't using --multihome - I didn't know that this option exists
>> and that is necessary. I haven't found it in man page and in
>> documentation on the web page. The only place where I found it (after
>> you let me know about it) was with openvpn --help.
>>
>> Thank you, I'll try it.
>> BTW, why is it not by default?
>>
>> Regards,
>>
>> Olaf
>> On Thu, 2009-11-12 at 04:15 -0700, James Yonan wrote:
>>> Are you using the --multihome option?
> 
> James, this option is not documented in the man pages, AFAICS.  Could
> that be the reason the needed use was not discovered?

I've documented --multihome in the man page.  The change has been 
checked into svn and will be in the next release.

James

