References: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
 <20201004160510.GN976@...1296...>
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
Message-ID: <51d6ba69-e7bc-027f-47cc-1f9a6192b17c@...2318...>
Date: Sun, 4 Oct 2020 19:32:36 +0200
MIME-Version: 1.0
In-Reply-To: <20201004160510.GN976@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] with IPv6 VPN connection,
 IPv4 traffic does not get router over VPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 10/4/20 6:05 PM, Gert Doering wrote:
> If you build your own openvpn, I'd appreciate quick feedback :-) -
> otherwise, we'll release a RC3 "this week", so you can test this with
> pre-built binaries as well.

Just tested it on Linux, and it works like a charm now! I was already
running OpenVPN 2.5 on my desktop, but never ran into this issue as
NetworkManager takes care of routing all traffic over the VPN, no matter
the redirect-gateway flags.

Testing it from the CLI shows the bug in rc2. It works now with the
latest version from release/2.5.

Tested with:

2020-10-04 19:27:04 OpenVPN 2.5_rc2 [git:release/2.5/7b4f53095c761bde]=20
x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO]=20
[AEAD] built on Oct  4 2020
2020-10-04 19:27:04 library versions: OpenSSL 1.1.1g FIPS  21 Apr 2020,=20
LZO 2.10

I don't have Windows building setup, so that will have to wait until rc3 :)

Thanks!

Regards,
Fran=E7ois

