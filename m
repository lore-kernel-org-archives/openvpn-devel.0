References: <20210421134348.1950392-1-arne@...1227...>
 <20210421134348.1950392-5-arne@...1227...>
 <20210421203205.GF976@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1478f050-1095-8183-5e01-3500c44cfd16@...1227...>
Date: Thu, 22 Apr 2021 00:19:01 +0200
MIME-Version: 1.0
In-Reply-To: <20210421203205.GF976@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 5/7] Remove support for blocking
 connect()
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 21.04.21 um 22:32 schrieb Gert Doering:
> Hi,
> 
> On Wed, Apr 21, 2021 at 03:43:46PM +0200, Arne Schwabe wrote:
>> It is hard to imagine that we still have any supported OS that does
>> not support non-blocking connect while still supporting non-blocking
>> sockets in general.
> [..]
>> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
>> index f29c63c73..a964ffd35 100644
>> --- a/src/openvpn/syshead.h
>> +++ b/src/openvpn/syshead.h
>> @@ -155,10 +155,6 @@
>>  #include <poll.h>
>>  #endif
>>  
>> -#ifdef HAVE_SYS_EPOLL_H
>> -#include <sys/epoll.h>
>> -#endif
>> -
> 
> Is that intentional?

Managed to slip into wrong patch. I accidentally commited it with 5/7
instead of 7/7.

Arne

