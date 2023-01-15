Message-ID: <ca380641-d0a0-ade7-2225-c17df3ba28fc@...1227...>
Date: Sun, 15 Jan 2023 17:17:44 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
 <f52172ec20da430975373e7192380874bc600062.camel@...2316...>
 <43485320-4957-8ac1-7bab-4e769000d156@...1227...>
 <234ef71a00e43f74bda0836d66c63a3d8c54a74c.camel@...2316...>
 <af0497ca-b862-6a5c-f5ff-eb0d34a84692@...1227...>
 <0456a9e2e317af58f1aa6947c768ac7853c06485.camel@...2316...>
 <334bc5ad-1d55-208b-bbaf-2233c4708d9f@...1227...>
 <f24287289b084285b67fc1a7fb26714fec3f0bbc.camel@...2316...>
 <79a79fe0-978b-020d-83f2-026299e7337e@...1227...>
 <CAFHpkQH-XCkzoY70AMQvZSeC9LVfrabnu6nSKmthq_-cxUw=Dg@...278...>
 <df394682-d609-4c08-7fbb-38b393b9a481@...1227...>
 <CAFHpkQGpA6gs5hfevrgW1HbZhetCaGCgxuDxFUi9PowboYMsnw@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAFHpkQGpA6gs5hfevrgW1HbZhetCaGCgxuDxFUi9PowboYMsnw@...278...>
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: James Bottomley <James.Bottomley@...2317...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 15.01.23 um 17:12 schrieb Илья Шипицин:
> that means
> 
> 1) distributing openssl dll for windows installer is illegal
> 2) distributing openssl/libressl with tunnelblick is illegal
> 

It means the exception for OpenSSL applies to it and it is on very solid 
ground (at least with OpenSSL up to 1.1.1). It should be also safe with 
OpenSSL 3.0 but interpretation of the clause is not 100% clear with 
OpenSSL's license change, so we want to reaffirm that.

Arne


