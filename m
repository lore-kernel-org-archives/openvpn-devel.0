From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0.4 Released -- Note security fixes
In-Reply-To: <20051101222421.GA15094@...33...>
Message-ID: <Pine.LNX.4.58.0511012351170.13189@...41...>
References: <Pine.LNX.4.58.0511011238570.16655@...41...>
 <20051101222421.GA15094@...33...>
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
Date: Tue Nov  1 22:59:03 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Tue, 1 Nov 2005, Matthias Andree wrote:

> On Tue, 01 Nov 2005, James Yonan wrote:
> 
> > This release contains fixes for two security issues that just came to my
> > attention over the past 24 hours, which affect OpenVPN 2.0, 2.0.1, 2.0.2,
> > and the 2.1 beta series.  OpenVPN 1.x is not affected.
> 
> Thanks for the quick fixes.
> 
> I understand that the release focus has been anything but helper
> scripts, however I found that the easy-rsa/2.0/ directory disappeared,
> it was present in 2.0.2 and gone in 2.0.4. What's the story about
> easy-rsa/* and easy-rsa/2.0/* in the distribution tarballs, and what has
> become of easy-rsa/2.0 in release 2.0.4?

That's an oversight...  It looks like it was accidently dropped from the 
tarball during the CVS -> SVN migration.

It is, however, present (and the default) in the 2.1-beta releases in
easy-rsa/

You can also get it directly from the svn repository:

http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn/easy-rsa/

James


