Message-ID: <d5e2aaa3-d047-3c5e-62c5-e908c2990e88@...1227...>
Date: Thu, 17 Feb 2022 11:04:54 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <7F7F60E5-66F9-4758-9F13-F54A5626D434@...1376...>
 <0ef0e09d-39e2-194f-2527-486154be7ade@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <0ef0e09d-39e2-194f-2527-486154be7ade@...2181...>
Subject: Re: [Openvpn-devel] DCO for FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, Kristof Provost <kp@...1376...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 17.02.22 um 10:25 schrieb Antonio Quartulli:
> Hi,
> 
> On 17/02/2022 09:33, Kristof Provost wrote:
>> Hi,
>>
>> I’m working on adding OpenVPN DCO support on FreeBSD (primarily for 
>> use in pfSense).
> 
> This is very nice!

Cool!

>> A secondary question is how you’d prefer to receive patches, once I 
>> get things working. E-mail to this list, or a published git tree or ..  ?
> 
> (git-send-)Emails to the list is our favourite approach for broader peer 
> review.
> However, early feedback can also be asked by means of a branch/PR on 
> GitHub or similar.
> 
> Best Regards,
> 

Some additional notes:

BSD and GPL2 are not compatible but for the new DCO code and the DCO 
modules we own the full copyright and are willing to relicense it to BSD 
if parts of it make sense to be used in the FreeBSD driver.

I already offered another one who had interest in implement DCO for 
FreeBSD (but never heard of him again) to implement the user space in 
OpenVPN part for a FreeBSD version of DCO.

If you just want to talk to use, we usually hang out in #openvpn-devel 
in libra-chat.

Arne

