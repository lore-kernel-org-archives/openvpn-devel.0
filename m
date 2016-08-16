References: <1471358761-8828-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <83a469b7-12af-76d2-4c30-c766c89c92a4@...1227...>
Date: Tue, 16 Aug 2016 16:52:31 +0200
MIME-Version: 1.0
In-Reply-To: <1471358761-8828-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Discourage using 64-bit block ciphers
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



Am 16.08.16 um 16:46 schrieb Steffan Karger:
> As discussed with the development team, we should start moving away from
> ciphers with a small block size.  For OpenVPN in particular this means
> moving away from 64-bit block ciphers, towards 128-bit block ciphers.
> This patch makes a start with that by moving ciphers with a block
> size < 128 bits to the bottom of the --show-ciphers output, and printing
> a warning in the connection phase if such a cipher is used.
>
> While touching this function, improve the output of --show-ciphers by
> ordering the output alphabetically, and changing the output format
> slightly.
>
ACK again from me. (C89 issue applies here as well)

Arne

