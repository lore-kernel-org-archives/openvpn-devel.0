References: <20210317181153.83716-1-juliusz@...2525...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c222bad7-1a5c-e8c7-1c20-d8af29d0dced@...1227...>
Date: Thu, 18 Mar 2021 13:28:38 +0100
MIME-Version: 1.0
In-Reply-To: <20210317181153.83716-1-juliusz@...2525...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
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
To: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net

Am 17.03.21 um 19:11 schrieb Juliusz Sosinowicz:
> This patch adds support for wolfSSL in OpenVPN. Support is added by using wolfSSL's OpenSSL compatibility layer. Function calls are left unchanged and instead the OpenSSL includes point to wolfSSL headers and OpenVPN is linked against the wolfSSL library. The wolfSSL installation directory is detected using pkg-config.
> 
> As requested by OpenVPN maintainers, this patch does not include wolfssl/options.h on its own. By defining the macro EXTERNAL_OPTS_OPENVPN in the configure script wolfSSL will include wolfssl/options.h on its own (change added in https://github.com/wolfSSL/wolfssl/pull/2825). The patch adds an option `--disable-wolfssl-options-h` in case the user would like to supply their own settings file for wolfSSL.
> 
> wolfSSL:
> Support added in: https://github.com/wolfSSL/wolfssl/pull/2503
> ```
> git clone https://github.com/wolfSSL/wolfssl.git
> cd wolfssl
> ./autogen.sh
> ./configure --enable-openvpn
> make
> sudo make install
> ```
> 
> OpenVPN:
> ```
> autoreconf -i -v -f
> ./configure --with-crypto-library=wolfssl
> make
> make check
> sudo make install
> ```
>

Acked-By: Arne Schwabe <arne@...1227...>

@Gert, can you also ACK/commit the README patch?
(https://patchwork.openvpn.net/patch/1087/)

