Message-ID: <f9325adf-7dc9-df6a-0cf7-07004c219dd7@...2181...>
Date: Sat, 17 Sep 2022 14:43:08 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220914185937.31423-1-a@...2181...>
 <YyW/n82ircKgjsFR@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YyW/n82ircKgjsFR@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] auth-user-pass: add support for
 inline credentials
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

Hi,

On 17/09/2022 14:37, Gert Doering wrote:
> Hi,
> 
> On Wed, Sep 14, 2022 at 08:59:36PM +0200, Antonio Quartulli wrote:
>>   #ifdef ENABLE_MANAGEMENT
>> -        auth_user_pass_setup(c->options.auth_user_pass_file, &c->options.sc_info);
>> +        auth_user_pass_setup(c->options.auth_user_pass_file,
>> +                             c->options.auth_user_pass_file,
>> +                             &c->options.sc_info);
>>   #else
>> -        auth_user_pass_setup(c->options.auth_user_pass_file, NULL);
>> +        auth_user_pass_setup(c->options.auth_user_pass_file,
>> +                             c->options.auth_user_pass_file, NULL);
>>   #endif
> 
> This does not look like it would work...  the second "..._pass_file"
> arguments wants to be "..._inline", no?

ehm, right!

Cheers,

> 
> 
>> @@ -2165,9 +2174,12 @@ key_method_2_write(struct buffer *buf, struct tls_multi *multi, struct tls_sessi
>>       if (auth_user_pass_enabled || (auth_token.token_defined && auth_token.defined))
>>       {
>>   #ifdef ENABLE_MANAGEMENT
>> -        auth_user_pass_setup(session->opt->auth_user_pass_file, session->opt->sci);
>> +        auth_user_pass_setup(session->opt->auth_user_pass_file,
>> +                             session->opt->auth_user_pass_file_inline,
>> +                             session->opt->sci);
>>   #else
>> -        auth_user_pass_setup(session->opt->auth_user_pass_file, NULL);
>> +        auth_user_pass_setup(session->opt->auth_user_pass_file,
>> +                             session->opt->auth_user_pass_file_inline, NULL);
>>   #endif
> 
> This one is better :-)
> 
> This aside, the change is surprisingly simple.  Seems proxy-user-pass did
> the grunt work for us...
> 
> gert

-- 
Antonio Quartulli

