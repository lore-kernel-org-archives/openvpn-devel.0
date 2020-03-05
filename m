From: Jan Just Keijser <janjust@...1147...>
References: <523527018.2514117.1583041035054.ref@...2084...>
 <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
Message-ID: <f978bb47-476f-1667-0f24-c216d5f07500@...1147...>
Date: Thu, 5 Mar 2020 15:48:55 +0100
MIME-Version: 1.0
In-Reply-To: <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

On 05/03/20 13:53, Jan Just Keijser wrote:
> Hi,
>
> On 01/03/20 16:29, Selva Nair wrote:
>> On Sun, Mar 1, 2020 at 2:17 AM Gert Doering <gert@...1296...> wrote:
>>>
>>> On Sun, Mar 01, 2020 at 05:37:15AM +0000, Leroy Tennison via 
>>> Openvpn-users wrote:
>>>> Admittedly, and older server version (2.3) but is there a way to 
>>>> specify multiple DNS search suffixes for a Windows (10 if that 
>>>> makes a difference) client.  The clients are part of a domain but I 
>>>> have no control over them via that avenue.  I've tried multiple 
>>>> dhcp-option DOMAiN entries and the last one applies, I don't see 
>>>> another dhcp-option such as DOMAIN-SEARCH.  Any options would be 
>>>> much appreciated.  Thanks.
>>>
>>> OpenVPN never had functionality to set the DHCP SEARCH LIST option
>>> on Windows.
>>>
>>> So while you could always specify the option multiple times, it would
>>> only use one of them and put it into the DHCP DOMAIN option.
>>>
>>> It's not very much missing code, but someone would have to do it (and
>>> the "core team" is very busy with other aspects right now).
>> IIRC, windows clients never queried DHCP option 119 (domain search).
>> It seems that has changed since Windows 10, or has it?
>>
>>
> I had to dig through my archives for this one - I found an OpenVPN 
> 2.0.9  (!) source tree to which I had added rudimentary support for 
> DHCP domain search, but that was *before* I found out that Windows did 
> not support that...
> And yes, according to the comment section of 
> https://www.normanbauer.com/2018/04/18/configuring-dhcp-option-119-domain-search-list-on-a-windows-dhcp-server/, 
> Windows 10 1809+ finally has support for DHCP domain searches.
>
> So, for what it's worth, I've dusted off the patch again and rebased 
> it to the current openvpn master tree. See attached. Note that I did 
> only rudimentary testing, as I don't use Windows 10 a lot and I was 
> testing using a mingw cross-compile only. In wireshark I *do* see that 
> the correct DHCP offer is sent to the tap-win adapter.
>
> Also note that I implemented multiple search domains by separating 
> them using semi-colons, e.g.
>
>    --dhcp-option SEARCH example.com;example.org;example.nl;example.de
>
> etc as that was easier to implement
> Also note that I did not fully implement the RFC3397 encoding of the 
> search list, as that requires one to merge domain names that occur 
> more than once - that would have made the code far more complicated.
>

to follow up on this:   I just found Jonathan's update-systemd-resolved 
thingie (https://github.com/jonathanio/update-systemd-resolved)  where 
he mentions that you can push
   --dhcp-option DOMAIN
multiple times to achieve a similar result - but at best that works on 
anything BUT Windows.
I do see that he lists a non-supported option
   --dhcp-option SEARCH-DOMAIN

instead of my 'SEARCH' ; it will be good to sync up with his script/code 
to ensure a smooth cooperation between platforms - provided, that is, 
that my patch is actually acceptable ;)

cheers,

JJK


