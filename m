References: <9a1a18c6-67ff-73ad-69aa-bbb75df45490@...515...>
 <07d3e88f-6f34-79b3-7244-a057b0820443@...515...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <4b142edb-34f0-2b53-8012-8b8d553de323@...1147...>
Date: Wed, 19 Dec 2018 17:00:04 +0100
MIME-Version: 1.0
In-Reply-To: <07d3e88f-6f34-79b3-7244-a057b0820443@...515...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 19th Dec 2018)
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
To: openvpn-devel@lists.sourceforge.net

Hi list,

as a follow-up to the discussion we had in the community meeting:
> (13:38:08) dazo: janjust: if you get a chance to verify whether using non=
-ncp-listed cipher works with ccd, that's a good detail to know

the answer is: yes and no ;)

Yes, it is possible to specify a *NEW* list of ncp ciphers in a CCD=20
file, overruling what is specified globally, provided that this same=20
"new" list of NCP ciphers is specified on the client side. This means=20
that the maximum *cipher* length is dependent on whatever is specified=20
in a CCD file. However, most ciphers used nowadays are 256 bits (32=20
bytes) in length anyways, so the impact on the maximum cipher length is=20
quite small.

No, it is NOT possible to specify a new "auth" parameter, e.g. "auth=20
sha512" as this would break many things, including tls-crypt. Thus,=20
there is no need to do a "worst case" calculation inside=20
"crypto_max_overhead()" to determine the biggest HMAC value possible.=20
Whatever is specified globally is as big as it will get.

My current conclusion is that the crypto_max_overhead function needs a=20
significant rewrite. The current code is:

 =A0755 size_t
 =A0756 crypto_max_overhead(void)
 =A0757 {
 =A0758=A0=A0=A0=A0 return packet_id_size(true) + OPENVPN_MAX_IV_LENGTH
 =A0759=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +OPENVPN_MAX_CIPHER_BLOCK_SIZE
 =A0760=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +max_int(OPENVPN_MAX_HMAC_SIZE, OP=
ENVPN_AEAD_TAG_LENGTH);
 =A0761 }

Question:=A0=A0 is the packet_id part of the crypto?=A0 or is packet_id use=
d,=20
regardless of whether crypto is used at all? If so, then the=20
packet_id_size needs to be removed from this function.

I'd be in favor of updating the above code to
- take into account the space allocated for the default/globally=20
specified crypto; if the default/globally specified crypto is at the=20
maximum value (currently 256 bits) then don't bother calculating a worst=20
case value
- determine *at runtime* the worst case scenario for the crypto=20
overhead, possibly by checking if client-config-dir and/or=20
client-connect script or plugin is specified. If one of those IS=20
specified, then allocate more space, otherwise use the largest cipher=20
length from the first step.
- figure out whether the OPENVPN_MAX_IV_LENGTH is needed whenever an=20
AEAD cipher is used - in which case the overhead needs to be calculated=20
differently.

I hope others like syzzer can comment on my proposal :)

share and enjoy,

JJK


