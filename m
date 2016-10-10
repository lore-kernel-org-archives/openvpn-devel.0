References: <20161010073931.54469-1-gert@...1296...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <bbd8ce5c-b7fc-aa14-358a-76ce1484dfe9@...68...>
Date: Mon, 10 Oct 2016 19:23:33 +0200
MIME-Version: 1.0
In-Reply-To: <20161010073931.54469-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Enable -D_SVR4_2 for compilation on
 Solaris
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 10.10.2016 um 09:39 schrieb Gert Doering:
> +		CPPFLAGS="$CPPFLAGS -D_XPG4_2"
NAK. Description mismatches content. Please revert and reapply with
proper description.

