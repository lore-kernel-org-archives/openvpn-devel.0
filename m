References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-7-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <6e515ad3-2858-c210-6c90-f91808f014a2@...2507...>
Date: Thu, 21 Oct 2021 14:37:09 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-7-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 06/21] [OSSL 3.0] Deprecate
 --ecdh-curve with OpenSSL 3.0 and adjust mbed TLS message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 19/10/2021 20:31, Arne Schwabe wrote:
> OpenSSL 3.0 deprecates SSL_CTX_set_tmp_ecdh() in favour of
> SSL_CTX_set1_groups(3). We already support the SSL_CTX_set1_groups
> using the --tls-groups. Adjust both mbed TLS and OpenSSL 3.0 to
> say that --ecdh-curve is ingored and --tls-groups should be used.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Max Fillinger <maximilian.fillinger@...2507...>

Not much to say here. It compiles and I can see the warning when I use 
the option.

