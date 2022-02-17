Message-ID: <0ef0e09d-39e2-194f-2527-486154be7ade@...2181...>
Date: Thu, 17 Feb 2022 10:25:03 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <7F7F60E5-66F9-4758-9F13-F54A5626D434@...1376...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <7F7F60E5-66F9-4758-9F13-F54A5626D434@...1376...>
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
To: Kristof Provost <kp@...1376...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 17/02/2022 09:33, Kristof Provost wrote:
> Hi,
> 
> I’m working on adding OpenVPN DCO support on FreeBSD (primarily for use in pfSense).

This is very nice!

> 
> I have a few questions, mostly around what’s planned for DCO in OpenVPN 2. I’m currently working based on https://github.com/schwabe/openvpn.git but intend to rebase to https://github.com/OpenVPN/openvpn/tree/dco

The repo under schwabe's space was the original prototype, but it has 
been changed and restyled quite a bit, therefore I'd suggest to wotk 
with the dco branch under openvpn's space.

> 
> It’s not clear to me what’s planned for DCO support in OpenVPN 2. Is the dco branch going to be merged into master for 2.6, or is it expected to live on as a separate branch? If it’s the former, what’s the expected timing for this?

It is expected to be merged into master in the coming weeks and be 
released OpenVPN 2.6.
We are a bit late, but aiming at having all 2.6 pieces merged next month 
(with DCO merged as well).

> 
> A secondary question is how you’d prefer to receive patches, once I get things working. E-mail to this list, or a published git tree or ..  ?

(git-send-)Emails to the list is our favourite approach for broader peer 
review.
However, early feedback can also be asked by means of a branch/PR on 
GitHub or similar.

Best Regards,

-- 
Antonio Quartulli

