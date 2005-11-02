From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0.4 Released -- Note security fixes
Message-ID: <20051102082433.GA3710@...33...>
References: <Pine.LNX.4.58.0511011238570.16655@...41...> <20051101222421.GA15094@...33...> <Pine.LNX.4.58.0511012351170.13189@...41...>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0511012351170.13189@...41...>
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
Date: Wed Nov  2 00:25:23 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Tue, 01 Nov 2005, James Yonan wrote:

> On Tue, 1 Nov 2005, Matthias Andree wrote:
> 
> > ...      however I found that the easy-rsa/2.0/ directory disappeared,
> > it was present in 2.0.2 and gone in 2.0.4. What's the story about
> > easy-rsa/* and easy-rsa/2.0/* in the distribution tarballs, and what has
> > become of easy-rsa/2.0 in release 2.0.4?
> 
> That's an oversight...  It looks like it was accidently dropped from the 
> tarball during the CVS -> SVN migration.
> 
> It is, however, present (and the default) in the 2.1-beta releases in
> easy-rsa/

Could you perhaps provide a tarball that unpacks into
openvpn-2.0.4/easy-rsa/2.0/ at the same place as the
openvpn-2.0.4.tar.gz?

The FreeBSD port is now at version 2.0.4, I'd however like to restore
the 2.0.2 file layout with easy-rsa/2.0 in place in a revision of the
port (2.0.4_1 perhaps).

An officially shipped easy-rsa-2.0[_rc1] tarball would help us
distributors quite a bit. FreeBSD prefers readable patches or files in
the ports system over binary (i. e. a "shar" archive or perhaps
uuencoded .tar.gz), and while I could theoretically ship a uuencoded
.tar.gz, I'd prefer not to bloat the FreeBSD ports (which are actually
only build instructions, file lists, MD5 sums) with another 50 or
perhaps 14 kB.

-- 
Matthias Andree

