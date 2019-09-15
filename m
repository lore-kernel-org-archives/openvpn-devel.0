References: <20190818111811.8853-1-matthias.andree@...68...>
 <20190818111811.8853-2-matthias.andree@...68...>
 <985961be-8e2e-573d-7aa9-95884dcc847a@...1227...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <6733f5b2-1206-b437-27a5-396648e025ab@...68...>
Date: Sun, 15 Sep 2019 11:38:17 +0200
MIME-Version: 1.0
In-Reply-To: <985961be-8e2e-573d-7aa9-95884dcc847a@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Fix regression,
 reinstate LibreSSL support.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne@...1227...>, pizzamig@...1249...

Am 18.08.19 um 14:11 schrieb Arne Schwabe:
> Am 18.08.19 um 13:18 schrieb Matthias Andree:
>> OpenVPN 2.4.6 could be compiled with LibreSSL, 2.4.7 cannot.  This was broken
>> since 9de7fe0a "Add support for tls-ciphersuites for TLS 1.3".
>>
>> This patch avoids using TLS 1.3 directly, be it that OpenSSL was compiled
>> without TLS 1.3 support, or LibreSSL was used.
> Test looks good. I don't like the additonal ifdefs but yeah seem no way
> around them.
>
> The ifdefs don't break OpenSSL. But I have not tested LibreSSL.
>
>
> Acked-By: Arne Schwabe <arne@...1227...>

So, four weeks later, what is the commit status of this change?

I don't yet see it in Git and no relevant messages here.


