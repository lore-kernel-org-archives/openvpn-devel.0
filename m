From: Heiko Hund <heiko@...2662...>
Date: Tue, 28 Jun 2022 17:46:40 +0200
Message-ID: <10438362.6d2rlngR5E@...2664...>
In-Reply-To: <202206281507.25SF7EVp045610@...2054...>
References: <20220624083809.23487-2-a@...2181...>
 <202206281507.25SF7EVp045610@...2054...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH applied] Re: dco: introduce low-level
 code for handling ovpn-dco in the Linux kernel
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

On Dienstag, 28. Juni 2022 17:07:14 CEST Gert Doering wrote:
> Uncrustify has complained at me when I merged the patch (because in that
> moment, ovpn_dco_linux.h was "newly modified" and the exclusion rule
> does not match on the pre-commit-hook) - but as discussed, this is a bit
> complicated due to "kernel style" vs "openvpn style", so I've left it
> alone for the moment.

That's something which needs to be improved. Who is dev-tools/special-files.lst 
intended for? Can uncrustify read it?

Heiko



