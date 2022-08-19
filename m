Message-ID: <dc9cefd6-3785-4344-a7ef-7949f98cde6f@...1227...>
Date: Fri, 19 Aug 2022 22:31:54 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220811171120.59361-1-maximilian.fillinger@...2507...>
 <2ec56ba7-4628-eafc-1ccd-bc8b5c2a164d@...1227...>
 <95a456920c2e4ca1b5400850dd210ea6@...2507...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <95a456920c2e4ca1b5400850dd210ea6@...2507...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Update openssl_compat.h for
 newer LibreSSL
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
To: Maximilian Fillinger <maximilian.fillinger@...2507...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> The patch basically removes the !defined(ENABLE_CRYPTO_WOLFSSL) from
>> this part of the ifdef and that breaks wolfSSL. While I don't think we
>> should much effort into wolfSSL, we should also not break it on purpose.
>>
>> Arne
> 
> You told me to ignore it in IRC. But sure, I can make a v3.

Ignore but not break on purpose :)

Arne

