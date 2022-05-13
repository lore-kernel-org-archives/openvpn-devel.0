From: Heiko Hund <heiko@...2662...>
Date: Fri, 13 May 2022 11:46:04 +0200
Message-ID: <1717201.NRGAxHBxdp@...2664...>
In-Reply-To: <93a42f95-e8a7-0134-e33f-c9d3ec479abb@...1227...>
References: <20220511121038.1002898-1-heiko@...2662...>
 <93a42f95-e8a7-0134-e33f-c9d3ec479abb@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] doc: fix literal block in
 tls-options.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Freitag, 13. Mai 2022 10:55:32 CEST Arne Schwabe wrote:
> Am 11.05.22 um 14:10 schrieb Heiko Hund:
> > +  Valid syntax::
> 
> I don't understand this to be honest. I don't have a good about rst but
> all other instances of Valid syntax use the form like what was before
> the patch, e.g.
> 
>    Valid syntax:
> 
>      peer-fingerprint AD:B0:95:D8:09:...
> 
> So why exactly does this one need to be different?

It doesn't need to. :: on an end of line are replaced by a single : and serve 
the same formatting purpose as :: on a separate line followed by a blank line:

https://docutils.sourceforge.io/docs/user/rst/quickref.html#literal-blocks

Thought it is easier on the eye here, because it is possible. The actual 
problem is that a blank line after the :: is missing. Let me know if I should 
send a version with :: separate.

Cheers
Heiko



