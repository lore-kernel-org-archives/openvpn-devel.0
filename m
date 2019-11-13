References: <20191113085854.6016-1-tom.ty89@...277...>
 <CAGnHSEnZraNv72SvtfdiipptQ4ESHvOSBn87vJREdh6trCb7ng@...278...>
 <20191113091844.GA40538@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <61c1b837-3f81-6783-5934-8128bb81881b@...2181...>
Date: Wed, 13 Nov 2019 10:24:00 +0100
MIME-Version: 1.0
In-Reply-To: <20191113091844.GA40538@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix server directive for /31 subnet
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Tom Yan <tom.ty89@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 13/11/2019 10:18, Gert Doering wrote:
>> By the way, why does `o->ifconfig_pool_netmask` need to be set even
>> when `nopool` is set?
> 
> Not sure.  This code has been rewritten a number of times over the
> years, so maybe the assignment slipped outside of an if() block...
> 
> Things like this can (and should) all be fixed, but please do not lump 
> them together with a functional change in one big patch.

I agree with Gert here. If you are finding inconsistencies across the
code and want to fix them, please do so in small separate patches
(related fixes can and should obviously go together).

It'll make them easier to be reviewed and merged ;-)

On top of that, a fix might be worth backporting to an older release,
while a functional change would normally just go to master.

Thanks a lot for your contribution though!


Cheers,

-- 
Antonio Quartulli

