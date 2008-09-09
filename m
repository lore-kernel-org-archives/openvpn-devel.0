Message-ID: <48C64023.2000702@...1114...>
Date: Tue, 09 Sep 2008 11:21:39 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <81AF7E8F1C0044E88581729A677FA384@...576...>
	<48C4C77A.3030306@...1114...> <48C610E7.8020308@...41...>
In-Reply-To: <48C610E7.8020308@...41...>
Subject: Re: [Openvpn-devel] Confusing "mtu-dynamic" warnings
Reply-To: dazo@...384...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net, Dave <dev@...575...>


Ahh!  Sorry about that.  Scratch my patch!  I didn't think about that this 
could be sent over the wire.  But I'm not sure that a search/replace of 
"mtu-dynamic" on the warning string would solve it completely neither, then 
something needs to be done with this part of the code instead:

options.c - line 3567
-------------------------------------------------------------------------
#ifdef ENABLE_FRAGMENT
   else if (streq (p[0], "mtu-dynamic"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       msg (msglevel, "--mtu-dynamic has been replaced by --fragment");
       goto err;
     }
   else if (streq (p[0], "fragment") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_MTU);
       options->fragment = positive_atoi (p[1]);
     }
#endif
-------------------------------------------------------------------------

Here we have a "goto err" if mtu-dynamic is used.  But we want to allow it, 
because if backward compatibility ... so the code probably would need to be 
something like this:
-------------------------------------------------------------------------
#ifdef ENABLE_FRAGMENT
   else if ((streq (p[0], "mtu-dynamic") || streq (p[0], "fragment"))
	  && p[1]))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       if( (streq (p[0], "mtu-dynamic")
	{
       	   msg (msglevel, "--mtu-dynamic has been replaced by --fragment");
	}

       VERIFY_PERMISSION (OPT_P_MTU);
       options->fragment = positive_atoi (p[1]);
     }
#endif
-------------------------------------------------------------------------

This would then preserve backward compatibility and give a warning.

But if this option is not longer supported, and has been deprecated for 
over 5 years, that would mean OpenVPN 1.x-something ... wouldn't it be 
about time to upgrade the software package then?  Such old software could 
just as well be a potential security breach.


Kind regards,

David S.


James Yonan wrote:
> It's not so simple -- the "mtu-dynamic" string is passed across the 
> network which means the patch below will break backward compatibility 
> when one side of the connection is patched but the other side is not. In 
> fact, that's the reason why the options consistency protocol still uses 
> "mtu-dynamic" instead of "fragment".  The solution that preserves 
> backward compatibility is to continue using "mtu-dynamic", but do a 
> search/replace of "mtu-dynamic" -> "fragment" on the warning string 
> before it is output.
> 
> Actually if that's the worst bug you guys can find, we're probably ready 
> to release 2.1 :)
> 
> James
> 
> David Sommerseth wrote:
>> I'm guessing the following patch would correct this ....
>>
>>
>> --- options.c.orig    2008-09-08 08:32:05.000000000 +0200
>> +++ options.c    2008-09-08 08:31:10.000000000 +0200
>> @@ -2236,7 +2236,7 @@
>>
>>  #ifdef ENABLE_FRAGMENT
>>    if (o->fragment)
>> -    buf_printf (&out, ",mtu-dynamic");
>> +    buf_printf (&out, ",fragment");
>>  #endif
>>
>>  #ifdef USE_CRYPTO
>>
>>
>> Seems to me like it's just a typo when preparing the argument parsing.
>>
>>
>> kind regards,
>>
>> David Sommerseth
>>
>>
>>
>>
>> Dave wrote:
>>> ..
>>>> Hi,
>>>>
>>>> When makins some inconsistency mistake with "--fragment" settings, I 
>>>> get an error message like:
>>>>
>>>> WARNING: 'mtu-dynamic' is present in local config but missing in 
>>>> remote config, local='mtu-dynamic'
>>>>
>>>> I guess this message has to be updates, as "--fragment" is meant to 
>>>> replace "--mtu-dynamic" AFAICS.
>>>>
>>>> This is with 2.1_rc9.
>>> ...
>>>
>>> Nice bug!  --mtu-dynamic is an ancient option, it was dropped in 
>>> version 1.5
>>> about 5 years ago.
>>>
>>>
>>> ------------------------------------------------------------------------- 
>>>
>>> This SF.Net email is sponsored by the Moblin Your Move Developer's 
>>> challenge
>>> Build the coolest Linux based applications with Moblin SDK & win 
>>> great prizes
>>> Grand prize is a trip for two to an Open Source event anywhere in the 
>>> world
>>> http://moblin-contest.org/redirect.php?banner_id=100&url=/
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>> -------------------------------------------------------------------------
>> This SF.Net email is sponsored by the Moblin Your Move Developer's 
>> challenge
>> Build the coolest Linux based applications with Moblin SDK & win great 
>> prizes
>> Grand prize is a trip for two to an Open Source event anywhere in the 
>> world
>> http://moblin-contest.org/redirect.php?banner_id=100&url=/
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

