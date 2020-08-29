References: <20200814080619.2108-1-arne@...1227...>
 <CAAWBBYM2+4FqN-HyV9W19fJfAHKd9K4KHhnQFz2_5f3tzdvMFA@...278...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <56fd8e74-c44e-f0d7-1b43-0f8c6c141af3@...277...>
Date: Sat, 29 Aug 2020 20:28:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAAWBBYM2+4FqN-HyV9W19fJfAHKd9K4KHhnQFz2_5f3tzdvMFA@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
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
To: openvpn-devel@lists.sourceforge.net

Hi,

sorry to interrupt, Rafael could you please confirm if you find this 
document to be correct/incorrect for your use case:
https://community.openvpn.net/openvpn/wiki/CipherNegotiation

Also note, this patch has been merged so make sure your binary has been 
compiled with it.


On 29/08/2020 20:19, Rafael Gava wrote:
> Hi Arne,
> 
> This thread has a could days but I'm testing the version 2.5-beta2 and I'm
> getting the following error:
> 
> 2020-08-29 16:02:53 us=643016 OPTIONS ERROR: failed to negotiate cipher
> with server.  Add the server's cipher ('BF-CBC') to --data-ciphers
> (currently 'BF-CBC') if you want to connect to this server.
> 
> I have added the data-ciphers and also the data-ciphers-fallback to the
> client's config file and in all attempts I'm getting the same error message.
> 
> data-ciphers BF-CBC
> data-ciphers-fallback BF-CBC
> 
> I know that you guys are trying to get rid of the BF-CBC but my question
> is, should it still work if we set these parameters in the config file or
> am I missing or doing something wrong? :-)
> 
> BR
> 
> Gava
> 
> 
> 
> 
> On Fri, Aug 14, 2020 at 5:06 AM Arne Schwabe <arne@...1227...> wrote:
> 
>> OpenVPN 2.5 clients do not correctly do a fallback to the server server.
>> This commit fixes that logic and also fixes --data-ciphers-fallback to
>> be used in situations other than no OCC cipher.
>>
>> To reproduce the error use a client with only --data-ciphers set against
>> a server without NCP.
>>
>>          OPTIONS ERROR: failed to negotiate cipher with server.
>>          Add the server's cipher  ('AES-256-CBC') to --data-ciphers
>>          (currently 'AES-256-CBC') if you want to connect to this server.
>>
>> Reported by: Richard Bonhomme <tincanteksup@...277...>
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>   src/openvpn/ssl_ncp.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
>> index f522b8f0..c9ab85ce 100644
>> --- a/src/openvpn/ssl_ncp.c
>> +++ b/src/openvpn/ssl_ncp.c
>> @@ -296,13 +296,14 @@ check_pull_client_ncp(struct context *c, const int
>> found)
>>       }
>>       /* If the server did not push a --cipher, we will switch to the
>>        * remote cipher if it is in our ncp-ciphers list */
>> -    bool useremotecipher = tls_poor_mans_ncp(&c->options,
>> -
>>   c->c2.tls_multi->remote_ciphername);
>> -
>> +    if(tls_poor_mans_ncp(&c->options, c->c2.tls_multi->remote_ciphername))
>> +    {
>> +        return true;
>> +    }
>>
>>       /* We could not figure out the peer's cipher but we have fallback
>>        * enabled */
>> -    if (!useremotecipher && c->options.enable_ncp_fallback)
>> +    if (!c->c2.tls_multi->remote_ciphername &&
>> c->options.enable_ncp_fallback)
>>       {
>>           return true;
>>       }
>> --
>> 2.26.2
>>
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

