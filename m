References: <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
 <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
 <20200630141103.GY1431@...1296...>
 <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
 <885f8b43-cd49-a88e-4a69-4913c0636e56@...2080...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <56e393a1-0838-9888-d178-96df4e9c277f@...1147...>
Date: Fri, 3 Jul 2020 09:39:07 +0200
MIME-Version: 1.0
In-Reply-To: <885f8b43-cd49-a88e-4a69-4913c0636e56@...2080...>
Content-Language: nl-NL
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
To: David Sommerseth <openvpn@...2080...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 02/07/20 23:04, David Sommerseth wrote:
> On 30/06/2020 16:15, Jan Just Keijser wrote:
>> hi,
>>
>> On 30/06/20 16:11, Gert Doering wrote:
>>> Hi,
>>>
>>> On Tue, Jun 30, 2020 at 04:07:52PM +0200, Jan Just Keijser wrote:
>>>> @@ -5697,6 +5740,11 @@ build_dhcp_options_string(struct buffer *buf, c=
onst struct tuntap_options *o)
>>>>       write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &e=
rror);
>>>>       write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, =
&error);
>>>>  =20
>>>> +    for (int i=3D0; i < o->domain_search_list_len; i++)
>>>> +    {
>>>> +        write_dhcp_search_str(buf, 119, o->domain_search_list[i], &er=
ror);
>>>> +    }
>>> I assume that this won't work.  In the DHCP answer, it must be a single
>>> option with the concatenated list, not multiple answers with a single
>>> domain name each.
>>>
>>> gert
>>>
>> see https://tools.ietf.org/html/rfc3397
>>
>> "
>>
>>     In the above diagram, Searchstring is a string specifying the
>>     searchlist.  If the length of the searchlist exceeds the maximum
>>     permissible within a single option (255 octets), then multiple
>>     options MAY be used, as described in "Encoding Long Options in the
>>     Dynamic Host Configuration Protocol (DHCPv4)" [RFC3396 <https://tool=
s.ietf.org/html/rfc3396>].
>>
>> "
>>
>>
>> so you MAY use this option multiple times - and wireshark groks it fine.=
 I don't have a Windows 10
>> client to test it against, however, so I am hoping that someone (Selva?)=
 can do that for me.
>>
> Hi,
>
> Can we please see this discussion also in context of this mail thread, wh=
ich
> tries to look a broader at this challenge?
>
> Message-Id: <c4628c37-0c3b-a402-ee9d-68ee7062e1f3@...2080...>
> URL:
> <https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg2010=
1.html>
>
> One change in that RFC since last time is that we will move IV_PROTO to be
> only about the OpenVPN wire protocol (features/settings only affecting
> protocol for the communication between the OpenVPN end-points themselves).
> The DNS settings and more related to host configuration and similar will =
be
> moved into an IV_FEAT field.  Except of that, nothing else has changed fr=
om
> the initial mail.
>
> The main purpose of that RFC is to ensure we handle DNS and --dhcp-options
> consistently across all OpenVPN implementations we care about, and that we
> document this properly.
>

I see one as an implementation issue (can we specify a particular DHCP=20
option more than once) and one as an OpenVPN protocol issue.
I fully agree that it's time to think about and overhaul the DNS=20
settings for OpenVPN but I also believe that further abusing the option=20
'dhcp-option' is not the best way forward.=A0 The option 'dhcp-option'=20
only really applies to the Windows tap-win adapter as that is the only=20
adapter where you can use DHCP to add/change settings. AFAIK even the=20
new win-tun adapter does not use DHCP for this. Hence the term 'dhcp-'=20
is moot.

Thus, moving forward, I'd be more in favor of overhauling this=20
*completely* and review all 'dhcp-option' flags to see how we can
a) specify then more logically and more neutrally
b) implement these features for each of the different platforms:

Windows+tap-win: use DHCP
Windows+win-tun:=A0=A0 use netsh ?
Linux:=A0 use systemd? use scripts
BSD: scripts? systemd?
MacOS:=A0=A0 just copy what Jonathan is using ;)


JM2CW,

JJK


