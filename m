MIME-Version: 1.0
In-Reply-To: <4C1A3658.6090501@...1380...>
References: <4C19ED93.50202@...1380...>
	<4C1A0941.5000808@...515...>
	<AANLkTinkGgRbX7tY0QZzoC-ru5jhKFdpiEgn-proJecI@...278...>
	<4C1A1AE1.5090305@...1380...>
	<AANLkTimpz7YASaTfmQ5DItwiMrplAx_G93ez2vHxAWW5@...278...>
	<4C1A3658.6090501@...1380...>
Date: Thu, 17 Jun 2010 18:21:24 +0300
Message-ID: <AANLkTika-8Fg3DWpQ6gDw_dACUITGrE13z7au83OSpin@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Emilien Mantel <emilien.mantel@...1380...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Jun 17, 2010 at 5:51 PM, Emilien Mantel
<emilien.mantel@...1380...> wrote:
> 1) Done
>
> 2) Done
>
> 3) "sizeof(common_name)" is useless... Line 745: char
> common_name[TLS_USERNAME_LEN]; we can use directly TLS_USERNAME_LEN.

Usually sizeof(XXX) should be used so if XXX is modified there is no
overrun (Single point of change).

>
> 4)
> I note "common_name" is used everwhere in OpenVPN code... I can rename it
> with a big sed :)
> But substitute all "common_name" is very heavy :
> emilienm@...1381...:~/dev/openvpn-testing$ grep -i common_name * | wc -l
> 165
> Are you sure it's a good idea? If I do that, are you agree to rename it
> "username"?

Oh... this is not for me to decide, I of course think it should be
done... Maybe as separate patch... it is very confusing to leave it
this way...

>
> --
> Emilien Mantel
>
> Le 17/06/2010 15:57, Alon Bar-Lev a =C3=A9crit :
>>
>> Great.
>>
>> Few more:
>>
>> 1. To upper:
>> char *s =3D p[1];
>> while ((*s =3D toupper(*s)) !=3D '\0') s++;
>> 2. Remove compound {} at this place, move the char *s before the
>> VERIFY_PERMISSION.
>> 3. I think:
>> """
>> extract_x509_field_ssl (X509_get_subject_name (ctx->current_cert),
>> x509_username_field, common_name, TLS_USERNAME_LEN)
>> """
>> TLS_USERNAME_LEN -> =C2=A0sizeof(common_name)
>> 4. Maybe rename common_name -> =C2=A0x509_field or something to make it
>> clearer that it isn't actually common_name.
>>
>> Thanks.
>>
>> On Thu, Jun 17, 2010 at 3:53 PM, Emilien Mantel
>> <emilien.mantel@...1380...> =C2=A0wrote:
>>
>>>
>>> I added toupper() + #include<ctype.h> =C2=A0in options.c
>>>
>>> See attached.
>>>
>>> --
>>> Emilien Mantel
>>>
>>> Le 17/06/2010 14:02, Alon Bar-Lev a =C3=A9crit :
>>>
>>>>
>>>> This is good idea.
>>>>
>>>> In order to upper case toupper() should be used and not manual guessin=
g.
>>>>
>>>> + =C2=A0else if (streq (p[0], "x509-username-field")&& =C2=A0 =C2=A0p[=
1])
>>>> + =C2=A0 =C2=A0{
>>>> + =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION (OPT_P_GENERAL);
>>>> + =C2=A0 =C2=A0 =C2=A0/* Uppercase if necessary */
>>>> + =C2=A0 =C2=A0 =C2=A0{
>>>> + =C2=A0 =C2=A0 =C2=A0 char *s =3D p[1];
>>>> + =C2=A0 =C2=A0 =C2=A0 int c, flag =3D 0;
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 while ((c =3D *s) !=3D '\0')
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c>=3D 'a'&& =C2=A0 =C2=A0c<=
=3D 'z')
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c =3D c + 'A'=
 - 'a';
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag++;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*s =3D (char) c;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s++;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>> + =C2=A0 =C2=A0 =C2=A0}
>>>> + =C2=A0 =C2=A0 =C2=A0options->x509_username_field =3D p[1];
>>>> + =C2=A0 =C2=A0}
>>>>
>>>> 2010/6/17 Samuli Sepp=C3=A4nen<samuli@...515...>:
>>>>
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> For my company, we use a PKI (linked to a LDAP) with OpenVPN. We can=
't
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
>>>>>
>>>>> Hi Emilien,
>>>>>
>>>>> Thanks for the patch! Could somebody with better C skills take a look
>>>>> and see if it needs modifications?
>>>>>
>>>>> --
>>>>> Samuli Sepp=C3=A4nen
>>>>> Community Manager
>>>>> OpenVPN Technologies, Inc
>>>>>
>>>>> irc freenode net: mattock
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> ---------------------------------------------------------------------=
---------
>>>>> ThinkGeek and WIRED's GeekDad team up for the Ultimate
>>>>> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
>>>>> lucky parental unit. =C2=A0See the prize list and enter to win:
>>>>> http://p.sf.net/sfu/thinkgeek-promo
>>>>> _______________________________________________
>>>>> Openvpn-devel mailing list
>>>>> Openvpn-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>> ----------------------------------------------------------------------=
--------
>>>> ThinkGeek and WIRED's GeekDad team up for the Ultimate
>>>> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
>>>> lucky parental unit. =C2=A0See the prize list and enter to win:
>>>> http://p.sf.net/sfu/thinkgeek-promo
>>>> _______________________________________________
>>>> Openvpn-devel mailing list
>>>> Openvpn-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>
>>>>
>>>
>>>
>>> -----------------------------------------------------------------------=
-------
>>> ThinkGeek and WIRED's GeekDad team up for the Ultimate
>>> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
>>> lucky parental unit. =C2=A0See the prize list and enter to win:
>>> http://p.sf.net/sfu/thinkgeek-promo
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>
>>>
>>>
>
>

