Message-ID: <d5cd5009-fbca-4aed-6373-9cf6ec5eae52@...1227...>
Date: Tue, 5 Apr 2022 09:17:15 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <1645504714.939521.1649104349504.ref@...2084...>
 <1645504714.939521.1649104349504@...2084...>
 <d2651134-b06c-c1bd-be49-afa2668d632b@...1227...>
 <1490790889.1011758.1649128231506@...2084...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <1490790889.1011758.1649128231506@...2084...>
Subject: Re: [Openvpn-devel] OpenVPN encryption architecture
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
To: Leroy Tennison <leroy.tennison@...1013...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 05.04.22 um 05:10 schrieb Leroy Tennison:
> Thanks for your reply, I'm actually looking for something pretty 
> high-level like "the server (or client) sends their (whatever key) and 
> the client (or server) (creates a session key from it or whatever 
> happens) and that is used for encryption."  I am also wondering what the 
> client and server keys are used for if not in this process.
>

High level is that we use a TLS 1.0/TLS 1.1 inspired key exchange in 
older versions and nowadays if both server and client are capable of TLS 
EKM, we use TLS EKM to generate key material for encryption of data 
channel.

The server and client keys are used in the TLS session like with any TLS 
session.

Arne

