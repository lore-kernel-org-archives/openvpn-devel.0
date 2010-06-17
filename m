Message-ID: <4C1A7E26.4010206@...1114...>
Date: Thu, 17 Jun 2010 21:57:26 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4C19ED93.50202@...1380...>	<4C1A0941.5000808@...515...>	<AANLkTinkGgRbX7tY0QZzoC-ru5jhKFdpiEgn-proJecI@...278...>	<4C1A1AE1.5090305@...1380...>	<AANLkTimpz7YASaTfmQ5DItwiMrplAx_G93ez2vHxAWW5@...278...>
	<4C1A3658.6090501@...1380...>
In-Reply-To: <4C1A3658.6090501@...1380...>
Subject: Re: [Openvpn-devel] [PATCH] Choose a different field in X509 to be
 username
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Emilien Mantel <emilien.mantel@...1380...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 17/06/10 16:51, Emilien Mantel wrote:
> 1) Done
> 
> 2) Done
> 
> 3) "sizeof(common_name)" is useless... Line 745: char
> common_name[TLS_USERNAME_LEN]; we can use directly TLS_USERNAME_LEN.

Thanks a lot for the patch and all rework done.  (Also: thank you to all
reviewers!)

The third and last patch looks very good!  I've applied it to the
feat_misc branch and merged it into allmerged.


commit 935c62be9c0c8a256112df818bfb8470586a23b6
Author: Emilien Mantel <emilien.mantel@...1380...>
Date:   Thu Jun 17 21:38:59 2010 +0200

    Choose a different field in X509 to be username

    For my company, we use a PKI (linked to a LDAP) with OpenVPN. We
    can't use "CN" to be username (few people can have the same "CN").
    In our case, we only use the UID.

    With my patch, you can choose another field to be username with a
    new option called --x509-username-field, the default value is "CN".

    Signed-off-by: Emilien Mantel <emilien.mantel@...1380...>
    Acked-by: David Sommerseth <dazo@...384...>
    Signed-off-by: David Sommerseth <dazo@...384...>


> 4)
> I note "common_name" is used everwhere in OpenVPN code... I can rename
> it with a big sed :)
> But substitute all "common_name" is very heavy :
> emilienm@...1381...:~/dev/openvpn-testing$ grep -i common_name * | wc -l
> 165
> Are you sure it's a good idea? If I do that, are you agree to rename it
> "username"?

In regards to this one.  It is a good idea to rename the common_name to
something else.  I am not sure if it is clearer to rename it to
username.  I lean more towards Alon's suggestion, x509_field - as it
tells you where this information comes from.  On the other hand '_field'
is a bit vague, to what this information can be used for.  So I'd
probably suggest something like:  x509_clientid or x509_clientref ...
maybe there are some better suggestions?

Anyhow, this change should be a separate patch.  This is to make it
eaiser to pin point which change (commit) causes troubles later on, if
that happens.  That way, smaller commits helps narrowing down the
problem better later on, when we've all forgotten which changes we've
done and why.


kind regards,

David Sommerseth



> Le 17/06/2010 15:57, Alon Bar-Lev a écrit :
>> Great.
>>
>> Few more:
>>
>> 1. To upper:
>> char *s = p[1];
>> while ((*s = toupper(*s)) != '\0') s++;
>> 2. Remove compound {} at this place, move the char *s before the
>> VERIFY_PERMISSION.
>> 3. I think:
>> """
>> extract_x509_field_ssl (X509_get_subject_name (ctx->current_cert),
>> x509_username_field, common_name, TLS_USERNAME_LEN)
>> """
>> TLS_USERNAME_LEN ->  sizeof(common_name)
>> 4. Maybe rename common_name ->  x509_field or something to make it
>> clearer that it isn't actually common_name.
>>
>> Thanks.
>>
>> On Thu, Jun 17, 2010 at 3:53 PM, Emilien Mantel
>> <emilien.mantel@...1380...>  wrote:
>>   
>>> I added toupper() + #include<ctype.h>  in options.c
>>>
>>> See attached.
>>>
>>> -- 
>>> Emilien Mantel
>>>
>>> Le 17/06/2010 14:02, Alon Bar-Lev a écrit :
>>>     
>>>> This is good idea.
>>>>
>>>> In order to upper case toupper() should be used and not manual
>>>> guessing.
>>>>
>>>> +  else if (streq (p[0], "x509-username-field")&&    p[1])
>>>> +    {
>>>> +      VERIFY_PERMISSION (OPT_P_GENERAL);
>>>> +      /* Uppercase if necessary */
>>>> +      {
>>>> +       char *s = p[1];
>>>> +       int c, flag = 0;
>>>> +
>>>> +       while ((c = *s) != '\0')
>>>> +          {
>>>> +           if (c>= 'a'&&    c<= 'z')
>>>> +              {
>>>> +                c = c + 'A' - 'a';
>>>> +               flag++;
>>>> +              }
>>>> +            *s = (char) c;
>>>> +            s++;
>>>> +         }
>>>> +      }
>>>> +      options->x509_username_field = p[1];
>>>> +    }
>>>>
>>>> 2010/6/17 Samuli Seppänen<samuli@...515...>:
>>>>
>>>>       
>>>>>
>>>>>         
>>>>>> Hi,
>>>>>>
>>>>>> For my company, we use a PKI (linked to a LDAP) with OpenVPN. We
>>>>>> can't
>>>>>> use "CN" to be username (few people can have the same "CN"). In our
>>>>>> case, we only use the UID.
>>>>>>
>>>>>> With my patch, you can choose another field to be username with a new
>>>>>> option called "x509-username-field", the default value is "CN".
>>>>>>
>>>>>> Best regards
>>>>>>
>>>>>> -- 
>>>>>> Emilien Mantel
>>>>>>
>>>>>>            
>>>>> Hi Emilien,
>>>>>
>>>>> Thanks for the patch! Could somebody with better C skills take a look
>>>>> and see if it needs modifications?
>>>>>
>>>>> -- 
>>>>> Samuli Seppänen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwafiYACgkQDC186MBRfrq3+QCgp9Si+E8oJmjiyrHnNJhQg1tm
zJkAn1G42OuH1bZ/wtQaiET+mnNI4LHJ
=hHj0
-----END PGP SIGNATURE-----

