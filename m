References: <20200930131317.1299-1-arne@...1227...>
 <20200930131317.1299-11-arne@...1227...>
 <43dc2d46-04a7-0d23-e3bc-587992d5020d@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <78b2c2dd-0d40-dbce-c6ce-e243b1a36938@...1227...>
Date: Mon, 25 Jan 2021 12:52:14 +0100
MIME-Version: 1.0
In-Reply-To: <43dc2d46-04a7-0d23-e3bc-587992d5020d@...2080...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 09/11] Implement deferred auth for
 scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn@...2080...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> +        int script_ret = openvpn_run_script(&argv, session->opt->es,
>> S_EXITCODE,
>> +                                            "--auth-user-pass-verify");
> 
> Perhaps move the retval declaration down here, as we're touching it
> anyhow?  This switch() is the first place we use it, unless I'm
> overlooking something.

You are overlooking the 'goto done' code path for error handling.


> 
>> @@ -1499,7 +1534,11 @@ verify_user_pass(struct user_pass *up, struct
>> tls_multi *multi,
>>   #ifdef PLUGIN_DEF_AUTH
>>            || s1 == OPENVPN_PLUGIN_FUNC_DEFERRED
>>   #endif
>> -         ) && s2
>> +         ) &&
>> +        ((s2 == OPENVPN_PLUGIN_FUNC_SUCCESS)
>> +#ifdef ENABLE_DEF_AUTH
>> +         || s2 ==  OPENVPN_PLUGIN_FUNC_DEFERRED)
>> +#endif
>>   #ifdef MANAGEMENT_DEF_AUTH
>>           && man_def_auth != KMDA_ERROR
>>   #endif
> 
> Yikes!  This if() statement is unreadable.  Since you are doing changes
> here, could we improve this whole logic.  Perhaps using a helper macro
> like this (incorrect code-style, for e-mail readability)
>

This is already the improved version after the connect patches cleaned
it up a bit :P

I really don't like hiding condition behind macros just make them
shorter, I will propose a variant that extracts parts of the condition
into individual booleans.

Arne

