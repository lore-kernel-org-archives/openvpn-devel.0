References: <20200813072923.24385-1-eric@...1918...>
 <1fb10dd1-8ddf-c467-21a5-a93e21e6a8ac@...1227...>
From: Eric Thorpe <eric@...1918...>
Message-ID: <0a634481-cf3b-de2f-5e34-8f5c5ef16fdc@...1918...>
Date: Thu, 13 Aug 2020 18:36:56 +1000
MIME-Version: 1.0
In-Reply-To: <1fb10dd1-8ddf-c467-21a5-a93e21e6a8ac@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Send auth-fail messages to clients
 on renegotiation failures via auth-token or user-pass expiry
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi Arne,

The issue is your state is not accessible from where that boolean needs 
to be used unless I am missing something? Please advise if I'm mistaken 
or of another route.

Eric

---
Eric Thorpe
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...

On 13/08/2020 6:30 pm, Arne Schwabe wrote:
>>   /*
>>    * Send restart message from server to client.
>>    */
>> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
>> index 96897e48..b5cc9dc9 100644
>> --- a/src/openvpn/ssl_common.h
>> +++ b/src/openvpn/ssl_common.h
>> @@ -576,6 +576,7 @@ struct tls_multi
>>   
>>       char *remote_ciphername;    /**< cipher specified in peer's config file */
>>   
>> +    bool connection_established; /** Notifies future auth calls this is a reneg */
>>       /*
>>        * Our session objects.
>>        */
>>
> NAK from my side. Adding another variable to state machine for just this
> feature that duplicates already existing states is something I really
> want to avoid. This might look and work fine for this patch but at the
> end you end up with a plenthora of mini states and unclear
> interdependency. I worked hard in the connect-client patches to remove
> duplication of these states and are not eager to reduce them, especially
> not "connection_established" which duplicates the name of
> link_socket->connection_established that has a completely different meaning.
>
> Arne
>

