Message-ID: <55225864.7020804@...1856...>
Date: Mon, 06 Apr 2015 11:56:52 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <54AC78FD.3010806@...515...>
In-Reply-To: <54AC78FD.3010806@...515...>
Subject: Re: [Openvpn-devel] OpenVPN protocol extensions update
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 07-01-15 01:08, James Yonan wrote:
> I've updated the OpenVPN protocol extension doc with additional details,
> now that more of these features have been implemented in OpenVPN 3.
>
> If you are implementing any of these features in OpenVPN 2.x, please
> review so we can ensure that OpenVPN 2.x and 3 are on the same page with
> respect to protocol extensions.

Sorry for being this slow to publicly respond.  There has been some 
discussion off-list, but I'd like to publicly mention my comments on the 
AEAD and NCP parts too.

 >    AEAD Nonce:
 >
 >      [ Packet ID ] [ HMAC keying material ]
 >      [ 4 bytes   ] [ 8 bytes              ]
 >      [ AEAD nonce total: 12 bytes         ]
 >
 >    TLS wire protocol:
 >
 >      [ DATA_V2 opcode ] [ Packet ID ] [ AEAD Auth tag ] [ ciphertext ]
 >      [ 4 bytes        ] [ 4 bytes   ] [ 16 bytes      ]
 >      [ AEAD additional data (AD)    ]

Agreed. I would have preferred to put the AEAD auth tag at the end of 
the packet (since that would put the additional data and ciphertext 
right next to each other), but this works for me too.

 >    Static Key wire protocol:
 >
 >      [ DATA_V2 opcode ] [ Packet ID ] [ Nonce tail (random) ]  [ AEAD 
Auth tag ] [ ciphertext ]
 >                         [           AEAD nonce              ]
 >      [ 4 bytes        ] [ 8 bytes   ] [ 4 bytes             ]  [ 16 
bytes      ]
 >      [ AEAD additional data (AD)                            ]

I think we should not support GCM in static key mode.  Reusing a 
nonce/key combination in GCM very bad, and guaranteeing that will never 
happen is tricky for static key mode.  Particularly on constrained 
devices (where using static key mode makes sense), proper time for the 
packet ID might not be available, and random might be bad.  Even if 
there is proper random, the birthday bound for the 32-bit nonce tail is 
only 2^16 (65536) packets.

Iirc, we agreed to not support GCM is static key mode before off-list, 
but I wanted to publicly mention this.

 >    When negotiating AEAD mode, the client indicates its support
 >    of AES-128-GCM, AES-192-GCM, and AES-192-GCM by including:
 >
 >      IV_NCP=2
 >
 >    in the peer info string (NCP stands for Negotiable Crypto
 >    Parameters).
 >
 >    When the IV_NCP value is 2 or higher, it indicates that
 >    the server may push an AEAD "cipher" directive, e.g.:
 >
 >      push "cipher AES-128-GCM"

We can use this as an upgrade path to GCM, but I think we will need to 
come up with a more elaborate negotiation mechanism at some point.

For now, some review comments about NCP=2:

  * Will there be a configuration option to enable/disable NCP?
    As a client or server, I might not want any dynamic behaviour, but
    instead be in full control.  How about a '--ncp', which a user
    can set to the ncp version to use, or '0' to disable NCP.

  * How does a server choose the cipher?
    Here too, I think we need a configuration directive.  We could merge
    it with the '--ncp' above, where any arguments after the version are
    interpreted based on the NCP version.  E.g. '--ncp 2 AES-128-GCM'
    would result in the server pushing AES-128-GCM if the client
    indicates support for NCP=2.

  * This mechanism gives a client little to say about the cipher.
    It would be nice if a client could somehow enforce e.g. AES-256-GCM
    instead of AES-128-GCM.

 >    In the future, the IV_NCP value (2 in the current
 >    implementation) may be increased to indicate the
 >    availability of additional negotiable ciphers.

Next to the ability to add negotiable ciphers, we should think about how 
to restrict the offered ciphers in the future.

-Steffan

