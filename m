Date: Wed, 9 Feb 2022 15:54:39 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1601040617.129220.1644418479406@...2642...>
In-Reply-To: <bd326838-2774-93db-1566-675813e20245@...2080...>
References: <20220208114905.100-1-lstipakov@...277...>
 <1019065492.66755.1644353962956@...2642...>
 <bd326838-2774-93db-1566-675813e20245@...2080...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] msvc: cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn@...2080...>
Cc: Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net

> David Sommerseth <openvpn@...2080...> hat am 09.02.2022 15:19 geschrieben:
> 
>  
> On 08/02/2022 21:59, Frank Lichtenheld wrote:
> > One thing I noticed while building:
> > 
> > FOR /F %i IN ('where rst2html.py') DO python %i "c:\OpenVPN\openvpn\/doc/openvpn.8.rst" "c:\OpenVPN\openvpn\/doc/openvpn.8.html"
> > 
> > This is clearly outdated code from before the rst split. But probably not something that needs to be addressed in this patch.
> 
> The openvpn.8.rst includes all the other .rst files and builds a 
> complete man page from there, so this isn't unexpected.  It's part of 
> the man-split design.

Yeah, I was confused. There was a "file not found" warning, but that is about rst2html.py, not openvpn.8.rst.

Regards,
--
Frank Lichtenheld

