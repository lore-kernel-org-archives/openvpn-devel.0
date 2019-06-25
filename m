References: <20190613134834.5709-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c256f078-6164-59b0-1cc4-0689a5da84e9@...2080...>
Date: Tue, 25 Jun 2019 22:08:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190613134834.5709-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v4 2/7] Implement --genkey type keyfile
 syntax and migrate tls-crypt-v2
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

On 13/06/2019 15:48, Arne Schwabe wrote:
> This unifies our key generation and also migrates the generation
> of the tls-crypt-v2 keys. Since tls-crypt-v2 is not included in any
> released version, we remove the the old syntax without compatibility.
> 
> PATCH V4: Introduce warning/error when using --secret with --genkey
>           Update non code usages to use new --genkey syntax
> ---
>  INSTALL                                |  2 +-
>  doc/openvpn.8                          | 81 ++++++++++++++------------
>  sample/sample-config-files/server.conf |  2 +-
>  sample/sample-keys/gen-sample-keys.sh  |  2 +-
>  sample/sample-windows/sample.ovpn      |  2 +-
>  src/openvpn/crypto.c                   |  2 +-
>  src/openvpn/init.c                     | 71 ++++++++++++++--------
>  src/openvpn/options.c                  | 67 +++++++++++++--------
>  src/openvpn/options.h                  | 11 +++-
>  tests/t_lpback.sh                      |  8 +--
>  10 files changed, 151 insertions(+), 97 deletions(-)
> 

Acked-by: David Sommerseth <davids@...515...>

Looks good now, 'make check' passes and behaviour is more consistent.



-- 
kind regards,

David Sommerseth
OpenVPN Inc


