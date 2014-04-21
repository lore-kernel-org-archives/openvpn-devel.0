Message-ID: <5354C53E.8020803@...515...>
Date: Mon, 21 Apr 2014 01:14:06 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <1393530007-6225-1-git-send-email-steffan.karger@...1435...>	<53502E71.8070503@...515...>	<53511F74.3010708@...1435...>
	<53528943.3090205@...1435...>
In-Reply-To: <53528943.3090205@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] PolarSSL 1.3
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
To: openvpn-devel@lists.sourceforge.net

On 19/04/2014 08:33, Steffan Karger wrote:
> Hi,
>
> On 04/18/2014 02:49 PM, Steffan Karger wrote:
>> On 04/17/2014 09:41 PM, James Yonan wrote:
>>> I'm not sure I understand the (SIZE_MAX - hashlen) > asn_len part.
>>> Wouldn't this always be true for reasonable values of hashlen and asn_len?
>>
>> This should indeed always be true for reasonable input.
>
> Ouch, James was totally right. This would always be true, but should
> always be *false* for reasonable input; the check has to be the other
> way around. Attached the same two patches, except for that single
> character...
>
> On the positive side: I've added my management-external-key test to my
> vanilla-openvpn tests too, so I should catch regressions more easily now.

ACK for the revised patches (0001-Upgrade-to-PolarSSL-1.3.patch and 
0002-Improve-error-reporting-during-key-cert-loading-with.patch).

James


