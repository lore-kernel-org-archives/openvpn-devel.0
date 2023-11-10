Message-ID: <0acc8d93-6175-4d7e-a39a-269a9652ac3e@...1823...>
Date: Fri, 10 Nov 2023 10:21:35 +0400
MIME-Version: 1.0
Content-Language: en-US, ru-RU
References: <13E5C41C-8358-4252-A751-8FDA9EE95B7D@...2722...>
From: Dmitry Melekhov <dm@...1823...>
In-Reply-To: <13E5C41C-8358-4252-A751-8FDA9EE95B7D@...2722...>
Subject: Re: [Openvpn-devel] OpenVPN 2.6.7 released
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
To: openvpn-devel@lists.sourceforge.net

10.11.2023 00:56, Yuriy Darnobyt пишет:
> The OpenVPN community project team is proud to release OpenVPN 2.6.7.


something is broken in 2.6.7. it stops passing traffic after several 
seconds after connection when acts as server,

so I reverted it back to 2.6.6.

compiled from sources on ubuntu 22.04 with --disable-dco

don't know where is problem, at least now.



