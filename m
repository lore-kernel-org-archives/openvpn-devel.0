Message-ID: <2e7bdb34-a42d-af88-ba35-cdd9e908c641@...2181...>
Date: Wed, 29 Dec 2021 14:49:15 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20211207121137.3221-1-a@...2181...>
 <20211207121137.3221-9-a@...2181...> <Ycxj+H3RexOHj6Oe@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <Ycxj+H3RexOHj6Oe@...1296...>
Subject: Re: [Openvpn-devel] [RFC 8/8] ovpn-dco: force user to set
 DCO_INCLUDEDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 29/12/2021 14:34, Gert Doering wrote:
> Hi,
> 
> On Tue, Dec 07, 2021 at 01:11:37PM +0100, Antonio Quartulli wrote:
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>   configure.ac | 32 ++++++++++----------------------
>>   1 file changed, 10 insertions(+), 22 deletions(-)
> 
> I think this should be squashed into the first patch, that adds DCO
> support to configure.ac in the first place.
> 

Yeah, this is done already.

> Plus, I wonder how we should do this in the first place - if we want
> widespread DCO adoption, maybe we should include the necessary header
> file into the openvpn community tree, and always compile "with DCO"
> on Linux (if libnl is available)?
> 
> Having to fiddle with an extra library dependency *and* "you need this
> header file which is found elsewhere" feels extra clumsy...
> 
> Alternatively, maybe linuxdco should just install the header file when
> installing the kernel module?  How's this typically done for other
> kernel modules that expose an API that needs a header file?
> 

Normally the required header is just shipped with the program itself 
(i.e. check the 'iw' program which comes with its own copy of 'nl80211.h').

Being this API forward compatible, it won't hurt if our header is 
slightly out-of-date.

Ideally, when DCO will be upstream, the header will be installed 
automatically along with other kernel headers. But we still can't assume 
they are installed, hence it's just easier to ship the header with the 
OpenVPN source code.

I'd just do that at the end.

Regards,


-- 
Antonio Quartulli

