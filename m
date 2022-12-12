Message-ID: <3406b66c-81a3-9db5-1e65-7038ba81da14@...1227...>
Date: Mon, 12 Dec 2022 13:23:35 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221126162648.150678-1-maximilian.fillinger@...2507...>
 <20221126162648.150678-2-maximilian.fillinger@...2507...>
 <Y5cYjSu0D5P4QMIZ@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Y5cYjSu0D5P4QMIZ@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix message for too long
 tls-crypt-v2 metadata
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
To: Gert Doering <gert@...1296...>, Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

Am 12.12.22 um 13:03 schrieb Gert Doering:
> Hi,
> 
> On Sat, Nov 26, 2022 at 05:26:48PM +0100, Max Fillinger wrote:
>> The current code only checks if the base64-encoded metadata is at most
>> 980 characters. However, that can encode up to 735 bytes of data, while
>> only up to 733 bytes are allowed. When passing 734 or 735 bytes, openvpn
>> prints a misleading error message saying that the base64 cannot be
>> decoded.
>>
>> This patch checks the decoded length to show an accurate error message.
> 
> This patch looks overly complex to me for "change 735 to 733" - could
> you (or Arne) explain the change a bit better?
> 
> (I see that the patch has an ACK, so this is not a showstopper, just
> be being confused)

Problem is that base64 does padding. So e.g.

a => YQ==
ab => YWI=
abc => YWJj

So checking the length of the base64 gives you only something that is 
rounded up to the next 3 bytes (base64 encodes 3 bytes to 4 bytes).

So if you have a limit like 733, you need to actually decode the base64 
to check if it is short enough. The alternative would be to only allow 
732 bytes, so we could check the base64 length again or use 735 bytes 
and use a maximum tls-crypt wrapped key size of 1026 bytes (which sounds 
a bit weird)

Arne


