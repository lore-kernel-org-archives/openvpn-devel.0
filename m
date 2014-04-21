Message-ID: <5354F1DE.8050604@...1856...>
Date: Mon, 21 Apr 2014 12:24:30 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1398064204-26476-1-git-send-email-james@...515...>
	<1398064204-26476-4-git-send-email-james@...515...>
In-Reply-To: <1398064204-26476-4-git-send-email-james@...515...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] When tls-version-min is unspecified,
 revert to original versioning approach.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 21-04-14 09:10, James Yonan wrote:
> For OpenSSL, this means to use TLSv1_(client|server)_method rather
> than SSLv23_(client|server)_method combined with SSL_OP_NO_x flags
> for specific TLS versions to disable.

I'm not sure I understand the rationale behind this. If I don't specify
a minimum version, my maximum version changes to TLS 1.0? Could you
maybe explain the "why" for this patch?

-Steffan

