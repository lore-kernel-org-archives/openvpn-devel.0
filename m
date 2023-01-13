Message-ID: <8e424ea3-ad81-0d34-d8ee-958113133e11@...2181...>
Date: Fri, 13 Jan 2023 09:54:39 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230111235052.24855-1-a@...2181...>
 <Y8EJzGoG6yEJaGmU@...1296...>
 <A4236869-0DD6-48AF-8CD0-3758E2FA4C70@...1376...>
 <22a3c27a-0404-ac58-4ae5-5f8b46ffb75c@...2181...>
 <Y8EZ0x9H7spmBEiJ@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <Y8EZ0x9H7spmBEiJ@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] dco: print proper message in case of
 transport disconnection
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
To: Kristof Provost <kp@...1249...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 13/01/2023 09:44, Gert Doering wrote:
> Hi,
> 
> On Fri, Jan 13, 2023 at 09:37:49AM +0100, Antonio Quartulli wrote:
>> On 13/01/2023 09:32, Kristof Provost wrote:
>>> I???m not sure how we???d cope with supporting building on older releases
>>> though. Not a worry just yet, because FreeBSD main is the only version
>>> with DCO support in it, but it???ll be a problem sooner or later.
>>
>> OpenVPN ships its own "recent"| version of the if_ovpn.h file, no?
>> So as long as the file contains all the enums it will compile just fine.
> 
> Yes, these defines are mirrored in our dco_freebsd.h - so I could just
> add it there, but we need to be careful that we never have conflicting
> enums in OpenVPN dco_freebsd.h vs. kernel if_ovpn.h.
> 
> Or, as Antonio explained to me how it works on linux uapi headers "enums
> are only ever appended to, never ever reordered, nothing is ever deleted".
> 
> I'm open for anything that lets me ship rc2+patch as FreeBSD port :-)

As I was saying on IRC, IMHO we took this path of using the same names 
for enums on linux and freebsd because it was convenient.
But here we are hitting a shortcoming of this approach.

If we assume that enums are not supposed to be the same across platforms 
(the latter may have different logic, or whatever), we could implement a 
conversion function that takes a platform specific enum as input and 
returns a userspace specific enum.

Platform independent code will then always only deal with userspace 
enums and won't care about what is truly written in the 
platform-specific headers.

This way we draw a clear boundary between "what kernel on platform X 
supports" and "what userspace openvpn can deal with". And situations 
like this should never happen again.

This conversion function would be implemented in the platform specific 
code (i.e. dco_linux.c)

Does it make sense?


-- 
Antonio Quartulli

