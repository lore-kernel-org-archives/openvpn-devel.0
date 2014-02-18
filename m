Message-ID: <530340C4.5060702@...277...>
Date: Tue, 18 Feb 2014 12:15:16 +0100
From: pietrek -- <pietrek.j@...277...>
MIME-Version: 1.0
References: <5302AADC.80801@...277...> <20140218085500.GU16637@...1296...>
In-Reply-To: <20140218085500.GU16637@...1296...>
Subject: Re: [Openvpn-devel] ECDH support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

> Could you describe in a bit more detail what your patch does?  I don't
> really understand the openssl innards well enough, but am curious.
>
> *If* I understand it correctly, what it does is provide keying material
> (ECDH) to support EC for the TLS handshake, right?  And there isn't actually
> anything in OpenVPN needed (besides provide keying material) as that's
> all "inside OpenSSL".
Yes, openssl does everything for us. I just added option to config.

> So how do you create the key material?
I used function EC_KEY_new_by_curve_name to generate eliptic curve parameters of type specyfied in config file.

> Which parts of the key handshake does it cover?  Signature/Certificates,
> or *only* DH?
Handshake only, EC certificates worked for me without doing anything.
Also, DH didn't work with EC certificates( no such cipher ).

    Piotr Jarosz


