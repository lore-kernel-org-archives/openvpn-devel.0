Date: Tue, 27 Jan 2009 17:34:01 +0100
From: Jos Vos <jos@...1120...>
Message-ID: <20090127163401.GA29730@...1119...>
References: <20090127135710.GA28793@...1119...>
	<20090127154519.GA14543@...33...>
Mime-Version: 1.0
In-Reply-To: <20090127154519.GA14543@...33...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc15 GCC 2.96 incompatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tue, Jan 27, 2009 at 04:45:19PM +0100, Matthias Andree wrote:

> Come on, nobody needs support for outdated operating systems and rogue
> releases of GCC. There has never been a GCC 2.96, and Redhat 7.3 has
> been out of security support for more than half a decade now, and if
> OpenVPN 2.1 breaks on such systems, that's perhaps some more incentive
> for their users to upgrade. See:
> 
> * <http://gcc.gnu.org/gcc-2.96.html>
> * <http://www.redhat.com/security/updates/eol/>

The rc10 ChangeLog says

* Fixed separate compile errors in options.c and ntlm.c that occur
  on strict C compilers (such as old versions of gcc) that require
  that C variable declarations occur at the start of a {} block,
  not in the middle.

so I thought this might fall into the same category (although I don't
know if this way of using the C preprocessor is formally allowed or
not).  But I don't mind *not* sharing this kind of patches anymore in
the future, if that bothers people too much.

And yes, I do know the status of old RH and GCC releases and I do
know that this patch is not necessary for "normal" use.

-- 
--    Jos Vos <jos@...1120...>
--    X/OS Experts in Open Systems BV   |   Phone: +31 20 6938364
--    Amsterdam, The Netherlands        |     Fax: +31 20 6948204

