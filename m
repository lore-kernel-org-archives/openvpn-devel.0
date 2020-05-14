MIME-Version: 1.0
References: <dc5c81c1-7529-07a9-2e53-750fec37ed56@...1856...>
 <20200217120340.20995-1-arne@...1227...>
In-Reply-To: <20200217120340.20995-1-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 14 May 2020 16:35:54 +0300
Message-ID: <CAGyAFMWHY=TuhkmDTC0XNAtskmjufU6SFA-HrSs6np4Rvctvcg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4] Make compression asymmetric by
 default and add warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> Warning for comp-lzo/compress are not generated in the post option check
> (options_postprocess_mutate) since these warnings should also be shown
> on pushed options. Moving the showing the warning showing for

Typo in the last sentence.

If I want to use compression and specify algorithm, I got confusing warning=
s:

=E2=9E=9C  openvpn git:(master) =E2=9C=97 sudo src/openvpn/openvpn --config=
 ~/lev.ovpn
--compress lz4-v2 --allow-compression yes
Thu May 14 16:16:26 2020 WARNING:  Compression enabled, Compression
has been used in the past to break encryption. Enabling decompression
of received packet only. Sent packets are not compressed.
Thu May 14 16:16:26 2020 WARNING: Compression enabled, Compression has
beenused in the past to break encryption. Allowing compression allows
attacks that break encryption. Using '--allow-compression yes' is
strongly discouraged for common usage. See --compress in the manual
page for more information
Thu May 14 16:16:26 2020 OpenVPN 2.5_git
[git:master/6001784afd89c4e9+] x86_64-apple-darwin19.4.0 [SSL
(OpenSSL)] [LZO] [LZ4] [MH/RECVDA] [AEAD] built on May 14 2020

1) The first warning is wrong, since I explicitly allowed compression.
Also it has unneeded whitespace in the beginning.

2) The second warning is missing whitespace ("beenused").

>           The logic of warnings etc in options.c has not been changed
>           since adding all the code to mutate_options would a lot more
>           and more complicated code and after discussion we decided that
>           it is okay as is.

Cannot we set some bit flags in options processing, like

COMP_WARN_GENERIC  1 << 0 // Compression enabled, Compression has been
used in the past to break encryption.
COMP_WARN_ASYNC  1 << 1 // Enabling decompression of received packet
only. Sent packets are not compressed.
COMP_WARN_ALLOWED_YES  1 << 2 // Using '--allow-compression yes' is
strongly discouraged for common usage. See --compress in the manual
page for more information

and handle them in options postprocessing -  excluding
COMP_ENABLED_WARN_ASYNC if COMP_ENABLED_WARN_YES is set and printing
the message?

--=20
-Lev

