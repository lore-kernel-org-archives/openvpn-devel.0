Date: Sat, 17 Jun 2006 22:22:10 +0900
FROM: postmaster@...604...
Content-Transfer-Encoding: 8bit
Mime-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
	boundary="1150550524.31664.nexg.q0"
Message-ID: <E1Frakd-0004Kb-MW@...556...>
Subject: [Openvpn-devel] [Err]  ovpn server on udp with multiple gateways
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

--1150550524.31664.nexg.q0
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

--1150550524.31664.nexg.q0
Content-type: message/delivery-status

Reporting-MTA: dns; nexg.net

Final-Recipient: rfc822;iryna7@...604...
Diagnostic-Code: smtp;
	550 error - <iryna7@...604...>: Recipient address rejected:
	User unknown in local recipient table(211.232.190.7)
Action: failed
Status: 5.0.0

--1150550524.31664.nexg.q0
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit

X-MF: BNDR=NULL,Date=0,IPR=3.0,HIP=1,DIP=MATCH-SPF,SPF=2,RcvdCnt=4
X-HELO: ehlo lists-outbound.sourceforge.net
X-RECEIVED-IP: 66.35.250.225
X-MAIL-FROM: openvpn-devel-bounces@lists.sourceforge.net
Date: Sat, 17 Jun 2006 15:21:51 +0200
From: richard lucassen <mailinglists@...673...>
To: openvpn-devel@lists.sourceforge.net
Message-Id: <20060617152151.6ce2f63f.mailinglists@...673...>
Organization: XAQ Systems
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
X-Spam-Score: 1.0 (+)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to
	http://sf.net/tracker/?func=add&group_id=1&atid=200001
	1.0 FORGED_RCVD_HELO       Received: contains a forged HELO
Subject: [Openvpn-devel] ovpn server on udp with multiple gateways
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

Hello list,

I tried to use an OpenVPN server listening on 1194/udp on a machine that
is having multiple gateways to the internet. I use policy routing.

eth1  1.1.1.2/29 (1.1.1.1 master def gw)
eth2  2.2.2.2/29 (2.2.2.1 gateway)
eth3  3.3.3.2/29 (3.3.3.1 gateway)

1.1.1.1 is the principal default gw. If I bind ovpn to 0.0.0.0, the
returnpackets will always have source address 1.1.1.2, even when making
a connection to 2.2.2.2 or 3.3.3.2.

I can of course use tcp instead of udp, but a tcp header is 12 bytes
larger that the udp one. And as I have a lot of Citrix traffic flowing
through the tunnel (which consists of a lot of small packets), I
want to reduce the tunnel overhead as maximum as possible.

Is there a (simple) way to let OpenVPN use the same source address to
which the connection was set up like in the following example?

- set up tunnel x.x.x.x to dst address 1.1.1.2
  return src address 1.1.1.2 to x.x.x.x
- set up tunnel x.x.x.x to dst address 2.2.2.2
  return src address 2.2.2.2 to x.x.x.x
- set up tunnel x.x.x.x to dst address 3.3.3.2
  return src address 3.3.3.2 to x.x.x.x

R.

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

--1150550524.31664.nexg.q0
Content-Type: text/plain



--1150550524.31664.nexg.q0--
