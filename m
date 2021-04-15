References: <20210415114541.1001644-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <78743bd0-6fb1-9cfa-8f1b-6acd7435ed78@...2181...>
Date: Thu, 15 Apr 2021 17:47:03 +0200
MIME-Version: 1.0
In-Reply-To: <20210415114541.1001644-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Remove LibreSSL specific defines not
 needed for modern LibreSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 15/04/2021 13:45, Arne Schwabe wrote:
> Most of the functions remove were either already have a version check
> against LibreSSL 2.9.0 or are also now deprecated in LibreSSL as well
> according to the man pages in OpenBSD 6.8 like SSL_CTX_set_ecdh_auto
> and SSL_library_init.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

This patch is changing the LibreSSL ifdef logic only, therefore no
functional change is expected for OpenSSL (the only SSL library sharing
code with this patch).

I compile tested with:
* LibreSSL 2.9.3, 3.2.5 and 3.3.0
* OpenSSL 1.0.2, 1.1.0 and 1.1.1

Basic connection test (client connects to server and pings) was
performed with:

* LibreSSL 2.9.3
* OpenSSL 1.0.2

Acked-by: Antonio Quartulli <antonio@...515...>

Regards,

-- 
Antonio Quartulli

