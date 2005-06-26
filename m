From: Simon Perreault <nomis80@...422...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
References: <200506141234.50171.nomis80@...401...> <200506250929.27797.nomis80@...422...> <20050626171742.GA20568@...33...>
In-Reply-To: <20050626171742.GA20568@...33...>
MIME-Version: 1.0
Message-Id: <200506261342.58057.nomis80@...422...>
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
Date: Sun Jun 26 10:45:11 2005
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sunday 26 June 2005 13:17, Matthias Andree wrote:
> An RPM for an older distribution should generally work on a newer
> version of the same distro, so your boss's expectation was right - at
> least it usually works on FreeBSD and Solaris, if it doesn't work on
> Linux, Linux must improve in this compatibility regard.

It doesn't, and Linux must improve in this regard. That's why an RPM for an 
older distribution can't be expected to work on a newer version.

> If I need an RPM for several versions of the same distribution, I
> usually compile on the oldest available and it usually works.

It *usually* works, but you can't expect it to. At least, not when your 
product costs upwards of 10k and is expected to be rock-stable. You just 
can't take that risk, it would be stupid. Not taking the risk costs virtually 
nothing.

-- 
Simon Perreault <nomis80@...422...> -- http://nomis80.org

