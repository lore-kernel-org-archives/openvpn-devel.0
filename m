From: Arne Schwabe <arne@...1227...>
References: <1494859435-16379-1-git-send-email-steffan.karger@...1435...>
Message-ID: <7281bab4-266a-0c7e-e45c-d2577bd36395@...1227...>
Date: Wed, 17 May 2017 18:24:14 +0200
MIME-Version: 1.0
In-Reply-To: <1494859435-16379-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Log the negotiated (NCP) cipher
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 15.05.17 um 16:43 schrieb Steffan Karger:
> To make it clear that NCP is in effect, print a log message (at --verb 2)
> to show that we selected a cipher using NCP.

ACK, also works as advertised:

May 17 18:23:09 hermes ovpn-aead-v6[15271]:
keto.blinkt.de/188.109.222.115 Data Channel: using negotiated cipher
'AES-256-GCM'



