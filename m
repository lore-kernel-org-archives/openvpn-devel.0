From: Arne Schwabe <arne@...1227...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
	<1454874438-5081-8-git-send-email-steffan@...1856...>
Message-ID: <56B8BA8E.9000809@...1227...>
Date: Mon, 8 Feb 2016 16:55:58 +0100
MIME-Version: 1.0
In-Reply-To: <1454874438-5081-8-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 07/10] Create separate function for
 replay check
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
> In preparation for AEAD cipher modes, which will need the same
> functionality.
>
> Should not change any behaviour.

ACK. Passing gc instead of using an own gc does not really matter in
this case.

Arne


