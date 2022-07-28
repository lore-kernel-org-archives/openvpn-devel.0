Message-ID: <472172bb-efba-eafc-3e78-51c112bcd722@...1227...>
Date: Thu, 28 Jul 2022 15:47:53 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220625234150.3398864-1-arne@...1227...>
 <YuGKwNinYLarY5v/@greenie.muc.de>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <YuGKwNinYLarY5v/@greenie.muc.de>
Subject: Re: [Openvpn-devel] [PATCH v3 1/5] Extract update_session_cipher
 into standalone function
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

Am 27.07.22 um 20:58 schrieb Gert Doering:
> Hi,
> 
> On Sun, Jun 26, 2022 at 01:41:46AM +0200, Arne Schwabe wrote:
>> +
>> +/**
>> + * Checks if the cipher is allowed and updates the TLS session cipher with it,
>> + * otherwise returns false
>> + */
>> +bool
>> +update_session_cipher(struct tls_session *session, struct options *options);
>> +
> 
> Is that comment correct?  I can't find any "updating" here, only "checking".
> 
> What am I overlooking?
>

It sets options->cipher sometimes but the name is misleading. I will 
rename to check_session_cipher

Arne

