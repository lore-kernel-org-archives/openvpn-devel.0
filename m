References: <20210325000121.10331-1-arne@...1227...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <214c73d3-e650-8766-b97d-fb14c5367673@...68...>
Date: Thu, 25 Mar 2021 20:29:20 +0100
MIME-Version: 1.0
In-Reply-To: <20210325000121.10331-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Deprecate non TLS mode in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am 25.03.21 um 01:01 schrieb Arne Schwabe:
> The non-TLS mode is a relict from OpenVPN 1.x or 2.0. When tls mode was
> introduce the advantages of TLS over non-tls were small but tls mode
> evolved to include a lot more features. (NCP, multipeer, AEAD ciphers to =
name
> a few).
>
> Today VPN that use --secret are mainly used because of its relative easy =
to
> setup and requiring to setup a PKI. This shortcoming of TLS mode should be
> addressed now with the peer-fingerprint option.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>

NAK.

Arne,

I find the reasons you present to withdraw the symmetric non-TLS mode
too weak to justify its deprecation or removal. Yes, TLS-based
configurations may be more feature-rich, but those are not mandatory and
we should not paternalize the users here. Is there a considerable
technical debt to keeping the --secret option?=C2=A0 WireGuard seems to be
becoming quite popular and it provides low-ceremony setups - just as
openvpn --secret does.=C2=A0

And to make a blunt point, it's not useless just because it's old, else
we should nuke DNS and SMTP.

Regards,
Matthias



