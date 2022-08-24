Message-ID: <d948db75-b3ae-e922-7247-25556d04ba73@...1227...>
Date: Wed, 24 Aug 2022 14:27:21 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220824105311.71288-1-arne@...1227...>
 <CAFHpkQFi+--ZwcGpr=O+tiy3j1=xU6h0tu=5DYNbqoHj_7i+mA@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAFHpkQFi+--ZwcGpr=O+tiy3j1=xU6h0tu=5DYNbqoHj_7i+mA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add OpenSSL 3.0 to mingw build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 24.08.22 um 13:26 schrieb Илья Шипицин:
> if this is not too late, can we add --libdir=mingw/opt/lib to keep 
> current behaviour ?
> 
> 
> +      # OpenSSL 3.0.5 installs itself into mingw/opt/lib64 instead of
> +      # mingw/opt/lib, so we include both dirs in the following steps
> +      # (pkcs11-helper and OpenVPN) so the libraries will be found
> 

We could but I am not sure why we should force it to be in the other 
directory and deviate from the default of how the libraries are build.

Arne

