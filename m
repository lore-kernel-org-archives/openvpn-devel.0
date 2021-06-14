References: <f40e6882-da83-ae0a-2230-ab1cbbe3d0c1@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <50df7743-5541-40dd-c2ea-f81e3ad9c29c@...1227...>
Date: Mon, 14 Jun 2021 02:56:01 +0200
MIME-Version: 1.0
In-Reply-To: <f40e6882-da83-ae0a-2230-ab1cbbe3d0c1@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] TLS Error: local/remote TLS keys are out of sync
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 14.06.21 um 02:24 schrieb Antonio Quartulli:
> @Arne, ideas?
> 

Yes. When reneg-sec is below 60 or 120 (would need to double check), you
need that value on both server and client since otherwise the timeouts
for changing active keys mismatch as the value is 60s normally but
changes if reneg-sec goes below that value.


> I start the server this way:
> 
> ${OVPN} \
> 	--server 10.10.0.0 255.255.255.0 \
> 	--dev tun \
> 	--cipher AES-256-GCM \
> 	--peer-fingerprint ${FP} \
> 	--cert ${CERT} --key ${KEY} \
> 	--verb 3 --dh none --auth-user-pass-verify auth.sh via-env
> --script-security 3
> 
> and the client this way:
> 
> ${OVPN} --dev tun --client --remote 10.10.10.1 \
> 	--cipher AES-256-GCM \
> 	--peer-fingerprint ${FP} \
> 	--cert ${CERT} --key ${KEY} --verb 3 --reneg-sec 20 --auth-user-pass


