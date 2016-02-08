From: Arne Schwabe <arne@...1227...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
	<1454874438-5081-7-git-send-email-steffan@...1856...>
Message-ID: <56B8BB2B.9060905@...1227...>
Date: Mon, 8 Feb 2016 16:58:35 +0100
MIME-Version: 1.0
In-Reply-To: <1454874438-5081-7-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 06/10] Change openvpn_encrypt() to
 append to work buffer only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net



Am 07.02.16 um 20:47 schrieb Steffan Karger:
> Preparation for AEAD cipher modes, which also have to authenticate the
> opcode and peer-id of packets.  To supply that information to
> openvpn_encrypt(), I want to simply write those to the work buffer
> before calling openvpn_encrypt().  That however requires that
> openvpn_encrypt() never prepends something to the work buffer.

ACK.

Arne



