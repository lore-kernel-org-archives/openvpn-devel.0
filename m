From: Cyril Scetbon <cyril.scetbon@...260...>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Message-Id: <11098166-9909-4011-83F9-C5BC3FEA769D@...260...>
Date: Wed, 21 Nov 2018 22:41:45 -0500
Subject: [Openvpn-devel] foreign_option_2 not set in 2.4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hey guys,

I=E2=80=99ve discovered that foreign_option_2 is not set using 2.4.4 but is=
 set using 2.3.10.

foreign_option_1=3Ddhcp-option DNS 10.201.50.150
foreign_option_2=3Ddhcp-option DOMAIN cyril.net

I had to downgrade to 2.3 because of it.

Thanks
=E2=80=94
Cyril Scetbon


