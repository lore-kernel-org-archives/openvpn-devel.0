MIME-Version: 1.0
In-Reply-To: <CAOazyz0Tv0_9Fqr_b8smQ0z00qk5fQ2AUaHz_75K-gQoEANDOg@...278...>
References: <1335441085-18186-1-git-send-email-davids@...1347...>
	<CAOazyz3-f2YkXE_vV2Oum+p4exQTUis=Q9RTOrvZ7WC0WEZymg@...278...>
	<20120426172410.GT1359@...1296...>
	<4F9986A2.10900@...1114...>
	<CAOazyz0Tv0_9Fqr_b8smQ0z00qk5fQ2AUaHz_75K-gQoEANDOg@...278...>
Date: Thu, 26 Apr 2012 20:38:09 +0300
Message-ID: <CAOazyz3X3sOAf3+nKJgy-nD1_GU=n86o3F8CDheUmGVpwutgnA@...278...>
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

On Thu, Apr 26, 2012 at 8:35 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> On Thu, Apr 26, 2012 at 8:32 PM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> On 26/04/12 19:24, Gert Doering wrote:
>>> Hi,
>>>
>>> On Thu, Apr 26, 2012 at 07:03:40PM +0300, Alon Bar-Lev wrote:
>>>> I plan to add --enable-ipv6/--disable-ipv6 to explicit support
>>>> ipv6.
>>>
>>> NAK.
>>>
>>> We considered this, and this will add a shitload of #ifdefs which
>>> will make maintenance of the code a lot harder.
>>>
>>> (We actually *removed* all the #ifdefs of JJO's IPv6 transport
>>> code, because it really hurt)
>>>
>>> We're in the year 2012, there are no operating systems without IPv6
>>> support anymore, and it does not make sense to have a VPN
>>> implementation that has no IPv6 support.
>>
>> Just for the record, I completely agree with Gert here. =C2=A0Actually we
>> should focus on getting OpenVPN work better in IPv6-only environments
>> - - but that's probably something for the 2.4 cycle.
>>
>
> At embedded system and several distros like Gentoo, the ipv6 should be
> made enable/disabled, just like any other project.
> It is the same #ifdef as we already have these in code.
> Even in 2012 kernels can be compiled without ipv6.
>
> Alon.

Just to see other project relevance:
---
# equery hasuse ipv6
 * Searching for USE flag ipv6 ...
[IP-] [  ] app-admin/syslog-ng-3.2.5:0
[IP-] [  ] dev-lang/python-2.7.2-r3:2.7
[IP-] [  ] dev-lang/python-3.2.2:3.2
[IP-] [  ] dev-libs/libxml2-2.7.8-r5:2
[IP-] [  ] mail-mta/ssmtp-2.64-r2:0
[IP-] [  ] media-libs/mediastreamer-2.7.3-r3:0
[IP-] [  ] net-analyzer/net-snmp-5.4.2.1-r4:0
[IP-] [  ] net-analyzer/netcat6-1.0-r2:0
[IP-] [  ] net-analyzer/tcpdump-3.9.8-r1:0
[IP-] [  ] net-analyzer/wireshark-1.6.6:0
[IP-] [  ] net-dialup/ppp-2.4.5-r1:0
[IP-] [  ] net-dns/bind-tools-9.8.1:0
[IP-] [  ] net-dns/dnsmasq-2.57:0
[IP-] [  ] net-firewall/iptables-1.4.12.1:0
[IP-] [  ] net-ftp/ftp-0.17-r7:0
[IP-] [  ] net-libs/libpcap-1.1.1-r1:0
[IP-] [  ] net-libs/ortp-0.16.5:0
[IP-] [  ] net-misc/curl-7.24.0:0
[IP-] [  ] net-misc/iperf-2.0.5:0
[IP-] [  ] net-misc/iputils-20101006-r2:0
[IP-] [  ] net-misc/ntp-4.2.6_p3:0
[IP-] [  ] net-misc/rsync-3.0.9:0
[IP-] [  ] net-misc/wget-1.12-r3:0
[IP-] [  ] net-nds/openldap-2.4.30:0
[IP-] [  ] sys-apps/busybox-1.19.3-r1:0
[IP-] [  ] sys-apps/tcp-wrappers-7.6-r8:0
[IP-] [  ] sys-process/lsof-4.85-r2:0
[IP-] [  ] sys-process/psmisc-22.14:0
[IP-] [  ] x11-apps/xauth-1.0.6:0
[IP-] [  ] x11-apps/xhost-1.0.4:0
[IP-] [  ] x11-base/xorg-server-1.11.2-r2:0
[IP-] [  ] x11-libs/libICE-1.0.7:0
[IP-] [  ] x11-libs/libSM-1.2.0:0
[IP-] [  ] x11-libs/libX11-1.4.4:0
[IP-] [  ] x11-libs/libXfont-1.4.4:0
[IP-] [  ] x11-libs/libXmu-1.1.0:0
---

