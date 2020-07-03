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
 <56e393a1-0838-9888-d178-96df4e9c277f@...1147...>
 <6cc72b95-3f72-f974-258e-c0b0e5efa28a@...1227...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <f32f50cd-6dc2-44a1-27bb-14dc6d60ac52@...1147...>
Date: Fri, 3 Jul 2020 11:57:55 +0200
MIME-Version: 1.0
In-Reply-To: <6cc72b95-3f72-f974-258e-c0b0e5efa28a@...1227...>
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
To: Arne Schwabe <arne@...1227...>, David Sommerseth <openvpn@...2080...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 03/07/20 11:18, Arne Schwabe wrote:
>>> The main purpose of that RFC is to ensure we handle DNS and
>>> --dhcp-options
>>> consistently across all OpenVPN implementations we care about, and
>>> that we
>>> document this properly.
>>>
>> I see one as an implementation issue (can we specify a particular DHCP
>> option more than once) and one as an OpenVPN protocol issue.
>> I fully agree that it's time to think about and overhaul the DNS
>> settings for OpenVPN but I also believe that further abusing the option
>> 'dhcp-option' is not the best way forward.=A0 The option 'dhcp-option'
>> only really applies to the Windows tap-win adapter as that is the only
>> adapter where you can use DHCP to add/change settings.
> This not even remotely true anymore. Basically all platforms will accept
> the dhcp-options for modifying the DNS settings.
>
>> AFAIK even the
>> new win-tun adapter does not use DHCP for this. Hence the term 'dhcp-'
>> is moot.
> Yes. Of course we can specify nicer sounding names for these options and
> that also break all kind of backwards compatibility for little gain or
> we document that the dhcp- prefix in these options is for historic reason=
s.
>
>
I should have worded it more carefully, but Jonathan beat me to it:

On 03/07/20 11:30, Jonathan K. Bullard wrote:
 > If you mean the term 'dhcp' should not be used in the name of the
 > option, I agree. Perhaps something like "interface-option" would be
 > better.
 >
 > But the _option_ isn't only for Windows tap-win adaptor. The option's
 > arguments are passed to scripts via $foreign_option_* environment
 > variables (on macOS, at least, and I think on most or all platforms).
 > And the Tunnelblick scripts use them to modify network settings, sort
 > of as if they came from DHCP, but not actually using DHCP.


I fully understand that most of those options are supported (or should I=20
say, '(ab)used' ) by the other platforms but what I meant was that the=20
name 'dhcp-option' is totally misleading as it has nothing to do with=20
DHCP *except* when using the tap-win adapter.

Thus, if we want an overhaul of this, let's do it right and change the=20
name of this option.

JJK

