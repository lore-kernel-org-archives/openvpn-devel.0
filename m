Message-ID: <000901c443c1$0e954830$0100a8c0@...226...>
From: "Ming-Ching Tiew" <mingching.tiew@...225...>
References: <twig.1085639189.5380@...41...>
Subject: Re: [Openvpn-devel] Trying to use zlib with openvpn
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu May 27 01:04:01 2004
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


> Make sure that you define
>
> #define LZO_EXTRA_BUFFER(len) ((len)/64 + 16 + 3)       /* LZO worst case
size
> expansion. */
>
> for zlib.
>

OK thanks for the response.  Upon closer investigation, I
found that it is my own problem. The LZO_COMPRESS is
taking the parameters as (source, source_len, dst, dest_len)
whereas zlib compress is  (dest, dest_len, source, source_len).

Therefore I just turned them around. It is now working !!!

My next question is whether anyone has a comparison of LZO
and zlib in terms of relative time taken to compress. In addition,
the zlib compress2() has a compression level parameter, I would
also need to know how it fairs comparing with compress().

Thanks once again.









