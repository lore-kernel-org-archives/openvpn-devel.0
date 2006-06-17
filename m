Date: Sun, 18 Jun 2006 03:09:10 +0900
FROM: postmaster@...604...
Content-Transfer-Encoding: 8bit
Mime-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
	boundary="1150567743.17161.nexg.q0"
Message-ID: <E1FrfEN-0007x1-TW@...556...>
Subject: [Openvpn-devel] [Err] Re: ovpn server on udp with multiple gateways
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multipart MIME message.

--1150567743.17161.nexg.q0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Transmit Report:

iryna7@...604...���� ���� ������ 3�� ���������� ��������������.
(���� ���� : 550 <iryna7@...604...>: Recipient address rejected: User unknown in local recipient table(211.232.190.7))

<����> ���� ������ ���� ����
User unknown       :������ ������ �������� �������� ����
Socket connect fail:���� ���� ������ ���� ����
DATA write fail    :���� ���� ������ ������ ���� ����
DATA reponse fail  :���� ���� ���������� ������ ���� ����

--1150567743.17161.nexg.q0
Content-type: message/delivery-status

Reporting-MTA: dns; nexg.net

Final-Recipient: rfc822;iryna7@...604...
Diagnostic-Code: smtp;
	550 error - <iryna7@...604...>: Recipient address rejected:
	User unknown in local recipient table(211.232.190.7)
Action: failed
Status: 5.0.0

--1150567743.17161.nexg.q0
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit

X-MF: BNDR=NULL,Date=0,IPR=3.0,HIP=1,DIP=MATCH-SPF,SPF=2,RcvdCnt=4
X-HELO: ehlo lists-outbound.sourceforge.net
X-RECEIVED-IP: 66.35.250.225
X-MAIL-FROM: openvpn-devel-bounces@lists.sourceforge.net
Date: Sat, 17 Jun 2006 20:08:51 +0200
From: richard lucassen <mailinglists@...673...>
To: openvpn-devel@lists.sourceforge.net
Message-Id: <20060617200851.4d3779e2.mailinglists@...673...>
In-Reply-To: <e710p7$8ic$1@...165...>
References: <20060617152151.6ce2f63f.mailinglists@...673...>
	<e710p7$8ic$1@...165...>
Organization: XAQ Systems
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
X-Spam-Score: 1.0 (+)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to
	http://sf.net/tracker/?func=add&group_id=1&atid=200001
	1.0 FORGED_RCVD_HELO       Received: contains a forged HELO
Subject: Re: [Openvpn-devel] ovpn server on udp with multiple gateways
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.8
Precedence: list
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: openvpn-devel-bounces@lists.sourceforge.net
Errors-To: openvpn-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 17 Jun 2006 08:40:50 -0500
Charles Duffy <cduffy@...294...> wrote:

> > Is there a (simple) way to let OpenVPN use the same source address
> > to which the connection was set up like in the following example?
> > 
> > - set up tunnel x.x.x.x to dst address 1.1.1.2
> >   return src address 1.1.1.2 to x.x.x.x
> > - set up tunnel x.x.x.x to dst address 2.2.2.2
> >   return src address 2.2.2.2 to x.x.x.x
> > - set up tunnel x.x.x.x to dst address 3.3.3.2
> >   return src address 3.3.3.2 to x.x.x.x
> 
> OpenVPN 2.1-beta3 merged a patch adding multihoming support.
> Multihoming  can be enabled or disabled at build-time, but should be
> enabled by  default if your OS supports it. There's a new "multihome"
> configuration  directive to enable this functionality if your build
> has support.

Ok, thanks a lot, I'll download 2.1beta3 then :)

> (BTW, this is a usage question rather than a development one; it
> should  go to OpenVPN-users, not OpenVPN-devel. That said, searching
> the  OpenVPN-devel archives for "multihome" should be interesting if
> you're  curious for the discussion surrounding the patch when it was
> initially  submitted).

Ok, I haven't searched yet for the keyword "multihome", otherwise I
would certainly have found it. I thought it would be more a
development question, so sorry for the noise I caused on this list. I'll
switch to users then.

Richard.

-- 
___________________________________________________________________
It is better to remain silent and be thought a fool, than to speak
aloud and remove all doubt.

+------------------------------------------------------------------+
| Richard Lucassen, Utrecht                                        |
| Public key and email address:                                    |
| http://www.lucassen.org/mail-pubkey.html                         |
+------------------------------------------------------------------+


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--1150567743.17161.nexg.q0
Content-Type: text/plain



--1150567743.17161.nexg.q0--
