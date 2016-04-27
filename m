References: <1460918143-408-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <57209BDF.4030202@...1227...>
Date: Wed, 27 Apr 2016 14:00:47 +0300
MIME-Version: 1.0
In-Reply-To: <1460918143-408-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Migrate to mbed TLS 2.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 17.04.16 um 21:35 schrieb Steffan Karger:
>  #ifdef HAVE_AEAD_CIPHER_MODES

Are there  actually mBedTLS >=2.0 without this?

The rest looks fine, so ACK for me.

Arne

P.S.: This was probably one of the most boring reviews I did (for most
part of the changes).

