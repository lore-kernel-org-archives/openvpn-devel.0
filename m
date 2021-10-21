References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-4-arne@...1227...>
 <a8e16056-5e9d-11e8-c517-129d4cfd122c@...2507...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fedfbeb1-d318-37ff-f022-81fa28c3235c@...1227...>
Date: Thu, 21 Oct 2021 11:41:25 +0200
MIME-Version: 1.0
In-Reply-To: <a8e16056-5e9d-11e8-c517-129d4cfd122c@...2507...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3 03/21] [OSSL 3.0] Implement DES ECB
 encrypt via EVP_CIPHER api
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Max Fillinger <maximilian.fillinger@...2507...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 20.10.21 um 19:36 schrieb Max Fillinger:
> On 19/10/2021 20:31, Arne Schwabe wrote:
>> +    if (!EVP_EncryptInit_ex(ctx, EVP_bf_ecb(), NULL, key, 0))
> 
> EVP_bf_ecb() is the Blowfish cipher, not DES.
> 

Oops. I probably need to write a unit test for this one too. Because
that sounds like I broke this.

Arne

