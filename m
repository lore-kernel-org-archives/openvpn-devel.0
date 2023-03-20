Message-ID: <add6c1ed-f469-4a95-733b-26bf7b122701@...1227...>
Date: Mon, 20 Mar 2023 18:02:14 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230214135658.1034787-1-arne@...1227...>
 <Y+uUSNTTULTEElt2@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Y+uUSNTTULTEElt2@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add missing check for nl_socket_alloc
 failure
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

Am 14.02.23 um 15:01 schrieb Gert Doering:
> Hi,
> 
> On Tue, Feb 14, 2023 at 02:56:58PM +0100, Arne Schwabe wrote:
>>   resolve_ovpn_netlink_id(int msglevel)
>>   {
>> -    int ret;
>>       struct nl_sock *nl_sock = nl_socket_alloc();
>>   
>> -    ret = genl_connect(nl_sock);
>> +    if (!nl_sock)
>> +    {
>> +        msg(msglevel, "Allocating net link socket failed");
>> +    }
> 
> ... shouldn't we abort in this case, aka, M_FATAL (or "return -errno")?

I don't think so. This function is called from two code paths:

- dco_available: I don't think if detection of dco fails, we should quit 
openvpn completely.

- ovpn_dco_init_netlink: Here we already call it with M_ERR, which is 
   (M_FATAL | M_ERRNO)

Arne


