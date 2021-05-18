References: <20210512131511.1309914-1-arne@...1227...>
 <20210512131511.1309914-10-arne@...1227...>
 <n3em3mH7u7_P9kORtR7dx27nCUaNZq2XLdynQIYd83pPkPDqkp6FiZp4MNIYDy4fBNPbLX44Izq3gGNI9yz_sV8aofHdD0TjDdV00RQERHU=@protonmail.com>
From: Arne Schwabe <arne@...1227...>
Message-ID: <6a826481-8afd-e164-e915-489d6a57040f@...1227...>
Date: Tue, 18 May 2021 14:21:21 +0200
MIME-Version: 1.0
In-Reply-To: <n3em3mH7u7_P9kORtR7dx27nCUaNZq2XLdynQIYd83pPkPDqkp6FiZp4MNIYDy4fBNPbLX44Izq3gGNI9yz_sV8aofHdD0TjDdV00RQERHU=@protonmail.com>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 9/9] Add detailed man page section to
 setup a OpenVPN setup with peer-fingerprint
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
To: tincantech <tincantech@...2282...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 17.05.21 um 19:16 schrieb tincantech:
> Hi,
> 
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Wednesday, 12 May 2021 14:15, Arne Schwabe <arne@...1227...> wrote:
> 
>> This is meant to give new users a quickstart for a useable OpenVPN
>> setup. Our own documentation is lacking in this regard and many often
>> tutorials that can be found online are often questionable in some
>> aspects.
> 
> 
> I believe Openvpn in standard mode (Full PKI) would reject an expired
> client certificate.
> 
> Note: There is absolutely nothing in the manual to confirm this !
> https://build.openvpn.net/man/openvpn-2.5/openvpn.8.html
> On that page there are eight uses of the word 'expire' and they all
> relate to an expired auth-token, this could also probably be improved.
> 
> However, Openvpn in peer-fingerprint mode allows an expired client
> certificate to connect.
> 
> The client log *does* have a 'WARNING: Your certificate has expired!'
> The server log has nothing about an expired client certificate.
> And, as we all know, _who reads their log files_ anyway ?
> 
> The issue here is that the server allows an expired client certificate
> to connect and there is no mention of this change in behaviour.

Yes. We just trust the fingerprint of the certificate. The behaviour to
ignore expiry is a side effect of that. It is kinda designed to be this way.

Arne

