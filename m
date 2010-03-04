From: =?UTF-8?Q?booyakasha?= <booyakasha@...1309...>
In-Reply-To: <eba800c91003011101v61fb1415l68146f00916b1c7@...278...>
References: <6c75f86b.6552e8f7.4b8bad61.2e7bd@...1309...>
	<4B8BB647.2020804@...1114...>
	<23627cf8.610acd4b.4b8bc540.d2023@...1309...>
	<eba800c91003011101v61fb1415l68146f00916b1c7@...278...>
Mime-Version: 1.0
Message-ID: <7cd17813.52db77fa.4b901800.4e59d@...1309...>
Date: Thu, 04 Mar 2010 21:28:48 +0100
Subject: Re: [Openvpn-devel]
	=?utf-8?q?Openvpn_2=2E1=2E1_bad_tcp_performance_b?=
	=?utf-8?q?ut_good_pingwhen_-l_1472_=28with_packet_size_=3D_MTU=29?=
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
To: openvpn-devel@lists.sourceforge.net

Dear developers,
because i really believe in open source software I've decided to check all =
sorts of configurations to check problems with tcp tunneling. I used both L=
inux and Windows (XP and Vista) to connect them over tcp tunnel in LAN netw=
ork. I've monitored both sides of connection and I have some interesting re=
sults. All 3 machines used fresh installed OS (Linux was Debian 4.1). Same =
problem with all of them. When you ping them with packet size 1472 (1500 by=
tes) you have excellent performance on both ends. But using any other size =
of packet causes dramatic performance lose (about 50 times slower response)=
. What is more interesting no retransmission on any of sides. Just slow res=
ponse from server and client. But then I=E2=80=99ve tried higher packet siz=
es just to make sure. And then I found a magic number 2952 (ping =E2=80=93l=
 2952). It wasn=E2=80=99t only the 1472 ping packet which worked OK. All pa=
ckets over 2952 are OK !!!  I am waiting for your opinions why packets from=
 1 byte to 2952 bytes (without 1472 byes package) are going extremely slowl=
y and others not.
Best regards
Ucho


