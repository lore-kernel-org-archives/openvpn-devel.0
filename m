From: tincanteksup <tincanteksup@...277...>
References: <1552943809-6367-1-git-send-email-selva.nair@...277...>
 <5a54b7c9-d466-c8c2-e468-42c16c88d1dd@...277...>
 <2bf767b9-8459-c0bf-3914-9afaee3093f8@...2181...>
Message-ID: <f4405d3e-8fc2-8935-6f1e-5b67d94868c4@...277...>
Date: Wed, 20 Mar 2019 18:41:01 +0000
MIME-Version: 1.0
In-Reply-To: <2bf767b9-8459-c0bf-3914-9afaee3093f8@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Improve the documentation for
 --dhcp-option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

bonjour

On 20/03/2019 08:00, Antonio Quartulli wrote:
> Hi,
> 
> On 18/03/2019 22:30, tincanteksup wrote:
>> Hi,
>>
>> this situation has been hanging around for so long is this brief note
>> really enough? Considering that the manual has numerous other URLs why
>> not include this URL here:
>> https://community.openvpn.net/openvpn/wiki/Pushing-DNS-to-clients
>>
>> We already have this:
>> https://community.openvpn.net/openvpn/wiki/SWEET32
>>

Reinserted from my original post:
>> Please consider adding it.


> 
> the problem with URLs is that they become obsolete and we need to
> re-patch the manual in order to update them (or ensure the URL always
> work/redirect to something).
> 
> 
> However, I was thinking that a WARNING in the log when parsing a
> dhcp-option without any script configured (on non-windows platform) may
> also be beneficial.
> 
> Not many people will read it, but at least it will be there to be seen
> at the first attempt of understanding what's wrong.
> 
> What do you think?


The argument against using URLs in the Manual has these facts to refute:
* URLs are already in use in the manual
* I cited another example of using a URL in the manual.
* Some URLS in use in the manual are external to openvpn.net
* Using URLs in online documentation is The standard practice.
* There are even URLs in the Openvpn log files ..

It is easier to maintain linked documentation than it is to have to
patch the source so, given that the link is under the openvpn.net wing,
this seems perfectly reasonable to me.


Adding a warning for this problem in the log file is unsuitable:
* When the situation changes the source will have to be maintained.
* The situation will change.
* It is easier to maintain linked documentation to account for change.
* Log files are for diagnosing problems and should not have any URLs..
(Except for one URL to ${help}.openvpn, a URL which is unlikely to 
change and can therefore be easily maintained by OpenVPN Inc and remove
that burden from the FOSS Openvpn development team)

my2c thanks
tct


> 
> This said, the warning could/should be implemented as a separate patch.
> 
> Regards,
> 

