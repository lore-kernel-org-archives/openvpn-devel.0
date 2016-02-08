References: <1454874438-5081-1-git-send-email-steffan@...1856...>
	<1454874438-5081-3-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56B8B263.60203@...1227...>
Date: Mon, 8 Feb 2016 16:21:07 +0100
MIME-Version: 1.0
In-Reply-To: <1454874438-5081-3-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 02/10] Remove reuse of key_type during
 init of data channel auth and tls-auth
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
> Prepare for using AEAD cipher modes + tls-auth, as tls-auth might want to
> use an HMAC, while the data channel uses e.g. GCM tags.  This separates
> the two initialisations.  Also, error out (and give a clear error message)
> if a user specifies tls-auth but no valid auth algorithm, which makes no
> sense at all.
>
ACK.

Arne

