Message-ID: <9e0cf0bf0709221104s79c10d18x426d8b29351b7720@...278...>
Date: Sat, 22 Sep 2007 20:04:53 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <20070922172545.GA6614@...997...>
MIME-Version: 1.0
References: <20070922172545.GA6614@...997...>
Subject: Re: [Openvpn-devel] [PATCH v3] Use CryptoAPI CA store
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Faidon Liambotis <paravoid@...334...>
Cc: openvpn-devel@lists.sourceforge.net

On 9/22/07, Faidon Liambotis <paravoid@...334...> wrote:
> Hello,
> Below you will find a revised version of a patch that I sent almost 9
> months before.
>
> It allows OpenVPN to verify certificates agains the Windows Certificate Store.
>
> Changed since v2:
>  * Replace the global variable by a TLS options variable
>  * Added relevant man page entry
>  * Minor bugfixes (more #ifdef WIN32 to guard the variable declaration,
>    spelling error etc.)
>  * diff against 2.1-rc4 instead of rc1

Why not use SSL_CTX_add_client_CA and add all CAPI root store into
OpenSSL context?

Alon.

