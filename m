Message-ID: <56006549.9010809@...515...>
Date: Mon, 21 Sep 2015 23:15:05 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <56002293.9080800@...515...>
In-Reply-To: <56002293.9080800@...515...>
Subject: Re: [Openvpn-devel] Topics for today's (21st Sep 2015) community
 meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Here's the summary of today's IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Monday 21st Sep 2015
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-09-21>

The next meeting has been scheduled to two weeks from this meeting:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-10-05>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, gava100, syzzer, mattock and plaisthos participated in this meeting.

---

Discussed Windows builds. Agreed that --disable-debug should be removed,=20
so that debugging can be enabled using a runtime option. This should not=20
affect performance in any significant way. Mattock made this change to=20
openvpn-build during the meeting, so that all future OpenVPN Windows=20
builds will have debugging capabilities.

--

Discussed the "Added two feature to Network Address Translator" patchset:

<http://thread.gmane.org/gmane.network.openvpn.devel/10047>

The NAT code adds quite a bit of code, which could bring with it=20
security vulnerabilities. For example FTP NAT code in other products has=20
historically had security issues. Cron2 will review the patches a bit=20
more before any decisions are made. Rafael will split the patch into two=20
to ease review and merging.

--

Discussed the "=E2=80=8Bfix unaligned access to TCP MSS" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/10047>
<https://community.openvpn.net/openvpn/ticket/497>

Syzzer gave the patch an ACK.

--

Discussed the "get_default_gateway_ipv6() for Windows (10/10)" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/10085>

The patch drops support for building for Windows XP, so it can only be=20
merged into Git "master", not 2.3.x.

Cron2 has tested the patch somewhat and has a few potential testers=20
waiting. Special Windows builds with this patch will be built by mattock=20
soon.

--

Discussed merging the "=E2=80=8Bredirect-gateway ipv6" patch to 2.3.x:

<http://thread.gmane.org/gmane.network.openvpn.devel/10086>

Cron2 will provide a patch against 2.3 and send it to the devel list.

--

Discussed the "strdup() return checks" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/10046>
<https://community.openvpn.net/openvpn/ticket/600>

Syzzer will provide two patches to replace this one.

--

Discussed merging the "control packet MTU increase" patch to 2.3:

<http://thread.gmane.org/gmane.network.openvpn.devel/9841>
<https://community.openvpn.net/openvpn/ticket/545>

Syzzer ACKed merging the patch to 2.3.

--

Review of the "=E2=80=8Bfix privilege dropping if first connection attempt=
=20
unsuccessful" patch had to be postponed, because it was getting too late.

---

Full chatlog has been attached to this email.

