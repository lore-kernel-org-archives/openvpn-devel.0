References: <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
 <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
 <20200630141103.GY1431@...1296...>
 <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
 <20200706161532.GH1431@...1296...>
 <e5be8b49-0689-eb96-b294-f5b50388a67b@...1147...>
 <20200708082428.GT1431@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <1271e0f7-2768-74df-e81b-6fa8ccf82af1@...1147...>
Date: Fri, 10 Jul 2020 18:48:26 +0200
MIME-Version: 1.0
In-Reply-To: <20200708082428.GT1431@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [Openvpn-users] Multiple DNS search suffixes on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,


On 08-Jul-20 10:24, Gert Doering wrote:
> On Tue, Jul 07, 2020 at 06:14:25PM +0200, Jan Just Keijser wrote:
>>> This one works(!), so generally, Win10 accepts this DHCP option - but
>>> it seems to want "all domains in one".
>>>
>>> Can you send a v3?
>>>
>> not sure if all went well , but here's V3.
> Unfortunately not, that one seems to be based on your V1 patch, so
> we have "remove 'SEARCH', add 'DOMAIN-SEARCH'" hunks...
>
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index e59b22b..85f1d8a 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -726,7 +726,7 @@ static const char usage_message[] =3D
>>       "                    which allow multiple addresses,\n"
>>       "                    --dhcp-option must be repeated.\n"
>>       "                    DOMAIN name : Set DNS suffix\n"
>> -    "                    SEARCH name : Set DNS domain search list\n"
>> +    "                    DOMAIN-SEARCH entry : Add entry to DNS domain =
search list\n"
> This is ok for me to have a look, but to actually merge I need something
> that applies "as it is" on top of master...
>
>> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
>> index eed9ae6..60a149c 100644
>> --- a/src/openvpn/tun.c
>> +++ b/src/openvpn/tun.c
>> @@ -5567,46 +5567,70 @@ write_dhcp_str(struct buffer *buf, const int typ=
e, const char *str, bool *error)
>>       buf_write(buf, str, len);
>>   }
>>  =20
>> +/*
>> + * RFC3397 states that multiple searchdomains are encoded as follows:
>> + *  - at start the length of the entire option is given
>> + *  - each subdomain is preceded by its length
>> + *  - each searchdomain is separated by a NUL character
>> + * e.g. if you want "openvpn.net" and "duckduckgo.com" then you end up =
with
>> + *  0x13  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00
>> + */
> Richard commented on IRC that the "0x13" does not seem to be right here
> - adding up all of it (1+7+1+3+1+1+10+1+3+1 =3D 29).  Can you double-chec=
k?
>
> It's just a comment, but if that is wrong, it's not helpful in trying to
> understand the code.
>
>
just submitted patch v4 but forgot to fix that:=A0=A0 richard is right 29=20
decimal is=A0 0x1D -=A0 or just 29, I guess=A0 - not 0x13

Want a v5 for that :P ?

cheers,

JJK


