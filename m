References: <20181006080617.18136-1-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <f0a52eaf-0da0-c46c-03df-a1e8851dc5e9@...1856...>
Date: Sat, 6 Oct 2018 11:04:36 +0200
MIME-Version: 1.0
In-Reply-To: <20181006080617.18136-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/3] Factor out
 convert_tls_list_to_openssl method
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

Two minor nits:

On 06-10-18 10:06, Arne Schwabe wrote:
> This makes the tls_ctx_restrict_ciphers function more readable and
> clean ups the code a bit more.

The signed-off-by tag is missing.

>                  "Failed to set restricted TLS cipher list, too long (>%d).",
> -                (int)sizeof(openssl_ciphers)-1);
> +                  (int)(len - 1));

This breaks the indenting alignment, there should be two less spaces.

Otherwise this makes sense and does not introduce any logical changes.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

