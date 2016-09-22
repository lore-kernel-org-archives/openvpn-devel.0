From: debbie10t <debbie10t@...277...>
Message-ID: <4e9afe58-f398-7163-18fe-9113bf0cdfbc@...277...>
Date: Thu, 22 Sep 2016 14:07:03 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel]  Linux: Use /tmp for log problem ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi

posting in devel because I am asking for clarification of
what the source code really does.

Re: https://forums.openvpn.net/viewtopic.php?f=30&t=22485

Config:
|---
server *normal stuff*
log-append /tmp/openvpn.log
---

I have just tried with Ubuntu1604 myself and observe that:
(My basic config I added: --log /tmp/client1.log)

1. $ sudo systemctl start openvpn@...2166... = log file *not* created
2. $ sudo openvpn client1.conf = log file created normally in /tmp

Obviously, systemctl start openvpn@...2166... appends more options when
starting openvpn (in my hand written service the only addition is
--daemon client1) So I presume that by daemonizing something changes
with regard to writing the log file to /tmp ??

Also note, in the forum post --daemon is used within the config file.

I did grep -E "/tmp" src/openvpn/* and found some code in init.c
(line 664) but it's all C, foo, bar to me (Sea food bar ;-) )

Anyhoo, can anybody provide a brief and simple explanation ?

Many thanks
-- 

|

