From: Matthias Andree <matthias.andree@...68...>
Subject: Re: [Openvpn-devel] compiling statically - how?
Message-ID: <20040804231213.GB21349@...33...>
References: <411111B9.2000405@...259...>
Mime-Version: 1.0
In-Reply-To: <411111B9.2000405@...259...>
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
Date: Wed Aug  4 21:56:01 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Tomasz Chmielewski <mangoo@...259...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 04 Aug 2004, Tomasz Chmielewski wrote:

> I was thinking of an option like ./configure --compile-statically - and 
> with such compiled binary, I wouldn't have to install compilers, compile 
> OpenVPN, deinstall compilers on every machine I want it to run.

My first attempt would probably be ./configure CC="gcc -static" - it's
untested and may require the installation of static libraries on some
systems.

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)

