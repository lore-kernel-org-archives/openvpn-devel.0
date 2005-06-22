From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
Message-ID: <20050622151050.GA4924@...33...>
References: <200506141234.50171.nomis80@...401...> <200506211059.31506.nomis80@...401...> <Pine.LNX.4.58.0506212216440.10675@...41...> <200506220836.53588.nomis80@...401...>
Mime-Version: 1.0
In-Reply-To: <200506220836.53588.nomis80@...401...>
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
Date: Wed Jun 22 08:11:26 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, 22 Jun 2005, Simon Perreault wrote:

> +# If PAM modules are not linked against libpam.so, set DLOPEN_PAM to 1. This
> +# must be done on SUSE 9.1, at least.
> +DLOPEN_PAM=0
> +
> +ifeq ($(DLOPEN_PAM),1)
> +	LIBPAM=-ldl
> +else
> +	LIBPAM=-lpam
> +endif

Is this portable to non-GNU makes?
If it is not, does OpenVPN require GNU make? I don't think it does.

Is there a broken-out C program that fails to link at run-time if the
workaround is required? This would be tested from configure.{in|ac} and
set DLOPEN_PAM appropriately.

-- 
Matthias Andree

