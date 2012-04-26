MIME-Version: 1.0
In-Reply-To: <4F9986A2.10900@...1114...>
References: <1335441085-18186-1-git-send-email-davids@...1347...>
	<CAOazyz3-f2YkXE_vV2Oum+p4exQTUis=Q9RTOrvZ7WC0WEZymg@...278...>
	<20120426172410.GT1359@...1296...>
	<4F9986A2.10900@...1114...>
Date: Thu, 26 Apr 2012 20:35:54 +0300
Message-ID: <CAOazyz0Tv0_9Fqr_b8smQ0z00qk5fQ2AUaHz_75K-gQoEANDOg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Presume that Linux is always IPv6
 capable at build time
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Apr 26, 2012 at 8:32 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> On 26/04/12 19:24, Gert Doering wrote:
>> Hi,
>>
>> On Thu, Apr 26, 2012 at 07:03:40PM +0300, Alon Bar-Lev wrote:
>>> I plan to add --enable-ipv6/--disable-ipv6 to explicit support
>>> ipv6.
>>
>> NAK.
>>
>> We considered this, and this will add a shitload of #ifdefs which
>> will make maintenance of the code a lot harder.
>>
>> (We actually *removed* all the #ifdefs of JJO's IPv6 transport
>> code, because it really hurt)
>>
>> We're in the year 2012, there are no operating systems without IPv6
>> support anymore, and it does not make sense to have a VPN
>> implementation that has no IPv6 support.
>
> Just for the record, I completely agree with Gert here. =C2=A0Actually we
> should focus on getting OpenVPN work better in IPv6-only environments
> - - but that's probably something for the 2.4 cycle.
>

At embedded system and several distros like Gentoo, the ipv6 should be
made enable/disabled, just like any other project.
It is the same #ifdef as we already have these in code.
Even in 2012 kernels can be compiled without ipv6.

Alon.

