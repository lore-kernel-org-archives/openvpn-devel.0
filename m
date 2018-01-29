References: <1516909261-31623-1-git-send-email-selva.nair@...277...>
 <1516909261-31623-2-git-send-email-selva.nair@...277...>
 <20180129082521.GI69387@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <7c09a307-116f-49d3-d16f-404c5714a91c@...1227...>
Date: Mon, 29 Jan 2018 09:32:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180129082521.GI69387@...1296...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH 2/2] Prompt for signature using
 '>PK_SIGN' if the client supports it
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
To: Gert Doering <gert@...1296...>, selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

Am 29.01.18 um 09:25 schrieb Gert Doering:
> Hi,
> 
> On Thu, Jan 25, 2018 at 02:41:01PM -0500, selva.nair@...277... wrote:
>> From: Selva Nair <selva.nair@...277...>
>>
>> - Increase the management version from 1 to 2
>> - If the client announces support for management version > 1
>>   prompt for signature using >PK_SIGN to which the client
>>   responds using 'pk-sig'
>>   Older (current) clients will be continued to be prompted
>>   by '>RSA_SIGN' and can respond using 'rsa-sig'
>> - Remove an unused rsa_sig buffer-list variable
>>
>> This facilitates a transparent transition to PK_SIG and future deprecation
>> of RSA_SIGN
> 
> I'm a bit confused about the sequence of patches here.  Is this one dependent
> on one of the other PK_SIGN related patches?  Or standalone and could be
> applied to master "as is"?
> 

These patches implement just PK_SIGN instead of RSA-SIGN but do not
implement ec cert support. So yes these two patches are applied first
and the EC patch comes third.

Arne

