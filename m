Subject: Re: [Openvpn-devel] --tls-cipher documentation bug
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1067375167.55937@...41...>
In-Reply-To: <1067328520.7131.321.camel@...125...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Oct 28 13:09:04 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Teemu Kiviniemi <teemuki@...124...>, openvpn-devel@lists.sourceforge.net

Teemu,

Thanks for the --tls-remote and --tls-cipher patches.  I've merged them and
they will be included in the next 1.5 beta release.

James

Teemu Kiviniemi <teemuki@...124...> said:

> Hi,
> 
> I think I found a bug in the openvpn(8) man page:
> 
> > --tls-cipher l
> >     A  list  l  of allowable TLS ciphers separated by |
> 
> When I use the character '|' to separate the ciphers, OpenSSL complains.
> The correct format is described in the ciphers(1) man page:
> 
> > CIPHER LIST FORMAT
> > The cipher list consists of one or more cipher strings separated
> > by colons.  Commas or spaces are also acceptable separators but colons
> > are normally used.
> 
> I changed '|' to be ':'. The patch is available at:
> http://iki.fi/teemuki/openvpn/cvs-docfix.diff
> 
> The patch is against EXP15 CVS branch with my cvs-tlsremote.diff merged.
> The patch changes also the help text in options.c.
> 
> Teemu
> 
> 



-- 




