Date: Tue, 27 Jan 2009 16:45:19 +0100
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20090127154519.GA14543@...33...>
References: <20090127135710.GA28793@...1119...>
MIME-Version: 1.0
In-Reply-To: <20090127135710.GA28793@...1119...>
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

On Tue, 27 Jan 2009, Jos Vos wrote:

> While there were some incompatibilities with older GCC releases
> resolved from RC9 to RC15 (I didn't try the releases RC10-RC14),
> a new incompatibility was introduced concerning the C preprocessor
> in ssl.c: #ifdef's in macro calls do not seem to be allowed with
> GCC 2.96.
> 
> Attached a brute-force patch to fix that.  This patch was tested
> on Red Hat Linux 7.3 with GCC 2.96.

Come on, nobody needs support for outdated operating systems and rogue
releases of GCC. There has never been a GCC 2.96, and Redhat 7.3 has
been out of security support for more than half a decade now, and if
OpenVPN 2.1 breaks on such systems, that's perhaps some more incentive
for their users to upgrade. See:

* <http://gcc.gnu.org/gcc-2.96.html>
* <http://www.redhat.com/security/updates/eol/>

-- 
Matthias Andree

