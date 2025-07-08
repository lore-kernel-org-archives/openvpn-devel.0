Message-ID: <2d8812b4-6b0c-41bf-a0e2-72c7c35daaf6@...1227...>
Date: Tue, 8 Jul 2025 11:09:52 +0200
MIME-Version: 1.0
References: <20250704082813.99654-2-spike@...1385...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20250704082813.99654-2-spike@...1385...>
Subject: Re: [Openvpn-devel] [PATCH] Replace deprecated
 OpenSSL.crypto.load_crl
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
To: =?UTF-8?Q?Christian_Sch=C3=BCrmann?= <spike@...1385...>, openvpn-devel@lists.sourceforge.net

Am 04.07.25 um 10:28 schrieb Christian Schürmann:
> OpenSSL.crypto.load_crl was deprecated with with pyOpenSSL 23.3.0 and
> eventually removed in 24.3.0. pyOpenSSL recommends using cryptography.x509's
> CRL functions as a replacement.
> See also: https://github.com/pyca/pyopenssl/blob/main/CHANGELOG.rst
> 
> Signed-off-by: Christian Schürmann <spike@...1385...>

Acked-By: Arne Schwabe <arne@...1227...>

