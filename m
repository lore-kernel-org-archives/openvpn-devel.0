Message-ID: <534CF7FD.9070204@...1528...>
Date: Tue, 15 Apr 2014 11:12:29 +0200
From: "M. Braun" <michael-dev@...1528...>
MIME-Version: 1.0
References: <20140413152613.GT16637@...1296...>	<20140414193422.GN16637@...1296...>	<534C42AB.7040700@...1114...>
	<20140415074239.GR16637@...1296...>
In-Reply-To: <20140415074239.GR16637@...1296...>
Subject: Re: [Openvpn-devel] RFD: ssl library version numbers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

Am 15.04.2014 09:42, schrieb Gert Doering:> char *
> get_ssl_library_version(void)
> {
>     static char polar_version[30];
>     unsigned int pv = version_get_number();
>     sprintf( polar_version, "PolarSSL %d.%d.%d",
>                 (pv>>24)&0xff, (pv>>16)&0xff, (pv>>8)&0xff );
>     return polar_version;
> }
>
> this is well-defined (polarssl/version.h), and guaranteed to not overflow.

wouldn't be using snprintf with length sizeof(polar_version) instead of
just sprintf be better as to make sure this will not be broken by
accident in future?

Regards,
M. Braun

