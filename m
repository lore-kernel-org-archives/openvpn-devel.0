References: <dc5c81c1-7529-07a9-2e53-750fec37ed56@...1856...>
 <20200217120340.20995-1-arne@...1227...>
 <CAGyAFMWHY=TuhkmDTC0XNAtskmjufU6SFA-HrSs6np4Rvctvcg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <f6c1bf53-c8fd-c708-ac85-8b666da362ef@...1227...>
Date: Mon, 18 May 2020 00:55:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAGyAFMWHY=TuhkmDTC0XNAtskmjufU6SFA-HrSs6np4Rvctvcg@...278...>
Content-Language: en-GB
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>


> Cannot we set some bit flags in options processing, like
>
> COMP_WARN_GENERIC  1 << 0 // Compression enabled, Compression has been
> used in the past to break encryption.
> COMP_WARN_ASYNC  1 << 1 // Enabling decompression of received packet
> only. Sent packets are not compressed.
> COMP_WARN_ALLOWED_YES  1 << 2 // Using '--allow-compression yes' is
> strongly discouraged for common usage. See --compress in the manual
> page for more information
>
> and handle them in options postprocessing -  excluding
> COMP_ENABLED_WARN_ASYNC if COMP_ENABLED_WARN_YES is set and printing
> the message?
>
Same explaination as last time when Steffan reviewed this patch. The
warning should also show up in pushed options. And I don't want to
complicate the logic for to avoid an extra warning for a corner case. We
reword the message a bit so that two messages are not that bad if both
are shown:


WARNING: Compression for receiving enabled, Compression
has been used in the past to break encryption. Sent packet are not compress=
 unless "allow-compression yes" is also set.


WARNING: Compression for sending and receiving enabled, Compression has
been used in the past to break encryption. Allowing compression allows
attacks that break encryption. Using '--allow-compression yes' is
strongly discouraged for common usage. See --compress in the manual
page for more information



