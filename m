From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
Message-ID: <20050626171742.GA20568@...33...>
References: <200506141234.50171.nomis80@...401...> <200506231324.52051.nomis80@...401...> <Pine.LNX.4.58.0506231750330.10675@...41...> <200506250929.27797.nomis80@...422...>
Mime-Version: 1.0
In-Reply-To: <200506250929.27797.nomis80@...422...>
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
Date: Sun Jun 26 10:20:27 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sat, 25 Jun 2005, Simon Perreault wrote:

> That's why RPMs are built on a per-distro basis. You usually can't
> assume that an RPM compiled on FC3 will work on FC4. I tried to
> explain that point to my boss at my previous job but we ended up
> cross-compiling on Gentoo for Suse 9.2 and FC2 anyway. I bet they've
> run into a lot of trouble and now have dedicated build machines
> running the target distros.

An RPM for an older distribution should generally work on a newer
version of the same distro, so your boss's expectation was right - at
least it usually works on FreeBSD and Solaris, if it doesn't work on
Linux, Linux must improve in this compatibility regard.

If I need an RPM for several versions of the same distribution, I
usually compile on the oldest available and it usually works.

Notable exception being kernel modules perhaps.

-- 
Matthias Andree

