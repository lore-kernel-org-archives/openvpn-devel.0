From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Trying to use zlib with openvpn
Message-ID: <20040527140719.GA14886@...33...>
References: <twig.1085639189.5380@...41...> <000901c443c1$0e954830$0100a8c0@...226...>
Mime-Version: 1.0
In-Reply-To: <000901c443c1$0e954830$0100a8c0@...226...>
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
Date: Thu May 27 07:08:09 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thu, 27 May 2004, Ming-Ching Tiew wrote:

> OK thanks for the response.  Upon closer investigation, I
> found that it is my own problem. The LZO_COMPRESS is
> taking the parameters as (source, source_len, dst, dest_len)
> whereas zlib compress is  (dest, dest_len, source, source_len).
> 
> Therefore I just turned them around. It is now working !!!
> 
> My next question is whether anyone has a comparison of LZO
> and zlib in terms of relative time taken to compress. In addition,
> the zlib compress2() has a compression level parameter, I would
> also need to know how it fairs comparing with compress().

I don't have a URL at hand and no time to search, try looking for
"archive shootout" or "archiver shootout" in the web (Google perhaps)
and at the LZO home page. LZO boasts its speed, and the LZO home page
might have figures.

HTH,
Matthias

